Return-Path: <linux-fsdevel+bounces-75641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIH+CGgWeWmyvAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:47:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A899A1C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529863038F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382933556A;
	Tue, 27 Jan 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/BTSWO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705D326D50
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543264; cv=pass; b=d1m/g84hjld1rUD0MtfhoCeoWdetngnX3PlXF28KbjAPmpxXw7PaWeJvmvBe5SF5sGYLlyhNHArj5zQviY71qG2xAWw4JPVr3U5IMTagTXf/tkrT7xDH6iSlTQuf2uAarTKaeD5fegaozA+vcCRCoqFKB6kxVeWNyzMn2jm1bms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543264; c=relaxed/simple;
	bh=i2+pZ86FG6FGq3oFgpcoC7msWzm4M4xURJdOLb/8a1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmOnDFfiRzw5SDuA7EYKZuiL7kCjSDz411kA3cAGSiyx3Oyb9N4GY39FO/XSeACWmh9Dfs7SMjaisotBPVyftKGbq4GDkJyocdNM7NbhdC69g3Akn8UrqyRaqYKUPXl3meay6+gCDnvCP56g/wLZyx0sTsisyrOBkvsjd6dbQ1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/BTSWO3; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50145d27b4cso64950971cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 11:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769543262; cv=none;
        d=google.com; s=arc-20240605;
        b=GdR7rDj7DjEgQ7579FoUx6YUle5DoUnFzsBvbzx/CvnhFqtzQ7sVvAKy4fIIhqqH1x
         whPie1L4NlqvRge2ZgYTklkaIax2W1F4l2hlqqs9c78ucgX4gdgbyRAzMK6cmTMHZVMh
         nYkqSGy8D/K6xlCjrojqsLfJOPLVfsg2n2ng1nzuD6z+0WvPpcrRJty1CcCQHlk9Q/5M
         RxqWaKTvltrUzQ8OQ+B0W8Agig4Gr+iOyXEYGije9C9Wz8d5pILaJmzSOldIGZtFFRnQ
         j1lefzirvc2sHmrWZ9AVgJNfEcH5tFupQLvk8nUvYMJ4jdt385zZ+ToNx2zOikk3CVa5
         NtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KlR3B1H0ttH3Rms4Du3XP4sfaNK7yOZH8xq+g1jUK4g=;
        fh=zjdTQHnOL/NudbfEDdERxz3YSBlCY7BxYYFu6cw1h9I=;
        b=CtmwYUnL5TvfOTH0QAVkKU6RqGQNldKxsjyfxf/egKeNnZY2UigiHdaHskp1YUhpAw
         C4aa+yxTqANip3t0QC872kS1vtxoSzhUxhf9M1+nxYGJyTkSipZjtuXsRunFyaf9+am/
         8JumL6m1TgNJLZ3rPWYY6OUsKyrb5i34x0zlnVbSiB2bAh5P5+O/hAovjTBOB/Rw1lVi
         iU5+gyzVEtdJqd37qVjcya33IV4XzCyMd55YX7k1wx6LWZwUDE/rwTJE90/o4jaeQqaR
         8Phf9q+RFV5dmAcZWdTzS3wm65Jm1ENNKK43Qbtths9Ar3Jjwa+/63+hJpQljIYRpm5q
         A+2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769543262; x=1770148062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlR3B1H0ttH3Rms4Du3XP4sfaNK7yOZH8xq+g1jUK4g=;
        b=m/BTSWO3FAfih6jcIHI0g7xROujuNuMdva93+yMZu78dc//g8t1dpgmE/ouAksJD6o
         T0dFJEu1Taz0x26YFh0ZoDZuXVp5ABhpuig19Abn/EY9i5VYXlDYbDLpRcLT3hpPpV4D
         cePDQfILLmzTE+9UEOwgBFVuMlE1Kpx0WvyqvnMxvNtYpWIsGcqV3eopT3yMrHefyfHk
         S5DuqwrPshoxXdi45h4cQqSnEuDsnGlIGnPRFOxdLPtKI4UuUsGZsxmu7JJo01VGQMoX
         /WcbIPuvWu3hDRClnwmHTG37/aFSCt3ZOaK5p+FG0VXFxuZCNlxeKFkmo2l+j32ljAbm
         AKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769543262; x=1770148062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlR3B1H0ttH3Rms4Du3XP4sfaNK7yOZH8xq+g1jUK4g=;
        b=pEeAj/0Xs4x2W4MLD3AD8zieXU76qAHTfzeZqp2nbVbSIPqQVEI5KyECECOYX/CiuL
         mya7Do+XDgs4Muco04/+E+vWhSQ1d0BHRxiPiePbCkHIUfTTJMqMKASkXdOzgq4U+4st
         6oNxsS2vtLPQdHWiqLqlFSw0aZuQ+iTmHesf1cTCYHTq2nwpJ0y7zon1ydAe87aucaq/
         /teSahHyyRdijWLusSEQ/06WDpu82AaQdxdLybStmXX0RBOoM47m180qhSCqj1hPLRtp
         8LGjJ4UpAu3xZdn8DSrYY9VpLWgSXMgUsDqayWDSWF3wJt1Jrqp1ZW1BcVK45Ami5xxh
         1skw==
