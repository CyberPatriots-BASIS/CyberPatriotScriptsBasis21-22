import re 
import subprocess 
import glob

class Util:

    @staticmethod
    def string_exists(targetFile, searchString):
        try:
            for line in open(targetFile, 'r').readLines():
                if re.search(searchString, line):
                    return True
                else:
                    continue
                return False
        except:
            return False

    @staticmethod
    def string_exists_in_dir(targetDir, searchString):
        command = 'egrep -r "' + searchString + '" ' + targetDir
        cmd = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
        if cmd.stdout.read() != b'':
            return True
        else:
            return False          
    
    @staticmethod
    def run_command(command):
        command = command.split(' ')
        print('command split:', command)
        cmd = subprocess.Popen(command, stdout=subprocess.PIPE)
        return cmd.stdout.read()

    @staticmethod
    def package_installed(package):
        if package in str(Util.run_command('dpkg --list')):
            return True
        else:
            return False

    @staticmethod
    def service_running(service):
        check_service = 'sudo systemctl status ' + service
        output = str(Util.run_command(check_service))
        if ' active ' in output:
            return True
        else:
            return False

    @staticmethod
    def process_running(process):
        check_process = 'sudo pgrep ' + process
        output = Util.run_command(check_process)
        if output.decode() == "":
            return True
        else:
            return False

    @staticmethod
    def user_in_group(user, group):
        command = "grep " + group + " /etc/group"
        output = Util.run_command(command).decode().rstrip().split(":")
        if any(user in oyeah for oyeah in output):
            return True
        else:
            return False

    @staticmethod
    def check_perm(filename):
        command = 'stat -c %a ' + filename
        output = Util.run_command(command).decode().rstrip()
        return output

    
    @staticmethod
    def file_exists(path):
        if subprocess.call("test -e '{}'".format(path), shell=True):
            return False
        else:
            return True
    
    @staticmethod
    def conf_d_check(directories_searchString): 
        ## Can seperate directories with | to check multiple directories. Returns last found state
        ## Ex /etc/lightdm/|/etc/lightdm.conf.d/:greeter-hide-users
        directories, searchString = directories_searchString.split(':')[0], directories_searchString.split(':')[1]
        directoryList = directories.split('|')
        searchStringFalse = "^" + searchString + "=false"
        searchStringTrue = "^" + searchString + "=true"
        status = False
        for directory in directoryList:
            mydir = directory + '*.conf'
            fileList = glob.glob(mydir)
            fileList.sort()
            for confFile in fileList:
                if Util.string_exists(confFile, searchStringTrue):
                    status = True
                elif Util.string_exists(confFile, searchStringFalse):
                    status = False
        return 