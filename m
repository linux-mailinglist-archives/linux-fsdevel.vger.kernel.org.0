Return-Path: <linux-fsdevel+bounces-75831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJr6FS60emma9QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:13:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A94AA874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C273302D96E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85E314D26;
	Thu, 29 Jan 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwFozfbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB12313534
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649188; cv=pass; b=Jm9TjBuba+15ThHDC0Uob8g1euZqGwwx91oDv4MdUC/8iAC6+P8e+ZT1BZeg1XtEXsJApLYb7Fbqm9a+tsGPjdEYVPSG8/ASkg1+vTSm0wcys4it7dCzMPDJFAJ1hCfxjsj8oziGHSX6sm5dyQtTXn7IwnWeaP12JEHUzJ+zDPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649188; c=relaxed/simple;
	bh=xc8KPrY7qr2KJfWLJx1nHvX93kGFE1sfwlPxYJMa1kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5+QFwQqG18tv/1PIJvrBz476xU9K4q9yU/xTyGOyJ3zTE8g+yW9yYJuViCJUznrQY8CytShXDV5YIxHOJc2BRdy8PG1VZ1v26MaoqSeMJDQ89dsU9yROMXQn12IOJBiYE4XgExHP0G+bWQe1oMqwx2W63WexAnU7l7eVXFNvqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwFozfbF; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-501506f448bso2907281cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:13:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769649185; cv=none;
        d=google.com; s=arc-20240605;
        b=JS5fKtPzCJqwgs8cr+7SVklam1w7acF3yI0RIy4fAp2Lb5S4o+AIAPKOjEA1vIyW6s
         j4kpQpJeghBfMopge3w/HSvA3hODDpKrztOIdSjOINqshhrvbuOtZ+gv2Pa2mGCU3rXG
         yYS1H8yg/O8JvWBZZY15YgC4A6a+nFv2kt9E6LAZZ50TCvQM0NETgzygBQ9yDGoBQQS1
         0lhX9G3mEghCoUwlzx/QQGNZ0EA8Iqw9c4s6cQNJtYFOiXn1v2pxY1kZXc1oozGltNId
         RRc6d5dyc5XcFaaEcwpdshkurHXl4V9St/v3TolnKlePaVona1hTRuJmy/tUgc0/GGr+
         7qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u4daGNpMwPVBimFsiKMgFwSRVZajiBOdkMBWepHTmF4=;
        fh=8FV7DvGWp3Fv8FTmAn/UfQr76EoaGW0jaW3+p9Ybi40=;
        b=U8C5kSfcCXUKhStQYz+X21biTG2c4F2BYASe80ZisG3+NRB/c3zGeDHCpjSE46Eawf
         K9kAWyGJxHvBi9LOuQ2NVpDZyggokDshGIBC4TBYQmeXkFDbhAsMX419tKtz39L2g6Wf
         tyso7XLUGpADmXaEmknwsvcC6TdaSHoeh5CPNJr51BIxbyTktC2Jr4SHgMRb+QoKI8rj
         oAEzeQwxRT9o5Pn9z0Xjwv5L02AptFbHVHdDbBnCh+n/PLJ9ROKHBZ7XzKMIDP6KqC4H
         OdgmKVzJg8XvUkoWvq62jLMMDfdPYslFcqJlNoE4itWPM8ueTa7XDgoROKToW55HkMou
         yhuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769649185; x=1770253985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4daGNpMwPVBimFsiKMgFwSRVZajiBOdkMBWepHTmF4=;
        b=HwFozfbFCga09Cs7C9xafLhLCmc4UJ7x64hXduG3lqS6Bj6yw3TcGo6q2d+dBYh5X/
         pmd/qpi+QOp/PIzEeaevIiKrHNHkurvxvnK98+oQe/quO5PCyuGFObozZ61xjP2EMMH7
         EP7YTdnxWxW3UrXbMxsZsnPODYqNA4Yg81xe7PMX4IsuNPqxVk/14jo0sVhkGTHyF4Jt
         IrskP8s4LJfnNCWfU4iQsQQ2GG6b3bPkYzpc5vonwiaS5re4Ec3B4omN2OXyNqyOvNRC
         vRAug/vWfKJ68poeU8IXp45xSRCZ8U/uqH+HGD2kS4metta6GsF2+k31vBGI3hML8TvN
         QqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649185; x=1770253985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4daGNpMwPVBimFsiKMgFwSRVZajiBOdkMBWepHTmF4=;
        b=MkiGNbapW+8ENMT1nrrK9DuGcAPML6pUkZtr5+fK1NXYGX7VRNNspH8SMIdGixl26J
         FKPtRAYclqt0Jwl5sN6cyzXbuhGU0egtoi78EQCoX4RmbipNZ5dTMtSi2NyBxY2c+Pdc
         Z5YaUV6MYk1xPuNzhNQ3iywBiLBDeThBqTtgyZff/mRfsGqLg8oJisiiBScm+ToAk6Df
         6fDcq/Nbw08WrS7MmId/OCzCP0oyWFdkQad/xgU8T/lPU30wJWzI3ratrNZNtjF7fDGY
         DPs1JNkKg7A9HBqAE2fJAfrcmfAT0uutgsLWWN8QCp08uaByesrGCNpwvYWbJjWqmHAv
         EJMg==
