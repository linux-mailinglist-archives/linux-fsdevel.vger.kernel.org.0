Return-Path: <linux-fsdevel+bounces-77604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DWCLGcElmm4YQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:26:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B4A158B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 276D6301ECD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073AD344DAC;
	Wed, 18 Feb 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI5r8fen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5D2DC77F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439184; cv=pass; b=M7lCW0oMsjVjq9u6HFmLc+bbnCSfCDA3AiVgzg8Up4LwWmxi56a+/yUkWsT8cAyBHdHXI0PK94/IhiLsvtn/S/qY0A4VLoMZG7tNNflpKoi5GK/Gxj1f7OfxzpXIsNlcyJ3wzlqXmc/NtKKMP69u7SUU99MJggRHP2Y17sekeFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439184; c=relaxed/simple;
	bh=/3L6TlTJg1WhHYIEd2iVIAIUxJmA8UJj7ZTAnhtx+PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7q4k+JdWWsDNg+Z2Gy2EafypNskrVVktoFL9ARW9Z80S1DkCQusDyoXXHR09CoEcaE3KJS1ihurb96LPavINadgnM013ZV9citbww2NGGBv7+G/OGqJzpzCkuQUFCLfHzA8p00RszDtRk/sOcQnJeiBjNKuLOy+zx0S51H2VwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI5r8fen; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fa3f2b8f7dso94317137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 10:26:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771439181; cv=none;
        d=google.com; s=arc-20240605;
        b=HMwiVnbHiggaH6Pzptr898UCI0DE4VaphQEXiJ8aAvfggfe544mNcx34sZcjwScONH
         SDoo1DHqYeZ96mLgqbJrA7IIl7mhgWLkjIoQujvxxijKHOutBqu5Wxs6bcYSu9T1vOK/
         R8C8wQM8FfRFWVhEG74XoSCu2OArMMuI5t+AgFs1HiGIwUZm9FAFHf75oQtZhs//0QtM
         qFmm5he0tcl7DR0mfSOdGg1ulyJJifSS16a892lbZGO9xb041ISsR6EaOvJxtmSo2e/8
         TUn9z43X1Qaf1RQ5hOJG09dsPW/CmarbeCBzdCwmQNGTprxqU8M8ciqSOk5WkicNr9vv
         nD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I5HdFmcgA1ZCCOQC87AnsgKkyIlCrosqjIVOBiBsa8Y=;
        fh=7o5I8DbYgvBmrpqoTx+VaCRrbDFH3ZO6SSaV3N1opeM=;
        b=EFmNp8oFbASH6GmJBPQDdl3u5w80vlznz+Pl1J7X8ja/xF23bnyTGMA+dejCsbTTv/
         8GmUjltd1B+N9gmch0OYSCUeqxnoDMsZs6pSn24XaNuXAmOAL32gpPDXkxQzAkVliNxh
         xm4+8tHfqnQvUpGD19+oWVSIsuvGp6JIRbe+JmkbHjDLTVq2pH+Sk5o8rBvGPuT5tfvr
         gOdKDg68pmDKQhHiqH2dIeBoNDKNZRe7cUuIGzxcWjmILGUpwZz7ZPzsDLVbidZYV3s2
         zc+MfB9NwTcsAjP9G1825xHJjVvMP3a2FpxBVPbfXHTqCyCAe4isN95F1/9axvwLlU5f
         FdLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439181; x=1772043981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5HdFmcgA1ZCCOQC87AnsgKkyIlCrosqjIVOBiBsa8Y=;
        b=lI5r8fenc5f8l+O/zCck6QY8tJM8Pa79tEw2id5IFMkzNY/HfqeIWSNWoXpsb752QU
         Slmo9vW/s4L/M1o7px6EXb1/56LqeHYNY5ObVPX8ofhVRRvMtACgeaMOshWMME4HBWo3
         tlqql0coq2ujsOrECVB/SPJDtfkj4fWL87DAY6KNlzpMsQVrxRiTF78bxqMta6UbOvdu
         E76udsKoARCg+6X2WVV66MN8zEtVo8LOrozfhoUbm52W12Q/YpimB+oXIENoJkNVwZMn
         tAdFRN6/LIv7xOes00SfnBRSQ8xAxbALL4UsJNdw3vEy5yfMkE2J41W6Skjwv2vQi51C
         u3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439181; x=1772043981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5HdFmcgA1ZCCOQC87AnsgKkyIlCrosqjIVOBiBsa8Y=;
        b=MexTIdan/iHFVdKOZ2+C6aIKOv1Yee1IIj/tA4XIrYMLLjRsdxMmUn9l72z3tFb9d+
         eTSaBXRmJTgAW5vSLicyRdlK8qlgmTLdhOxwUh9dECq2ExKU3yfHyLpMr1rLUUr26C65
         XyYcQgBCz4HFaE6SpZFN1TZ7aIV4zu11TGIg9MsYveixcOLxGqDHEXBpyIsXiyBc7H10
         gzZxBF7OA/zUYriWzd8HV5gyWkWHB6Q3oG/GQ2H02HqzijJYTLVGzZlw9vgkvRvmcwvX
         bYZFoP+sUq8SevvXLJsVMLcf1ezcu/qHVJORruOkPFtlFjYoFmXFeG6ibyr2TxH730qS
         h+QA==
