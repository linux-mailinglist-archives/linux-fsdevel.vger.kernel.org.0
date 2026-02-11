Return-Path: <linux-fsdevel+bounces-76954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NaYOt+ojGkusAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:05:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB8125F06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B1543002F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A4335BA8;
	Wed, 11 Feb 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1UlKpmD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D832B9BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825943; cv=pass; b=EcknDwKsLQpJiZP1D3FrcKOnGZ85L8ZtCSzNLaeY7kQI4mJdaSrQxRV6rlYqQ2WZd1+adQc3vdECaVkzvcP83fFFJe1638tEZUuCA6UPgg2/VQe0fndUK9KsYidxtf1ZlKvP2faz2wPhZyluCymG7jzClfsYgYDKPVLzz+0OD+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825943; c=relaxed/simple;
	bh=CY+m/yWCdF9oclHUNZ+SL3VVALA7Vdjl2gqw7+VBr/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIVTly4Sq3eR++Ofx0zWmbSBbVO9yWKqjdZIJOyMyfxHPp227LoNkCLH/fl+P3hSircvPfVzN2xSGFV5Pm+TPr7niwtvjG5CiYbImDUc2oeuLhN26pyUzjJnUlGeyPCRuejr4t3a9f8M+czqDgxqKCkFt3giWzJ/fC7bcnnypYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1UlKpmD; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5f9ed174ebcso4397125137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 08:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770825941; cv=none;
        d=google.com; s=arc-20240605;
        b=a0iiqzOEb/vq3xjfkmFRI+mJhjZoxNZe2iyjv+b5uOhyWaNg4mG+U2v6OGiLjCOvf8
         CgHfrZE/lcZEFDOQenDfmD/KFaMxSPtlaPJCNeLILx6kPY50LPLMjV90E7K3oFtB/LAr
         HZORSZjCqBRMoRL7sCirDwWnSYnR1l8RezkdkW+SsK7tT3bEhzCOq9HOhHBmwQJjaXaT
         vJXtzj/24UPtX2AKS+JEg2bKcMvPrK5tJhnqprW3sTV5l3k4mqBEvLhrZyP+2auG176/
         Xeoz+aLKitgMsceqT30tjSTU0AF8Z4CNYQm9Wr7L7ZV+I0MiJRNALyoxP4ITWmj6aaxs
         a5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQ3J36Qefr0ORl6pDRhDRFyaV8fkIkX7qTVm1qK0zx4=;
        fh=ycnk+DzZGjHB/nOiT9vhJr1YYXt7FXpBcfzKzRRZQfQ=;
        b=j/HXHERDcxmhpDRK74CeDsHuSsbJHIOG7/7HeeuCEEsGuEAwrA+OyFWYCzMc4qZ2wZ
         Bn162BOF7fZcCEr5Sfsk+nqGEi/ULpl7m+b+p0zUa3KZhQeU4JfvCweeRmRUwbN+RKmj
         wT4Jni10Idl1Yy3nHepDxRpCr+aXov+Me76a/SaTfDBkanpfvak/FEHqw//g2xEYQpP9
         8Pcw2Vg8y5nyDXBv6KCkEPlm7tLftzi4Ct8M8gMUNza2lGB/pEHnt/jMY96U8lO+vfcO
         Nk4shxZ97B1ifAs+DS6o+zbsQV1Gf2WeWNgsAUb3jzqg9NnEVeNzWU8tJXTI0tifx/n9
         ivfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770825941; x=1771430741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ3J36Qefr0ORl6pDRhDRFyaV8fkIkX7qTVm1qK0zx4=;
        b=U1UlKpmDETCcvk4bEj0aY22c/ugLuHmkBf0+a2seyUgnV5PkW0K9q3+osoqSqsSyBr
         pWllUrgVG2jT48CYmqxRu23AF89Jif5o0Hv7LrTKnkvSl69Zr0eV4v4v/BcF9V63tuT1
         IxQbdslkPrdmlSFwTf6s7dIyKNl61w99XFKa5P8dmPTAaJuh7MxwS+tulgpk7wmIifgs
         Pou7ZhngwZYYfG1mYfZkruEDZpGNrb6qoho3UfyQvByG4VVZ1s08KOEJmVg3u+7WvEWp
         X9/JL19fue8+uJIU+0mpVy2I6baxxkF+lrDUhFwFzO37Y82CFJ7X4ifsNx3B5l6c+RvR
         Y3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770825941; x=1771430741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQ3J36Qefr0ORl6pDRhDRFyaV8fkIkX7qTVm1qK0zx4=;
        b=MGqq6LB+fa4Vw+YVKyWu72sQChI4QwyBSpAUBkAx1vZvewcVZ9AB6IncxHrAnLE7fz
         xPAQci7etuWpOOPxfiE4dWWFP4XyWJKv9ARMTxa81Se7V2rTsQUSWbbk2buJyRaFMpCY
         wom9LJGKGuzV8+Br5z3jPKXNMvwg1qnSeZyqWf3Othfzm4j6KN1hP1zW6ffuBqD5JMeB
         bKF85cCVQo0Y0gjWlXbCHx1mfhVL6R4635lIQGQvdMEl4jOyLCDqtT6NP7YHtDajGOJ0
         hUaK+XhpyyILdwJHT+IwCyJDPyxt5nFnppIXYWuteLxbfLvwjD2CmdEHDcuU1v31WJW5
         yYtA==