X-Forwarded-Encrypted: i=1; AJvYcCU5E44corGxgjH7EoI3hC5HfNfAAb2tVvjs5IJAjX2l8LSpkngCUzWyNf2zGmDUdNew89oN8yiiQz3Pk3iZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdU3/4kj8omrujMU7hxErBDfEmg25xYA0olrwz0D4reY0mAsG
	wKInibn1nPiywgo3JqRcyU31fFbVgeqzSnmmBx2WBppGc1qxAf04c5dGfhO7B5BMHWh9vZ+Llin
	kjOqiWKH3P2ki9NiAP326KPXIVwuy2yMP8gpy8hc=
X-Gm-Gg: AZuq6aLzraj3k92u6QSvZUxRrpL7Yaz3FArtVcvx/Hja32JZRzRyM74IrtWRSgZeV0h
	G29jYJ0aXEgdkQktIQPo+RCARDJaM3CfcKHUuN0TSRT+4gdyA9+vl35Jto8PcBOs/UBfjRGJDI0
	wwrwF65HRZN/xbNGPF21d2B66myzX7u3kgKTPP487YC8FTJmZB0H7EIt54Gealy4L8vDqOvGU/o
	nVKxa5yTrMi39tDoOh2UpsQoqQcHZIyFlvrtMiQX2UHqS+WLGSYngANDuWdGrsdWlYIgw==
X-Received: by 2002:a05:622a:4c8:b0:4ee:2984:7d95 with SMTP id
 d75a77b69052e-5032f74c526mr100024811cf.13.1769649185254; Wed, 28 Jan 2026
 17:13:05 -0800 (PST)
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
 <20260128003431.GX5910@frogsfrogsfrogs>
In-Reply-To: <20260128003431.GX5910@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 28 Jan 2026 17:12:54 -0800
X-Gm-Features: AZwV_Qj21Fe0zz_lyhtfO53IVHLqzHI1GSKWXENH33xVZNJmbkUj2BCigCfH2oE
Message-ID: <CAJnrk1aBGx_FQ=_F-PaPshVKvyecdZZt4C0+z+XvNm6=tL0Y_Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75831-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01A94AA874
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 4:34=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Jan 27, 2026 at 04:10:43PM -0800, Joanne Koong wrote:
> > On Tue, Jan 27, 2026 at 3:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Tue, Jan 27, 2026 at 11:47:31AM -0800, Joanne Koong wrote:
> > > > On Mon, Jan 26, 2026 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > On Mon, Jan 26, 2026 at 04:59:16PM -0800, Joanne Koong wrote:
> > > > > > On Tue, Oct 28, 2025 at 5:38=E2=80=AFPM Darrick J. Wong <djwong=
@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > This series connects fuse (the userspace filesystem layer) to=
 fs-iomap
> > > > > > > to get fuse servers out of the business of handling file I/O =
themselves.
> > > > > > > By keeping the IO path mostly within the kernel, we can drama=
tically
> > > > > > > improve the speed of disk-based filesystems.  This enables us=
 to move
