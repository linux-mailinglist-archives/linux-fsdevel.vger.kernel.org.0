Return-Path: <linux-fsdevel+bounces-75674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBKFAH1UeWknwgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:12:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0A9B98A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EB530182BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614DC78F2B;
	Wed, 28 Jan 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQTGzAVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5C79CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559057; cv=pass; b=LHLiSheqJj75Q/gPa6kqKC/+raJO8NpPEIRIe1i/dqd6CruZUdj4aeilYFYQrOyDsK05U0YDZlVKVOyqxH0JgAHprX+Zz2On473uJHd+KG2IJy9orRPct/YAwDRJJf3pT9fiaY0TZSZxANd3LAuMQz6hfPNq6p3zmvS2w+NA2Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559057; c=relaxed/simple;
	bh=agnYCDEq5OahXqfTRpvocU+yfhAFoKMven7aYvnoKNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoS3AX4Nv6TLzVtshkNidKC3cCL8BwTxkHPXZWxd1Kz+WIjF/spbs0bU9O6UKoqMSv9r0lMNvXwXhEjBd3ZpSLhDNiwyxOzCBuUhDOpO5FqzPGvDQHHnru7W6+g7Y7rzGCDLFBAniAQHasDH8V/yZ27I6mEpRyeadjsFpsRdcWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQTGzAVu; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88ffcb14e11so102077416d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 16:10:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769559054; cv=none;
        d=google.com; s=arc-20240605;
        b=J7Qi1Go2ZJ8oJLIOAMYMRWt/+QYyW9onvIfMJoklRwLtAiExj+zdogKhorkmRau2on
         ntiuTS8cQhZS0xn4l3iFyvgFzCOjL8eGC1LZYY31K7uuCFIG1CebB+nvtdoPWy7bSjwr
         g/8Hy/wJV1474mg3t6ECYw87YsLXjHZq9uuW7CltU/thF0xoBuU7xLJHRLYxebDAVmiK
         4RvaHJ/PHgWyJpnSL2pcNWYk7J19Flh/x2FgLX/6w4rMBpcTqBYGnXWnTl5KdFMOtIxx
         wHJWqtsro0t1pBL7Pr+sWwFPfa5nHTVR2+ZubL2nuuZYwMajiEuxasPS3Fgww13DfVsF
         ycvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWDUdu66oqvaNol20Nk1uOcdvG5IUl46np3iQyf1Hog=;
        fh=GNYN8nej6LWfUdpqJ4+EADYCUUpwx9KVJo/3w33eu4w=;
        b=d8FNpsLlZ2K4PkBP0BFCJIWCUQNETCMecltdbkd18WiH1oFTrO2yYdvCMT7+6ZRr/H
         sH6pzW2Zt1XRvzyEXcmlIIO3HDgpaP1hW6a7hJAp3XeJseKiuYuoWh6T/WnIxaDmkQfW
         zDXtNb24VUoRzuq68Kn7SCMyZ5VWj1ECw6YjTa/reN3Wa3i01vvHfglkHXwoT5QtikFN
         CiMf+3Af0SLJVPiWjpr7m5LCWaP7PSzBs4eXG/crFR0uhoU9KJXxj9NKP9hfdNSeAsJy
         xXNVofPcgaV719sJgpzIGFdxiSQHgKky0VIW/noKOvt8onkTcIGRDAUOjJO9eKvPD5Qz
         +w8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769559054; x=1770163854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWDUdu66oqvaNol20Nk1uOcdvG5IUl46np3iQyf1Hog=;
        b=jQTGzAVu/z97CW3lDa3C8xRaKH129pQGHogQiIdwJYKo9XowJhEAyFx1y9UPZQvlS+
         rQ0DLs0noHhUYUPG30aaB+lKHoj+73Dc+bD819Ha8leHzUyY3ZXQfsr/OEn1wpLEGrBR
         HxZmTmXUFEel6lq0YjjNBonDp4GSQaVLn9FtaZnthqyIcSG3lLiitpBWyCU/412/b43y
         L9Yf1wBGS56jNUgREt1477Q04DVwJ2joeXQ+jtDYkXmtko4EYJWbnB+X70C+K5j9qSj3
         NngPyCKRiP4yZikFiazUsPW/x9w7GkloL/ybcaPhDD0KkQ9WZf61kwPiWBbegTrG4GDT
         B1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769559054; x=1770163854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWDUdu66oqvaNol20Nk1uOcdvG5IUl46np3iQyf1Hog=;
        b=NWJ3GL10Rl99ffegjfhUA4MdML5Xy0zYh4QF92uyuc/VrReI2DbWZNiqeqY8Smg1tM
         ePXgrwJ8hx3yM2SdOza1PfyJwhOArLjeTeN7H21RtXb7cEYQQUz6EttRKEGz4IARLE/q
         76pqZ+8hDHiOp81Cn831DxLrRszFiM4Ati4sKYpP6Y9c3Lw+OP2Mj0MlelXFb4AB2B4P
         lvaMRDgop0W7Aqu+zV+al5g+07AuY1YDHvwdaWa3v8r60zqgA4B1a8hSygJ70wJtit2w
         6IlQLBKiSNyDs00iSaG4Dt4jK18n1xZFhIHzjaaGy9FTgNWBfKY4gXpfPgf76IfaedYu
         sx7w==
