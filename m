Return-Path: <linux-fsdevel+bounces-77855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPVLLiPUmWnWWwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:49:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255A16D36F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 949A53005166
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46789246797;
	Sat, 21 Feb 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkb4fODz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65C24469E
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771688981; cv=pass; b=Q2rf0DzLT8eT5ZF2bx7ZwqQ6Lk/GSu1FJB+igovMWfN7gjHEdiZg3dx9mBJO4V0d8XNyTcVdFjrkKOLJALv7Q2tbPEl/RVMezX65f0oM1EMy8IglJ3WArpAfoxcHw3ieCUOd1pHAgU4u8uW8KL8Ev9+YJVnWasOa8KOXpyezlmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771688981; c=relaxed/simple;
	bh=23P6V3/EZFsgY+c1DhMXwm+sT4gSINYfgO8QSA/c/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+EX2TGw/Is/Q14l96xhlvgaBsaUw1MoYdq2jo423qz3Xa81JfibPDD5DM3wmHSyaE0COIEZUR4ZpnxKPYJ122EYZhhkrMXqDFP+svHw4XKOYVCo2YHruY+h8+HIpRhsTtrqtVw70FSmF2cYRi3eyZG5ur+PPOq4mKI/ngfKgxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkb4fODz; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-948ccec7c89so868703241.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 07:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771688979; cv=none;
        d=google.com; s=arc-20240605;
        b=P1WH8iX9mSWyHtvQMwLEH/6uhxw0EgeDMZygrGRo2efXVYkzf4iTOPSQ6f8cNANz3d
         PO3TodIe+DvTIitsmlc38UPCel1ESMtqzS6zLCx3uwTFUiTTzgyDt0w5YfUM9tQ2iNIq
         ZQ7XwifD4DwUrKL034N0bda0e5+MsjqbAQIcD0r38RucaeOgFTGIp1e8ErxGFKu/pPtS
         589LmwUqnxiWtGMvBiTbhjqne/HDhJL+FOPqrzU9U2OR+6kwVABMiNA070BSRuEvSRR8
         yNA1JcuZaEb+okFJoocrtcp22oN3fKP0em4jH/0LTaE4qOn+3AZRAVPoASRxmHGL8M1t
         r8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        fh=QmP7FmnHBnfXKJWHkz8FRhPdYzdsDA8OP6XZkpJDshc=;
        b=EM6VxfdTFXAKfTLhJHlgTqft+9vuyKt/RbN0j9qAs22blUCOwR5RMtIK8baTSuGpOu
         HiX8PpiXzyfiS6H8cz2y1WmcB0Af7bC7DTElPzVotcCloWl9jMcYjYp4CCS5cO89jJfG
         xA9t/WjCTgu0SJbQbcOg9D5j5QTBENjyYSgLxEEZIXIoyBQHKqbhfuRgcMygbQjrW1Uh
         Hcj+l+LmVOpsWO4ZQ9Ra1FnKGMRk/Q94Eq7wztvD05LaVEjLURanPMmIMuSjMlvwKmxe
         9Qkmme1xqOuE0SfZ7wYH3LW5qk4pxZEY4h9IAuTuq8cUwyo4z+gPm247AVFtUw1+u/y7
         ewag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771688979; x=1772293779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=Gkb4fODzMaw1FLWV7mj2nCgQ03v5D6/tPz5gHoVwIGz2lLtM06+6FOW6rnoYecBJL1
         Uikc2GaVK1cDHI42+uotLOIYJ/g3huSLJtoxuXUDOk7Fr2lCTZn/Rl3MZ9XPCO4HPhD/
         UtNuy4LArncf6UKt57ejd7jtyhd3w5eBdWMIk4LLIA/cJVAaVdQC/TiWyiW6dNqUSFMX
         NLeThlFQuWxY0TzxS0mNhI44QpBx+ybld6i7VIXlxb3yPUx73HYZhK/4WK9tRdCVwbAe
         NMWcuQj+hR4G7Xdg0TAlaJH2OFWMi3S6BboSVmZ4WKVbvgJDdpgdpTfoWJQYQ0VwpgHE
         HDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771688979; x=1772293779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=KaEhGRdYdBDVYaZYNtoHFzhlnZJEwNVnySJkkFNm1oa3pm2W3KfmzenIN79qzyRKEx
         /8Suei293EpAMuQ0SpTouBd6ne8DGu8/OV+nvhnYasSKquZabIsT/tiJIi3dEPYLywZw
         lbK4qelf7aQS6xTQeDCadlI61xpBGwAP8O78qMRVq9ZcHDeCrifTBPqbs18dW0GDUSnF
         p1i5Dt7AuKzXh2qGQtjreee81Wgd8u/KbsbUkcahnxQEKQQwudsGFgSTw6iiNVr/wvVR
         0spCxZNs/BZsSdjTdX0l+6ilLANDrq4chkTG+aKEzAChvsqBBtCF79hi/oULA/IoofEp
         z5uw==
X-Gm-Message-State: AOJu0YziY8Ark8IZZBWuefR5he7EHKQE9uaeKQq6zGtQTLrCYxk58ezK
	mUYSDbk8MjHvxqOBDtDH43jCmgAD0NWh9s08TObVT/YyPHTpPlma4eBofVUE1TbLfI1Cg40Na1P
	E0IyLlpK155J90Yotw29r0CfQCoTiSMpixBgVVEE=
X-Gm-Gg: AZuq6aLWkEB7xBpBqD2DBvkHvLLk9g82eVl6nkUsemTMkXN6ZuOPzO80xYTIVF8xoIW
	ymI3anPD3U8wfFn4QaIT9W6o0HacsNXneGNT4/vW4aZJZaWX4oWRuGhNhD5bv4RZcqtK+PTRSf4
	gLKSUHemUg49oxNMjuLDAdGcBqpgf2NoXbLtafCpI80dJjlrkJ6sYgnDe6GBlU9oesKLEaZI6jn
	knzwHEI7J3ir0EPBCdWPGEsOgzz6bcR0FIB3DraiS6Knky12j1eNGhCVbqgMbDULMJKT4sDt3OM
	TaqatFZaxrisEilTH4/hWHIojrZiNvL+eAna4jG/FMg=
X-Received: by 2002:a05:6102:6cd:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5feb30aa44cmr1230671137.29.1771688978916; Sat, 21 Feb 2026
 07:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 21 Feb 2026 21:49:27 +0600
X-Gm-Features: AaiRm52uxICzwXE4h2cG-NB71vMvoLaBUhNK0X1besn-bhoE2jLckvjHX39jcu4
Message-ID: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-77855-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uapi-group.org:url,get_maintainers.pl:url]
X-Rspamd-Queue-Id: 3255A16D36F
X-Rspamd-Action: no action

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

I am not sure if my patch series made it properly to the mailing
lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
The patch series does have a big cc list (what I got from
get_maintainers.pl excluding commit-signers) and I used git send-email
to send to everyone. It's also showing properly in my gmail inbox. Is
it just the website that's not showing it properly? Should I prune the
cc list and resend? is there any limitations to sending patches to
mailing lists with many cc-s via gmail?

