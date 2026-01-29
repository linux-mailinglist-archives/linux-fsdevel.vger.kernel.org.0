Return-Path: <linux-fsdevel+bounces-75917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCDRKEPke2nBJAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:50:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1511BB5834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF4E300D631
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454236B064;
	Thu, 29 Jan 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvCLqyJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDE36B06F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727038; cv=pass; b=av8FwZMoIJA/nkUEN0m73Lf/4CimhQZ0B3xmR9xC6Uv8gDcryM3m/9xrU8S7El3Z1hDW+o/4685Zda8VkIwJBMNSp15B2UumS8/RMS/zrTqBslQmuOXyDaWHj+uSuwlaD8hNC/cgpcJRogvVOEwEYRGrZEy8WdqhSil8a2TmDWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727038; c=relaxed/simple;
	bh=L4iUBimPNtXTVH9il8UzlnDW04nAXXdPLmZ4Jt1QLC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqGnw6G2qmtDUywRMkikQWzUqcTHa0a/y709wGMXIbiok2eVMlqxTbKTnvsy85FCITSgvdVZpbdOdp9dK1+4VdCzVUAX6mDEbrMFv87AtwMgCvBQlA7tYUujeg8akpUQ99M0bTnIpnein5cMhfaqzNJwuMHfSErqFM03hc+Qll0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvCLqyJY; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-503bf474fdfso11585421cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 14:50:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769727034; cv=none;
        d=google.com; s=arc-20240605;
        b=PeyqgbYQhKtuLdqN8QPjQIDLx9x3OFtPCREN44a7J+5t2aOq72+NcJ+4X/4cwLjWdC
         +/gYXXE085EUdCJyQOXka3BZf5BHLfTnmHmI+aDlUSuWnv5f/966ics3I98ZK+G0wsp/
         v+nEgol5mwZuiT+TGPNPflXqJugSXDUOsI5eME2YyBDN9RYr3UT/8GdfQOxmXRBLtLYZ
         gYdeHKahtJrHTdZXrbC73yIo/TiUB5bSBql4DF3pwZsM959gx4cE214kga/tfScuZQvY
         fGXwglp9ioClQX2w2fL+1Za2MLj71xFqYcFnKWEm4LrnDtgNO6qm+Uqc+kmUKTKjMoP1
         l0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZUK1HaUJrRiaXZg5G5WW1YkreAyTlgUPY27auYP/epg=;
        fh=hhKHmYsdxrLVblIVAFgTqR+gHuqPtmyUwge9vGq8JU0=;
        b=eNaXzFvHwAMP6GfezVkzxB4nn7387PHTKrQ/252boIf8q6rB4v9kwpX2A8Ypp6DFd0
         BRYYClWcZgJCohJBi0u4cSCbMtTrmzcNsFvyW7wsLrrRXnxPUz2Xd4DNOr3pcn6J7k41
         /pDHzsrvfCzN04w+e3+pZw8+dx/oyzJFRsW/Q1yctvI/CAY1JFZYBVORpctgT/SxYS8S
         jH5tcXhsPfyvzudM3pybROdoroA2QAeZgDOpAUGVnxOJ9qU4WV4CjfiATpejfyJ1h/zn
         PB58kDcVbVwh64hfXYKOx0mAWXEbGpvLvGri4QRyDptCvHLzLJp0GumWSmONV9/t/TjI
         gYEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769727034; x=1770331834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUK1HaUJrRiaXZg5G5WW1YkreAyTlgUPY27auYP/epg=;
        b=CvCLqyJYgDd0MbRajAp9kXCnxDFbXmJAR9zZT1xaf/izErfyByz24lxrk5rQmeWle6
         oKSRQMf6RcYKCKXD4mdEN0aKcrqZ/wfheEUiq9uJoL0n7KebdAk502qvlxqw+Gg8VPFO
         +UErOPWBgp7LLGkAUyFUt5Sac4nZA1tmvinKT8xrfuyeXHozom/tx3QmagRuK17cKnM7
         MZRLdZ/Pn/QnuLtMlI1Ztj8DqJ9M2Davn/CeRzxIJUxHBUlI3jkg5tSMvCdEqiVCwF/D
         0z1JRTIPmreZk8u7RNuzwb5GzeuPEKOcs4YSNFXTZnJUtvJHJhnoxR7sbGEWKqLb/fcl
         IbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769727034; x=1770331834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUK1HaUJrRiaXZg5G5WW1YkreAyTlgUPY27auYP/epg=;
        b=He8x7ScUNpx6fH4LmoRJ1gevflTM2DKEEEA5TNBQWRyL9Hm+1VGoMalD7fbld3foOl
         Pk0Uz3wAcU/dqHsAzry/yrOelo5xW3IM5auCFIvTAiSG/4jBzojKJrlF0cScV2Xwe1du
         kncF2G6gjSaeclRR80QY9tNzv/c5voPMA+b58bz4wHXmnT1xdwzc7k4E/579zD3saebs
         /sob3VgFfbcPr/OEbQ7TzHUWQjQzgl9HCFSr8lFIAYQHqtQQjxBvbWMEumAiosFd/QL3
         ivWAGdkM4AkHPTMgZFmnfz3ilVbZHpGgH4kd6ahnEr1oTsj40jeZexbquqh9N5U1hUJN
         rcGg==
