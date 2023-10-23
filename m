Return-Path: <linux-fsdevel+bounces-921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878AF7D36A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A861C20939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278A18E3B;
	Mon, 23 Oct 2023 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7lgQD/K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3A18E20;
	Mon, 23 Oct 2023 12:32:35 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033C1A4;
	Mon, 23 Oct 2023 05:32:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9c1989509bso3516543276.1;
        Mon, 23 Oct 2023 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698064351; x=1698669151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAUDbhcsE9ddMeHMNf02Vb0sw2MeVTUQig6X6JkAK/Y=;
        b=E7lgQD/KCm7M5jbozHWFBMuF2/zcjwwUOXghw+N/XeJTzUdu3MVPhjG3OTMP0F0esg
         OSWxRWQ1gYRvaWW2s3wOZM4BzkwyHkwhLT4bcaHib8X7fBo9dlXl7boqQfEtDS7IUFTh
         /xa1SO5xX5w0Y4IhmzoKAUOOz35tJJj1XXW9+JNcp0vhD/DZH9BnbHyOQ4xBd7u6xBiK
         IkWngFIlTu8/qBDGeHjJq+vs/qIRNpp8AFUnaDyX9XrOm3yemM/VNIG8we15v5I2lOHZ
         MLekOyoHCDtyWEY5fbGFHwUrEkisyEQ0CPV7Q/EqWgP2eHdCjvQksXZhgec/X3TDsWcI
         zlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064351; x=1698669151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAUDbhcsE9ddMeHMNf02Vb0sw2MeVTUQig6X6JkAK/Y=;
        b=Hwm9T5b+YuJO9lIvF5tDeTxWMSonI3kGWKa46ecodjrKVqm9ZqkPR7bIMhrqbb5Q8Q
         8W5VRP4+8fKipfmtkHcvo1Dhw+92RZ8CfjGnmxYmBRQKtLEeTeXlKW2LwPu8+1MN8L5O
         Gcne6R0J+EmLJuQtYFVrp+FGtOLaCS+fq+8wdq5pG5LsFIbhKKyqKOrDUPL/2wZR3Eri
         CMUT2XyjVbtIHMfF+FleNlev9AcXiglH2Lbftqf3Fl/v3lsp03tkCbPNj1XyCofy5XrB
         9KXbgZ+qHYsG9J2gSgPIsxG/gfyF4akWO6wvvN4pgsFeAe9ZHMtHCumD+TTKAYQ6m7cN
         zx/w==
X-Gm-Message-State: AOJu0YwKvch/XcS5p4XWmL7vAKCPCfGD3SlEn7IGsQYfOPK1IGV4TNe/
	Md0rvdpSfwsXwfedHWBHqG5Y4GAKDvuhTa+yLJM=
X-Google-Smtp-Source: AGHT+IGaMuDfNXkWYNmGl+AGnbxy4JuCld1m6ftmJNGtIFMmj/aOfa6hee5o3ef+cIylfzv8GeSXc6+JyhZ0Ul3pQhY=
X-Received: by 2002:a25:b4e:0:b0:d9a:5f53:1732 with SMTP id
 75-20020a250b4e000000b00d9a5f531732mr9502972ybl.18.1698064351484; Mon, 23 Oct
 2023 05:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org> <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org> <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
 <ZTH9+sF+NPyRjyRN@casper.infradead.org> <ZTKaGFN/tp3QjGaD@casper.infradead.org>
In-Reply-To: <ZTKaGFN/tp3QjGaD@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 23 Oct 2023 09:32:20 -0300
Message-ID: <CANeycqpbPOw=3wsdV+qQNEsa5O6-7fSz5twiK=Uw9-LqXZ+LGg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 12:17, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 20, 2023 at 05:11:38AM +0100, Matthew Wilcox wrote:
> > > Sure, it's safe to map a folio in general, but Rust has stricter rules
> > > about aliasing and mutability that are part of how memory safety is
> > > achieved. In particular, it requires that we never have mutable and
> > > immutable pointers to the same memory at once (modulo interior
> > > mutability).
> > >
> > > So we need to avoid something like:
> > >
> > > let a = folio.map(); // `a` is a shared pointer to the contents of the folio.
> > >
> > > // While we have a shared (and therefore immutable) pointer, we're
> > > changing the contents of the folio.
> > > sb.sread(sector_number, sector_count, folio);
> > >
> > > This violates Rust rules. `UniqueFolio` helps us address this for our
> > > use case; if we try the above with a UniqueFolio, the compiler will
> > > error out saying that  `a` has a shared reference to the folio, so we
> > > can't call `sread` on it (because sread requires a mutable, and
> > > therefore not shareable, reference to the folio).
> >
> > This is going to be quite the impedance mismatch.  Still, I imagine
> > you're used to dealing with those by now and have a toolbox of ideas.
> >
> > We don't have that rule for the pagecache as it is.  We do have rules that
> > prevent data corruption!  For example, if the folio is !uptodate then you
> > must have the lock to write to the folio in order to bring it uptodate
> > (so we have a single writer rule in that regard).  But once the folio is
> > uptodate, all bets are off in terms of who can be writing to it / reading
> > it at the same time.  And that's going to have to continue to be true;
> > multiple processes can have the same page mmaped writable and write to
> > it at the same time.  There's no possible synchronisation between them.
> >
> > But I think your concern is really more limited.  You're concerned
> > with filesystem metadata obeying Rust's rules.  And for a read-write
> > filesystem, you're going to have to have ... something ... which gets a
> > folio from the page cache, and establishes that this is the only thread
> > which can modify that folio (maybe it's an interior node of a Btree,
> > maybe it's a free space bitmap, ...).  We could probably use the folio
> > lock bit for that purpose,  For the read-only filesystems, you only need
> > be concerned about freshly-allocated folios, but you need something more
> > when it comes to doing an ext2 clone.
> >
> > There's general concern about the overuse of the folio lock bit, but
> > this is a reasonable use -- preventing two threads from modifying the
> > same folio at the same time.
>
> Sorry, I didn't quite finish this thought; that'll teach me to write
> complicated emails last thing at night.
>
> The page cache has no single-writer vs multiple-reader exclusion on folios
> found in the page cache.  We expect filesystems to implement whatever
> exclusion they need at a higher level.  For example, ext2 has no higher
> level lock on its block allocator.  Once the buffer is uptodate (ie has
> been read from storage), it uses atomic bit operations in order to track
> which blocks are freed.  It does use a spinlock to control access to
> "how many blocks are currently free".
>
> I'm not suggesting ext2 is an optimal strategy.  I know XFS and btrfs
> use rwsems, although I'm not familiar enough with either to describe
> exactly how it works.

Thanks for this explanation, it's good to see this kind of high-level
decisions/directions spelled out. When we need writable file systems,
we'll encode this in the type system.

