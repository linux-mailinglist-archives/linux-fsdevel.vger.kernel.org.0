Return-Path: <linux-fsdevel+bounces-78840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EBgLgQSpGlcWQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 11:16:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E61CF188
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2B5E3008620
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E41A9FB0;
	Sun,  1 Mar 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N04lOntM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3C430BB1
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360186; cv=pass; b=eAO4M80dM7tjV8QKQZDTVSpUhS+FpWWZJu3BmTVmlj0c0SkdMnTpkfTX8oy18MDGn+ALLSlQX4me2cJJjtwhwt5reYwzoBVAIPIna3AQPKDZCgol3BLuzKZv1G6aDFKHNURm/P26MvK5bb0xYy7mPMXNeSZOvhDBNQL4D7yYE5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360186; c=relaxed/simple;
	bh=s7rfjnPtFd6SU6xoPH3SYe9hNrVk5+6PWUoUYgGCnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQniZ0UHdc0Yizy9PmPTEGDp2OFhJKPCRjfPV77k/T8NkaKK0CYx4j4zfGA5VcMkTwo+u5cw5fnZth1nOiTaprVbahdfzXNqT7JIe/4JZ3QxORvLoWArORPsJUlqNitaMaFUbYxJ6pFnwY0h2lbZgVbGApa2k7Cxz2NrjD++9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N04lOntM; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so1043464241.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 02:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360184; cv=none;
        d=google.com; s=arc-20240605;
        b=JC1UVw9aIlhq6cPRia+YQlrGG0beIUDjv2zmJ/NsYPwyDRTDCxUwZubpfvnAZ8ZsAg
         leX+GS1eUtLZbYbsVXBuAh5MBb44iD4N174I8lrvWZUHbBENfVfQFLRt2JeWVkWnbLsO
         ADIgZdvqzhnd67vHP6fLN5IvFEj/hznWuFkPLfKJTqUD7MP1O1dheu8seDSU8xMyn7tS
         Pzkm89HzJbAGxzkYTyprmG7Dxl8f6Wnj82cpC88NYlYkck1vlqd1aDfnCiu8n3cKzaGM
         0S2JAL1U1mTkduOYoAhbVqbYycdlNmB1Npcea8qr+PTXwxB4441RYIP8Fbl+Gmoy0NXg
         NB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        fh=QmP7FmnHBnfXKJWHkz8FRhPdYzdsDA8OP6XZkpJDshc=;
        b=gi5rL+Ky+StMmCZ2zouCIvby5ibkqS0WDSLrd6hQTnXUz/YtTaCg5PNJIF2GfxJgUj
         /joYuSV3IgMN7z60gQdvTcuz8d8Xtg5aEkmh7Wuz4n+e5kJTM424whjT1TmG3YfJ+P7e
         0pafLgCwk6XOxj+kThjqA4WJWSw1dEBS/7niOtdl4bHMFIaj7VMq6k6Uu9jPJJ+9G0Iy
         qg/Zw6PkUoOD+jT2f7Z7ngiBcknXACW6318EnVIO+5BrxOOf0BYS615LbG0NToPAM7Ve
         EWvDaCJm704l9Q6+NNXLfzuxtaMBr33yhUJg/1RlljE45lZXnmcroYspXUWyVXlpkDCi
         CPGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360184; x=1772964984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=N04lOntMi64Tm+WqmzZhhWbQVrZnkQBqb/MlNznFDsXrPLPhUMz2dw+9bZmRLd62x6
         gIZip+2v7bDGN3YmJtyk4HJAS4UVN1WG1U0Aqu+faG+/IK+3n9PscrvR3J8Hc2r3L5vD
         A5uXJoMIZWCHG9gWgha3KPr9hJU5Pwao6gkNx9B+qbzu5kCnHRCJ5NXOFZVE81rWZMuy
         oNEWxKfvREP7ll/7g5gPcPb1e+5IBkH+hqPqacUdRkaFalxafjYraKIm9CEePams18fe
         kE2Ybd6TdGJv+3qXBbPDTeW23hLy3ZGb08T1SoziBB2S3B18vq2kSbBKkP1SUMhuR+Hw
         L1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360184; x=1772964984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=rBuD/F8VKwySbkErr1Plg+UC4xAuAWmO2Yobtkge3zdMJ0WPtCBezI6Kq1jP4m7CcY
         xwR470Kxj0QMNQej5lqVxSpEkrfw+hNqwAN7Ba6rv2O5tkmmycrsjOTdAXMYetLgPn1i
         u36lO2gk78hzby2dU9/byGNOCZZGzuuNSDr0ip3wkwIkeIT0uJMEEPqWP3A0nut2ym3k
         G1CtKd5c0G28dCCohTjrfR1xpWWaVghfCPnHN+mDQEGCYbDOUO6VHVKWAzr6aYzuihOO
         lItBol1gVrQAYxZdJOHWZmoPdPfhX6hv9fPSN0ogkwu3dzfG8ALCMNb4wp3oKFAB9zEW
         3GVQ==