X-Forwarded-Encrypted: i=1; AJvYcCXQNvPczZsdfutaxQZSz4oYQEkJ8taiIjYpH1bsdxJ6AO1XHCaB1Wtip7aQs2PpnkdVX5mNJmh3B12kRIxp@vger.kernel.org
X-Gm-Message-State: AOJu0YwCf/zaI2bHzhI2YATSLZLEzF67o2yaFUQJQdi8rYnR+K+IH5GE
	ykrcg7y8L6c6/Selqkh00g50uGpZMKx4Mlo/5loN8ZUBlxfCI2r727d5KGtIsHsQIJtFVX/Tq/e
	iD5KMqt35QNPux2KmQIkb8Lm5e/EagrA=
X-Gm-Gg: AZuq6aIp9eQes9lYPjzqtyrUDNMmJPsL4opy27nFikaLsbhb+mcRHoAI2pD8nlqmMAV
	AmgI7JLVc2UIosiAVhay3WSOqsFgB7/2lB0ZU/acrS+GUCjK3UfWuLSvlyN4m5WQaNBMl4ogfaT
	Zm9YTRQyiW8P4VE62vdWijey9i3koA+yJ69jyCZbuKa3RPNyyj19S4108okUJljglIy6l3Nlxob
	o/MrXQr2oZGjcvQnMFijvYaTNT8Mcb3VTYUwD0EaQqTjYjt1zahwR8ZdOgFIAzilCMwnA==
X-Received: by 2002:ac8:5f54:0:b0:4f1:ddeb:c4c with SMTP id
 d75a77b69052e-505d218e15bmr15178961cf.21.1769727034095; Thu, 29 Jan 2026
 14:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs> <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
 <20260127022235.GG5900@frogsfrogsfrogs> <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
 <20260127232125.GA5966@frogsfrogsfrogs> <CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com>
 <20260128003431.GX5910@frogsfrogsfrogs> <CAJnrk1aBGx_FQ=_F-PaPshVKvyecdZZt4C0+z+XvNm6=tL0Y_Q@mail.gmail.com>
 <20260129200254.GA7686@frogsfrogsfrogs>
In-Reply-To: <20260129200254.GA7686@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 Jan 2026 14:50:23 -0800
X-Gm-Features: AZwV_QjqE0NeLsnBQ5ArrIhWu8cwmUQBzgqRK9cnh6w_Ja7SFIfpNDj51VMUraQ
Message-ID: <CAJnrk1ag3ffQC=U1ZXVLTipDyo1VBQBM3MYNB6=6d4ywLOEieA@mail.gmail.com>
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75917-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1511BB5834
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:02=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Jan 28, 2026 at 05:12:54PM -0800, Joanne Koong wrote:
>
> <snip>
>
> > > > > > > Hrmm.  Now that /is/ an interesting proposal.  Does BPF have =
a data
> > > > > > > structure that supports interval mappings?  I think the exist=
ing bpf map
> > > > > >
> > > > > > Not yet but I don't see why a b+ tree like data strucutre could=
n't be added.
> > > > > > Maybe one workaround in the meantime that could work is using a=
 sorted
> > > > > > array map and doing binary search on that, until interval mappi=
ngs can
> > > > > > be natively supported?
> > > > >
> > > > > I guess, though I already had a C structure to borrow from xfs ;)
> > > > >
> > > > > > > only does key -> value.  Also, is there an upper limit on the=
 size of a
