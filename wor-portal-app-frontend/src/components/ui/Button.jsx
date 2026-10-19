import { cn } from "../lib/cn";
/**
 * Єдина кнопка для всього застосунку.
 * Візуал (колір/тінь/radius/hover/active/disabled) живе в design-system/styles/tokens.css
 * (@utility btn, btn-primary, btn-secondary, btn-success, btn-outline).
 * Тут — лише варіанти та поведінка (loading-стан), жодних "сирих" кольорів.
 *
 * @param {'primary'|'secondary'|'success'|'outline'} variant
 * @param {boolean} loading
 */
export default function Button({
  variant = 'primary',
  loading = false,
  disabled = false,
  className,
  children,
  type = 'button',
  ...props
}) {
  return (
    <button
      type={type}
      disabled={disabled || loading}
      className={cn('btn', `btn-${variant}`, className)}
      {...props}
    >
      {loading ? 'Зачекайте…' : children}
    </button>
  )
}