X-Forwarded-Encrypted: i=1; AJvYcCWx0VCpaOsDPe+k1l6cK6EtB4hRpazcpLuQEyutdC4iZAZoZqVwRNpZJxOR6EmVcSnqRmo4wlVL6fpy5Tzk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41nbTsZ+5nuS3HPZyiv5ZooDfO42JplzI/V2WEqrsrQ2xGVqU
	vC+5dzsz2OpXrg6gnLvOCT/NLj972sK6fDSSFx49oynxjCg0Fm9JLN3KhLR6K6dB64foNyCGhWb
	3aHBUVoqI+p7P6hgS3p/tUJ5lUBQjZkI=
X-Gm-Gg: AZuq6aJ1F/obMUkcQjGK40Rn0DHs6kxuRA5gy2x83J1OFrtNuUKo6OE2iB32oZWaHe7
	YF89rpLxgGwGuYNj91fPh902S1AC7S3hJUQPTJ30X6brVu4wYndEa0Kqjebfo23s7JLU2mYcWcT
	+nvT+Ph1B8X0+74vlQKqvgNjlGgQo7GT0z0tnNvkWHLXKCQcNOkF68U3J+TR6ntAbLT6biB8dGr
	ksBCL+f66JYK3xAbpqfx6i7D8Nt8AkJN/+w2ONOY5R3uoRgXXyv5+uBE9C0MeYBsJa3ew==
X-Received: by 2002:a05:622a:14:b0:4ec:f2e1:483 with SMTP id
 d75a77b69052e-5032f76558cmr34769341cf.26.1769543261931; Tue, 27 Jan 2026
 11:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs> <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com> <20260127022235.GG5900@frogsfrogsfrogs>
In-Reply-To: <20260127022235.GG5900@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 11:47:31 -0800
X-Gm-Features: AZwV_QjF9rNfZtsYijV_1NKbqNSFD1bzyLoPT1OLzI0R9ryfxVWNeNQAShqWpHg
Message-ID: <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75641-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: B3A899A1C8
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jan 26, 2026 at 04:59:16PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:38=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > Hi all,
> > >
> > > This series connects fuse (the userspace filesystem layer) to fs-ioma=
p
> > > to get fuse servers out of the business of handling file I/O themselv=
es.
> > > By keeping the IO path mostly within the kernel, we can dramatically
> > > improve the speed of disk-based filesystems.  This enables us to move
> > > all the filesystem metadata parsing code out of the kernel and into
> > > userspace, which means that we can containerize them for security
> > > without losing a lot of performance.
> >
> > I haven't looked through how the fuse2fs or fuse4fs servers are
> > implemented yet (also, could you explain the difference between the
> > two? Which one should we look at to see how it all ties together?),
>
> fuse4fs is a lowlevel fuse server; fuse2fs is a high(?) level fuse
> server.  fuse4fs is the successor to fuse2fs, at least on Linux and BSD.

Ah I see, thanks for the explanation. In that case, I'll just look at
fuse4fs then.

>
> > but I wonder if having bpf infrastructure hooked up to fuse would be
> > especially helpful for what you're doing here with fuse iomap. afaict,
> > every read/write whether it's buffered or direct will incur at least 1
> > call to ->iomap_begin() to get the mapping metadata, which will be 2
> > context-switches (and if the server has ->iomap_end() implemented,
> > then 2 more context-switches).
>
> Yes, I agree that's a lot of context switching for file IO...
>
> > But it seems like the logic for retrieving mapping
> > offsets/lengths/metadata should be pretty straightforward?
>
> ...but it gets very cheap if the fuse server can cache mappings in the
> kernel to avoid all that.  That is, incidentally, what patchset #7
> implements.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/=
?h=3Dfuse-iomap-cache_2026-01-22
>
> > If the extent lookups are table lookups or tree
> > traversals without complex side effects, then having
> > ->iomap_begin()/->iomap_end() be executed as a bpf program would avoid
> > the context switches and allow all the caching logic to be moved from
> > the kernel to the server-side (eg using bpf maps).
>
> Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
> structure that supports interval mappings?  I think the existing bpf map