> > > > > > > map?  You could have hundreds of millions of maps for a very =
fragmented
> > > > > > > regular file.
> > > > > >
> > > > > > If I'm remembering correctly, there's an upper limit on the num=
ber of
> > > > > > map entries, which is bounded by u32
> > > > >
> > > > > That's problematic, since files can have 64-bit logical block num=
bers.
> > > >
> > > > The key size supports 64-bits. The u32 bound would be the limit on =
the
> > > > number of extents for the file.
> > >
> > > Oh, ok.  If one treats the incore map as a cache and evicts things wh=
en
> > > they get too old, then that would be fine.  I misread that as an uppe=
r
> > > limit on the *range* of the map entry keys. :/
> >
> > I think for more complicated servers, the bpf prog handling for
> > iomap_begin() would essentially just serve as a cache where if it's
> > not found in the cache, then it sends off the FUSE_IOMAP_BEGIN request
> > to the server. For servers that don't need as much complicated logic
> > (eg famfs), the iomap_begin() logic would just be executed within the
> > bpf prog itself.
>
> Yes, I like the fuse_iomap_begin logic flow of:
>
> 1. Try to use a mapping in the iext tree
> 2. Call a BPF program to try to generate a mapping
> 3. Issue a fuse command to userspace
>
> wherein #2 and #3 can signal that #1 should be retried.  (This is
> already provided by FUSE_IOMAP_TYPE_RETRY_CACHE, FWIW)
>
> That said, BPF doesn't expose an interval btree data structure.  I think
> it would be better to add the iext mapping cache and make it so that bpf
> programs could call fuse_iomap_cache_{upsert,remove,lookup}.  You could
> use the interval tree too, but the iext tree has the advantage of higher
> fanout factor.
>
> > > As it stands, I need to figure out a way to trim the iomap btree when
> > > memory gets tight.  Right now it'll drop the cache whenever someone
> > > closes the file, but that won't help for long-life processes that ope=
n a
> > > heavily fragmented file and never close it.
> > >
> > > A coding-intensive way to do that would be to register a shrinker and
> > > deal with that, but ugh.  A really stupid way would be to drop the wh=
ole
> > > cache once you get beyond (say) 64k of memory usage (~2000 mappings).
> >
> > This kind of seems like another point in favor of giving userspace
> > control of the caching layer. They could then implement whatever
> > eviction policies they want.
>
> Note that userspace already can control the cached iomappings --
> FUSE_NOTIFY_IOMAP_UPSERT pushes a mapping into the iext tree, and
> FUSE_NOTIFY_IOMAP_INVAL removes them.  The fuse server can decide to

This incurs round-trip context-switch costs though, which the bpf prog
approach doesn't incur.

> evict whenever it pleases, though admittedly the iext tree doesn't track
> usage information of any kind, so how would the fuse server know?
>
> The static limit is merely the kernel's means to establish a hard limit
> on the memory consumption of the iext tree, since it can't trust
> userspace completely.
>
> > It also allows them to prepopulate the cache upfront (eg when
> > servicing a file open request, if the file is below a certain size or
> > if the server knows what'll be hot, it could put those extents into
> > the map from the get-go).
>
> Hrm.  I haven't tried issuing FUSE_NOTIFY_IOMAP_UPSERT during an open
> call, but I suppose it's possible.
>
> > in my opinion, the fuse-iomap layer should try to be as simple/minimal
> > and as generic as possible. I haven't read through iomap_cache.c yet
> > but the header comment suggests it's adapted from the xfs extent tree
>
> Rudely copied, not adapted ;)
>
> I actually wonder if I should make a horrible macro to generate the
> fuse_iext_* structures and functions, and then xfs_iext_tree.c and
> fuse_iomap_cache.c can "share" that hairba^Wcode.
>
> > cache. As I understand it, different filesystem implementations have
> > different caching architectures that are better suited for their use
> > cases
>
> Err.  The way this evolved is ... way too long to go into in this email.
> Here's a truncated version; I can tell you the full story next week.
>
> Most filesystems store their file mapping data on disk in whatever
> format the designers specified.  When the pagecache asks them to read
> or write the cache, they attach buffer heads to the folio, fill out the
> buffer heads with the minimum mapping information needed to map the
> folios to disk addresses.  bios are constructed for each folio based on
> what's in the bufferhead.
>
> This was fine for filesystems that map each block individually, such as
> FFS/ext2/ext3/fat...
>
> > (I'm guessing that's the case, otherwise there would just be one
> > general cache inside iomap all the filesystems would use?). It seems a
>
> ...but newer filesystems such as xfs/ext4/btrfs map a bunch of blocks at
> a time.  Each of them invented their own private incore mapping
> structures to mirror the ondisk structure.  xfs kept using the old
> bufferheads into the early 2010s, ext4 is still using them, and btrfs
> went its own way from the start.
>
> Eventually XFS grew its own internal extent-to-bio mapping code that
> flipped the model -- rather than get a pagecache folio, map the folio to
> blocks, and issue IOs based on the blocks, it would get the file
> mapping, grab folios for the whole mapping, and issue bios for the batch
> of folios.  That's more efficient, but at this point we have a legacy
> codebase problem for everything else in fs/.
>
> In 2019, hch and I decided to export the extent-to-bio mapping code from
> xfs so that new filesystems could start with something cleaner than
> bufferheads.  In the past 7 years, nobody's added a new filesystem with
> complex mapping requirements; they've only ported existing filesystems
> to it, without further refactoring of their incore data structures.
> That's why there's no generic iomap cache.

