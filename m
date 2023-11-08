Return-Path: <linux-fsdevel+bounces-2353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584D7E4FCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 05:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED25A2814B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76768F5B;
	Wed,  8 Nov 2023 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iglw28FI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B63239
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 04:54:13 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F8D7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 20:54:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b3f6dd612cso3792749b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699419252; x=1700024052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLKgp1YEMHFSrdbjD8ydOV01K5tKjOEnyS+RjT/+kyk=;
        b=iglw28FI6vi3n3wn9VFADmAGEiyoOqDOeeNwJKYh5fXX7fGAYWQfxKe3fdOEwiDXTO
         WTvmHWz6L7RzgjEEPe7DNDVLtLN7tPcEDM0AYh9Y414UTojccOPk2Hb/xoQTtJWms9Nl
         2Qhql+DE8hdNCnd8dC+3xtPFrVbEDBBNIWkb/l2Z/DaM6z51n9n9mvWgJKnt4G7Fc7Jp
         fz0WWuiL7GyY9nLinyn0yrikecngvTLKPAiqC1rokXEZiq2bMAd44LcQugLwFJCzjFXQ
         /1+AfkJwCeLgRcS9FgPQFIXqzxIZXsgfJAcip+yk7Nnf5mtYvBJjLB1AmIHG2v//griV
         sx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699419252; x=1700024052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLKgp1YEMHFSrdbjD8ydOV01K5tKjOEnyS+RjT/+kyk=;
        b=NANWFQuvOkfVKzxXwnjQTdDDq7pNgnyaAE/DKUUmcAw4GnZ2yWVgi6ctXjEtMnJ2lo
         ICnBlFkjpWsRR9c+aJVMy6qD50hZYJCMLVRs5XJ7Pst9npOlK1xb88Jvpldr07fRhpvk
         /zAUFGf+Htp4h11BFMemuSuBkwISQawnUdm7ownIqIeaEjCakyH1Z7W10UnedZKzf0M5
         RGDfnf5cPTZ0ljV4d55gKejgF29+2cP+j2gWomVwl93kC8rLiPpp3YspyGjlgIpq8BW6
         8BRf2UQg2yzq64rrAByPjOLGD6jm/AAbtUzaQ5FI/ZzkGwZJRXYYUt4rSJ4QZ5JDe94z
         jWHg==
X-Gm-Message-State: AOJu0Yw0gxyfyiM9fTjLEJIUebM3Ye3x2+8C/Hj25zr9NLkmi7HKc7eL
	ekRbU94Y7b6bg8z/KM0jPiLTXg==
X-Google-Smtp-Source: AGHT+IGqct68ua/6YVrv44dc6uBz8F6sLmKW/QYXzYOGzg15r41q1vR6MFsqIw/fiTriEQel0501wQ==
X-Received: by 2002:a54:4110:0:b0:3b2:f500:7be3 with SMTP id l16-20020a544110000000b003b2f5007be3mr960065oic.39.1699419252338;
        Tue, 07 Nov 2023 20:54:12 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id y11-20020a62f24b000000b0066a4e561beesm8202440pfl.173.2023.11.07.20.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 20:54:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r0aZt-009jFq-1p;
	Wed, 08 Nov 2023 15:54:09 +1100
Date: Wed, 8 Nov 2023 15:54:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	Benno Lossin <benno.lossin@proton.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZUsUcU/s56zogyac@dread.disaster.area>
References: <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux>
 <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>
 <ZTQDztmY0ivPcGO/@casper.infradead.org>
 <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home>
 <ZTYE0PSDwITrWMHv@dread.disaster.area>
 <CANeycqq49Ubj-3BKcUaMOKeEwFastZzC17z_uk_VE3RDDv2wfw@mail.gmail.com>
 <ZT8VG0MTKNNpGDOC@dread.disaster.area>
 <CANeycqpwFs3Sfz86ngG-ysQuP1-MzVdkMNZPFXWUgvBrphdiAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqpwFs3Sfz86ngG-ysQuP1-MzVdkMNZPFXWUgvBrphdiAQ@mail.gmail.com>