X-Forwarded-Encrypted: i=1; AJvYcCVIkSIHz9ggpLe08+Fg/FUA1uTxRGjYRiZtCMgEo7ha7+klf6mM382/SgKWtnNpKSNdYXWqwwX0sVIQbjCM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AJMysiiAmI+9gUohkuoW0bJ0ZgE7xcGlYkQpGd+X21DG9R34
	Ex2ccmgxkNPEI5Tvs1Ho9yG8/fQNKjR+1evge1jafsa4zq5naXYynTRJWHfaZfortYPcDzz+Kgn
	Zb4q8z8fCCq3KLxk3mtUzJ1iPVn8tieY=
X-Gm-Gg: AZuq6aKM0QDKE1gYsd/M3YJ/WgAsIEnXuMeX0uDKJnJdNIPlVwbj2zZ+/DAcdL18Qps
	iS4DiIxYbNSDHBEyhb0pNqZ3QDMfcEw4wZaYOh8Y85OKy0gQJ4m+KnKPZ5+IwW2OMnPB7AcjEwB
	0CoeWp+JUAsjxjnZYhE4MMmyw9AFCVu4VW1/v16m3QONJfHocyU9+VMSFSgeat9GmF65Dl3YQYV
	LBNBenCcORI95QtejcNY//dqX46QNmr21kgmOT4Fh53MVPPZnjqlso/FRMWbRkRXmX8iSTLjrt2
	7syY902tG84CMS/UymsJ+0t23IklYE+VlVd5yPcAorsQ0HSujxAi4g==
X-Received: by 2002:a05:6102:c0f:b0:5fc:5852:6321 with SMTP id
 ada2fe7eead31-5fe7f3ffd65mr1548041137.20.1771439181151; Wed, 18 Feb 2026
 10:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com> <1c6cccc3e058ef16fa8b296ef6126b76a12db136.camel@kernel.org>
 <CAFfO_h5yrXR0-igVayH0ent1t12rm=6DUEGjUDW0zqfqy3=ZoQ@mail.gmail.com>
 <b6749fa99a728189e745f1769140be3ac8950af5.camel@kernel.org>
 <20260129-tierwelt-wahlabend-2cb470bcb707@brauner> <90421b8d47484be162644e3b612daaf271bc7855.camel@kernel.org>
