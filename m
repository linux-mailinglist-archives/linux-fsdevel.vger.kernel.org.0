Return-Path: <linux-fsdevel+bounces-1517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDFF7DB20F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 03:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B184B20DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A41EC2;
	Mon, 30 Oct 2023 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="E/Y3MToH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403F806
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 02:29:53 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BFBF
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 19:29:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso22834995ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 19:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698632991; x=1699237791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bCdvSlpz1hDv7p4GSr2XVNxtMcsUc8tGdKVI0ksdEg=;
        b=E/Y3MToH1WN7+WIkBdtvDPc9tveLAn0fZqYCltdshwHJFeqdaNDf59UgiMXlw/CfQF
         XIg0bGhXuk+oczexzJolId4yRD5XGb+SOMPokdmbwSTkFXl8xTMMUvIETAKQKCiRE5sZ
         32kVTozhRTUTo7BnK7EufDg1GRhy+cusS48ANVUa5FzcbLcvtc9cXzfPCStYz27Dm7JY
         fZB5ju1k5Lxb2e5Dyl/D5GYDKLeVXtsN7EyNp0I648wjfqn1xjWMsZXa3sCsg3IrrRQs
         HVe7zx3YTz6hMZRlbU41/CdQHJ560XNi/nDW7/CgSplJQJsEEFV/sHlEQRSK2/th24w6
         sJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698632991; x=1699237791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bCdvSlpz1hDv7p4GSr2XVNxtMcsUc8tGdKVI0ksdEg=;
        b=pQ/6ksZx6oVzsH0vNTdyQLoyxOUbzSkT9442FJdDK7QrxLc0G2hEwuTt3KmFksU3//
         v5VvK0/hk3W8oTIRzuTeTs9rehC/shtD0WiYP4rDN7o2x+K6nmoOFBP4NMRA3M+fZdoL
         u2aEtNFmEly8VTSNTYF3nGiU+GLcOyJzpH9/hFeSD38wkroxVQHroH9eyLRLf5TvIojl
         N6isPnYxX7HUOxcSA9pBeG0G51qZr/FvZG2wKK+kqsZsttB2RMUejXsjP14Q3y75pxZX
         gQaVVL2ah2GJizTQYh0NJ8GwnAIVE1JoaerC4EyJDNfhf/Av4B4Pi8BHmllMBo84E5qZ
         u0jQ==
X-Gm-Message-State: AOJu0YybruVZM51/bo6KcEJbr4fg0MFkAztB/8baitDg4yZXzddmpbCW
	8uaCtgK2URfXEGH92FhxHGNtEA==
X-Google-Smtp-Source: AGHT+IGdFyNqQZGTK3X91Bqwn5ScSLeGF8Jk6HTe0zARBVHvUCJ4yYQ04EWIJEqJ/Lok7o/AK7oHKA==
X-Received: by 2002:a17:903:32c3:b0:1cc:45d0:470b with SMTP id i3-20020a17090332c300b001cc45d0470bmr2938121plr.7.1698632990924;
        Sun, 29 Oct 2023 19:29:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001b9f032bb3dsm5282609pln.3.2023.10.29.19.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 19:29:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qxI2F-005jod-05;
	Mon, 30 Oct 2023 13:29:47 +1100
Date: Mon, 30 Oct 2023 13:29:47 +1100
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
Message-ID: <ZT8VG0MTKNNpGDOC@dread.disaster.area>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux>
 <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>
 <ZTQDztmY0ivPcGO/@casper.infradead.org>
 <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home>
 <ZTYE0PSDwITrWMHv@dread.disaster.area>
 <CANeycqq49Ubj-3BKcUaMOKeEwFastZzC17z_uk_VE3RDDv2wfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqq49Ubj-3BKcUaMOKeEwFastZzC17z_uk_VE3RDDv2wfw@mail.gmail.com>

On Mon, Oct 23, 2023 at 09:55:08AM -0300, Wedson Almeida Filho wrote:
> On Mon, 23 Oct 2023 at 02:29, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sat, Oct 21, 2023 at 12:33:57PM -0700, Boqun Feng wrote:
> > > On Sat, Oct 21, 2023 at 06:01:02PM +0100, Matthew Wilcox wrote:
> > > > I'm only an expert on the page cache, not the rest of the VFS.  So
> > > > what are the rules around modifying i_state for the VFS?
> > >
> > > Agreed, same question here.
> >
> > inode->i_state should only be modified under inode->i_lock.
> >
> > And in most situations, you have to hold the inode->i_lock to read
> > state flags as well so that reads are serialised against
> > modifications which are typically non-atomic RMW operations.
> >
> > There is, I think, one main exception to read side locking and this
> > is find_inode_rcu() which does an unlocked check for I_WILL_FREE |
> > I_FREEING. In this case, the inode->i_state updates in iput_final()
> > use WRITE_ONCE under the inode->i_lock to provide the necessary
> > semantics for the unlocked READ_ONCE() done under rcu_read_lock().
> >
> > IOWs, if you follow the general rule that any inode->i_state access
> > (read or write) needs to hold inode->i_lock, you probably won't
> > screw up.
> 
> I don't see filesystems doing this though. In particular, see
> iget_locked() -- if a new inode is returned, then it is locked, but if
> a cached one is found, it's not locked.

I did say "if you follow the general rule".

And where there is a "general rule" there is the implication that
there are special cases where the "general rule" doesn't get
applied, yes? :)

I_NEW is the exception to the general rule, and very few people
writing filesystems actually know about it let alone care about
it...

> So we're in this situation where a returned inode may or may not be
> locked. And the way to determine if it's locked or not is to read
> i_state.
> 
> Here are examples of kernfs, ext2, ext4 and squashfs doing it:
> https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/kernfs/inode.c#L252
> https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/ext2/inode.c#L1392
> https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/ext4/inode.c#L4707
> https://elixir.bootlin.com/linux/v6.6-rc7/source/fs/squashfs/inode.c#L82
> 
> They all call iget_locked(), and if I_NEW is set, they initialise the
> inode and unlock it with unlock_new_inode(); otherwise they just
> return the unlocked inode.

All of them are perfectly fine.

I_NEW is the bit we use to synchronise inode initialisation - we
have to ensure there is only a single initialisation running while
there are concurrent lookups that can find the inode whilst it is
being initialised. We cannot hold a spin lock over inode
initialisation (it may have to do IO!), so we set the I_NEW flag
under the i_lock and the inode_hash_lock during hash insertion so
that they are set atomically from the hash lookup POV. If the inode
is then found in cache, wait_on_inode() does the serialisation
against the running initialisation indicated by the __I_NEW bit in
the i_state word.

Hence if the caller of iget_locked() ever sees I_NEW, it is
guaranteed to have exclusive access to the inode and -must- first
initialise the inode and then call unlock_new_inode() when it has
completed. It doesn't need to hold inode->i_lock in this case
because there's nothing it needs to serialise against as
iget_locked() has already done all that work.

If the inode is found in cache by iget_locked, then the
wait_on_inode() call is guaranteed to ensure that I_NEW is not set
when it returns. The atomic bit operations on __I_NEW and the memory
barriers in unlock_new_inode() plays an important part in this
dance, and they guarantee that I_NEW has been cleared before
iget_locked() returns. No need for inode->i_lock to be held in this
case, either, because iget_locked() did all the serialisation for
us.

This special dance is an optimisation that avoids the need to take
inode->i_lock in the inode lookup fast path just to check I_NEW. It
is an exception to the general rule but internal it uses
inode->i_lock in the places it is needed to ensure anything using
the general rule about accessing i_state still behaves correctly.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

