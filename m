Return-Path: <linux-fsdevel+bounces-1602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC97DC3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0310BB20E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 01:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72EA3F;
	Tue, 31 Oct 2023 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OsQu4Sp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E336D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 01:42:48 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FFD3
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 18:42:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso4577675b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698716564; x=1699321364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gq2lGFwF4bxRWBxtwu5w9sBzhD8p8IyhBLW9hVZaXvI=;
        b=OsQu4Sp24Y//SSKVWnyXGhdFRfjp5JW3WpxBFovMlg8XnaYK3/RFSHkoKjWzX8f23A
         UNdE/3AkGlRHCpunbJtimdQ+4KG2WDwP5LXjOtmh8vc5cdlysOpgS5JKaJZYt14Lzi6a
         pALaXIjyk+UGeOpIrNUEkRO0V+2za2gygWKnglNE0Jvcf7fRR9xNZYoywmc/W2khrMWg
         jrkb3qgo4+YUCA2GpFbFS/lsn0LbT/2v3fOGtmmCCCytx5sukT9G9LmXYzQt8ieRiaft
         ECQP/yyliI3kh+ECxYzwtVcZDzcXzRQrzzJxpgJXfMM4yG2h20eFZp7HReJsfbcKWgfn
         vUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698716564; x=1699321364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq2lGFwF4bxRWBxtwu5w9sBzhD8p8IyhBLW9hVZaXvI=;
        b=p3O6aUfsknZwz+6c8z+vxgBmTqfD19uWQ0kQwuCw8UZEd4uAR44f9ZstZgJCvhPi7v
         Ai1lYLWNKFOtZxhmEph7mmC1D8isfb8k2CI4NOhenXI8J1R9Pxx3GIcNq86udVm4gjXg
         RTMxnVegnx/NQhA8Sw8VnAinsUZECERkO7FT52te24HutWnnD0rdof8ugFrVLI0Qf32s
         PJqmKI5sdHU3QVx2SWBHGQX0YHbHmbwvSC18Vk76qzMHgXizVnIN9T2YrwCAfZ3IsCwg
         Vwh1E+OTzbYlaIlaJOJGRV+skn/C9KPLcysF4t3SWCOV00qWXmABFBtwzjzodzOvUBr6
         xhow==
X-Gm-Message-State: AOJu0Yycj56g2cAdVEbXGkeYtbdunpLQ+r3zLR2GhngyrORCk0eDE33h
	uoqEmcnBEpVMgcoxxB3EsCRNwA==
X-Google-Smtp-Source: AGHT+IGdn0+gqtPwjsc6S1RJPgTznnlDmnMp6k47wccNyrWTBrFDio/A8SFbOI5f2QToLrcb1QPM3A==
X-Received: by 2002:a05:6a21:778a:b0:16b:7602:1837 with SMTP id bd10-20020a056a21778a00b0016b76021837mr10790249pzc.29.1698716564006;
        Mon, 30 Oct 2023 18:42:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id y19-20020aa78553000000b00686b649cdd0sm142984pfn.86.2023.10.30.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 18:42:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qxdmB-0069xx-2l;
	Tue, 31 Oct 2023 12:42:39 +1100
Date: Tue, 31 Oct 2023 12:42:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
References: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>

On Mon, Oct 30, 2023 at 01:11:56PM -1000, Linus Torvalds wrote:
> On Mon, 30 Oct 2023 at 12:37, Dave Chinner <david@fromorbit.com> wrote:
> >
> > If XFS can ignore relatime or lazytime persistent updates for given
> > situations, then *we don't need to make periodic on-disk updates of
> > atime*. This makes the whole problem of "persistent atime update bumps
> > i_version" go away because then we *aren't making persistent atime
> > updates* except when some other persistent modification that bumps
> > [cm]time occurs.
> 
> Well, I think this should be split into two independent questions:
> 
>  (a) are relatime or lazytime atime updates persistent if nothing else changes?

They only become persistent after 24 hours or, in the case of
relatime, immediately persistent if mtime < atime (i.e. read after a
modification). Those are the only times that the VFS triggers
persistent writeback of atime, and it's the latter case (mtime <
atime) that is the specific trigger that exposed the problem with
atime bumping i_version in the first place.

>  (b) do atime updates _ever_ update i_version *regardless* of relatime
> or lazytime?
>
> and honestly, I think the best answer to (b) would be that "no,
> i_version should simply not change for atime updates". And I think
> that answer is what it is because no user of i_version seems to want
> it.

As I keep repeating: Repeatedly stating that "atime should not bump
i_version" does not address the questions I'm asking *at all*.

> Now, the reason it's a single question for you is that apparently for
> XFS, the only thing that matters is "inode was written to disk" and
> that "di_changecount" value is thus related to the persistence of
> atime updates, but splitting di_changecount out to be a separate thing
> from i_version seems to be on the table, so I think those two things
> really could be independent issues.

Wrong way around - we'd have to split i_version out from
di_changecount. It's i_version that has changed semantics, not
di_changecount, and di_changecount behaviour must remain unchanged.