Oh I see, so it actually *is* a generic cache? Just that the other
filesystems haven't ported over to it yet? That changes my opinion a
lot on this then. If it's a generic cache that pretty much any modern
filesystem should use, then it seems reasonable to me to have it on
the fuse iomap kernel side. Though in that case, it seems a lot
cleaner imo if the cache could be ported to the iomap layer as a
generic cache (which seems like it'd be useful anyways for other
filesystems to use if/when they port over to it, if I'm understanding
what you're saying correctly), and then fuse just call into that api.

>
> > lot better to me to just let the userspace server define that
> > themselves. And selfishly from the fuse perspective, would be less
>
> Well if I turned the iext code into a template then fuse would only need
> enough glue code to declare a template class and use it.  The glue part
> is only ... 230LOC.

Nice, I think this would be a lot nicer / less of a headache in the
future for fuse to maintain.

>
> > code we would have to maintain. And I guess too if some servers don't
> > need caching (like famfs?), they could avoid that overhead.
>
> Hrm.  Right now the struct fuse_iomap_cache is embedded in struct
> fuse_inode, but that could be turned into a dynamic allocation.
>
> > > > > > > At one point I suggested to the famfs maintainer that it migh=
t be
> > > > > > > easier/better to implement the interleaved mapping lookups as=
 bpf
> > > > > > > programs instead of being stuck with a fixed format in the fu=
se
> > > > > > > userspace abi, but I don't know if he ever implemented that.
> > > > > >
> > > > > > This seems like a good use case for it too
> > > > > > >
> > > > > > > > Is this your
> > > > > > > > assessment of it as well or do you think the server-side lo=
gic for
> > > > > > > > iomap_begin()/iomap_end() is too complicated to make this r=
ealistic?
> > > > > > > > Asking because I'm curious whether this direction makes sen=
se, not
> > > > > > > > because I think it would be a blocker for your series.
> > > > > > >
> > > > > > > For disk-based filesystems I think it would be difficult to m=
odel a bpf
> > > > > > > program to do mappings, since they can basically point anywhe=
re and be
> > > > > > > of any size.
> > > > > >
> > > > > > Hmm I'm not familiar enough with disk-based filesystems to know=
 what
> > > > > > the "point anywhere and be of any size" means. For the mapping =
stuff,
> > > > > > doesn't it just point to a block number? Or are you saying the =
problem
> > > > > > would be there's too many mappings since a mapping could be any=
 size?
> > > > >
> > > > > The second -- mappings can be any size, and unprivileged userspac=
e can
> > > > > control the mappings.
> > > >
> > > > If I'm understanding what you're saying here, this is the same
> > > > discussion as the one above about the u32 bound, correct?
> > >
> > > A different thing -- file data mappings are irregularly sized, can
> > > contain sparse holes, etc.  Userspace controls the size and offset of
> > > each mapping record (thanks to magic things like fallocate) so it'd b=
e
> > > very difficult to create a bpf program to generate mappings on the fl=
y.
> >
> > Would the bpf prog have to generate mappings on the fly though? If the
> > userspace does things like fallocate, those operations would still go
> > through to the server as a regular request (eg FUSE_FALLOCATE) and on
> > the server side, it'd add that to the map dynamically from userspace.
>
> That depends on the fuse server design.  For simple things like famfs
> where the layout is bog simple and there's no fancy features like
> delayed allocation or unwritten extents, then you could probably get
> away a BPF program to generate the entire mapping set.  I suspect an
> object-store type filesystem (aka write a file once, close it, snapshot
> it, and never change it again) might be good at landing all the file
> data in relatively few extent mappings, and it could actually compile a
> custom bpf program for that file and push it to the kernel.
>
> > > Also you could have 2^33 mappings records for a file, so I think you
> > > can't even write a bpf program that large.
> >
> > I think this depends on what map structure gets used. If there is
> > native support added for b+ tree like data structures, I don't see why
> > it wouldn't be able to.
>
> <nod>
>
> > > > > > I was thinking the issue would be more that there might be othe=
r logic
> > > > > > inside ->iomap_begin()/->iomap_end() besides the mapping stuff =
that
> > > > > > would need to be done that would be too out-of-scope for bpf. B=
ut I
> > > > > > think I need to read through the fuse4fs stuff to understand mo=
re what
> > > > > > it's doing in those functions.
> > > >
> > > > Looking at fuse4fs logic cursorily, it seems doable? What I like ab=
out
> > > > offloading this to bpf too is it would also then allow John's famfs=
 to
> > > > just go through your iomap plumbing as a use case of it instead of
> > > > being an entirely separate thing. Though maybe there's some other
> > > > reason for that that you guys have discussed prior. In any case, I'=
ll
> > > > ask this on John's main famfs patchset. It kind of seems to me that
> > > > you guys are pretty much doing the exact same thing conceptually.
> > >
> > > Yes, though John's famfs has the nice property that memory controller
> > > interleaving is mathematically regular and likely makes for a compact
> > > bpf program.
> >
> > I tried out integrating the bpf hooks into fuse for iomap_begin() just
> > to see if it was realistic and it seems relatively straightforward so
> > far (though maybe the devil is in the details...). I used the
>
> Ok, now *that's* interesting!  I guess I had better push the latest
> fuse-iomap code ... but I cannot share a link, because I cannot get
> through the @!#%%!!! kernel.org anubis bullcrap.
>
> So I generated a pull request and I *think* this munged URL will work
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/=
?h=3Dfuse-service-container_2026-01-29
>
> Or I guess you could just git-pull this:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags=
/fuse-service-container_2026-01-29
>
> > drivers/hid/bpf/hid_bpf_struct_ops.c program as a model for how to set
> > up the fuse bpf struct ops on the kernel side. calling it from
> > file_iomap.c looks something like
> >
> > static int fuse_iomap_begin(...)
> > {
> >        ...
> >        struct fuse_bpf_ops *bpf_ops =3D fuse_get_bpf_ops();
> >        ...
> >       err =3D -EOPNOTSUPP;
> >       if (bpf_ops && bpf_ops->iomap_begin)
> >                err =3D bpf_ops->iomap_begin(inode, pos, len, flags, &ou=
targ);
> >        if (err)
> >                err =3D fuse_simple_request(fm, &args);
> >       ...
> > }
>
> I'm curious what the rest of the bpf integration code looks like.

This is the code I had yesterday (I didn't know how to run the fuse4fs
stuff, so I used passthrough_hp as the server and had the trigger go
through statfs):


diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4..10c3939f4cf3 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
 fuse-y :=3D trace.o      # put trace.o first so we see ftrace errors soone=
r
 fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o i=
octl.o
 fuse-y +=3D iomode.o
+fuse-y +=3D fuse_bpf.o
 fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
 fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
diff --git a/fs/fuse/fuse_bpf.c b/fs/fuse/fuse_bpf.c
new file mode 100644
index 000000000000..637cf152e997
--- /dev/null
+++ b/fs/fuse/fuse_bpf.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+
+#include "fuse_i.h"
+#include "fuse_dev_i.h"
+#include "fuse_bpf.h"
+
+static struct btf *fuse_bpf_ops_btf;
+static struct fuse_bpf_ops *active_bpf_ops;
+
+static int fuse_bpf_ops_init(struct btf *btf)
+{
+       fuse_bpf_ops_btf =3D btf;
+       return 0;
+}
+
+static bool fuse_bpf_ops_is_valid_access(int off, int size,
+                                         enum bpf_access_type type,
+                                         const struct bpf_prog *prog,
+                                         struct bpf_insn_access_aux *info)
+{
+       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int fuse_bpf_ops_check_member(const struct btf_type *t,
+                                     const struct btf_member *member,
+                                     const struct bpf_prog *prog)
+{
+       return 0;
+}
+
+static int fuse_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
+                                          const struct bpf_reg_state *reg,
+                                          int off, int size)
+{
+       return 0;
+}
+
+static const struct bpf_verifier_ops fuse_bpf_verifier_ops =3D {
+       .get_func_proto =3D bpf_base_func_proto,
+       .is_valid_access =3D fuse_bpf_ops_is_valid_access,
+       .btf_struct_access =3D fuse_bpf_ops_btf_struct_access,
+};
+
+static int fuse_bpf_ops_init_member(const struct btf_type *t,
+                                   const struct btf_member *member,
+                                   void *kdata, const void *udata)
+{
+    const struct fuse_bpf_ops *u_ops =3D udata;
+    struct fuse_bpf_ops *ops =3D kdata;
+    u32 moff;
+
+    moff =3D __btf_member_bit_offset(t, member) / 8;
+    switch (moff) {
+    case offsetof(struct fuse_bpf_ops, name):
+        if (bpf_obj_name_cpy(ops->name, u_ops->name,
+                             sizeof(ops->name)) <=3D 0)
+            return -EINVAL;
+        return 1;  /* Handled */
+    }
+
+    /* Not handled, use default */
+    return 0;
+}
+
+static int fuse_bpf_reg(void *kdata, struct bpf_link *link)
+{
+       struct fuse_bpf_ops *ops =3D kdata;
+
+       active_bpf_ops =3D ops;
+
+       printk("fuse_bpf: registered ops '%s'\n", ops->name);
+
+       return 0;
+}
+
+static void fuse_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+       struct fuse_bpf_ops *ops =3D kdata;
+
+       if (active_bpf_ops =3D=3D ops)
+               active_bpf_ops =3D NULL;
+
+       printk("fuse_bpf: unregistered ops '%s'\n", ops->name);
+}
+
+static int __iomap_begin(struct inode *inode, loff_t pos,
+                        loff_t length, unsigned int flags,
+                        struct fuse_iomap_io *out_io)
+{
+       printk("stub __iomap_begin(). should never get called\n");
+       return 0;
+}
+
+static struct fuse_bpf_ops __fuse_bpf_ops =3D {
+       .iomap_begin =3D __iomap_begin,
+};
+
+static struct bpf_struct_ops fuse_bpf_struct_ops =3D {
+       .verifier_ops =3D &fuse_bpf_verifier_ops,
+       .init =3D fuse_bpf_ops_init,
+       .check_member =3D fuse_bpf_ops_check_member,
+       .init_member =3D fuse_bpf_ops_init_member,
+       .reg =3D fuse_bpf_reg,
+       .unreg =3D fuse_bpf_unreg,
+       .name =3D "fuse_bpf_ops",
+       .cfi_stubs =3D &__fuse_bpf_ops,
+       .owner =3D THIS_MODULE,
+};
+
+struct fuse_bpf_ops *fuse_get_bpf_ops(void)
+{
+       return active_bpf_ops;
+}
+
+int fuse_bpf_init(void)
+{
+       return register_bpf_struct_ops(&fuse_bpf_struct_ops, fuse_bpf_ops);
+}
+
+BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_bpf_ops_id, struct, fuse_bpf_ops)
+BTF_ID_LIST_GLOBAL_SINGLE(btf_fuse_iomap_io_id, struct, fuse_iomap_io)
diff --git a/fs/fuse/fuse_bpf.h b/fs/fuse/fuse_bpf.h
new file mode 100644
index 000000000000..d9482b64642b
--- /dev/null
+++ b/fs/fuse/fuse_bpf.h
@@ -0,0 +1,29 @@
+#ifndef _FS_FUSE_BPF_H
+#define _FS_FUSE_BPF_H
+
+#include "fuse_i.h"
+#include <linux/iomap.h>
+
+/* copied from darrick's iomap patchset */
+struct fuse_iomap_io {
+        uint64_t offset;        /* file offset of mapping, bytes */
+        uint64_t length;        /* length of mapping, bytes */
+        uint64_t addr;          /* disk offset of mapping, bytes */
+        uint16_t type;          /* FUSE_IOMAP_TYPE_* */
+        uint16_t flags;         /* FUSE_IOMAP_F_* */
+        uint32_t dev;           /* device cookie */
+};
+
+struct fuse_bpf_ops {
+    int (*iomap_begin)(struct inode *inode, loff_t pos,
+                      loff_t length, unsigned int flags,
+                      struct fuse_iomap_io *out_io__nullable);
+
+    /* Required for bpf struct_ops */
+    char name[16];
+};
+
+struct fuse_bpf_ops *fuse_get_bpf_ops(void);
+int fuse_bpf_init(void);
+
+#endif /* _FS_FUSE_BPF_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d66622..78ae4425e863 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -7,6 +7,7 @@
 */

 #include "fuse_i.h"
