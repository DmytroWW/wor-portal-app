import { forwardRef, useId } from 'react'
import { cn } from "../lib/cn";
/**
 * Поле форми "label + input" одним компонентом.
 * Раніше в LoginPage.jsx цей блок (label + input + стилі) дублювався
 * вручну для кожного поля — тут він написаний один раз і перевикористовується
 * для Login/Register/Settings тощо.
 */
const TextField = forwardRef(function TextField(
  { label, error, className, id, ...inputProps },
  ref
) {
  const generatedId = useId()
  const inputId = id ?? generatedId

  return (
    <div>
      {label && (
        <label htmlFor={inputId} className="field-label">
          {label}
        </label>
      )}
      <input
        id={inputId}
        ref={ref}
        className={cn('input-field', error && 'border-brand-danger', className)}
        {...inputProps}
      />
      {error && <p className="mt-1 text-xs text-brand-danger-hover">{error}</p>}
    </div>
  )
})

export default TextField