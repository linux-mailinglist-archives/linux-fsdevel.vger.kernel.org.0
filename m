Return-Path: <linux-fsdevel+bounces-75771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGriA4I5eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:29:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEDEA5B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F84630071D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39A3148A7;
	Wed, 28 Jan 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+qCPPtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09B313E23
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617784; cv=pass; b=W8iuGMwKfl8YtHjWy+fzZVQAW3kZ0VjE7FbSGRJvIVhFAimsXMBJD4mTxh5yJSTsnWRhhm0yFOcxHKs4tQvGp3+227/pL7ki/dQJoiSMQkNAlBzbhQN2OyNC75EtbpClC6TRRnfnCiHmze1vmQQudxYJmJrI+S35YnxJdZOLMJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617784; c=relaxed/simple;
	bh=KzK9NQyvf1wbEYFVxuwtRrAGYkCo7RujFJLuiEJeQtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE2+GK/4W38SO+KrBF/v5JscpNH1HCBE+RUvbEC2eFTbC08cml8RzkwuYxvORBjp3DdBOPk0zHBipZhO9VmAElKUtOzVTi4BVTCYvsCz5eMywlCQgwDVZVewIbWMBuAvAnmdRNNur93+YbVARPekPTNjLPbRgu4sA9RVPe2P/Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+qCPPtF; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-941063da73eso26522241.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:29:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769617781; cv=none;
        d=google.com; s=arc-20240605;
        b=NuOEYwQmo0C9+wzcpToOpTKEXIqYGo4+iVXb0LXvbzcbm0gYnFqAKODxFnajy9w+Jd
         kQlwnTRpDlEV1NP4c9HTMnL7zuXKpwMSiHsOhoCQ4Fgt5cdKLdFQ96iaTl8rsSgf1Miz
         zbnfbZTic/tbD1RU2lMTQDhgdj+asNSjzHyKmeJicLYC06T4OiGXP6OkhgSi74f+nc9Z
         DoqJQeoMZ034cS05iBPMpU9n83AtPyh7yxU+51b+GVZMjkiniYnZyTh2p/w05CAOT4Ji
         s2RliMzJbUqlDaspbf30qAI5iH0rRf+Qlm8FazSwadgI4EbeZtkrb1Qj8YFWJ6s+WpBn
         NhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hh3Cxuzu9CdC5N7BUB5MAWkk7Q62ZXyCJgJ2ZJAgwLU=;
        fh=jgsd5EeLgyKhfyWJbwXLAsr1YUB9aneFkr3EZlTIlHQ=;
        b=BPD/KEY8zdFh3axaHZGlwzBzbH2noo57wd24Uo7UanHNo2JMfBDd8gQ1eEfSDG33X7
         IvRO2yPQkL2TEt1cf8IY6BnxaqTOkHfM9rML1zlnjpRtgRQ1Tb2WkF7Sq1ze2X1YNG3g
         yi/gx+FYRmlaNiq7zxjNuTgQp3Lo5u9aQoqqXEXBafKk6wDBbR0hH4jF+UailwBiWIxO
         qG5Ygf9fdCn5/ZgikiwaDPmQdfKKCznd56AYurg4x8AeIh8ykudW5QpAyDjP8LOU/5DU
         Twlk/kb8A/G/ZGsSbLDSOCGF4wrnDWklx7Sw4bqjvewE72IHPha1Liclrz/x7Olgy1XD
         phkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769617781; x=1770222581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh3Cxuzu9CdC5N7BUB5MAWkk7Q62ZXyCJgJ2ZJAgwLU=;
        b=O+qCPPtFcZQsIONKpqoEx/XX9YJ3q1gr+9ZZBMKyudz7zrpK4PhbJEnSzMhOiWfI77
         Zla/G0TtnnTj+YHQh4egmOyw538Q+PO1pQ7JpFqIDvJSlH73b0cWl6f9K7b+rCLjY4dH
         gKzD4PU+k07DrTsfXQk7O9exanBDAMOb4SqBvwiKXQmWrFRmpJAsDHajGtqmhNiDBPYm
         dxZzJf8RRYm18MUGBCxabiHxkRiP083wS1VfOF4iSk54Ipa+1+mnNICFEPtfmb4I5tma
         VxRVsTfawFFL5rJII4i+Qo3P9yZH/FS4Q5wxImhxYI4+RbiRkdUtgOC54VIoYQ/3C4+l
         cwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617781; x=1770222581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hh3Cxuzu9CdC5N7BUB5MAWkk7Q62ZXyCJgJ2ZJAgwLU=;
        b=aP4bD4y0hE74yYaahQqO25V77nBWD3skq+T3ZLqV0R44MkEn/tQHGWG4woDgrgThBQ
         9VejiIJ0XfKClLrYQ6hWnun/mD28whfC0290KcJEwKgGPk8OiouO0Uz2hn9a6PIzmNki
         Din+7PaZgPbrukfzAQlyK9hK3Ozd59L7WV24GH6xw8jXrO/NRW5dxAoR2wUkApFQWLrp
         XCXYOlImzvHkfSo5Kq+1U/PSHFxoJ3KqtB/pe0JxJR+6OhAh3PcVfxhkbHllpF75/lAU
         zWs/hP60ArVnfP7hqsSsJZDZ+TGABV4x9OUecb4queRz1ZsryCOQPODrKerCNHgzyoXE
         2wCQ==
