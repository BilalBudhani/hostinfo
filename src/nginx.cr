class Nginx
  def is_installed?
    status, output = run_cmd "which nginx"
    output
  end

  def info
    status, output = run_cmd "nginx", ["-t"]
    output
  end

  def run_cmd(cmd, args = nil)
    stdout = IO::Memory.new
    stderr = IO::Memory.new
    status = Process.run(cmd, args: args, output: stdout, error: stderr, shell: true)
    if status.success?
      {status.exit_code, stdout.to_s}
    else
      {status.exit_code, stderr.to_s}
    end
  end
end