What I really don't want to do is implement a new i_version field in
the XFS on-disk format. What this redefinition of i_version
semantics has made clear is that i_version is *user defined
metadata*, not internal filesystem metadata that is defined by the
filesystem on-disk format.

User defined persistent metadata *belongs in xattrs*, not in the
core filesystem on-disk formats. If the VFS wants to define and
manage i_version behaviour, smeantics and persistence independently
of the filesystems that manage the persistent storage (as it clearly
does!) then we should treat it just like any other VFS defined inode
metadata (e.g. per inode objects like security constraints, ACLs,
fsverity digests, fscrypt keys, etc). i.e. it should be in a named
xattr, not directly implemented in the filesystem on-disk format
deinfitions.

Then the application can change the meaning of the metadata whenever
and however it likes. Then filesystem developers just don't need
to care about it at all because the VFS specific persistent metadata
is not part of the on-disk format we need to maintain
cross-platform forwards and backwards compatibility for.

> > But I don't want to do this unconditionally - for systems not
> > running anything that samples i_version we want relatime/lazytime
> > to behave as they are supposed to and do periodic persistent updates
> > as per normal. Principle of least surprise and all that jazz.
> 
> Well - see above: I think in a perfect world, we'd simply never change
> i_version at all for any atime updates, and relatime/lazytime simply
> wouldn't be an issue at all wrt i_version.

Right, that's what I'd like, especially as the new definition of
i_version - "only change when [cm]time changes" - means that the VFS
i_version is really now just a glorified timestamp.

> Wouldn't _that_ be the trule "least surprising" behavior? Considering
> that nobody wants i_version to change for what are otherwise pure
> reads (that's kind of the *definition* of atime, after all).

So, if you don't like the idea of us ignoring relatime/lazytime
conditionally, are we allowed to simply ignore them *all the time*
and do all timestamp updates in the manner that causes users the
least amount of pain?

I mean, relatime only exists because atime updates cause users pain.
lazytime only exists because relatime doesn't address the pain that
timestamp updates cause mixed read/write or pure O_DSYNC overwrite
workloads pain. noatime is a pain because it loses all atime
updates.

There is no "one size is right for everyone", so why not just let
filesystems do what is most efficient from an internal IO and
persistence POV whilst still maintaining the majority of "expected"
behaviours?

Keep in mind, though, that this is all moot if we can get rid of
i_version entirely....

> Now, the annoyance here is that *both* (a) and (b) then have that
> impact of "i_version no longer tracks di_changecount".

.... and what is annoying is that that the new i_version just a
glorified ctime change counter. What we should be fixing is ctime -
integrating this change counting into ctime would allow us to make
i_version go away entirely. i.e. We don't need a persistent ctime
change counter if the ctime has sufficient resolution or persistent
encoding that it does not need an external persistent change
counter.

That was reasoning behind the multi-grain timestamps. While the mgts
implementation was flawed, the reasoning behind it certainly isn't.
We should be trying to get rid of i_version by integrating it into
ctime updates, not arguing how atime vs i_version should work.

> So I don't think the issue here is "i_version" per se. I think in a
> vacuum, the best option of i_version is pretty obvious.  But if you
> want i_version to track di_changecount, *then* you end up with that
> situation where the persistence of atime matters, and i_version needs
> to update whenever a (persistent) atime update happens.

Yet I don't want i_version to track di_changecount.

I want to *stop supporting i_version altogether* in XFS.

I want i_version as filesystem internal metadata to die completely.

I don't want to change the on disk format to add a new i_version
field because we'll be straight back in this same siutation when the
next i_version bug is found and semantics get changed yet again.

Hence if we can encode the necessary change attributes into ctime,
we can drop VFS i_version support altogether.  Then the "atime bumps
i_version" problem also goes away because then we *don't use
i_version*.

But if we can't get the VFS to do this with ctime, at least we have
the abstractions available to us (i.e. timestamp granularity and
statx change cookie) to allow XFS to implement this sort of
ctime-with-integrated-change-counter internally to the filesystem
and be able to drop i_version support.... 

[....]

> This really is all *entirely* an artifact of that "bi_changecount" vs
> "i_version" being tied together. You did seem to imply that you'd be
> ok with having "bi_changecount" be split from i_version, ie from an
> earlier email in this thread:
> 
>  "Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
>   the change cookie, we really don't need to expose di_changecount in
>   i_version at all - we could simply copy an internal di_changecount
>   value into the statx cookie field in xfs_vn_getattr() and there
>   would be almost no change of behaviour from the perspective of NFS
>   and IMA at all"

.... which is what I was talking about here.

i.e. I was not talking about splitting i_version from di_changecount
- I was talking about being able to stop supporting the VFS
i_version counter entirely and still having NFS and IMA work
correctly.

Continually bring the argument back to "atime vs i_version" misses
the bigger issues around this new i_version definition and
implementation, and that the real solution should be to fix ctime
updates to make i_version at the VFS level go away forever.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

