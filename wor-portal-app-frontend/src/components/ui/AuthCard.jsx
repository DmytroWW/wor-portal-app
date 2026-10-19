export default function AuthCard({ title, subtitle, children, footer }) {
  return (
    <div className="min-h-screen bg-surface-base text-foreground-primary flex items-center justify-center p-4 w-full">
      <div className="max-w-md w-full card p-8 space-y-6">
        <div className="text-center space-y-2">
          <h1 className="font-display text-3xl font-extrabold text-brand-accent tracking-wider">
            {title}
          </h1>
          {subtitle && <p className="text-foreground-secondary text-sm">{subtitle}</p>}
        </div>

        {children}

        {footer && (
          <div className="pt-2 text-center text-sm text-foreground-muted border-t border-surface-border">
            {footer}
          </div>
        )}
      </div>
    </div>
  )
}