class CrawlScheduler
  @queue = :scheduler

  def self.perform
    targets = Target.all
    targets.each do |t|
      t.backup_now! if t.backup_due?
    end
  end
end