> > > > > > > all the filesystem metadata parsing code out of the kernel an=
d into
> > > > > > > userspace, which means that we can containerize them for secu=
rity
> > > > > > > without losing a lot of performance.
> > > > > >
> > > > > > I haven't looked through how the fuse2fs or fuse4fs servers are
> > > > > > implemented yet (also, could you explain the difference between=
 the
> > > > > > two? Which one should we look at to see how it all ties togethe=
r?),
> > > > >
> > > > > fuse4fs is a lowlevel fuse server; fuse2fs is a high(?) level fus=
e
> > > > > server.  fuse4fs is the successor to fuse2fs, at least on Linux a=
nd BSD.
> > > >
> > > > Ah I see, thanks for the explanation. In that case, I'll just look =
at
> > > > fuse4fs then.
> > > >
> > > > >
> > > > > > but I wonder if having bpf infrastructure hooked up to fuse wou=
ld be
> > > > > > especially helpful for what you're doing here with fuse iomap. =
afaict,
> > > > > > every read/write whether it's buffered or direct will incur at =
least 1
> > > > > > call to ->iomap_begin() to get the mapping metadata, which will=
 be 2
> > > > > > context-switches (and if the server has ->iomap_end() implement=
ed,
> > > > > > then 2 more context-switches).
> > > > >
> > > > > Yes, I agree that's a lot of context switching for file IO...
> > > > >
> > > > > > But it seems like the logic for retrieving mapping
> > > > > > offsets/lengths/metadata should be pretty straightforward?
> > > > >
> > > > > ...but it gets very cheap if the fuse server can cache mappings i=
n the
> > > > > kernel to avoid all that.  That is, incidentally, what patchset #=
7
> > > > > implements.
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.=
git/log/?h=3Dfuse-iomap-cache_2026-01-22
> > > > >
> > > > > > If the extent lookups are table lookups or tree
> > > > > > traversals without complex side effects, then having
> > > > > > ->iomap_begin()/->iomap_end() be executed as a bpf program woul=
d avoid
> > > > > > the context switches and allow all the caching logic to be move=
d from
> > > > > > the kernel to the server-side (eg using bpf maps).
> > > > >
> > > > > Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a da=
ta
> > > > > structure that supports interval mappings?  I think the existing =
bpf map
> > > >
> > > > Not yet but I don't see why a b+ tree like data strucutre couldn't =
be added.
> > > > Maybe one workaround in the meantime that could work is using a sor=
ted
> > > > array map and doing binary search on that, until interval mappings =
can
> > > > be natively supported?
> > >
> > > I guess, though I already had a C structure to borrow from xfs ;)
> > >
> > > > > only does key -> value.  Also, is there an upper limit on the siz=
e of a
> > > > > map?  You could have hundreds of millions of maps for a very frag=
mented
> > > > > regular file.
> > > >
> > > > If I'm remembering correctly, there's an upper limit on the number =
of
> > > > map entries, which is bounded by u32
> > >
> > > That's problematic, since files can have 64-bit logical block numbers=
.
> >
> > The key size supports 64-bits. The u32 bound would be the limit on the
> > number of extents for the file.
>
> Oh, ok.  If one treats the incore map as a cache and evicts things when
> they get too old, then that would be fine.  I misread that as an upper
> limit on the *range* of the map entry keys. :/

I think for more complicated servers, the bpf prog handling for
iomap_begin() would essentially just serve as a cache where if it's
not found in the cache, then it sends off the FUSE_IOMAP_BEGIN request
to the server. For servers that don't need as much complicated logic
(eg famfs), the iomap_begin() logic would just be executed within the
bpf prog itself.

>
> As it stands, I need to figure out a way to trim the iomap btree when
> memory gets tight.  Right now it'll drop the cache whenever someone
> closes the file, but that won't help for long-life processes that open a
> heavily fragmented file and never close it.
>
> A coding-intensive way to do that would be to register a shrinker and
> deal with that, but ugh.  A really stupid way would be to drop the whole
> cache once you get beyond (say) 64k of memory usage (~2000 mappings).

This kind of seems like another point in favor of giving userspace
control of the caching layer. They could then implement whatever
eviction policies they want.

It also allows them to prepopulate the cache upfront (eg when
servicing a file open request, if the file is below a certain size or
if the server knows what'll be hot, it could put those extents into
the map from the get-go).

in my opinion, the fuse-iomap layer should try to be as simple/minimal
and as generic as possible. I haven't read through iomap_cache.c yet
but the header comment suggests it's adapted from the xfs extent tree
cache. As I understand it, different filesystem implementations have
different caching architectures that are better suited for their use
cases (I'm guessing that's the case, otherwise there would just be one
general cache inside iomap all the filesystems would use?). It seems a
lot better to me to just let the userspace server define that
themselves. And selfishly from the fuse perspective, would be less
code we would have to maintain. And I guess too if some servers don't
need caching (like famfs?), they could avoid that overhead.