X-Gm-Message-State: AOJu0YyhF0dpWpTXgh6F9hjh0mxJtBH7mX5UXi6h/6wkK61iTax5sw8j
	vp8pZQ6LFRCa8UabQ2zPtkZDr2FFQO06QNJbFTRhS0Cn6nCaOjGVdaHHtfYlZQ4pE1v0MKNDG5T
	H4HC1wa60xJRF3KYTnX09Wm1PC9h691TXbQ==
X-Gm-Gg: AZuq6aLAVpGaBBIpKJ5FKHFcFff8/aEuMySOnVuOQdczU3+bG8jREkjt3De6RN6wga1
	5AYq52yS/AHoQxFE/raxgmud8R2lIg8rht23m40oWOIlHCaK2ru1SjCCTDvF64Zf2Pc0wKmlewK
	YMFB3f5ObZVdDpEmnZaUlWfEJnA3x5kMzQjJ05wejR0PN6fpk+uf0ijao03FcU4il7/en+Se3QE
	nrFDvyPkmlsk1Ruarm5Zqxes+UMlRF1+ETO+7mP0RnKeG7tS+s6o72xfVI0V0det7beYNoxCMWf
	JHULPjvRCk0/HuazxWFHIUU4jFsdiQ+/wtE7YcZKMU++Z5YGsbMFfQ==
X-Received: by 2002:a05:6102:3a13:b0:5fd:eb74:ca41 with SMTP id
 ada2fe7eead31-5fdeb74cc77mr624474137.24.1770825940455; Wed, 11 Feb 2026
 08:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206190536.57289-1-dorjoychy111@gmail.com>
In-Reply-To: <20260206190536.57289-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 11 Feb 2026 22:05:28 +0600
X-Gm-Features: AZwV_Qhcln6Pgpzp3lnEnJJGjX5ugGj4d6tIgXqRWH9Bd7UvTjOjdD-nH3gtwzs
Message-ID: <CAFfO_h4Hw5Lu-PQn4C31Cdzcz2AH5zmWa-TB8ocdci5K=F8m7Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] openat2: new OPENAT2_REGULAR flag support
To: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jlayton@kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76954-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[file_operations.open:url,uapi-group.org:url,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64FB8125F06
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 1:05=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> Note that in v4, for now, I have returned -EINVAL from the atomic_open co=
depaths.
> I do want to make this new flag properly supported and proper api behavio=
r, but
> last time I could not quite understand what should be done for the atomic=
_open
> codepaths. So to have a more concrete discussion, I have included the -EI=
NVAL
> changes.
>
> Changes in v4:
> - changed O_REGULAR to OPENAT2_REGULAR
> - OPENAT2_REGULAR does not affect O_PATH
> - OPENAT2_REGULAR with O_DIRECTORY will open path for both directory or r=
egular file
> - atomic_open codepaths updated to return -EINVAL when OPENAT2_REGULAR is=
 set
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
> Hi,
>
> I came upon this "Ability to only open regular files" uapi feature sugges=
tion
> from https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
> and thought it would be something I could do as a first patch and get to
> know the kernel code a bit better.
>
> I am not quite sure if the semantics that I baked into the code for this
> O_REGULAR flag's behavior when combined with other flags like O_CREAT loo=
k
> good and if there are other places that need the checks. I can fixup my
> patch according to suggestions for improvement. I did some happy path tes=
ting
> and the O_REGULAR flag seems to work as intended.
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
>  arch/mips/include/uapi/asm/fcntl.h            | 22 ++++-----
>  arch/parisc/include/uapi/asm/errno.h          |  2 +
>  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
>  arch/sparc/include/uapi/asm/errno.h           |  2 +
>  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++-------
>  fs/9p/vfs_inode.c                             |  3 ++
>  fs/9p/vfs_inode_dotl.c                        |  3 ++
>  fs/ceph/file.c                                |  3 ++
>  fs/fuse/dir.c                                 |  3 ++
>  fs/gfs2/inode.c                               |  3 ++
>  fs/namei.c                                    |  9 +++-
>  fs/nfs/dir.c                                  |  3 ++
>  fs/nfs/file.c                                 |  3 ++
>  fs/open.c                                     |  2 +-
>  fs/smb/client/dir.c                           |  3 ++
>  fs/vboxsf/dir.c                               |  3 ++
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 46 ++++++++++++++++++-
>  28 files changed, 138 insertions(+), 31 deletions(-)
>
> --
> 2.53.0
>

Hi,
I would appreciate some feedback on this patch series. I think there
are 2 things that need definite feedback.

1) I have defined OPENAT2_REGULAR to be in the 32-bit space. At first,
I tried to make it the 33rd bit but then realized, there are existing
structs like (struct open_flag and others) where the flag (or similar)
members are of type int or unsigned int which get passed over to lots
of places. So I ended up making it a flag in the 32-bit space. I guess
it's okay as it's not easy to add new flags to existing open syscalls
due to backward compatibility anyway.

2) For now, I am returning -EINVAL from the atomic_open codepaths.
What would be the proper way to handle this? And is there anything
needed for the file_operations.open codepaths (right now, do_open
already checks and returns errors for the new flag before we reach
file_operations.open)? I am a bit confused about the new flag and
network filesystems where obviously the new flag won't be recognized
by the server. So, if we want to handle the new flag properly in those
filesystems, does the flag need to be masked out? It's a bit hard for
me to understand the right thing that should be done as I am not
familiar with all the code so I appreciate any help and suggestions on
this.

Thanks.

Regards,
Dorjoy

