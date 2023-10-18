Return-Path: <linux-fsdevel+bounces-690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81A7CE6AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8072BB214C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F09CA4D;
	Wed, 18 Oct 2023 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1vlxzje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99167450E9;
	Wed, 18 Oct 2023 18:32:50 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E755F118;
	Wed, 18 Oct 2023 11:32:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9c1989509bso2713894276.1;
        Wed, 18 Oct 2023 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697653968; x=1698258768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h65u8wTc43iKX1/MDjpqRaX8azYjY2/nSFDLxF3Zi1Q=;
        b=m1vlxzjeDsVINFlYrR0iW7BFeCK/XRknv03kUW3zedhwKX/HsqEmd79oOwQTuw8EsN
         +VqferWYA3CHqkoX+K4FoWU3o0R+dDRduTFymUnWauPjkH4Owgyz9K7upb3XCPI3ocJc
         cSBBSin0cX7sgjG5XdJMa/4/fXNOyarGEcmpjZ6+iI6daK906vOLvig4gBdRCguQMGXb
         Pjgt+TK9Vo+gWRtgNIzY9HTuSPze97LZLaQjaUitNyHMqL6M9R1cM8n6dRoXEHcXq9a3
         RWJA0iqAzCuSYU0h3tlZbl7UP9VYkeQRtlAiZasxTsxRDF5X5u9/kKMUEMiH9VrBco+y
         g2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653968; x=1698258768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h65u8wTc43iKX1/MDjpqRaX8azYjY2/nSFDLxF3Zi1Q=;
        b=kr3zP6sQU36Tx9JTU3En6h5jEiY3C5dJjvJ6iWoNKleJ/DgFmW4H6ay1cXmiW+177H
         7EWc1crc7OPmIi2e2b61KtZaDxGH+TYcK+gn9IjQWLu4QujyFfXsBRBMld7oKb7jatoE
         2efPkvQyUmLBta2jUdtZHQAdNRg0cZ+oeWgTtw609rc3zfCFk+dyXuAsHU9AXzLNd0xz
         nWOafX7HaPv5F0rD3gsuDTaLN6Fsj3vB+JuRG8KUnPgd/QvzaIVcu5xlzxtXCJW61z95
         oXspdc3xtY7KntXkeG3AbdAbIUmq7pQ9b3wqXQkIDrlxpT+0SRfzrrWh0VSJxifMqUN2
         BE6A==
X-Gm-Message-State: AOJu0Yy+YAdDYhhEQYQE76W1ppatDKvSSDMBMQeIzFV0TzXk2f/Gt3y+
	5lYlgQZmFQKVqfGN25md7wJg0jOo09XEkM20vx0=
X-Google-Smtp-Source: AGHT+IFluTy5gW7IJuF0qYSmhlrpJX9E8iKprtx+i89+q3GSXdq3zUwOjapFJecGgOzIi5tYj9p4ACHZbpugbRJy/IU=
X-Received: by 2002:a25:ce94:0:b0:d9a:68ef:9d24 with SMTP id
 x142-20020a25ce94000000b00d9a68ef9d24mr126975ybe.14.1697653967929; Wed, 18
 Oct 2023 11:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org>