+#include "fuse_bpf.h"
 #include "fuse_dev_i.h"
 #include "dev_uring_i.h"

@@ -662,6 +663,21 @@ static int fuse_statfs(struct dentry *dentry,
struct kstatfs *buf)
        struct fuse_statfs_out outarg;
        int err;

+       printk("fuse_statfs() called!\n");
+
+       struct fuse_bpf_ops *bpf_ops =3D fuse_get_bpf_ops();
+       struct fuse_iomap_io out_io =3D {};
+
+       /* call BPF prog if attached */
+       if (bpf_ops && bpf_ops->iomap_begin) {
+               err =3D bpf_ops->iomap_begin(d_inode(dentry), 111, 222,
+                                          333, &out_io);
+               printk("bpf prog returned: err=3D%d, out_io->offset=3D%llu\=
n",
+                      err, out_io.offset);
+       } else {
+               printk("did not find a bpf prog\n");
+       }
+
        if (!fuse_allow_current_process(fm->fc)) {
                buf->f_type =3D FUSE_SUPER_MAGIC;
                return 0;
@@ -2194,6 +2210,12 @@ static int __init fuse_fs_init(void)
        if (!fuse_inode_cachep)
                goto out;

+       err =3D fuse_bpf_init();
+       if (err) {
+               printk("fuse_bpf_init() failed %d\n", err);
+               goto out2;
+       }
+
        err =3D register_fuseblk();
        if (err)
                goto out2;


These are the changes for the libfuse side:
https://github.com/joannekoong/libfuse/commit/1a6198f17dd215c93fd82ec020641=
c079aae1241

To run it, run "make clean; make" from libfuse/example, and then sudo
ninja from libfuse/build, and then
 sudo ~/libfuse/build/example/passthrough_hp ~/liburing ~/mounts/tmp2
--nopassthrough --foreground

Then from ~/mounts/tmp2, run "stat -f filename" and that will show a few th=
ings:
on the kernel side it'll print a statement like "bpf prog returned:
err=3D0, out_io->offset=3D999" which shows that the prog can return back a
"struct fuse_iomap_io" with all the requisite metadata filled out
on the server-side, if you run " sudo cat
/sys/kernel/debug/tracing/trace_pipe", that should print out "
bpf_trace_printk: fuse iomap_begin: inode=3Dffff8a75cbe63800 pos=3D111
len=3D222 flags=3D333" which shows the prog can take in whatever
pos/len/flags values you pass it from the fuse kernel


>
> > and I was able to verify that iomap_begin() is able to return back
> > populated outarg fields from the bpf prog. If we were to actually
> > implement it i'm sure it'd be more complicated (eg we'd need to make
> > the fuse_bpf_ops registered per-connection, etc) but on the whole it
>
> What is a fuse_bpf_ops?  I'm assuming that's the attachment point for a
> bpf program that the fuse server would compile?  In which case, yes, I
> think that ought to be per-connection.
>
> So the bpf program can examine the struct inode, and the pos/len/opflags
> field; and from that information it has to write the appropriate fields
> in &outarg?  That's new, I didn't think bpf was allowed to write to
> kernel memory.  But it's been a few years since I last touched the bpf
> internals.

It's been a few years since I looked at bpf as well but yes
fuse_bpf_ops is basically the kernel-side struct_ops interface for
getting fuse to trigger the attached bpf program's callback
implementations. When the bpf program is loaded in, its callback
functions get swapped in and fuse_bpf_ops's function pointers now
point to the bpf's callback functions, so when you invoke
fuse_bpf_ops's callbacks, it calls into the bpf prog's callback.

>
> Some bpf programs might just know how to fill out outarg on their own
> (e.g. famfs memory interleaving) but other bpf programs might perform a
> range query on some imaginary bpf-interval-tree wherein you can do a
> fast lookup based on (inumber, pos, len)?
>
> I guess that's an interesting question -- would each fuse connection
> have one big bpf-interval-tree?  Or would you shard things by inode to
> reduce contention?  And if you sharded like that, then would you need a
> fuse_bpf_ops per inode?

Hmm the cache's tree is per-inode as I understand it, so probably each
inode would have its own tree / map?

>
> (I'm imagining that the fuse_bpf_ops might be where you'd stash the root
> of the bpf data structure, but I know nothing of bpf internals ;))
>
> Rolling on: how easy is it for a userspace program to compile and upload
> bpf programs into the kernel?  I've played around with bcc enough to
> write some fairly stupid latency tracing tools for XFS, but at the end
> of the day it still python scripts feeding a string full of maybe-C into
> whatever the BPF does under the hood.

