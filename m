Return-Path: <linux-fsdevel+bounces-754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864AA7CFAEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E1C1C20EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA02745B;
	Thu, 19 Oct 2023 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx5DXHGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA601EB59;
	Thu, 19 Oct 2023 13:25:54 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A76112;
	Thu, 19 Oct 2023 06:25:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a389db3c7so686414276.1;
        Thu, 19 Oct 2023 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721951; x=1698326751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZvKA08lsV+CHODBvCno/CaKuKoTd3xS9EkJV2Oc63I=;
        b=Bx5DXHGI5+wYOxunQJB4CN2zfK7CKT/PaY7AMS3DhJZo0KyHGJusxXFtcnce1fyLiM
         8TtK7D2M3a8BzAeZm5evfnXQVCLDYhuInY83ZyusF3v3VdgSsRSwYF+S5a6k6qrOmwRB
         1achhlt3NfCgbQE9973agE6OC/bydleiuCaK3nts6Ct6+WNIfcWJEjKrj/e2cCam6fq5
         cpGR+RIebPBgHgzpUQZFOwLmEtsCEfG9s2nSz5lrm8M2ZhxtgVuEGh6eE7vvcYjb4mO1
         I+QYd32r9vnpFx564xLhMLATEuwhWHTt1Tey734przcyFb8KdQ9uWSlioxLpZ9ogFg92
         dlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721951; x=1698326751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZvKA08lsV+CHODBvCno/CaKuKoTd3xS9EkJV2Oc63I=;
        b=KzUNvsmEqdfClpP5uy1ajoh5SYcuWWV3D4ZClDFwGZsWlsVlALbO2cIN3MG4zHcFa/
         45alDFougBQuFhUZVykcjcnYKTJEFGHOCv+FWQoIENqJ+FY/NpS11iTiL0xfmacqjFqk
         kqCRUu50C1WX9KVi1zXS7QaYLKQBgaz+Gk9DjGu+F6TYVqhfyheGHMrN+BCV2KG77swO
         eYkPFAgpcg/dHhb9qQbkhVE5sTqeaZai8MLicX5c+UakLpcHalyuBR2kBccDXuH8J5WR
         FD+b0vPveQJ2tE5Mi7lHmZJ1KPbQcIrJT+pwJlpsWqStk5epABTRaKExV1+HQhdEoL8a
         qRaQ==
X-Gm-Message-State: AOJu0YxpovfJJZmu3AOl9S+SXKJNnr0UHmOOPvH4rA2z0Fr7QjbD1bOS
	JSOvYTh3Sy9Lu66/DWu0zqQ41Xrb+YMoiwH831s=
X-Google-Smtp-Source: AGHT+IH37zAfKrrX0aZKbfznyA92lcFjSConllzdH8DsnvbY2ljACj0KBIjX0wQHJlPaHFZmSLR0DokybHnvQCQ3KDE=
X-Received: by 2002:a25:3044:0:b0:d9a:c26b:e965 with SMTP id
 w65-20020a253044000000b00d9ac26be965mr1327987ybw.13.1697721950659; Thu, 19
 Oct 2023 06:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org> <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org>