X-Forwarded-Encrypted: i=1; AJvYcCXBoqTLeu83EXwsZEi0lwCgXA+SxB2OHtQu65yVSdgQDxqkdTH7LrP0T7rfIbXj1CaHWk0X1WrZRBBp4kcW@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkGiO3mSw5nhAhj1GSATqEYL9IGp0QegY+t0bbWgu23q7N5hI
	GnylgcZr6O7HnDK2KSkkDfRZx+rXlbCrk32qkebwYNGFTq1Ji8pS/yWiq99ckzG8v135RPAFZW6
	hqCHhbrbY13jptQnLSnPFWkRsp8V2JqM=
X-Gm-Gg: AZuq6aKike3U4VMaJD6O52y/+o4H07NNqXlXN56zjuTwaXndOIytq0AvWDDLJgoTkh9
	uobjZqgfxqLxiabZiPSHsEZgDJjkVnYMTnBjf5ZCnudOeuhmV59bj7AcTMt2L030I28kDTBHNxG
	Lvc/BWJbIhfxcdFB8yoL6JSZK6VNaIXRaLtxZ8GstwAVPAtVbgdcfGpwD3XnECFB05C8zqDeB7F
	1D/BQNgjpST5geFCJmX6acJi1VVcaSQyjUlY071VOSV2DCTEHZqEz0zHoMNFLVOgK0xcw==
X-Received: by 2002:a05:622a:242:b0:501:466b:5141 with SMTP id
 d75a77b69052e-5032f87f885mr48350581cf.18.1769559053898; Tue, 27 Jan 2026
 16:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs> <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
 <20260127022235.GG5900@frogsfrogsfrogs> <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
 <20260127232125.GA5966@frogsfrogsfrogs>
