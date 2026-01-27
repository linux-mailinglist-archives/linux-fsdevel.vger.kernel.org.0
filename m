Return-Path: <linux-fsdevel+bounces-75560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE9JEPgNeGmzngEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:59:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B88E972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4234E3008D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0419D07E;
	Tue, 27 Jan 2026 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3xNGce0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06EBC8F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475571; cv=pass; b=XB646bz+5iZnijt5Y+0CmhdXLzYcvQ4U+9grtg6zmIyj6SB2e6YrmrVfER/Qtq3rQi4OEe66FLlSEsJmcxvJ2XlHVVqJmXIHORxm5f0UCm2HJFdsI31U3Pp1TzW9bSLc2RDBg3s2fXlftk4RMLERinQAg77RdRBzmNGX652s8Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475571; c=relaxed/simple;
	bh=D69ptwANmBNhCPcucfBrPko3sYR/MuWgcHBB2jRML2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXQt1DhPmy8u4Q+/ti7NnDfliU4CxfvzUgeiJ5RWh9vhPbL2g5VF84vrG9bAkJmmt5re6YyUev2heycgfLqWIAw8LG+IvW5OiALL7PAWXGYRliSkCE6jAJ7ykscJsaAyyoF7i1avEyg+lp5FPv/SJ0XXNic+yjLFB1npYKb+wOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3xNGce0; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89461ccc46eso92133626d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769475569; cv=none;
        d=google.com; s=arc-20240605;
        b=GBq8bHJqDUIXsc80mKwacYdPX/3EFXPNSwbPrc9/mai4S07+4vS/RS1bVRnejiem9q
         xtMkE/VntokrUxYxIILCtP1FAbYa2OUoY40pqBTucpWJHwCh10YKvE1/HEtCRJ8e67Vv
         dT6v5oyxtUY00nNNHgxKT8wuGGtKSrTzMWW6y2W1/SaE/TGmv0N+B6iyqO7oGsD+8Ssn
         owIeQdX3sIOcQ8fOiLc9t+rd/yr2AaG023ZOUaN/1+JoL8DAg/ImzLVtZZBwOm+PKwK3
         Iwu5O4XMLHHDeWtKgm6Fod0FL8EE35tgoUsMLUOdfBwP1AbljCmjtIXTDty5RWsUz9VB
         Wjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKK5+XZyBkEjhopnPUGxO9+0bL33NledXPoUaVEI+gE=;
        fh=gFAHEek3MsPYSYMBFSVCEmoVUawWISOgyvX0+9dfz+w=;
        b=EQQ7W+7H/O32lGg7B2/j3BVcwmytGsHPQR2W3CI0e5mT/Q2Gk+6KY6qbJ/p46MCHp1
         jr7z2gokaXB9+RVIywe3FXIuIfqQpPKupFYoKhWHoNdeT6P6iz1xpyVPPYTXLuGTh0vN
         Xze6B24VJIMnh7/ROh6kEovZHoed8J3Zc+VHU2Us9vuQPEC9JbwAvWsTZt5f9M981Vu6
         /yTPznDoVY0kASaSzdxiaEyVBmJXX+tC3QcXB4xeR38km8+U8OfkKM4KbGHs22nRyzhR
         u9NLpBQuD+634GhtT1dyo9ehM/YcDJuq7aLC+onPtHWHhQeiWX6ro2OWQRnppH9k55ub
         erUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769475569; x=1770080369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKK5+XZyBkEjhopnPUGxO9+0bL33NledXPoUaVEI+gE=;
        b=G3xNGce0EXr1DrwvZOWn+v7zG9FncV4jn7HwoRQmaXYbusP+eTJo/pBvHo634+qYDN
         wv+eq1gum0nt9RNP7skwTyzl0uU0WVQC7aSdJmp7Ohr0wm30+4KrtsHE+WFB5N/I63lZ
         MfzsHh35Beykp4+zXPZU3PfzPOPLzKwyHGQ3wjb5ISvDVrWmUhNWb7e5QxIbZ2TrXzW3
         jbFIX3Iw6AXQA/mDw5hnsed3b2jrmjHd25qKX4Bmt90H7dJLD7FnuPTCSmpE95dOFnEm
         C1lXqtlwDBOR/eQwGDiIgtuzyc+9Jvq/4Zls9djDzsNIOZoakEbtJxZ7qc0A1nbuacfM
         QdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769475569; x=1770080369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKK5+XZyBkEjhopnPUGxO9+0bL33NledXPoUaVEI+gE=;
        b=EDvEvyDPCgb/xvuqxk5ERQGBdCNu5etntkYVPxNyU5ZOcjAAs8SbI5deJV6d0QU6HV
         DQHoGmFGjHS0AxqI//O2JATKmTSFaOz4J707v/w+E8Zqi71tigXV9NBo7WibU5p8adOA
         WFRN4kVp0tflxINoWwgIHR08LN8IJKR4p9xDqn9ihNKrpyzWpfokuvWvDw0Nwj3tMauc
         hH+V6yDX4w6rqGyqooigxtxnvc9rsR0aSkNQhESFxbV8yUPwChIz+V5Fp8/9YIRn4LsY
         gD8L3QWZGYJpxMiyBzIwIdPHhRHfRhC9c5LFRCZg8bHZb5Qm+blqKnuxegBW2kOFYKAf
         t3vw==
X-Forwarded-Encrypted: i=1; AJvYcCW5KVwAyWeRdBg7H77NjDEhvAsCfiM7GC+PDLK7Z+s9b9Aj3SCuuKUq0MCjYcKwW+O1lp2UpyaKOUD9dm2r@vger.kernel.org
X-Gm-Message-State: AOJu0YzJN6p4QpEmfRHs/X/lsc0cpAejO3Ozwou7Q17dnj4OrnTAY4FE
	zeNrQ5bEZYIBqhIRwLwgs/LzJBu2sLyJe8DMXOIoLtYtrPXXPHWylwacbbfrrVtR/s4Ws6qekVu
	SqGvEvUp3pAuIuedfiTt012+HZYdhk7waQ4QGCj8=