X-Gm-Message-State: AOJu0YxEaWnWycuFzYBZJV5tGocwI8YiqbwrE8Mu1tW8jKEUH37J0kBU
	nHBjItQT/i/kq4PP+FkNd/8MVJQjEKZwg3E8q0zZhraFbLbBg9efc7bv3JrNcVFQxV7PbRH7iEX
	9sqmCdm7unAmXt9w/3RtUOsJh4sJVxNg=
X-Gm-Gg: AZuq6aLbg8dBroqOJZzlOhkIN9LbLmNnJMsO+0JDQDV1scgdnDn2U45qZHWvT4Dbiiu
	Gme4PWG7qr6bM29zpuB+3c+t4Yj4q+YPGX3ihq05fUgVxG7NRhCnKbvFINIoJDpieoKF7kJkUD3
	+mziru+xtsW111xLRr1GqJ+QD14ggZ5/rheQLnrRhJKGz+IQyzDzSeEIvLKXX1UzfcHT9wLqRnm
	3xk0x3eJPNUlELZsVZrIZ4Xxf/NafXhiBSyhEs6XGRQBo5d5cMT+SFm+TP6iDU7QIaWS0gSzbq7
	t/NgRjgM3YQYo0LkYxI7GMFyy9WP6YY=
X-Received: by 2002:a05:6102:390c:b0:5f1:7aad:7c04 with SMTP id
 ada2fe7eead31-5f7237f183bmr2234478137.41.1769617780610; Wed, 28 Jan 2026
 08:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com> <1c6cccc3e058ef16fa8b296ef6126b76a12db136.camel@kernel.org>
 <CAFfO_h5yrXR0-igVayH0ent1t12rm=6DUEGjUDW0zqfqy3=ZoQ@mail.gmail.com> <b6749fa99a728189e745f1769140be3ac8950af5.camel@kernel.org>