X-Gm-Message-State: AOJu0YwbGThsnxW1O/ZbNMs70dSyIg60WG7pnVIVrQckAXQwmp3OSdvF
	YFGsVHBP4Yk72vKjwrR8tIaV4qE8xm2ZQh4uuWCgZFZ1FNbEk5aZKN33jDYKbZF3eT0/G5MNPSC
	LbDTBKj9CLXRiGwGKtd7qV2lyLko2PfmGBA==
X-Gm-Gg: ATEYQzxPfMlbR/GZ5hkCHNq2IWW1XSwyN26X8yYg4/MiPs1Oy3E2ZtZFg+V21M1DZP/
	jwcS1Z3R25wVibIUjWbPFE9hJQ2ZPvHEnKk+s5ua3siiMoeJYg7ktVsqzf/PUo0ZiMi+0Z8+1/7
	/MwXMk8U+UtzrsApjBRscTpgM6nkotvaZ9zEgbTFnjyykuWATvHNYVHC6GJKqKR7/+/q0xLgOhO
	2b8A6nwlISPRmuLyZCwQopKTz+Z+FfAGP7ZoMRWSYI5OW5z/qStUVE1Ea/ew769RRP7YlfoEIiX
	OPp6qrg/e+OgykaAjOd2fvxtbTSx4VkmQAy4yuL2+g==
X-Received: by 2002:a05:6102:5091:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ff322bf4bdmr2863289137.7.1772360184080; Sun, 01 Mar 2026
 02:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 16:16:13 +0600
X-Gm-Features: AaiRm52S_i7uxGvz2GvDZgmu6T0jp37pcUwvZrAaDhnW-l9lgBlZerFtvlbrSME
Message-ID: <CAFfO_h6Y1QcW7mNGdCuY-_J6zrF_F8aW+Q8O9SvoBbXTxteFjQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78840-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 155E61CF188
X-Rspamd-Action: no action

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy

On Sat, Feb 21, 2026 at 8:59=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Hi,
>
> I came upon this "Ability to only open regular files" uapi feature sugges=
tion
> from https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
> and thought it would be something I could do as a first patch and get to
> know the kernel code a bit better.
>
> I only tested this new flag on my local system (fedora btrfs).
>
> Note that I had submitted a v4 previously (that had -EINVAL for the atomi=
c_open
> code paths) but did not do a get_maintainers.pl. It didn't get any review=
 and
> please ignore that one anyway. In this version, I have tried to properly =
update
> the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs=
2,
> fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
> (fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, mo=
st of
> the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |=3D=
 FMODE_CREATED
> for the O_CREAT code path which I assume means they always create new fil=
e which
> is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead=
 of working
> if path is either a directory or regular file) as it was easier to reason=
 about when
> making changes in all the filesystems.
>
> Changes in v4:
> - changed O_REGULAR to OPENAT2_REGULAR
> - OPENAT2_REGULAR does not affect O_PATH
> - atomic_open codepaths updated to work properly for OPENAT2_REGULAR
> - commit message includes the uapi-group URL
> - v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v3:
> - included motivation about O_REGULAR flag in commit message e.g., progra=
ms not wanting to be tricked into opening device nodes
> - fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
> - fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 0=
60000000 to 0100000000
> - added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O=
_* macros from hex to octal
> - v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v2:
> - rename ENOTREGULAR to ENOTREG
> - define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) an=
d in arch/*/include/uapi/asm/errno.h files
> - override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.=
h due to clash with include/uapi/asm-generic/fcntl.h
> - I have kept the kselftest but now that O_REGULAR and ENOTREG can have d=
ifferent value on different architectures I am not sure if it's right
> - v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-=
dorjoychy111@gmail.com/T/
>
> Thanks.
>
> Regards,
> Dorjoy
>
> Dorjoy Chowdhury (4):
>   openat2: new OPENAT2_REGULAR flag support
>   kselftest/openat2: test for OPENAT2_REGULAR flag
>   sparc/fcntl.h: convert O_* flag macros from hex to octal
>   mips/fcntl.h: convert O_* flag macros from hex to octal
>
>  arch/alpha/include/uapi/asm/errno.h           |  2 +
>  arch/alpha/include/uapi/asm/fcntl.h           |  1 +
>  arch/mips/include/uapi/asm/errno.h            |  2 +
>  arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
>  arch/parisc/include/uapi/asm/errno.h          |  2 +
>  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
>  arch/sparc/include/uapi/asm/errno.h           |  2 +
>  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
>  fs/ceph/file.c                                |  4 ++
>  fs/gfs2/inode.c                               |  2 +
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 +-
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 11 +++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 119 insertions(+), 32 deletions(-)
>
> --
> 2.53.0
>