X-Gm-Gg: AZuq6aJcVrbv5kl5K6VVk9vWxPEFXKQKcllMVWHxgPt3+jtdJXdXC5N2sjzgVu2m8xD
	4E6106lZf384gaSBTliv8bGOxLxSTPrvAh6JXpXZDh7XbckO2JeqN8qz9wmjiuXF/VFWVT0m7QB
	jDx9lD8mFm6nx9bou8wSr3FNssU1YwWav7C/k5Gu86Fkho0Phv+K624k04vl7+7k1P6gPMYnJBo
	YXbTX11R36oKqDnxACP4FP3ki/Q0sMPsujJPEyMh5BQSgRVruEUWFBVe8j0rqzWDp3v5CzZP8os
	N7tnqZ3eEROwBXPdbrnpoA==
X-Received: by 2002:ac8:5981:0:b0:4e8:b446:c01b with SMTP id
 d75a77b69052e-50314c690a1mr83731901cf.61.1769475568788; Mon, 26 Jan 2026
 16:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs> <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 16:59:16 -0800
X-Gm-Features: AZwV_QiCLsW4098i_o1ND3ZAp-I17VKc7jXatwN-zQQrkGhitlVqj3v7SWmqig0
Message-ID: <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75560-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D35B88E972
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:38=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi all,
>
> This series connects fuse (the userspace filesystem layer) to fs-iomap
> to get fuse servers out of the business of handling file I/O themselves.
> By keeping the IO path mostly within the kernel, we can dramatically
> improve the speed of disk-based filesystems.  This enables us to move
> all the filesystem metadata parsing code out of the kernel and into
> userspace, which means that we can containerize them for security
> without losing a lot of performance.

I haven't looked through how the fuse2fs or fuse4fs servers are
implemented yet (also, could you explain the difference between the
two? Which one should we look at to see how it all ties together?),
but I wonder if having bpf infrastructure hooked up to fuse would be
especially helpful for what you're doing here with fuse iomap. afaict,
every read/write whether it's buffered or direct will incur at least 1
call to ->iomap_begin() to get the mapping metadata, which will be 2
context-switches (and if the server has ->iomap_end() implemented,
then 2 more context-switches). But it seems like the logic for
retrieving mapping offsets/lengths/metadata should be pretty
straightforward? If the extent lookups are table lookups or tree
traversals without complex side effects, then having
->iomap_begin()/->iomap_end() be executed as a bpf program would avoid
the context switches and allow all the caching logic to be moved from
the kernel to the server-side (eg using bpf maps). Is this your
assessment of it as well or do you think the server-side logic for
iomap_begin()/iomap_end() is too complicated to make this realistic?
Asking because I'm curious whether this direction makes sense, not
because I think it would be a blocker for your series.

Thanks,
Joanne

>
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
>
> This has been running on the djcloud for months with no problems.  Enjoy!
> Comments and questions are, as always, welcome.
>
> --D
>
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=
=3Dfuse-iomap-fileio
> ---
> Commits in this patchset:
>  * fuse: implement the basic iomap mechanisms
>  * fuse_trace: implement the basic iomap mechanisms
>  * fuse: make debugging configurable at runtime
>  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
>  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap d=
evices
>  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
>  * fuse: create a per-inode flag for toggling iomap
>  * fuse_trace: create a per-inode flag for toggling iomap
>  * fuse: isolate the other regular file IO paths from iomap
>  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HO=
LE}
>  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{D=
ATA,HOLE}
>  * fuse: implement direct IO with iomap
>  * fuse_trace: implement direct IO with iomap
>  * fuse: implement buffered IO with iomap
>  * fuse_trace: implement buffered IO with iomap
>  * fuse: implement large folios for iomap pagecache files
>  * fuse: use an unrestricted backing device with iomap pagecache io
>  * fuse: advertise support for iomap
>  * fuse: query filesystem geometry when using iomap
>  * fuse_trace: query filesystem geometry when using iomap
>  * fuse: implement fadvise for iomap files
>  * fuse: invalidate ranges of block devices being used for iomap
>  * fuse_trace: invalidate ranges of block devices being used for iomap
>  * fuse: implement inline data file IO via iomap
>  * fuse_trace: implement inline data file IO via iomap
>  * fuse: allow more statx fields
>  * fuse: support atomic writes with iomap
>  * fuse_trace: support atomic writes with iomap
>  * fuse: disable direct reclaim for any fuse server that uses iomap
>  * fuse: enable swapfile activation on iomap
>  * fuse: implement freeze and shutdowns for iomap filesystems
> ---
>  fs/fuse/fuse_i.h          |  161 +++
>  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
>  fs/fuse/iomap_i.h         |   52 +
>  include/uapi/linux/fuse.h |  219 ++++
>  fs/fuse/Kconfig           |   48 +
>  fs/fuse/Makefile          |    1
>  fs/fuse/backing.c         |   12
>  fs/fuse/dev.c             |   30 +
>  fs/fuse/dir.c             |  120 ++
>  fs/fuse/file.c            |  133 ++-
>  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |  162 +++
>  fs/fuse/iomode.c          |    2
>  fs/fuse/trace.c           |    2
>  14 files changed, 4056 insertions(+), 55 deletions(-)
>  create mode 100644 fs/fuse/iomap_i.h
>  create mode 100644 fs/fuse/file_iomap.c
>