In-Reply-To: <b6749fa99a728189e745f1769140be3ac8950af5.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 28 Jan 2026 22:29:29 +0600
X-Gm-Features: AZwV_Qi8tRZ2bk3FMtn2_dRf5eyGu0hMTXS_Va64e3c9cswyI3OIfP82dTSBaDg
Message-ID: <CAFfO_h78piy+DUGPMNnnVh734PBUPb-v_jVpJ_MWjDbnN9QqBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	TAGGED_FROM(0.00)[bounces-75771-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MSBL_EBL_FAIL(0.00)[dorjoychy111@gmail.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECEDEA5B72
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 9:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2026-01-28 at 21:36 +0600, Dorjoy Chowdhury wrote:
> > On Wed, Jan 28, 2026 at 5:52=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Tue, 2026-01-27 at 23:58 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being tr=
icked
> > > > into opening device nodes with special semantics while thinking the=
y
> > > > operate on regular files.
> > > >
> > > > A corresponding error code ENOTREG has been introduced. For example=
, if
> > > > open is called on path /dev/null with O_REGULAR in the flag param, =
it
> > > > will return -ENOTREG.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -ENOTREG is returned.
> > > >
> > > > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (no=
t
> > > > part of O_TMPFILE) because it doesn't make sense to open a path tha=
t
> > > > is both a directory and a regular file.
> > > >
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >  arch/alpha/include/uapi/asm/errno.h        | 2 ++
> > > >  arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> > > >  arch/mips/include/uapi/asm/errno.h         | 2 ++
> > > >  arch/parisc/include/uapi/asm/errno.h       | 2 ++
> > > >  arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> > > >  arch/sparc/include/uapi/asm/errno.h        | 2 ++
> > > >  arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> > > >  fs/fcntl.c                                 | 2 +-
> > > >  fs/namei.c                                 | 6 ++++++
> > > >  fs/open.c                                  | 4 +++-
> > > >  include/linux/fcntl.h                      | 2 +-
> > > >  include/uapi/asm-generic/errno.h           | 2 ++
> > > >  include/uapi/asm-generic/fcntl.h           | 4 ++++
> > > >  tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> > > >  tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> > > >  tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> > > >  tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> > > >  tools/include/uapi/asm-generic/errno.h     | 2 ++
> > > >  18 files changed, 38 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/inclu=
de/uapi/asm/errno.h
> > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > @@ -127,4 +127,6 @@
> > > >
> > > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              140     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/inclu=
de/uapi/asm/fcntl.h
> > > > index 50bdc8e8a271..4da5a64c23bd 100644
> > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > @@ -34,6 +34,7 @@
> > > >
> > > >  #define O_PATH               040000000
> > > >  #define __O_TMPFILE  0100000000
> > > > +#define O_REGULAR    0200000000
> > > >
> > > >  #define F_GETLK              7
> > > >  #define F_SETLK              8
> > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include=
/uapi/asm/errno.h
> > > > index c01ed91b1ef4..293c78777254 100644
> > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > @@ -126,6 +126,8 @@
> > > >
> > > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              169     /* Not a regular file */
> > > > +
> > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > >
> > > >
> > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/inc=
lude/uapi/asm/errno.h
> > > > index 8cbc07c1903e..442917484f99 100644
> > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > @@ -124,4 +124,6 @@
> > > >
> > > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              258     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/inc=
lude/uapi/asm/fcntl.h
> > > > index 03dee816cb13..0cc3320fe326 100644
> > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > @@ -19,6 +19,7 @@
> > > >
> > > >  #define O_PATH               020000000
> > > >  #define __O_TMPFILE  040000000
> > > > +#define O_REGULAR    0100000000
> > > >
> > > >  #define F_GETLK64    8
> > > >  #define F_SETLK64    9
> > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/inclu=
de/uapi/asm/errno.h
> > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > @@ -117,4 +117,6 @@
> > > >
> > > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              136     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/inclu=
de/uapi/asm/fcntl.h
> > > > index 67dae75e5274..a93d18d2c23e 100644
> > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > @@ -37,6 +37,7 @@
> > > >
> > > >  #define O_PATH               0x1000000
> > > >  #define __O_TMPFILE  0x2000000
> > > > +#define O_REGULAR    0x4000000
> > > >
> > > >  #define F_GETOWN     5       /*  for sockets. */
> > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index f93dbca08435..62ab4ad2b6f5 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_ND=
ELAY
> > > >        * is defined as O_NONBLOCK on some platforms and not on othe=
rs.
> > > >        */
> > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > >               HWEIGHT32(
> > > >                       (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY))=
 |
> > > >                       __FMODE_EXEC));
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index b28ecb699f32..f5504ae4b03c 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
> > > >               if (unlikely(error))
> > > >                       return error;
> > > >       }
> > > > +
> > > > +     if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
> > > > +             return -ENOTREG;
> > > > +
> > > >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.=
dentry))
> > > >               return -ENOTDIR;
> > > >
> > > > @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd, un=
signed flags, struct file *file)
> > > >       struct path path;
> > > >       int error =3D path_lookupat(nd, flags, &path);
> > > >       if (!error) {
> > > > +             if ((file->f_flags & O_REGULAR) && !d_is_reg(path.den=
try))
> > > > +                     return -ENOTREG;
> > > >               audit_inode(nd->name, path.dentry, 0);
> > > >               error =3D vfs_open(&path, file);
> > > >               path_put(&path);
> > > > diff --git a/fs/open.c b/fs/open.c
> > > > index 74c4c1462b3e..82153e21907e 100644
> > > > --- a/fs/open.c
> > > > +++ b/fs/open.c
> > > > @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struct pa=
th *path, int flags,
> > > >  EXPORT_SYMBOL_GPL(kernel_file_open);
> > > >
> > > >  #define WILL_CREATE(flags)   (flags & (O_CREAT | __O_TMPFILE))
> > > > -#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | =
O_CLOEXEC)
> > > > +#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | =
O_CLOEXEC | O_REGULAR)
> > > >
> > > >  inline struct open_how build_open_how(int flags, umode_t mode)
> > > >  {
> > > > @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct open=
_how *how, struct open_flags *op)
> > > >                       return -EINVAL;
> > > >               if (!(acc_mode & MAY_WRITE))
> > > >                       return -EINVAL;
> > > > +     } else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
> > > > +             return -EINVAL;
> > > >       }
> > > >       if (flags & O_PATH) {
> > > >               /* O_PATH only permits certain other flags to be set.=
 */
> > > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > > index a332e79b3207..4fd07b0e0a17 100644
> > > > --- a/include/linux/fcntl.h
> > > > +++ b/include/linux/fcntl.h
> > > > @@ -10,7 +10,7 @@
> > > >       (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY |=
 O_TRUNC | \
> > > >        O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
> > > >        FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW |=
 \
> > > > -      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > > +      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)
> > > >
> > > >  /* List of all valid flags for the how->resolve argument: */
> > > >  #define VALID_RESOLVE_FLAGS \
> > > > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-ge=
neric/errno.h
> > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > --- a/include/uapi/asm-generic/errno.h
> > > > +++ b/include/uapi/asm-generic/errno.h
> > > > @@ -122,4 +122,6 @@
> > > >
> > > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              134     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-ge=
neric/fcntl.h
> > > > index 613475285643..3468b352a575 100644
> > > > --- a/include/uapi/asm-generic/fcntl.h
> > > > +++ b/include/uapi/asm-generic/fcntl.h
> > > > @@ -88,6 +88,10 @@
> > > >  #define __O_TMPFILE  020000000
> > > >  #endif
> > > >
> > > > +#ifndef O_REGULAR
> > > > +#define O_REGULAR    040000000
> > > > +#endif
> > > > +
> > > >  /* a horrid kludge trying to make sure that this will fail on old =
kernels */
> > > >  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> > > >
> > > > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch=
/alpha/include/uapi/asm/errno.h
> > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > > > @@ -127,4 +127,6 @@
> > > >
> > > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              140     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/=
mips/include/uapi/asm/errno.h
> > > > index c01ed91b1ef4..293c78777254 100644
> > > > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > > > @@ -126,6 +126,8 @@
> > > >
> > > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              169     /* Not a regular file */
> > > > +
> > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > >
> > > >
> > > > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arc=
h/parisc/include/uapi/asm/errno.h
> > > > index 8cbc07c1903e..442917484f99 100644
> > > > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > > > @@ -124,4 +124,6 @@
> > > >
> > > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              258     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch=
/sparc/include/uapi/asm/errno.h
> > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > > > @@ -117,4 +117,6 @@
> > > >
> > > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              136     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include=
/uapi/asm-generic/errno.h
> > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > --- a/tools/include/uapi/asm-generic/errno.h
> > > > +++ b/tools/include/uapi/asm-generic/errno.h
> > > > @@ -122,4 +122,6 @@
> > > >
> > > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > > >
> > > > +#define ENOTREG              134     /* Not a regular file */
> > > > +
> > > >  #endif
> > >
> > > One thing this patch is missing is handling for ->atomic_open(). I
> > > imagine most of the filesystems that provide that op can't support
> > > O_REGULAR properly (maybe cifs can? idk). What you probably want to d=
o
> > > is add in some patches that make all of the atomic_open operations in
> > > the kernel return -EINVAL if O_REGULAR is set.
> > >
> > > Then, once the basic support is in, you or someone else can go back a=
nd
> > > implement support for O_REGULAR where possible.
> >
> > Thank you for the feedback. I don't quite understand what I need to
> > fix. I thought open system calls always create regular files, so
> > atomic_open probably always creates regular files? Can you please give
> > me some more details as to where I need to fix this and what the
> > actual bug here is that is related to atomic_open?  I think I had done
> > some normal testing and when using O_CREAT | O_REGULAR, if the file
> > doesn't exist, the file gets created and the file that gets created is
> > a regular file, so it probably makes sense? Or should the behavior be
> > that if file doesn't exist, -EINVAL is returned and if file exists it
> > is opened if regular, otherwise -ENOTREG is returned?
> >
>
> atomic_open() is a combination lookup+open for when the dentry isn't
> present in the dcache. The normal open codepath that you're patching
> does not get called in this case when ->atomic_open is set for the
> filesystem. It's mostly used by network filesystems that need to
> optimize away the lookup since it's wasted round trip, and is often
> racy anyway. Your patchset doesn't address those filesystems. They will
> likely end up ignoring O_REGULAR in that case, which is not what you
> want.
>
> What I was suggesting is that, as an interim step, you find all of the
> atomic_open operations in the kernel (there are maybe a dozen or so),
> and just make them return -EINVAL if someone sets O_DIRECTORY. Later,

Sorry, I am just trying to fully understand this. Do you mean to
return -EINVAL from all atomic_open implementations in the kernel if
both O_REGULAR and O_DIRECTORY are set (or just only if O_REGULAR is
set, we need to return -EINVAL)? I am already returning -EINVAL when
both these are set from the build_open_flags function, so that should
already handle the cases, right? I think after atomic_open get called,
all code paths eventually go through the do_open function where I have
this check "if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
return -ENOTREG". This is right before if ((nd->flags &
LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry)) return -ENOTDIR;
which I had initially followed. So should I just return -EINVAL from
the atomic_open functions too if both O_REGULAR and O_DIRECTORY are
set? Sorry if I am misunderstanding this.

Regards,
Dorjoy