Not yet but I don't see why a b+ tree like data strucutre couldn't be added=
.
Maybe one workaround in the meantime that could work is using a sorted
array map and doing binary search on that, until interval mappings can
be natively supported?

> only does key -> value.  Also, is there an upper limit on the size of a
> map?  You could have hundreds of millions of maps for a very fragmented
> regular file.

If I'm remembering correctly, there's an upper limit on the number of
map entries, which is bounded by u32

>
> At one point I suggested to the famfs maintainer that it might be
> easier/better to implement the interleaved mapping lookups as bpf
> programs instead of being stuck with a fixed format in the fuse
> userspace abi, but I don't know if he ever implemented that.

This seems like a good use case for it too
>
> > Is this your
> > assessment of it as well or do you think the server-side logic for
> > iomap_begin()/iomap_end() is too complicated to make this realistic?
> > Asking because I'm curious whether this direction makes sense, not
> > because I think it would be a blocker for your series.
>
> For disk-based filesystems I think it would be difficult to model a bpf
> program to do mappings, since they can basically point anywhere and be
> of any size.

Hmm I'm not familiar enough with disk-based filesystems to know what
the "point anywhere and be of any size" means. For the mapping stuff,
doesn't it just point to a block number? Or are you saying the problem
would be there's too many mappings since a mapping could be any size?

I was thinking the issue would be more that there might be other logic
inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
would need to be done that would be too out-of-scope for bpf. But I
think I need to read through the fuse4fs stuff to understand more what
it's doing in those functions.

Thanks,
Joanne

>
> OTOH it would be enormously hilarious to me if one could load a file
> mapping predictive model into the kernel as a bpf program and use that
> as a first tier before checking the in-memory btree mapping cache from
> patchset 7.  Quite a few years ago now there was a FAST paper
> establishing that even a stupid linear regression model could in theory
> beat a disk btree lookup.
>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > > If you're going to start using this code, I strongly recommend pullin=
g
> > > from my git trees, which are linked below.
> > >
> > > This has been running on the djcloud for months with no problems.  En=
joy!
> > > Comments and questions are, as always, welcome.
> > >
> > > --D
> > >
> > > kernel git tree:
> > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log=
/?h=3Dfuse-iomap-fileio
> > > ---
> > > Commits in this patchset:
> > >  * fuse: implement the basic iomap mechanisms
> > >  * fuse_trace: implement the basic iomap mechanisms
> > >  * fuse: make debugging configurable at runtime
> > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap dev=
ices
> > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iom=
ap devices
> > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmoun=
t
> > >  * fuse: create a per-inode flag for toggling iomap
> > >  * fuse_trace: create a per-inode flag for toggling iomap
> > >  * fuse: isolate the other regular file IO paths from iomap
> > >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DAT=
A,HOLE}
> > >  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEE=
K_{DATA,HOLE}
> > >  * fuse: implement direct IO with iomap
> > >  * fuse_trace: implement direct IO with iomap
> > >  * fuse: implement buffered IO with iomap
> > >  * fuse_trace: implement buffered IO with iomap
> > >  * fuse: implement large folios for iomap pagecache files
> > >  * fuse: use an unrestricted backing device with iomap pagecache io
> > >  * fuse: advertise support for iomap
> > >  * fuse: query filesystem geometry when using iomap
> > >  * fuse_trace: query filesystem geometry when using iomap
> > >  * fuse: implement fadvise for iomap files
> > >  * fuse: invalidate ranges of block devices being used for iomap
> > >  * fuse_trace: invalidate ranges of block devices being used for ioma=
p
> > >  * fuse: implement inline data file IO via iomap
> > >  * fuse_trace: implement inline data file IO via iomap
> > >  * fuse: allow more statx fields
> > >  * fuse: support atomic writes with iomap
> > >  * fuse_trace: support atomic writes with iomap
> > >  * fuse: disable direct reclaim for any fuse server that uses iomap
> > >  * fuse: enable swapfile activation on iomap
> > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > ---
> > >  fs/fuse/fuse_i.h          |  161 +++
> > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > >  fs/fuse/iomap_i.h         |   52 +
> > >  include/uapi/linux/fuse.h |  219 ++++
> > >  fs/fuse/Kconfig           |   48 +
> > >  fs/fuse/Makefile          |    1
> > >  fs/fuse/backing.c         |   12
> > >  fs/fuse/dev.c             |   30 +
> > >  fs/fuse/dir.c             |  120 ++
> > >  fs/fuse/file.c            |  133 ++-
> > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c           |  162 +++
> > >  fs/fuse/iomode.c          |    2
> > >  fs/fuse/trace.c           |    2
> > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > >  create mode 100644 fs/fuse/iomap_i.h
> > >  create mode 100644 fs/fuse/file_iomap.c
> > >
> >