I found it pretty easy with the libbpf library which will generate the
skeletons and provide the api helpers to load it in and other stuff
(the libfuse link I pasted above for the userspace side has the code
for compiling it and loading it).

>
> I /think/ it calls clang on the provided text, links that against the
> current kernel's header files, and pushes the compiled bpf binary into
> the kernel, right?  So fuse4fs would have to learn how to do that; and
> now fuse4fs has a runtime dependency on libllvm.

I think the libbpf library takes care of a lot of that for you. I
think fuse4fs would just need to do the same thing as in that libfuse
link above

>
> And while I'm on the topic of fuse-bpf uapi: It's ok for us to expose
> primitive-typed variables (pos/len/opflags) and existing fuse uapi
> directly to a bpf program, but I don't think we should expose struct
> inode/fuse_inode.  Maybe just fuse_inode::nodeid?  If we're careful not
> to allow #include'ing structured types in the fuse bpf code, then
> perhaps the bpf programs could be compiled at the same time as the fuse
> server.

I agree, I think if we do decide to go further with this approach,
we'll need to define exactly what the interfaces should be that would
be safe to expose.

>
> > seems doable. My worry is that if we land the iomap cache patchset now
> > then we can't remove it in the future without breaking backwards
> > compatibility for being a performance regression (though maybe we can
> > since the fuse-iomap stuff is experimental?), so imo it'd be great if
>
> I don't think it's a huge problem to remove functionality while the
> EXPERIMENTAL warnings are in place.  We'd forever lose the command codes
> for FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL, but we've only
> used 12 out of INT_MAX so that's not likely to be a concern.
>
> > we figured out what direction we want to go before landing the cache
> > stuff. And I think we need to have this conversation too on the main
> > famfs patchset (eg whether it should go through your general iomap
> > plumbing with bpf helpers vs. being a separate implementation) since
> > once that lands, it'd be irrevocable.
>
> I've of two minds on that -- John got here first, so I don't want to
> delay his patchset whilst I slowly work on this thing.  OTOH from an
> architecture standpoint we probably ought to push for three ways for a
> fuse server to upload mappings:

I think if John/Miklos wanted to go in this direction, all that would
be needed from your series is the first one or two patches that define
the basic fuse_iomap_io / fuse_iomap_begin / fuse_iomap_end structs
and init config plumbing.

Thanks,
Joanne

>
> 1. Upserting mappings with arbitrary offset and size into a cache
> 2. Self contained bpf program that can generate any mapping
> 3. Sprawling bpf program that can read any other artifacts that another
>    bpf program might have set up for it
>
> But yeah, let's involve John.
>
> --D
>
> >
> > Thanks,
> > Joanne
> > >
> > > --D
> > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > > <nod>
> > > > >
> > > > > --D
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Joanne
> > > > > >
> > > > > > >
> > > > > > > OTOH it would be enormously hilarious to me if one could load=
 a file
> > > > > > > mapping predictive model into the kernel as a bpf program and=
 use that
> > > > > > > as a first tier before checking the in-memory btree mapping c=
ache from
> > > > > > > patchset 7.  Quite a few years ago now there was a FAST paper
> > > > > > > establishing that even a stupid linear regression model could=
 in theory
> > > > > > > beat a disk btree lookup.
> > > > > > >
> > > > > > > --D
> > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Joanne
> > > > > > > >
> > > > > > > > >
> > > > > > > > > If you're going to start using this code, I strongly reco=
mmend pulling
> > > > > > > > > from my git trees, which are linked below.
> > > > > > > > >
> > > > > > > > > This has been running on the djcloud for months with no p=
roblems.  Enjoy!
> > > > > > > > > Comments and questions are, as always, welcome.
> > > > > > > > >
> > > > > > > > > --D
> > > > > > > > >
> > > > > > > > > kernel git tree:
> > > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-l=
inux.git/log/?h=3Dfuse-iomap-fileio
> > > > > > > > > ---
> > > > > > > > > Commits in this patchset:
> > > > > > > > >  * fuse: implement the basic iomap mechanisms
> > > > > > > > >  * fuse_trace: implement the basic iomap mechanisms
> > > > > > > > >  * fuse: make debugging configurable at runtime
> > > > > > > > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add n=
ew iomap devices
> > > > > > > > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to=
 add new iomap devices
> > > > > > > > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTR=
OY on unmount
> > > > > > > > >  * fuse: create a per-inode flag for toggling iomap
> > > > > > > > >  * fuse_trace: create a per-inode flag for toggling iomap
> > > > > > > > >  * fuse: isolate the other regular file IO paths from iom=
ap
> > > > > > > > >  * fuse: implement basic iomap reporting such as FIEMAP a=
nd SEEK_{DATA,HOLE}
> > > > > > > > >  * fuse_trace: implement basic iomap reporting such as FI=
EMAP and SEEK_{DATA,HOLE}
> > > > > > > > >  * fuse: implement direct IO with iomap
> > > > > > > > >  * fuse_trace: implement direct IO with iomap
> > > > > > > > >  * fuse: implement buffered IO with iomap
> > > > > > > > >  * fuse_trace: implement buffered IO with iomap
> > > > > > > > >  * fuse: implement large folios for iomap pagecache files
> > > > > > > > >  * fuse: use an unrestricted backing device with iomap pa=
gecache io
> > > > > > > > >  * fuse: advertise support for iomap
> > > > > > > > >  * fuse: query filesystem geometry when using iomap
> > > > > > > > >  * fuse_trace: query filesystem geometry when using iomap
> > > > > > > > >  * fuse: implement fadvise for iomap files
> > > > > > > > >  * fuse: invalidate ranges of block devices being used fo=
r iomap
> > > > > > > > >  * fuse_trace: invalidate ranges of block devices being u=
sed for iomap
> > > > > > > > >  * fuse: implement inline data file IO via iomap
> > > > > > > > >  * fuse_trace: implement inline data file IO via iomap
> > > > > > > > >  * fuse: allow more statx fields
> > > > > > > > >  * fuse: support atomic writes with iomap
> > > > > > > > >  * fuse_trace: support atomic writes with iomap
> > > > > > > > >  * fuse: disable direct reclaim for any fuse server that =
uses iomap
> > > > > > > > >  * fuse: enable swapfile activation on iomap
> > > > > > > > >  * fuse: implement freeze and shutdowns for iomap filesys=
tems
> > > > > > > > > ---
> > > > > > > > >  fs/fuse/fuse_i.h          |  161 +++
> > > > > > > > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > > > > > > > >  fs/fuse/iomap_i.h         |   52 +
> > > > > > > > >  include/uapi/linux/fuse.h |  219 ++++
> > > > > > > > >  fs/fuse/Kconfig           |   48 +
> > > > > > > > >  fs/fuse/Makefile          |    1
> > > > > > > > >  fs/fuse/backing.c         |   12
> > > > > > > > >  fs/fuse/dev.c             |   30 +
> > > > > > > > >  fs/fuse/dir.c             |  120 ++
> > > > > > > > >  fs/fuse/file.c            |  133 ++-
> > > > > > > > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++=
++++++++++++++++++++++
> > > > > > > > >  fs/fuse/inode.c           |  162 +++
> > > > > > > > >  fs/fuse/iomode.c          |    2
> > > > > > > > >  fs/fuse/trace.c           |    2
> > > > > > > > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > > > > > > > >  create mode 100644 fs/fuse/iomap_i.h
> > > > > > > > >  create mode 100644 fs/fuse/file_iomap.c
> > > > > > > > >
> > > > > > > >
> > > >
> >