>
> > > > > At one point I suggested to the famfs maintainer that it might be
> > > > > easier/better to implement the interleaved mapping lookups as bpf
> > > > > programs instead of being stuck with a fixed format in the fuse
> > > > > userspace abi, but I don't know if he ever implemented that.
> > > >
> > > > This seems like a good use case for it too
> > > > >
> > > > > > Is this your
> > > > > > assessment of it as well or do you think the server-side logic =
for
> > > > > > iomap_begin()/iomap_end() is too complicated to make this reali=
stic?
> > > > > > Asking because I'm curious whether this direction makes sense, =
not
> > > > > > because I think it would be a blocker for your series.
> > > > >
> > > > > For disk-based filesystems I think it would be difficult to model=
 a bpf
> > > > > program to do mappings, since they can basically point anywhere a=
nd be
> > > > > of any size.
> > > >
> > > > Hmm I'm not familiar enough with disk-based filesystems to know wha=
t
> > > > the "point anywhere and be of any size" means. For the mapping stuf=
f,
> > > > doesn't it just point to a block number? Or are you saying the prob=
lem
> > > > would be there's too many mappings since a mapping could be any siz=
e?
> > >
> > > The second -- mappings can be any size, and unprivileged userspace ca=
n
> > > control the mappings.
> >
> > If I'm understanding what you're saying here, this is the same
> > discussion as the one above about the u32 bound, correct?
>
> A different thing -- file data mappings are irregularly sized, can
> contain sparse holes, etc.  Userspace controls the size and offset of
> each mapping record (thanks to magic things like fallocate) so it'd be
> very difficult to create a bpf program to generate mappings on the fly.

Would the bpf prog have to generate mappings on the fly though? If the
userspace does things like fallocate, those operations would still go
through to the server as a regular request (eg FUSE_FALLOCATE) and on
the server side, it'd add that to the map dynamically from userspace.

>
> Also you could have 2^33 mappings records for a file, so I think you
> can't even write a bpf program that large.

I think this depends on what map structure gets used. If there is
native support added for b+ tree like data structures, I don't see why
it wouldn't be able to.

>
> > > > I was thinking the issue would be more that there might be other lo=
gic
> > > > inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
> > > > would need to be done that would be too out-of-scope for bpf. But I
> > > > think I need to read through the fuse4fs stuff to understand more w=
hat
> > > > it's doing in those functions.
> >
> > Looking at fuse4fs logic cursorily, it seems doable? What I like about
> > offloading this to bpf too is it would also then allow John's famfs to
> > just go through your iomap plumbing as a use case of it instead of
> > being an entirely separate thing. Though maybe there's some other
> > reason for that that you guys have discussed prior. In any case, I'll
> > ask this on John's main famfs patchset. It kind of seems to me that
> > you guys are pretty much doing the exact same thing conceptually.
>
> Yes, though John's famfs has the nice property that memory controller
> interleaving is mathematically regular and likely makes for a compact
> bpf program.

I tried out integrating the bpf hooks into fuse for iomap_begin() just
to see if it was realistic and it seems relatively straightforward so
far (though maybe the devil is in the details...). I used the
drivers/hid/bpf/hid_bpf_struct_ops.c program as a model for how to set
up the fuse bpf struct ops on the kernel side. calling it from
file_iomap.c looks something like

static int fuse_iomap_begin(...)
{
       ...
       struct fuse_bpf_ops *bpf_ops =3D fuse_get_bpf_ops();
       ...
      err =3D -EOPNOTSUPP;
      if (bpf_ops && bpf_ops->iomap_begin)
               err =3D bpf_ops->iomap_begin(inode, pos, len, flags, &outarg=
);
       if (err)
               err =3D fuse_simple_request(fm, &args);
      ...
}

and I was able to verify that iomap_begin() is able to return back
populated outarg fields from the bpf prog. If we were to actually
implement it i'm sure it'd be more complicated (eg we'd need to make
the fuse_bpf_ops registered per-connection, etc) but on the whole it
seems doable. My worry is that if we land the iomap cache patchset now
then we can't remove it in the future without breaking backwards
compatibility for being a performance regression (though maybe we can
since the fuse-iomap stuff is experimental?), so imo it'd be great if
we figured out what direction we want to go before landing the cache
stuff. And I think we need to have this conversation too on the main
famfs patchset (eg whether it should go through your general iomap
plumbing with bpf helpers vs. being a separate implementation) since
once that lands, it'd be irrevocable.

