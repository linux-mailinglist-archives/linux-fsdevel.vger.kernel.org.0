Return-Path: <linux-fsdevel+bounces-689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD77CE5E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441EAB21261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9A3FE55;
	Wed, 18 Oct 2023 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVKM+q1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE33FB33;
	Wed, 18 Oct 2023 18:07:23 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE211C;
	Wed, 18 Oct 2023 11:07:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4452627276.1;
        Wed, 18 Oct 2023 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697652441; x=1698257241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OSlrQAgM+k1wMB6Z68g3ftb4jGZMPolV8ubzXfKvFOg=;
        b=lVKM+q1rD/IT31OBTqLMrlmagTGPpE8bghs1Lg1wpDFIuWW792U3l5q1vtX6x+ga8y
         sSuhxUJ9ifrkfrDsE69Pq3NElzZAZNHlrQozSYNyCXzO8F6esohwKnM9G4lgDvnHQ0H5
         wXnaEXSNuhg+vCE7UF7+ESkJCMe+g+wcMLSEsBQaT+pRSgUXnHtSTfYDpf4VxUX7lDBt
         2ZcMnGTh/MpHyzOLMW1JadKxyKhcBqQB4wQXjPduc48PLA13JoCYofX46XKd/v7OXeP+
         I6grVSYClnwzL2dgGjy02mJ7s1UMc9VAlCkrbvyjDgSxbEWgGS7Iz/nNRKuBjiSrISiI
         rtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652441; x=1698257241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSlrQAgM+k1wMB6Z68g3ftb4jGZMPolV8ubzXfKvFOg=;
        b=C1HH1dUqOHBnUEhk9NjeRuZB8AZm83Wxke/5lymvu7Hoxb2fpyvYCbaXqdxhx5+iPD
         qr8aBm4NpxlRKs6wNf7lyehzf8KKus+DFJajhKhJCt/5Mt6QWLHU6s8rFn7SyZisZqZh
         InKYdhYnxbQVdYn1HH5J6aBj44evJ9u5gqk9JmtISyf4zimZLvqfc7vNciN5Yzbr54CQ
         fN5zSMow/HlFUhLLhgYd58Hp1XLWyFz9uSsY+0tITH6lV/+bvmm987vdWmkYKrlaxafN
         Fn2xwzjhMMSEYb0vmSYOwkI15iPeMwbtg+kTwrSBEDJWw0ApDe+N2f1aW5DE/65Yiv5y
         oo7A==
X-Gm-Message-State: AOJu0Yz0WvuezvVKT4jqBodWAldIEjsNg/q6u3Xe7bCDKHVCXnw2PqwC
	688Cs654f+vXKoqyN+BQqif61MDOpG9p8wrxYBDFZ07u6bM=
X-Google-Smtp-Source: AGHT+IErHFbWAHGHjZ3maqQ1dsR4QQ1h9NIDIH0NlyP9vGkM0pfUGzywVvsepHUch37h+q3NBk2TdCB0TMmICGvIqrQ=
X-Received: by 2002:a5b:94d:0:b0:d9a:cd2a:a18 with SMTP id x13-20020a5b094d000000b00d9acd2a0a18mr131846ybq.24.1697652441005;
 Wed, 18 Oct 2023 11:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZTAOfMvegVAc58Yn@casper.infradead.org> <CANeycqqTgj_cVyRx1ZvGFjZjK0ACBUPobDk93ovP41DSXK2Xmg@mail.gmail.com>
 <ZTATyXETyGeAVSxd@casper.infradead.org>
In-Reply-To: <ZTATyXETyGeAVSxd@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 18 Oct 2023 15:07:10 -0300
Message-ID: <CANeycqqU3tNTmCvQp2rjEUf1xB2qo+Q60h7G+i7hW3oE-HBW3g@mail.gmail.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 at 14:20, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 02:05:51PM -0300, Wedson Almeida Filho wrote:
> > On Wed, 18 Oct 2023 at 13:57, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> > > > +    fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
> > > > +        let pos = u64::try_from(folio.pos()).unwrap_or(u64::MAX);
> > > > +        let size = u64::try_from(inode.size())?;
> > > > +        let sb = inode.super_block();
> > > > +
> > > > +        let copied = if pos >= size {
> > > > +            0
> > > > +        } else {
> > > > +            let offset = inode.data().offset.checked_add(pos).ok_or(ERANGE)?;
> > > > +            let len = core::cmp::min(size - pos, folio.size().try_into()?);
> > > > +            let mut foffset = 0;
> > > > +
> > > > +            if offset.checked_add(len).ok_or(ERANGE)? > sb.data().data_size {
> > > > +                return Err(EIO);
> > > > +            }
> > > > +
> > > > +            for v in sb.read(offset, len)? {
> > > > +                let v = v?;
> > > > +                folio.write(foffset, v.data())?;
> > > > +                foffset += v.data().len();
> > > > +            }
> > > > +            foffset
> > > > +        };
> > > > +
> > > > +        folio.zero_out(copied, folio.size() - copied)?;
> > > > +        folio.mark_uptodate();
> > > > +        folio.flush_dcache();
> > > > +
> > > > +        Ok(())
> > > > +    }
> > >
> > > Who unlocks the folio here?
> >
> > The `Drop` implementation of `LockedFolio`.
> >
> > Note that `read_folio` is given ownership of `folio` (the last
> > argument), so when it goes out of scope (or when it's explicitly
> > dropped) its `drop` function is called automatically. You'll its
> > implementation (and the call to `folio_unlock`) in patch 9.
>
> That works for synchronous implementations of read_folio(), but for
> an asynchronous implementation, we need to unlock the folio once the
> read completes, typically in the bio completion handler.  What's the
> plan for that?  Hand ownership of the folio to the bio submission path,
> which hands it to the bio completion path, which drops the folio?

Yes, exactly. (I mentioned this in a github comment a few days back:
https://github.com/Rust-for-Linux/linux/pull/1037#discussion_r1359706872.)

The code as is doesn't allow a `LockedFolio` to outlive this call but
we can add support as you described.

Part of the reason support for this isn't included in this series is
that are no Rust users of the async code path. And we've been told
repeatedly by Greg and others that we must not add code that isn't
used yet.