In-Reply-To: <20260127232125.GA5966@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 16:10:43 -0800
X-Gm-Features: AZwV_QhfDYKMqWd2bFwRWavYp0XYYTRHqMXXE6KL8WkHswQJC83AZyMBrAH96Zc
Message-ID: <CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75674-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53B0A9B98A
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 3:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Jan 27, 2026 at 11:47:31AM -0800, Joanne Koong wrote:
> > On Mon, Jan 26, 2026 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 04:59:16PM -0800, Joanne Koong wrote:
> > > > On Tue, Oct 28, 2025 at 5:38=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This series connects fuse (the userspace filesystem layer) to fs-=
iomap
> > > > > to get fuse servers out of the business of handling file I/O them=
selves.
> > > > > By keeping the IO path mostly within the kernel, we can dramatica=
lly
> > > > > improve the speed of disk-based filesystems.  This enables us to =
move
> > > > > all the filesystem metadata parsing code out of the kernel and in=
to
> > > > > userspace, which means that we can containerize them for security
> > > > > without losing a lot of performance.
> > > >
> > > > I haven't looked through how the fuse2fs or fuse4fs servers are
> > > > implemented yet (also, could you explain the difference between the
> > > > two? Which one should we look at to see how it all ties together?),
> > >
> > > fuse4fs is a lowlevel fuse server; fuse2fs is a high(?) level fuse
> > > server.  fuse4fs is the successor to fuse2fs, at least on Linux and B=
SD.
> >
> > Ah I see, thanks for the explanation. In that case, I'll just look at
> > fuse4fs then.
> >
> > >
> > > > but I wonder if having bpf infrastructure hooked up to fuse would b=
e
> > > > especially helpful for what you're doing here with fuse iomap. afai=
ct,
> > > > every read/write whether it's buffered or direct will incur at leas=
t 1
> > > > call to ->iomap_begin() to get the mapping metadata, which will be =
2
> > > > context-switches (and if the server has ->iomap_end() implemented,
> > > > then 2 more context-switches).
> > >
> > > Yes, I agree that's a lot of context switching for file IO...
> > >
> > > > But it seems like the logic for retrieving mapping
> > > > offsets/lengths/metadata should be pretty straightforward?
> > >
> > > ...but it gets very cheap if the fuse server can cache mappings in th=
e
> > > kernel to avoid all that.  That is, incidentally, what patchset #7
> > > implements.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/=
log/?h=3Dfuse-iomap-cache_2026-01-22
> > >
> > > > If the extent lookups are table lookups or tree
> > > > traversals without complex side effects, then having
> > > > ->iomap_begin()/->iomap_end() be executed as a bpf program would av=
oid
> > > > the context switches and allow all the caching logic to be moved fr=
om
> > > > the kernel to the server-side (eg using bpf maps).
> > >
> > > Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
> > > structure that supports interval mappings?  I think the existing bpf =
map
> >
> > Not yet but I don't see why a b+ tree like data strucutre couldn't be a=
dded.
> > Maybe one workaround in the meantime that could work is using a sorted
> > array map and doing binary search on that, until interval mappings can
> > be natively supported?
>
> I guess, though I already had a C structure to borrow from xfs ;)
>
> > > only does key -> value.  Also, is there an upper limit on the size of=
 a
> > > map?  You could have hundreds of millions of maps for a very fragment=
ed
> > > regular file.
> >
> > If I'm remembering correctly, there's an upper limit on the number of
> > map entries, which is bounded by u32
>
> That's problematic, since files can have 64-bit logical block numbers.

The key size supports 64-bits. The u32 bound would be the limit on the
number of extents for the file.

>
> > > At one point I suggested to the famfs maintainer that it might be
> > > easier/better to implement the interleaved mapping lookups as bpf
> > > programs instead of being stuck with a fixed format in the fuse
> > > userspace abi, but I don't know if he ever implemented that.
> >
> > This seems like a good use case for it too
> > >
> > > > Is this your
> > > > assessment of it as well or do you think the server-side logic for
> > > > iomap_begin()/iomap_end() is too complicated to make this realistic=
?
> > > > Asking because I'm curious whether this direction makes sense, not
> > > > because I think it would be a blocker for your series.
> > >
> > > For disk-based filesystems I think it would be difficult to model a b=
pf
> > > program to do mappings, since they can basically point anywhere and b=
e
> > > of any size.
> >
> > Hmm I'm not familiar enough with disk-based filesystems to know what
> > the "point anywhere and be of any size" means. For the mapping stuff,
> > doesn't it just point to a block number? Or are you saying the problem
> > would be there's too many mappings since a mapping could be any size?
>
> The second -- mappings can be any size, and unprivileged userspace can
> control the mappings.

If I'm understanding what you're saying here, this is the same
discussion as the one above about the u32 bound, correct?

>
> > I was thinking the issue would be more that there might be other logic
> > inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
> > would need to be done that would be too out-of-scope for bpf. But I
> > think I need to read through the fuse4fs stuff to understand more what
> > it's doing in those functions.

