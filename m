Return-Path: <linux-fsdevel+bounces-920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B347D368E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDA1C20A71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A56618E36;
	Mon, 23 Oct 2023 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia2jl9nV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF918E27;
	Mon, 23 Oct 2023 12:30:07 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AA102;
	Mon, 23 Oct 2023 05:30:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so2434346276.2;
        Mon, 23 Oct 2023 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698064205; x=1698669005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFS/kQRVR+YXNYPo7zcsStKHJQlBbTRFSyUMDWeNuSU=;
        b=ia2jl9nVzUvoPSvNpQhfqfakGFCYLoETJnN+I/R5yQAx1LsV2Pi8RoGOqmpKQ8vTcz
         M+37Nslfa7y+/6K4lAfKtgP4xv9zE6Omy2G6ZAoLd3CuQnEJAHD8x5rzcqw3VBc6fZXo
         Fwc13p4XT/VLXNMJQl9usndMutsSi2p4aiKQhrsKSvhdJwWdxk96F5UYhIDzVqA2VG70
         1TuHFFLBTqbFtmONEge05X0VetS2vj7b86w/5gXoQWlTbjlnlc04uJvCx7llyTwk7/QE
         X5GS6Xb88BTAHbSBSlowTex3oX4NdB1nZE19ciQq8D94txO+Bepr8ho5msKZlcH2MR2D
         dDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064205; x=1698669005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFS/kQRVR+YXNYPo7zcsStKHJQlBbTRFSyUMDWeNuSU=;
        b=HwD0vIXPxKlcbwF2jzdvOcCNz9QDGFQQ364bDqttrBTac8jJfyeyZDTKww9ybTydGr
         3ni4QqKdj+lisfrD2IP7fxzNZ9fZdPqh2JEyG7VS0YCJFt+dbQ2Z6EGbW0I2wzk0PAc9
         cSlZtIJsLTTvlCcnTpgogWKo02MQdnb8Sd/WP0KF1WWzI9kzOmQVUXsfNtPzFoMKp5ku
         0QYTJjVADxWscqBFIrnTr/aWZVuivEkA9muMPBLQe1Xyi9dd5Ba8aEljaSUmO1rgFiNP
         pp3lePcwNoZS19zvw5Tml/fISmpadslsI5/3rsM9LY17tgqggtDwjMFvWMkM1/JJXbJG
         aUgw==
X-Gm-Message-State: AOJu0YwkxLuW+iUNnpoTnIltvT1X+cKGH/C4tWR10CCUyqTPwlMsqEK1
	BHE8xP4tNfWak51iHdZO+v9XluLXRMIta6DxPszlD89vYaQ=
X-Google-Smtp-Source: AGHT+IFbdDQNI85eSyvI4k/UB3FphJUrV39Ua1Ros13cW7UfAIj+bJfiMf+5gJ5UU2wPwfqRSN6/I1bx5cwLGCxDTjQ=
X-Received: by 2002:a25:d3d1:0:b0:d9a:3a83:98e0 with SMTP id
 e200-20020a25d3d1000000b00d9a3a8398e0mr8303782ybf.52.1698064204962; Mon, 23
 Oct 2023 05:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org> <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org> <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
 <ZTH9+sF+NPyRjyRN@casper.infradead.org>