Thanks,
Joanne
>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > > <nod>
> > >
> > > --D
> > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > > OTOH it would be enormously hilarious to me if one could load a f=
ile
> > > > > mapping predictive model into the kernel as a bpf program and use=
 that
> > > > > as a first tier before checking the in-memory btree mapping cache=
 from
> > > > > patchset 7.  Quite a few years ago now there was a FAST paper
> > > > > establishing that even a stupid linear regression model could in =
theory
> > > > > beat a disk btree lookup.
> > > > >
> > > > > --D
> > > > >
> > > > > > Thanks,
> > > > > > Joanne
> > > > > >
> > > > > > >
> > > > > > > If you're going to start using this code, I strongly recommen=
d pulling
> > > > > > > from my git trees, which are linked below.
> > > > > > >
> > > > > > > This has been running on the djcloud for months with no probl=
ems.  Enjoy!
> > > > > > > Comments and questions are, as always, welcome.
> > > > > > >
> > > > > > > --D
> > > > > > >
> > > > > > > kernel git tree:
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux=
.git/log/?h=3Dfuse-iomap-fileio
> > > > > > > ---
> > > > > > > Commits in this patchset:
> > > > > > >  * fuse: implement the basic iomap mechanisms
> > > > > > >  * fuse_trace: implement the basic iomap mechanisms
> > > > > > >  * fuse: make debugging configurable at runtime
> > > > > > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new i=
omap devices
> > > > > > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add=
 new iomap devices
> > > > > > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY o=
n unmount
> > > > > > >  * fuse: create a per-inode flag for toggling iomap
> > > > > > >  * fuse_trace: create a per-inode flag for toggling iomap
> > > > > > >  * fuse: isolate the other regular file IO paths from iomap
> > > > > > >  * fuse: implement basic iomap reporting such as FIEMAP and S=
EEK_{DATA,HOLE}
> > > > > > >  * fuse_trace: implement basic iomap reporting such as FIEMAP=
 and SEEK_{DATA,HOLE}
> > > > > > >  * fuse: implement direct IO with iomap
> > > > > > >  * fuse_trace: implement direct IO with iomap
> > > > > > >  * fuse: implement buffered IO with iomap
> > > > > > >  * fuse_trace: implement buffered IO with iomap
> > > > > > >  * fuse: implement large folios for iomap pagecache files
> > > > > > >  * fuse: use an unrestricted backing device with iomap pageca=
che io
> > > > > > >  * fuse: advertise support for iomap
> > > > > > >  * fuse: query filesystem geometry when using iomap
> > > > > > >  * fuse_trace: query filesystem geometry when using iomap
> > > > > > >  * fuse: implement fadvise for iomap files
> > > > > > >  * fuse: invalidate ranges of block devices being used for io=
map
> > > > > > >  * fuse_trace: invalidate ranges of block devices being used =
for iomap
> > > > > > >  * fuse: implement inline data file IO via iomap
> > > > > > >  * fuse_trace: implement inline data file IO via iomap
> > > > > > >  * fuse: allow more statx fields
> > > > > > >  * fuse: support atomic writes with iomap
> > > > > > >  * fuse_trace: support atomic writes with iomap
> > > > > > >  * fuse: disable direct reclaim for any fuse server that uses=
 iomap
> > > > > > >  * fuse: enable swapfile activation on iomap
> > > > > > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > > > > > ---
> > > > > > >  fs/fuse/fuse_i.h          |  161 +++
> > > > > > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > > > > > >  fs/fuse/iomap_i.h         |   52 +
> > > > > > >  include/uapi/linux/fuse.h |  219 ++++
> > > > > > >  fs/fuse/Kconfig           |   48 +
> > > > > > >  fs/fuse/Makefile          |    1
> > > > > > >  fs/fuse/backing.c         |   12
> > > > > > >  fs/fuse/dev.c             |   30 +
> > > > > > >  fs/fuse/dir.c             |  120 ++
> > > > > > >  fs/fuse/file.c            |  133 ++-
> > > > > > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++=
++++++++++++++++++
> > > > > > >  fs/fuse/inode.c           |  162 +++
> > > > > > >  fs/fuse/iomode.c          |    2
> > > > > > >  fs/fuse/trace.c           |    2
> > > > > > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > > > > > >  create mode 100644 fs/fuse/iomap_i.h
> > > > > > >  create mode 100644 fs/fuse/file_iomap.c
> > > > > > >
> > > > > >
> >