In-Reply-To: <90421b8d47484be162644e3b612daaf271bc7855.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 19 Feb 2026 00:26:09 +0600
X-Gm-Features: AaiRm51YnkiER0zxUyd7E-xGCkLm_D7LKh--aHD-GgJgOX4KEHny9d5tzE-Y5t0
Message-ID: <CAFfO_h5B72v+1aZWU9jNNWFPGcZhti0oVPCWMAPkPjpq2_1nVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, smfrench@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77604-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,file_operations.open:url]
X-Rspamd-Queue-Id: 12B4A158B27
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 7:12=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2026-01-29 at 13:33 +0100, Christian Brauner wrote:
> > On Wed, Jan 28, 2026 at 10:51:07AM -0500, Jeff Layton wrote:
> > > On Wed, 2026-01-28 at 21:36 +0600, Dorjoy Chowdhury wrote:
> > > > On Wed, Jan 28, 2026 at 5:52=E2=80=AFAM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > On Tue, 2026-01-27 at 23:58 +0600, Dorjoy Chowdhury wrote:
> > > > > > This flag indicates the path should be opened if it's a regular=
 file.
> > > > > > This is useful to write secure programs that want to avoid bein=
g tricked
> > > > > > into opening device nodes with special semantics while thinking=
 they
> > > > > > operate on regular files.
> > > > > >
> > > > > > A corresponding error code ENOTREG has been introduced. For exa=
mple, if
> > > > > > open is called on path /dev/null with O_REGULAR in the flag par=
am, it
> > > > > > will return -ENOTREG.
> > > > > >
> > > > > > When used in combination with O_CREAT, either the regular file =
is
> > > > > > created, or if the path already exists, it is opened if it's a =
regular
> > > > > > file. Otherwise, -ENOTREG is returned.
> > > > > >
> > > > > > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY=
 (not
> > > > > > part of O_TMPFILE) because it doesn't make sense to open a path=
 that