In-Reply-To: <ZTH9+sF+NPyRjyRN@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 23 Oct 2023 09:29:53 -0300
Message-ID: <CANeycqrgMch_vDYT3KvpFeMaJxv-X9O0h6CYMT0gT5tzr2RhqA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 01:11, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 19, 2023 at 10:25:39AM -0300, Wedson Almeida Filho wrote:
> > On Wed, 18 Oct 2023 at 16:21, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Oct 18, 2023 at 03:32:36PM -0300, Wedson Almeida Filho wrote:
> > > > On Wed, 18 Oct 2023 at 14:17, Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Wed, Oct 18, 2023 at 09:25:08AM -0300, Wedson Almeida Filho wrote:
> > > > > > +void *rust_helper_kmap(struct page *page)
> > > > > > +{
> > > > > > +     return kmap(page);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> > > > > > +
> > > > > > +void rust_helper_kunmap(struct page *page)
> > > > > > +{
> > > > > > +     kunmap(page);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
> > > > >
> > > > > I'm not thrilled by exposing kmap()/kunmap() to Rust code.  The vast
> > > > > majority of code really only needs kmap_local_*() / kunmap_local().
> > > > > Can you elaborate on why you need the old kmap() in new Rust code?
> > > >
> > > > The difficulty we have with kmap_local_*() has to do with the
> > > > requirement that maps and unmaps need to be nested neatly. For
> > > > example:
> > > >
> > > > let a = folio1.map_local(...);
> > > > let b = folio2.map_local(...);
> > > > // Do something with `a` and `b`.
> > > > drop(a);
> > > > drop(b);
> > > >
> > > > The code obviously violates the requirements.
> > >
> > > Is that the only problem, or are there situations where we might try
> > > to do something like:
> > >
> > > a = folio1.map.local()
> > > b = folio2.map.local()
> > > drop(a)
> > > a = folio3.map.local()
> > > drop(b)
> > > b = folio4.map.local()
> > > drop (a)
> > > a = folio5.map.local()
> > > ...
> >
> > This is also a problem. We don't control the order in which users are
> > going to unmap.
>
> OK.  I have something in the works, but it's not quite ready yet.

Please share once you're happy with it!

Or before. :)

> > This violates Rust rules. `UniqueFolio` helps us address this for our
> > use case; if we try the above with a UniqueFolio, the compiler will
> > error out saying that  `a` has a shared reference to the folio, so we
> > can't call `sread` on it (because sread requires a mutable, and
> > therefore not shareable, reference to the folio).
>
> This is going to be quite the impedance mismatch.  Still, I imagine
> you're used to dealing with those by now and have a toolbox of ideas.
>
> We don't have that rule for the pagecache as it is.  We do have rules that
> prevent data corruption!  For example, if the folio is !uptodate then you
> must have the lock to write to the folio in order to bring it uptodate
> (so we have a single writer rule in that regard).  But once the folio is
> uptodate, all bets are off in terms of who can be writing to it / reading
> it at the same time.  And that's going to have to continue to be true;
> multiple processes can have the same page mmaped writable and write to
> it at the same time.  There's no possible synchronisation between them.
>
> But I think your concern is really more limited.  You're concerned
> with filesystem metadata obeying Rust's rules.  And for a read-write
> filesystem, you're going to have to have ... something ... which gets a
> folio from the page cache, and establishes that this is the only thread
> which can modify that folio (maybe it's an interior node of a Btree,
> maybe it's a free space bitmap, ...).  We could probably use the folio
> lock bit for that purpose,  For the read-only filesystems, you only need
> be concerned about freshly-allocated folios, but you need something more
> when it comes to doing an ext2 clone.
>
> There's general concern about the overuse of the folio lock bit, but
> this is a reasonable use -- preventing two threads from modifying the
> same folio at the same time.
>
> (I have simplified all this; both iomap and buffer heads support folios
> which are partially uptodate, but conceptually this is accurate)

Yes, that's precisely the case. Rust doesn't mind if data is mapped
multiple times for a given folio as in most cases it won't inspect the
contents anyway. But for metadata, it will need some synchronisation.

In this read-only scenario we're supporting now, we conveniently
already get locked folios in `read_folio` calls, so we're using the
fact that it's locked to have a single writer to it -- note that the
`write` and `zero_out` functions are only available  in `LockedFolio`,
not in `Folio`.

`UniqueFolio` is for when a module needs to read sectors without the
cache, in particular the super block. (Before it has decided on the
block size and has initialised the superblock with the block size.) So
it's essentially a sequence of allocate a folio, read from a block
device, map it, use the contents, unmap, free. The folio isn't really
shared with anyone else. Eventually we may want to merge this with
concept with that of a locked folio so that we only have one writable
folio.

> > > On systems without HIGHMEM, kmap() is a no-op.  So we could do something
> > > like this:
> > >
> > >         let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(),
> > >                 if (folio_test_highmem(folio))
> > >                         bindings::PAGE_SIZE
> > >                 else
> > >                         folio_size(folio) - page_idx * PAGE_SIZE) }
> > >
> > > ... modulo whatever the correct syntax is in Rust.
> >
> > We can certainly do that. But since there's the possibility that the
> > array will be capped at PAGE_SIZE in the HIGHMEM case, callers would
> > still need a loop to traverse the whole folio, right?
> >
> > let mut offset = 0;
> > while offset < folio.size() {
> >     let a = folio.map(offset);
> >     // Do something with a.
> >     offset += a.len();
> > }
> >
> > I guess the advantage is that we'd have a single iteration in systems
> > without HIGHMEM.
>
> Right.  You can see something similar to that in memcpy_from_folio() in
> highmem.h.

I will have this in v2.

> > > Something I forgot to mention was that I found it more useful to express
> > > "map this chunk of a folio" in bytes rather than pages.  You might find
> > > the same, in which case it's just folio.map(offset: usize) instead of
> > > folio.map_page(page_index: usize)
> >
> > Oh, thanks for the feedback. I'll switch to bytes then for v2.
> > (Already did in the example above.)
>
> Great!  Something else I think would be a good idea is open-coding some
> of the trivial accessors.  eg instead of doing:
>
> +size_t rust_helper_folio_size(struct folio *folio)
> +{
> +       return folio_size(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_size);
> [...]
> +    pub fn size(&self) -> usize {
> +        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
> +        unsafe { bindings::folio_size(self.0.get()) }
> +    }
>
> add:
>
> impl Folio {
> ...
>     pub fn order(&self) -> u8 {
>         if (self.flags & (1 << PG_head))
>             self._flags_1 & 0xff
>         else
>             0
>     }
>
>     pub fn size(&self) -> usize {
>         bindings::PAGE_SIZE << self.order()
>     }
> }
>
> ... or have I misunderstood what is possible here?  My hope is that the
> compiler gets to "see through" the abstraction, which surely can't be
> done when there's a function call.

As Andreas pointed out, with LTO we can get the linker to see through
these functions, even across different languages, and optimise when it
makes sense.

Having said that, while it's possible to do what you suggested above,
we try to avoid it so that maintainers can continue to have a single
place they need to change if they ever decide to change things. A
simple example from above is order(), if you decide to implement it
differently (I don't know, if you change the flag, you decide to have
an explicit field, whatever), then you'd have to change the C _and_
the Rust versions. Worse yet, there's a chance that forgetting to
update the Rust version wouldn't break the build, which would make it
harder to catch mismatched versions.

