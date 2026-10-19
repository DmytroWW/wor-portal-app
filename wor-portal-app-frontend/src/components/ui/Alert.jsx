import { cn } from "../lib/cn";

/**
 * Статусне повідомлення (помилка форми, успіх, інфо).
 * variant керує кольором через токени — danger/success/info,
 * ніяких "сирих" red-500/10 розкиданих по сторінках.
 */
export default function Alert({ variant = 'danger', className, children }) {
  if (!children) return null

  return <div className={cn('alert', `alert-${variant}`, className)}>{children}</div>
}