> > > > > > is both a directory and a regular file.
> > > > > >
> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > > ---
> > > > > >  arch/alpha/include/uapi/asm/errno.h        | 2 ++
> > > > > >  arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> > > > > >  arch/mips/include/uapi/asm/errno.h         | 2 ++
> > > > > >  arch/parisc/include/uapi/asm/errno.h       | 2 ++
> > > > > >  arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> > > > > >  arch/sparc/include/uapi/asm/errno.h        | 2 ++
> > > > > >  arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> > > > > >  fs/fcntl.c                                 | 2 +-
> > > > > >  fs/namei.c                                 | 6 ++++++
> > > > > >  fs/open.c                                  | 4 +++-
> > > > > >  include/linux/fcntl.h                      | 2 +-
> > > > > >  include/uapi/asm-generic/errno.h           | 2 ++
> > > > > >  include/uapi/asm-generic/fcntl.h           | 4 ++++
> > > > > >  tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> > > > > >  tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> > > > > >  tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> > > > > >  tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> > > > > >  tools/include/uapi/asm-generic/errno.h     | 2 ++
> > > > > >  18 files changed, 38 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/i=
nclude/uapi/asm/errno.h
> > > > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > > > @@ -127,4 +127,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    139     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              140     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/i=
nclude/uapi/asm/fcntl.h
> > > > > > index 50bdc8e8a271..4da5a64c23bd 100644
> > > > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > @@ -34,6 +34,7 @@
> > > > > >
> > > > > >  #define O_PATH               040000000
> > > > > >  #define __O_TMPFILE  0100000000
> > > > > > +#define O_REGULAR    0200000000
> > > > > >
> > > > > >  #define F_GETLK              7
> > > > > >  #define F_SETLK              8
> > > > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/inc=
lude/uapi/asm/errno.h
> > > > > > index c01ed91b1ef4..293c78777254 100644
> > > > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > > > @@ -126,6 +126,8 @@
> > > > > >
> > > > > >  #define EHWPOISON    168     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              169     /* Not a regular file */
> > > > > > +
> > > > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > > >
> > > > > >
> > > > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc=
/include/uapi/asm/errno.h
> > > > > > index 8cbc07c1903e..442917484f99 100644
> > > > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > > > @@ -124,4 +124,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    257     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              258     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc=
/include/uapi/asm/fcntl.h
> > > > > > index 03dee816cb13..0cc3320fe326 100644
> > > > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > @@ -19,6 +19,7 @@
> > > > > >
> > > > > >  #define O_PATH               020000000
> > > > > >  #define __O_TMPFILE  040000000
> > > > > > +#define O_REGULAR    0100000000
> > > > > >
> > > > > >  #define F_GETLK64    8
> > > > > >  #define F_SETLK64    9
> > > > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/i=
nclude/uapi/asm/errno.h
> > > > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > > > @@ -117,4 +117,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    135     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              136     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/i=
nclude/uapi/asm/fcntl.h
> > > > > > index 67dae75e5274..a93d18d2c23e 100644
> > > > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > @@ -37,6 +37,7 @@
> > > > > >
> > > > > >  #define O_PATH               0x1000000
> > > > > >  #define __O_TMPFILE  0x2000000
> > > > > > +#define O_REGULAR    0x4000000
> > > > > >
> > > > > >  #define F_GETOWN     5       /*  for sockets. */
> > > > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > > index f93dbca08435..62ab4ad2b6f5 100644
> > > > > > --- a/fs/fcntl.c
> > > > > > +++ b/fs/fcntl.c
> > > > > > @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> > > > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; =
O_NDELAY
> > > > > >        * is defined as O_NONBLOCK on some platforms and not on =
others.
> > > > > >        */
> > > > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > >               HWEIGHT32(
> > > > > >                       (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDEL=
AY)) |
> > > > > >                       __FMODE_EXEC));
> > > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > > index b28ecb699f32..f5504ae4b03c 100644
> > > > > > --- a/fs/namei.c
> > > > > > +++ b/fs/namei.c
> > > > > > @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
> > > > > >               if (unlikely(error))
> > > > > >                       return error;
> > > > > >       }
> > > > > > +
> > > > > > +     if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry)=
)
> > > > > > +             return -ENOTREG;
> > > > > > +
> > > > > >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->p=
ath.dentry))
> > > > > >               return -ENOTDIR;
> > > > > >
> > > > > > @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd=
, unsigned flags, struct file *file)
> > > > > >       struct path path;
> > > > > >       int error =3D path_lookupat(nd, flags, &path);
> > > > > >       if (!error) {
> > > > > > +             if ((file->f_flags & O_REGULAR) && !d_is_reg(path=
.dentry))
> > > > > > +                     return -ENOTREG;
> > > > > >               audit_inode(nd->name, path.dentry, 0);
> > > > > >               error =3D vfs_open(&path, file);
> > > > > >               path_put(&path);
> > > > > > diff --git a/fs/open.c b/fs/open.c
> > > > > > index 74c4c1462b3e..82153e21907e 100644
> > > > > > --- a/fs/open.c
> > > > > > +++ b/fs/open.c
> > > > > > @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struc=
t path *path, int flags,
> > > > > >  EXPORT_SYMBOL_GPL(kernel_file_open);
> > > > > >
> > > > > >  #define WILL_CREATE(flags)   (flags & (O_CREAT | __O_TMPFILE))
> > > > > > -#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PAT=
H | O_CLOEXEC)
> > > > > > +#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PAT=
H | O_CLOEXEC | O_REGULAR)
> > > > > >
> > > > > >  inline struct open_how build_open_how(int flags, umode_t mode)
> > > > > >  {
> > > > > > @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct =
open_how *how, struct open_flags *op)
> > > > > >                       return -EINVAL;
> > > > > >               if (!(acc_mode & MAY_WRITE))
> > > > > >                       return -EINVAL;
> > > > > > +     } else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) =
{
> > > > > > +             return -EINVAL;
> > > > > >       }
> > > > > >       if (flags & O_PATH) {
> > > > > >               /* O_PATH only permits certain other flags to be =
set. */
> > > > > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > > > > index a332e79b3207..4fd07b0e0a17 100644
> > > > > > --- a/include/linux/fcntl.h
> > > > > > +++ b/include/linux/fcntl.h
> > > > > > @@ -10,7 +10,7 @@
> > > > > >       (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCT=
TY | O_TRUNC | \
> > > > > >        O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | =
\
> > > > > >        FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLL=
OW | \
> > > > > > -      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > > > > +      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR=
)
> > > > > >
> > > > > >  /* List of all valid flags for the how->resolve argument: */
> > > > > >  #define VALID_RESOLVE_FLAGS \
> > > > > > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/as=
m-generic/errno.h
> > > > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > > > --- a/include/uapi/asm-generic/errno.h
> > > > > > +++ b/include/uapi/asm-generic/errno.h
> > > > > > @@ -122,4 +122,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    133     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              134     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/as=
m-generic/fcntl.h
> > > > > > index 613475285643..3468b352a575 100644
> > > > > > --- a/include/uapi/asm-generic/fcntl.h
> > > > > > +++ b/include/uapi/asm-generic/fcntl.h
> > > > > > @@ -88,6 +88,10 @@
> > > > > >  #define __O_TMPFILE  020000000
> > > > > >  #endif
> > > > > >
> > > > > > +#ifndef O_REGULAR
> > > > > > +#define O_REGULAR    040000000
> > > > > > +#endif
> > > > > > +
> > > > > >  /* a horrid kludge trying to make sure that this will fail on =
old kernels */
> > > > > >  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> > > > > >
> > > > > > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/=
arch/alpha/include/uapi/asm/errno.h
> > > > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > > > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > > > > > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > > > > > @@ -127,4 +127,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    139     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              140     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/a=
rch/mips/include/uapi/asm/errno.h
> > > > > > index c01ed91b1ef4..293c78777254 100644
> > > > > > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > > > > > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > > > > > @@ -126,6 +126,8 @@
> > > > > >
> > > > > >  #define EHWPOISON    168     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              169     /* Not a regular file */
> > > > > > +
> > > > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > > >
> > > > > >
> > > > > > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools=
/arch/parisc/include/uapi/asm/errno.h
> > > > > > index 8cbc07c1903e..442917484f99 100644
> > > > > > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > > > > > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > > > > > @@ -124,4 +124,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    257     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              258     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/=
arch/sparc/include/uapi/asm/errno.h
> > > > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > > > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > > > > > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > > > > > @@ -117,4 +117,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    135     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              136     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/inc=
lude/uapi/asm-generic/errno.h
> > > > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > > > --- a/tools/include/uapi/asm-generic/errno.h
> > > > > > +++ b/tools/include/uapi/asm-generic/errno.h
> > > > > > @@ -122,4 +122,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    133     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define ENOTREG              134     /* Not a regular file */
> > > > > > +
> > > > > >  #endif
> > > > >
> > > > > One thing this patch is missing is handling for ->atomic_open(). =
I
> > > > > imagine most of the filesystems that provide that op can't suppor=
t
> > > > > O_REGULAR properly (maybe cifs can? idk). What you probably want =
to do
> > > > > is add in some patches that make all of the atomic_open operation=
s in
> > > > > the kernel return -EINVAL if O_REGULAR is set.
> > > > >
> > > > > Then, once the basic support is in, you or someone else can go ba=
ck and
> > > > > implement support for O_REGULAR where possible.
> > > >
> > > > Thank you for the feedback. I don't quite understand what I need to
> > > > fix. I thought open system calls always create regular files, so
> > > > atomic_open probably always creates regular files? Can you please g=
ive
> > > > me some more details as to where I need to fix this and what the
> > > > actual bug here is that is related to atomic_open?  I think I had d=
one
> > > > some normal testing and when using O_CREAT | O_REGULAR, if the file
> > > > doesn't exist, the file gets created and the file that gets created=
 is
> > > > a regular file, so it probably makes sense? Or should the behavior =
be
> > > > that if file doesn't exist, -EINVAL is returned and if file exists =
it
> > > > is opened if regular, otherwise -ENOTREG is returned?
> > > >
> > >
> > > atomic_open() is a combination lookup+open for when the dentry isn't
> > > present in the dcache. The normal open codepath that you're patching
> > > does not get called in this case when ->atomic_open is set for the
> > > filesystem. It's mostly used by network filesystems that need to
> > > optimize away the lookup since it's wasted round trip, and is often
> > > racy anyway. Your patchset doesn't address those filesystems. They wi=
ll
> > > likely end up ignoring O_REGULAR in that case, which is not what you
> > > want.
> > >
> > > What I was suggesting is that, as an interim step, you find all of th=
e
> > > atomic_open operations in the kernel (there are maybe a dozen or so),
> > > and just make them return -EINVAL if someone sets O_DIRECTORY. Later,
> > > you or someone else can then go back and do a proper implementation o=
f
> > > O_REGULAR handling on those filesystems, at least on the ones where
> > > it's possible. You will probably also need to similarly patch the
> > > open() routines for those filesystems too. Otherwise you'll get
> > > inconsistent behavior vs. when the dentry is in the cache.
> > >
> > > One note: I think NFS probably can support O_DIRECTORY, since its OPE=
N
> > > call only works on files. We'll need to change how we handle errors
> > > from the server when it's set though.
> >
> > So I think you're proposing two separate things or there's a typo:
> >
> > (1) blocking O_DIRECTORY for ->atomic_open::
> > (2) blocking O_REGULAR for ->atomic_open::
> >
> > The (1) point implies that O_DIRECTORY currently doesn't work correctly
> > with atomic open for all filesystems.
> >
> > Ever since 43b450632676 ("open: return EINVAL for O_DIRECTORY |
> > O_CREAT") O_DIRECTORY with O_CREAT is blocked. It was accidently allowe=
d
> > and completely broken before that.
> >
> > For O_DIRECTORY without O_CREAT the kernel will pass that down through
> > ->atomic_open:: to the filesystem.
> >
> > The worry that I see is that a network filesystem via ->atomic_open::
> > somehow already called open on the server side on something that wasn't
> > a directory. At that point the damage such as side-effects from device
> > opening is already done.
> >
> >
>
> Exactly. I guess you could send an immediate close, but that's not
> without side effects.
>
> >
> > But I suspect that every filesystem implementing ->atomic_open:: just
> > does finish_no_open() and punts to the VFS for the actual open. And the
> > VFS will catch it in do_open() for it actually opens the file. So the
> > only real worry for O_DIRECTORY I see is that there's an fs that handle=
s
> > it wrong.
> >
> > For (2) it is problematic as there surely are filesystems with
> > ->atomic_open:: that do handle the ~O_CREAT case and return with
> > FMODE_OPENED. So that'll be problematic if the intention is to not
> > trigger an actual open on a non-regular file such as a
> > device/socket/fifo etc. before the VFS had a chance to validate what's
> > going on.
> >
> > So I'm not excited about having this 70% working and punting on
> > ->atomic_open:: waiting for someone to fix this. One option would be to
> > bypass ->atomic_open:: for OPENAT2_REGULAR without O_CREAT and fallback
> > to racy and pricy lookup + open for now. How problematic would that be?
> > If possible I'd prefer this a lot over merging something that works
> > half-way.
> >
> > I guess to make that really work you'd need some protocol extension?
>
> For NFS, I think we're OK. The OPEN call on NFSv4 only works for
> regular files, so it should be able to handle O_REGULAR. We just need
> to rejigger the error handling when it's set (just return an error
> instead of doing the open of a directory or whatever it is).
>

Thank you for the details. Do you remember which codepath this is? Is
this the inode_operations.atomic_open codepath or file_operations.open
codepath? I am a bit confused also about where exactly the error
handling that needs to be done.

> The others (at a quick glance):
>
> cifs: I don't see a way to specify an O_REGULAR equivalent to the
> SMB2_CREATE call and it looks like it can create directories. Maybe
> SteveF (cc'ed) knows if this is possible?
>
> ceph: I think CEPH_MDS_OP_OPEN might only work for files, in which case
> O_REGULAR can probably be supported similarly to NFS.
>
> fuse: probably ok? Does finish_no_open() in most cases. May depend on
> the userland driver though.
>
> gfs2: is ok, it just does finish_no_open() in most cases anyway
>
> vboxsf: does finish_no_open on non-creates, so you could probably just
> punt to that if O_REGULAR is set.
>

These are all inode_operations.atomic_open code paths, right? Because
you mentioned finish_no_open and I see finish_no_open in the
atomic_open code paths as opposed to file_operations.open code paths.

Regards,
Dorjoy