In-Reply-To: <ZTAwLGi4sCup+B1r@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 19 Oct 2023 10:25:39 -0300
Message-ID: <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct 2023 at 16:21, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 03:32:36PM -0300, Wedson Almeida Filho wrote:
> > On Wed, 18 Oct 2023 at 14:17, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Oct 18, 2023 at 09:25:08AM -0300, Wedson Almeida Filho wrote:
> > > > +void *rust_helper_kmap(struct page *page)
> > > > +{
> > > > +     return kmap(page);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> > > > +
> > > > +void rust_helper_kunmap(struct page *page)
> > > > +{
> > > > +     kunmap(page);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
> > >
> > > I'm not thrilled by exposing kmap()/kunmap() to Rust code.  The vast
> > > majority of code really only needs kmap_local_*() / kunmap_local().
> > > Can you elaborate on why you need the old kmap() in new Rust code?
> >
> > The difficulty we have with kmap_local_*() has to do with the
> > requirement that maps and unmaps need to be nested neatly. For
> > example:
> >
> > let a = folio1.map_local(...);
> > let b = folio2.map_local(...);
> > // Do something with `a` and `b`.
> > drop(a);
> > drop(b);
> >
> > The code obviously violates the requirements.
>
> Is that the only problem, or are there situations where we might try
> to do something like:
>
> a = folio1.map.local()
> b = folio2.map.local()
> drop(a)
> a = folio3.map.local()
> drop(b)
> b = folio4.map.local()
> drop (a)
> a = folio5.map.local()
> ...

This is also a problem. We don't control the order in which users are
going to unmap.

> > One way to enforce the rule is Rust is to use closures, so the code
> > above would be:
> >
> > folio1.map_local(..., |a| {
> >     folio2.map_local(..., |b| {
> >         // Do something with `a` and `b`.
> >     })
> > })
> >
> > It isn't ergonomic the first option, but allows us to satisfy the
> > nesting requirement.
> >
> > Any chance we can relax that requirement?
>
> It's possible.  Here's an untested patch that _only_ supports
> "map a, map b, unmap a, unmap b".  If we need more, well, I guess
> we can scan the entire array, both at map & unmap in order to
> unmap pages.

We need more.

If you don't want to scan the whole array, we could have a solution
where we add an indirection between the available indices and the
stack of allocations; this way C could continue to work as is and Rust
would have a slightly different API that returns both the mapped
address and an index (which would be used to unmap).

It's simple to remember the index in Rust and it wouldn't have to be
exposed to end users, they'd still just do:

let a = folio1.map_local(...);

And when `a` is dropped, it would call unmap and pass the index back.
(It's also safe in the sense that users would not be able to
accidentally pass the wrong index.)

But if scanning the whole array is acceptable performance-wise, it's
definitely a simpler solution.

> diff --git a/mm/highmem.c b/mm/highmem.c
> index e19269093a93..778a22ca1796 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -586,7 +586,7 @@ void kunmap_local_indexed(const void *vaddr)
>  {
>         unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
>         pte_t *kmap_pte;
> -       int idx;
> +       int idx, local_idx;
>
>         if (addr < __fix_to_virt(FIX_KMAP_END) ||
>             addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
> @@ -607,15 +607,25 @@ void kunmap_local_indexed(const void *vaddr)
>         }
>
>         preempt_disable();
> -       idx = arch_kmap_local_unmap_idx(kmap_local_idx(), addr);
> +       local_idx = kmap_local_idx();
> +       idx = arch_kmap_local_unmap_idx(local_idx, addr);
> +       if (addr != __fix_to_virt(FIX_KMAP_BEGIN + idx) && local_idx > 0) {
> +               idx--;
> +               local_idx--;
> +       }
>         WARN_ON_ONCE(addr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
>
>         kmap_pte = kmap_get_pte(addr, idx);
>         arch_kmap_local_pre_unmap(addr);
>         pte_clear(&init_mm, addr, kmap_pte);
>         arch_kmap_local_post_unmap(addr);
> -       current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
> -       kmap_local_idx_pop();
> +       current->kmap_ctrl.pteval[local_idx] = __pte(0);
> +       if (local_idx == kmap_local_idx()) {
> +               kmap_local_idx_pop();
> +               if (local_idx > 0 &&
> +                   pte_none(current->kmap_ctrl.pteval[local_idx - 1]))
> +                       kmap_local_idx_pop();
> +       }
>         preempt_enable();
>         migrate_enable();
>  }
> @@ -648,7 +658,7 @@ void __kmap_local_sched_out(void)
>                         WARN_ON_ONCE(pte_val(pteval) != 0);
>                         continue;
>                 }
> -               if (WARN_ON_ONCE(pte_none(pteval)))
> +               if (pte_none(pteval))
>                         continue;
>
>                 /*
> @@ -685,7 +695,7 @@ void __kmap_local_sched_in(void)
>                         WARN_ON_ONCE(pte_val(pteval) != 0);
>                         continue;
>                 }
> -               if (WARN_ON_ONCE(pte_none(pteval)))
> +               if (pte_none(pteval))
>                         continue;
>
>                 /* See comment in __kmap_local_sched_out() */
>
> > > > +void rust_helper_folio_set_error(struct folio *folio)
> > > > +{
> > > > +     folio_set_error(folio);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_folio_set_error);
> > >
> > > I'm trying to get rid of the error flag.  Can you share the situations
> > > in which you've needed the error flag?  Or is it just copying existing
> > > practices?
> >
> > I'm just mimicking C code. Happy to remove it.
>
> Great, thanks!
>
> > > > +    /// Returns the byte position of this folio in its file.
> > > > +    pub fn pos(&self) -> i64 {
> > > > +        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
> > > > +        unsafe { bindings::folio_pos(self.0.get()) }
> > > > +    }
> > >
> > > I think it's a mistake to make file positions an i64.  I estimate 64
> > > bits will not be enough by 2035-2040.  We should probably have a numeric
> > > type which is i64 on 32-bit and isize on other CPUs (I also project
> > > 64-bit pointers will be insufficient by 2035-2040 and so we will have
> > > 128-bit pointers around the same time, so we're not going to need i128
> > > file offsets with i64 pointers).
> >
> > I'm also just mimicking C here -- we just don't have a type that has
> > the properties you describe. I'm happy to switch once we have it, in
> > fact, Miguel has plans that I believe align well with what you want.
> > I'm not sure if he has already contacted you about it yet though.
>
> No, I haven't heard about plans for an off_t equivalent.

He tells me he'll send a patch for that soon.

> Perhaps you
> could just do what the crates.io libc does?
>
> https://docs.rs/libc/0.2.149/libc/type.off_t.html
> pub type off_t = i64;
>
> and then there's only one place to change to be i128 when the time comes.

Yes, I'll do that for v2.

> > > > +/// A [`Folio`] that has a single reference to it.
> > > > +pub struct UniqueFolio(pub(crate) ARef<Folio>);
> > >
> > > How do we know it only has a single reference?  Do you mean "has at
> > > least one reference"?  Or am I confusing Rust's notion of a reference
> > > with Linux's notion of a reference?
> >
> > Instances of `UniqueFolio` are only produced by calls to
> > `folio_alloc`. They encode the fact that it's safe for us to map the
> > folio and know that there aren't any concurrent threads/CPUs doing the
> > same to the same folio.
>
> Mmm ... it's always safe to map a folio, even if other people have a
> reference to it.  And Linux can make temporary spurious references to
> folios appear, although those should be noticed by the other party and
> released again before they access the contents of the folio.  So from
> the point of view of being memory-safe, you can ignore them, but you
> might see the refcount of the folio as >1, even if you just got the
> folio back from the allocator.

Sure, it's safe to map a folio in general, but Rust has stricter rules
about aliasing and mutability that are part of how memory safety is
achieved. In particular, it requires that we never have mutable and
immutable pointers to the same memory at once (modulo interior
mutability).

So we need to avoid something like:

let a = folio.map(); // `a` is a shared pointer to the contents of the folio.

// While we have a shared (and therefore immutable) pointer, we're
changing the contents of the folio.
sb.sread(sector_number, sector_count, folio);

This violates Rust rules. `UniqueFolio` helps us address this for our
use case; if we try the above with a UniqueFolio, the compiler will
error out saying that  `a` has a shared reference to the folio, so we
can't call `sread` on it (because sread requires a mutable, and
therefore not shareable, reference to the folio).

(It's ok for the reference count to go up and down; it's unfortunate
that we use "reference" with two slightly different meanings, we
invariably get confused.)

> > > > +impl UniqueFolio {
> > > > +    /// Maps the contents of a folio page into a slice.
> > > > +    pub fn map_page(&self, page_index: usize) -> Result<MapGuard<'_>> {
> > > > +        if page_index >= self.0.size() / bindings::PAGE_SIZE {
> > > > +            return Err(EDOM);
> > > > +        }
> > > > +
> > > > +        // SAFETY: We just checked that the index is within bounds of the folio.
> > > > +        let page = unsafe { bindings::folio_page(self.0 .0.get(), page_index) };
> > > > +
> > > > +        // SAFETY: `page` is valid because it was returned by `folio_page` above.
> > > > +        let ptr = unsafe { bindings::kmap(page) };
> > >
> > > Surely this can be:
> > >
> > >            let ptr = unsafe { bindings::kmap_local_folio(folio, page_index * PAGE_SIZE) };
> >
> > The problem is the unmap path that can happen at arbitrary order in
> > Rust, see my comment above.
> >
> > >
> > > > +        // SAFETY: We just mapped `ptr`, so it's valid for read.
> > > > +        let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(), bindings::PAGE_SIZE) };
> > >
> > > Can we hide away the "if this isn't a HIGHMEM system, this maps to the
> > > end of the folio, but if it is, it only maps to the end of the page"
> > > problem here?
> >
> > Do you have ideas on how this might look like? (Don't worry about
> > Rust, just express it in some pseudo-C and we'll see if you can
> > express it in Rust.)
>
> On systems without HIGHMEM, kmap() is a no-op.  So we could do something
> like this:
>
>         let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(),
>                 if (folio_test_highmem(folio))
>                         bindings::PAGE_SIZE
>                 else
>                         folio_size(folio) - page_idx * PAGE_SIZE) }
>
> ... modulo whatever the correct syntax is in Rust.

We can certainly do that. But since there's the possibility that the
array will be capped at PAGE_SIZE in the HIGHMEM case, callers would
still need a loop to traverse the whole folio, right?

let mut offset = 0;
while offset < folio.size() {
    let a = folio.map(offset);
    // Do something with a.
    offset += a.len();
}

I guess the advantage is that we'd have a single iteration in systems
without HIGHMEM.

> Something I forgot to mention was that I found it more useful to express
> "map this chunk of a folio" in bytes rather than pages.  You might find
> the same, in which case it's just folio.map(offset: usize) instead of
> folio.map_page(page_index: usize)

Oh, thanks for the feedback. I'll switch to bytes then for v2.
(Already did in the example above.)