In-Reply-To: <ZTATIhi9U6ObAnN7@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 18 Oct 2023 15:32:36 -0300
Message-ID: <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 at 14:17, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 09:25:08AM -0300, Wedson Almeida Filho wrote:
> > +void *rust_helper_kmap(struct page *page)
> > +{
> > +     return kmap(page);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> > +
> > +void rust_helper_kunmap(struct page *page)
> > +{
> > +     kunmap(page);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
>
> I'm not thrilled by exposing kmap()/kunmap() to Rust code.  The vast
> majority of code really only needs kmap_local_*() / kunmap_local().
> Can you elaborate on why you need the old kmap() in new Rust code?

The difficulty we have with kmap_local_*() has to do with the
requirement that maps and unmaps need to be nested neatly. For
example:

let a = folio1.map_local(...);
let b = folio2.map_local(...);
// Do something with `a` and `b`.
drop(a);
drop(b);

The code obviously violates the requirements.

One way to enforce the rule is Rust is to use closures, so the code
above would be:

folio1.map_local(..., |a| {
    folio2.map_local(..., |b| {
        // Do something with `a` and `b`.
    })
})

It isn't ergonomic the first option, but allows us to satisfy the
nesting requirement.

Any chance we can relax that requirement?

(If not, and we really want to get rid of the non-local function, we
can fall back to the closure-based implementation. In fact, you'll
find that in this patch I already do this for a private function that
used when writing into the folio, we could just make a version of it
public.)

> > +void rust_helper_folio_set_error(struct folio *folio)
> > +{
> > +     folio_set_error(folio);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_folio_set_error);
>
> I'm trying to get rid of the error flag.  Can you share the situations
> in which you've needed the error flag?  Or is it just copying existing
> practices?

I'm just mimicking C code. Happy to remove it.

> > +    /// Returns the byte position of this folio in its file.
> > +    pub fn pos(&self) -> i64 {
> > +        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
> > +        unsafe { bindings::folio_pos(self.0.get()) }
> > +    }
>
> I think it's a mistake to make file positions an i64.  I estimate 64
> bits will not be enough by 2035-2040.  We should probably have a numeric
> type which is i64 on 32-bit and isize on other CPUs (I also project
> 64-bit pointers will be insufficient by 2035-2040 and so we will have
> 128-bit pointers around the same time, so we're not going to need i128
> file offsets with i64 pointers).

I'm also just mimicking C here -- we just don't have a type that has
the properties you describe. I'm happy to switch once we have it, in
fact, Miguel has plans that I believe align well with what you want.
I'm not sure if he has already contacted you about it yet though.

> > +/// A [`Folio`] that has a single reference to it.
> > +pub struct UniqueFolio(pub(crate) ARef<Folio>);
>
> How do we know it only has a single reference?  Do you mean "has at
> least one reference"?  Or am I confusing Rust's notion of a reference
> with Linux's notion of a reference?

Instances of `UniqueFolio` are only produced by calls to
`folio_alloc`. They encode the fact that it's safe for us to map the
folio and know that there aren't any concurrent threads/CPUs doing the
same to the same folio.

Naturally, if you to increment the refcount on this folio and share it
with other threads/CPUs, it's no longer unique. So we don't allow it.

This is only used when using a synchronous bio to read blocks from a
block device while setting up a new superblock, in particular, to read
the superblock itself.

>
> > +impl UniqueFolio {
> > +    /// Maps the contents of a folio page into a slice.
> > +    pub fn map_page(&self, page_index: usize) -> Result<MapGuard<'_>> {
> > +        if page_index >= self.0.size() / bindings::PAGE_SIZE {
> > +            return Err(EDOM);
> > +        }
> > +
> > +        // SAFETY: We just checked that the index is within bounds of the folio.
> > +        let page = unsafe { bindings::folio_page(self.0 .0.get(), page_index) };
> > +
> > +        // SAFETY: `page` is valid because it was returned by `folio_page` above.
> > +        let ptr = unsafe { bindings::kmap(page) };
>
> Surely this can be:
>
>            let ptr = unsafe { bindings::kmap_local_folio(folio, page_index * PAGE_SIZE) };

The problem is the unmap path that can happen at arbitrary order in
Rust, see my comment above.

>
> > +        // SAFETY: We just mapped `ptr`, so it's valid for read.
> > +        let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(), bindings::PAGE_SIZE) };
>
> Can we hide away the "if this isn't a HIGHMEM system, this maps to the
> end of the folio, but if it is, it only maps to the end of the page"
> problem here?

Do you have ideas on how this might look like? (Don't worry about
Rust, just express it in some pseudo-C and we'll see if you can
express it in Rust.)

My approach here was to be conservative, since the common denominator
was "maps to the end of the page", that's what I have.

One possible way to do it with Rust would be an "Iterator" -- in
HIGHMEM it would return one item per page, otherwise it would return a
single item. (We have something similar for reading arbitrary ranges
of a block device, it's broken up into several chunks, so we return an
iterator.)

