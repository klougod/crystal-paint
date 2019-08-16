require "watcher"

process = uninitialized Process
process_running = false

watch ["src/*", "src/modules/*"] do |event|
  begin
    process.kill(Signal::TERM) if process_running
    event.on_change do |files|
      puts "watch> running..."
      process = Process.new(command: "./auto/build_and_run", output: Process::Redirect::Inherit, error: Process::Redirect::Inherit)
      running = true
    end
  rescue ex
    puts ex
  end
end
