/**
 * cn — мінімалістичний аналог clsx/classnames без зайвої залежності.
 * Дозволяє комбінувати базові класи з умовними без конкатенації рядків:
 *
 *   <button className={cn('btn', 'btn-primary', isLoading && 'opacity-50')} />
 *
 * Якщо проєкт росте — заміните на `clsx` + `tailwind-merge`
 * (останній ще й прибирає конфліктні утиліти, напр. "p-2 p-4" -> "p-4").
 */
export function cn(...values) {
  return values.filter(Boolean).join(' ')
}

export default cn