On Tue, Oct 31, 2023 at 05:49:19PM -0300, Wedson Almeida Filho wrote:
> On Sun, 29 Oct 2023 at 23:29, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 09:55:08AM -0300, Wedson Almeida Filho wrote:
> > > On Mon, 23 Oct 2023 at 02:29, Dave Chinner <david@fromorbit.com> wrote:
> > > > IOWs, if you follow the general rule that any inode->i_state access
> > > > (read or write) needs to hold inode->i_lock, you probably won't
> > > > screw up.
> > >
> > > I don't see filesystems doing this though. In particular, see
> > > iget_locked() -- if a new inode is returned, then it is locked, but if
> > > a cached one is found, it's not locked.
> >
> > I did say "if you follow the general rule".
> >
> > And where there is a "general rule" there is the implication that
> > there are special cases where the "general rule" doesn't get
> > applied, yes? :)
> 
> Sure. But when you say "if _you_ do X", it gives me the impression
> that I have a choice. But if want to use `iget_locked`, I don't have
> the option to follow the "general rule" you state.
> 
> I guess I have the option to ignore `iget_locked`. :)
> 
> > I_NEW is the exception to the general rule, and very few people
> > writing filesystems actually know about it let alone care about
> > it...
> <snip>
> > All of them are perfectly fine.
> 
> I'm not sure I agree with this. They may be fine, but I wouldn't say
> perfectly. :)
> 
> > I_NEW is the bit we use to synchronise inode initialisation - we
> > have to ensure there is only a single initialisation running while
> > there are concurrent lookups that can find the inode whilst it is
> > being initialised. We cannot hold a spin lock over inode
> > initialisation (it may have to do IO!), so we set the I_NEW flag
> > under the i_lock and the inode_hash_lock during hash insertion so
> > that they are set atomically from the hash lookup POV. If the inode
> > is then found in cache, wait_on_inode() does the serialisation
> > against the running initialisation indicated by the __I_NEW bit in
> > the i_state word.
> >
> > Hence if the caller of iget_locked() ever sees I_NEW, it is
> > guaranteed to have exclusive access to the inode and -must- first
> > initialise the inode and then call unlock_new_inode() when it has
> > completed. It doesn't need to hold inode->i_lock in this case
> > because there's nothing it needs to serialise against as
> > iget_locked() has already done all that work.
> >
> > If the inode is found in cache by iget_locked, then the
> > wait_on_inode() call is guaranteed to ensure that I_NEW is not set
> > when it returns. The atomic bit operations on __I_NEW and the memory
> > barriers in unlock_new_inode() plays an important part in this
> > dance, and they guarantee that I_NEW has been cleared before
> > iget_locked() returns. No need for inode->i_lock to be held in this
> > case, either, because iget_locked() did all the serialisation for
> > us.
> 
> Thanks for explanation!
> 
> Let's consider the case when I call `inode_get`, and it finds an inode
> that _has_ been fully initialised before, so I_NEW is not set in
> inode->i_state and the inode is _not_ locked.
> 
> But the only means of checking that is by inspecting the i_state
> field, so I do something like:
> 
> if (!(inode->i_state & I_NEW))
>     return inode;
> 
> But now suppose that while I'm doing a naked load on inode->i_state,
> another cpu is running concurrently and happens to be holding the
> inode->i_lock, so it is within its right to write to inode->i_state,
> for example through a call to __inode_add_lru, which has the
> following:
> 
> inode->i_state |= I_REFERENCED;
> 
> So we have a thread doing a naked read and another thread doing a
> naked write, no ordering between them.
> 
> Would you agree that this is a data race? (Note that I'm not asking if
> "it will be ok" or "the compilers today generate the right code", I'm
> asking merely if you agree this is a data race.)

I'll agree that technically it is a data race on the entire i_state
word. Practically, however, it is not a data race on the I_NEW bit
within that word. The I_NEW bit remains unchanged across the entire
operation.

i.e. it does not matter where the read of i_state intersects with
the RMW of I_REFERENCED bit, the I_NEW bit remains unchanged in
memory across the operation. If the above operation results in the
I_NEW bit changing state in memory - even transiently - then the
compiler implementation is simply broken...

> If you do, then you'd have to agree that we are in undefined-behaviour
> territory. I can quote the spec if you'd like.

/me shrugs

I can point you at lots of code that it will break if bit operations
are allowed to randomly change other bits in the word transiently.

> Anyway, the discussion here is that this is also undefined behaviour
> in Rust. And we're trying really hard to avoid that. Of course, in
> cases like this there's not much we can do on the Rust side alone so
> the conclusion now appears to be that we'll introduce helper functions
> for this now and live with it. If one day we have a better solution,
> we'll update just one place.

All the rust code that calls iget_locked() needs to do to "be safe"
is the rust equivalent of:

	spin_lock(&inode->i_lock);
	if (!(inode->i_state & I_NEW)) {
		spin_unlock(&inode->i_lock);
		return inode;
	}
	spin_unlock(&inode->i_lock);

IOWs, we solve the "safety" concern by ensuring that Rust filesystem
implementations follow the general rule of "always hold the i_lock
when accessing inode->i_state" I originally outlined, yes?

> But we want the be very deliberate about these. We don't want to
> accidentally introduce data races (and therefore potential undefined
> behaviour).

The stop looking at the C code and all the exceptions we make for
special case optimisations and just code to the generic rules for
safe access to given fields. Yes, rust will then have to give up the
optimisations we make in the C code, but there's always a price for
safety...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