Looking at fuse4fs logic cursorily, it seems doable? What I like about
offloading this to bpf too is it would also then allow John's famfs to
just go through your iomap plumbing as a use case of it instead of
being an entirely separate thing. Though maybe there's some other
reason for that that you guys have discussed prior. In any case, I'll
ask this on John's main famfs patchset. It kind of seems to me that
you guys are pretty much doing the exact same thing conceptually.

Thanks,
Joanne

>
> <nod>
>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > >
> > > OTOH it would be enormously hilarious to me if one could load a file
> > > mapping predictive model into the kernel as a bpf program and use tha=
t
> > > as a first tier before checking the in-memory btree mapping cache fro=
m
> > > patchset 7.  Quite a few years ago now there was a FAST paper
> > > establishing that even a stupid linear regression model could in theo=
ry
> > > beat a disk btree lookup.
> > >
> > > --D
> > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > > If you're going to start using this code, I strongly recommend pu=
lling
> > > > > from my git trees, which are linked below.
> > > > >
> > > > > This has been running on the djcloud for months with no problems.=
  Enjoy!
> > > > > Comments and questions are, as always, welcome.
> > > > >
> > > > > --D
> > > > >
> > > > > kernel git tree:
> > > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git=
/log/?h=3Dfuse-iomap-fileio
> > > > > ---
> > > > > Commits in this patchset:
> > > > >  * fuse: implement the basic iomap mechanisms
> > > > >  * fuse_trace: implement the basic iomap mechanisms
> > > > >  * fuse: make debugging configurable at runtime
> > > > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap=
 devices
> > > > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new=
 iomap devices
> > > > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on un=
mount
> > > > >  * fuse: create a per-inode flag for toggling iomap
> > > > >  * fuse_trace: create a per-inode flag for toggling iomap
> > > > >  * fuse: isolate the other regular file IO paths from iomap
> > > > >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_=
{DATA,HOLE}
> > > > >  * fuse_trace: implement basic iomap reporting such as FIEMAP and=
 SEEK_{DATA,HOLE}
> > > > >  * fuse: implement direct IO with iomap
> > > > >  * fuse_trace: implement direct IO with iomap
> > > > >  * fuse: implement buffered IO with iomap
> > > > >  * fuse_trace: implement buffered IO with iomap
> > > > >  * fuse: implement large folios for iomap pagecache files
> > > > >  * fuse: use an unrestricted backing device with iomap pagecache =
io
> > > > >  * fuse: advertise support for iomap
> > > > >  * fuse: query filesystem geometry when using iomap
> > > > >  * fuse_trace: query filesystem geometry when using iomap
> > > > >  * fuse: implement fadvise for iomap files
> > > > >  * fuse: invalidate ranges of block devices being used for iomap
> > > > >  * fuse_trace: invalidate ranges of block devices being used for =
iomap
> > > > >  * fuse: implement inline data file IO via iomap
> > > > >  * fuse_trace: implement inline data file IO via iomap
> > > > >  * fuse: allow more statx fields
> > > > >  * fuse: support atomic writes with iomap
> > > > >  * fuse_trace: support atomic writes with iomap
> > > > >  * fuse: disable direct reclaim for any fuse server that uses iom=
ap
> > > > >  * fuse: enable swapfile activation on iomap
> > > > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > > > ---
> > > > >  fs/fuse/fuse_i.h          |  161 +++
> > > > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > > > >  fs/fuse/iomap_i.h         |   52 +
> > > > >  include/uapi/linux/fuse.h |  219 ++++
> > > > >  fs/fuse/Kconfig           |   48 +
> > > > >  fs/fuse/Makefile          |    1
> > > > >  fs/fuse/backing.c         |   12
> > > > >  fs/fuse/dev.c             |   30 +
> > > > >  fs/fuse/dir.c             |  120 ++
> > > > >  fs/fuse/file.c            |  133 ++-
> > > > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  fs/fuse/inode.c           |  162 +++
> > > > >  fs/fuse/iomode.c          |    2
> > > > >  fs/fuse/trace.c           |    2
> > > > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > > > >  create mode 100644 fs/fuse/iomap_i.h
> > > > >  create mode 100644 fs/fuse/file_iomap.c
> > > > >
> > > >

