Return-Path: <linux-fsdevel+bounces-77611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP6tKtEQlmkXZgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:19:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3615C158FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6916830089BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010AB347BB9;
	Wed, 18 Feb 2026 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfZG9vSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EC346FB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442380; cv=pass; b=ARRdJ/nIoyEfymL9DSnAQB+yBiltqrURHVuANG3+7O0QVQw8Wm3RJ+KgXwKmW+GfrDS3PM25EqCdl7uUPq/39nRM55GH8UySNuVZgE3IUFcjQP50KeBfgidX+LXMGenQPET32jmYLoovFqiPSpR7QvUeTcc7Nk61AUANWWIk334=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442380; c=relaxed/simple;
	bh=RrQI+QnEdBOizv6XYVJeHlL5RsOUVt2/edveLvsl3dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUNc2lZ/h221jebFkPgVuuH7FJSlZJZHfMQoxC7YRhKmKzFI9lyC7dlQVUEnCBnmz/PASdcDb/BvJzywCsVC7r2UlM3Y9hDO7vewEculMwlEVLKx7okPvyjUrtvwYJqnbFQQjrHiFruU2Z0vdoYZ3frtHcqnuMuVqXNHQU9MKYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfZG9vSS; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5fadd5d4319so92535137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:19:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771442377; cv=none;
        d=google.com; s=arc-20240605;
        b=S0jKc67/dT6Cq+gYyePUHePJqWYe2xbo14KJ8XFS2K8cvfEU+5mMkaj380gpYtnT1k
         njMWnRvxKsex2iJ1a6hdXoexIjeIyyZQw7V+k8Q2yUROJewka1WuvzEpjQSWcPLkXSFw
         V429FbkKaBmxAwQMEq+4zHgDgm3L8UHGwI46TdkocIy35NtTsnuCzNhaLIC+qkixgwF+
         mRDQyZnczP8PEiRq80qHqPBNrM6GUk9gYpPCnCizbzl2Jc+lf2G4f+um4zAHcSGlRPOD
         ISoSstzYsAjDNzYgH4eGztUKfS+RrTWLynJH0qV/gpKegSjapUylkQNPIFgAP3wwDjni
         zWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9z+DyJMyjesh0Rf/6Zl6Plb59sv5DMiVmf5X3Y4JO6o=;
        fh=09PWLUnOc33W2t8wE85FQmTZ+tIH7qGasCwdqXXEzJs=;
        b=JResXws5D8IRJ9tiZrLUFuz31m9l14VtaR0b/UDoc+XWYG3WCJsbleEVMgrikkYG++
         16eG8bQT5vr+0AWQqwXRziI5oMj9WTcQ1TlV5NYPLKs2CVPRELJmzbGcIlCKsKKZaneb
         KwBpk4Z4AgxgczIMyicOgi38BzGidR9ukY2+hCSMKAgIHmd1NM3SV68ptoSiUBarw8q2
         It289hhY7xsuckChkitbRE7zqo8GseZDumVuu+C7x3MoBoG0rT/lJu3ktAs1oIA3EUUb
         LWEVYGK9cwgOFrQyc012SFpoeTGxXKS2jmhP3ue9Ce2fHEKdhLmt+gyRoa9OIwgX7VU8
         0xUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771442377; x=1772047177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z+DyJMyjesh0Rf/6Zl6Plb59sv5DMiVmf5X3Y4JO6o=;
        b=YfZG9vSS7f3PRxcmR7O5nSnvIcZOh7sFiRm71Ko27N3QpSFNWfYQuS2zbDsH7MjBH2
         AR5aWEQNjwOt/PhtGO8fHb3hSUJtHiXeZ1DQj9byNgq86Ib91m5FsorO+PKx5axjxHLf
         AYpSI8nBLpuvVArg24ng6u2YLSaPEVh4fVi2jPPPcguPpL4AY1PJstS8i3d4Xq6ubifg
         MDOQIcX50jA2yje/rnI88sx8mm/HMFMuxzhgzajTI8g/VT+3l3rXGLq4SIGsgYC6L4M/
         Ah4/LRRxIkxxnu7AmqhljIM7D4OGmUvr/swwqsxueq42pLRjB4toU/Jz0eF30jAGSA71
         8SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771442377; x=1772047177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9z+DyJMyjesh0Rf/6Zl6Plb59sv5DMiVmf5X3Y4JO6o=;
        b=oWrzjl8idji786pbMvhQe/UQOZphKvRvPexwP5R/CD90LFSU1QEFE3I1qpE5wLoXli
         r6vA3qm2o8ZxxusEfxGzAv2U3zS9xuejvAhQd6HFoFQzzvbwu0GhZjczn0/rFlOtjhNJ
         6HjkU+p+u+rPpQm1jCRvI6EkF6HkLXkSBkrajsrnIvoIGijk0Am7zvU5TsCNHF5k84bH
         pXYSugN8vLNGJeNXr3QhXl/Ibu0pdR//0nMk7YGKH+Ay2eK4e6UxMD5S+sb/ug9lo5MI
         +Fs5dt+0QOQFzs3ekvw+20j4M9i2YzMPW2s5QCOxxWXdl7f/0Usr7q/fpJ7eY12kKtx1
         LyDA==
X-Forwarded-Encrypted: i=1; AJvYcCWcCH67yMD6jXpn60iGkY4gN7Sk+JPxrS1CUcKvvQ4OtK7fope5k0fZrfB7d+MUF+iU42lVy2vxXBmSwtaG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mTm2vX7qdUGHSIPd0nGZwDeDe9racdUmGKhkCxC9nhTkKUAX
	JRjOYdDUPoXOdJZeMQFaSL47f7H7C2rjw1voK0bCH8nmJGkqkVLd79NT5wxjbf7Kpa8sZwVjdQ/
	Ptdr0JxgyomIRZ4uCgvdZZn7G4qSE838=
X-Gm-Gg: AZuq6aK2OYyioO82XLojMrRBCXHQ8uwo/6G4hhmUsqlv5l3/oui3oFm9paLK0tekD+b
	C0XVHmAJT2kq6d7wlIjoEnrVTgjvXAVM9mRDTSu1+z5Vf+EAFwHVtHATNpFrIYC+Mqrfj8Rjg56
	N8yPP/7KyGtSip6KCzdIX9AigihHr3yiy/MxZcG65xiDJSyWg5h3vLQbQBz3lRUeDUGq3ZgyixX
	DR2qfGsb8oIwYMLouHIgkhuXY3hiDKLiCSt9sxZ25GO3G5GEJiDdw/NaoTq3JXGJI0AZv+f3YmM
	SXsuSx/hyYLl/0Queygse0wlDeGnwz3UXJPJKK+O7T7Y05TXnKHwfw==
X-Received: by 2002:a05:6102:390e:b0:5f7:307e:80d9 with SMTP id
 ada2fe7eead31-5fe7fd7c889mr1376183137.28.1771442376964; Wed, 18 Feb 2026
 11:19:36 -0800 (PST)
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
 <CAFfO_h5B72v+1aZWU9jNNWFPGcZhti0oVPCWMAPkPjpq2_1nVA@mail.gmail.com> <67ba3b2b52f7dd1f46e5aa75dd9ea0c75f178374.camel@kernel.org>
In-Reply-To: <67ba3b2b52f7dd1f46e5aa75dd9ea0c75f178374.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 19 Feb 2026 01:19:25 +0600
X-Gm-Features: AaiRm51at6q3GcoeAmBG5jiD104gv-_7OFZtzuaVlVO_z5TLTyoNdAHePVggSEc
Message-ID: <CAFfO_h7nnpXXg6Wv25-CX_Mrjh26_s+u8hi42O2y6wRLWknywg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77611-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,file_operations.open:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3615C158FEB
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 1:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2026-02-19 at 00:26 +0600, Dorjoy Chowdhury wrote:
> > On Thu, Jan 29, 2026 at 7:12=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Thu, 2026-01-29 at 13:33 +0100, Christian Brauner wrote:
> > > > On Wed, Jan 28, 2026 at 10:51:07AM -0500, Jeff Layton wrote:
> > > > > On Wed, 2026-01-28 at 21:36 +0600, Dorjoy Chowdhury wrote:
> > > > > > On Wed, Jan 28, 2026 at 5:52=E2=80=AFAM Jeff Layton <jlayton@ke=
rnel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 2026-01-27 at 23:58 +0600, Dorjoy Chowdhury wrote:
> > > > > > > > This flag indicates the path should be opened if it's a reg=
ular file.
> > > > > > > > This is useful to write secure programs that want to avoid =
being tricked
> > > > > > > > into opening device nodes with special semantics while thin=
king they
> > > > > > > > operate on regular files.
> > > > > > > >
> > > > > > > > A corresponding error code ENOTREG has been introduced. For=
 example, if
> > > > > > > > open is called on path /dev/null with O_REGULAR in the flag=
 param, it
> > > > > > > > will return -ENOTREG.
> > > > > > > >
> > > > > > > > When used in combination with O_CREAT, either the regular f=
ile is
> > > > > > > > created, or if the path already exists, it is opened if it'=
s a regular
> > > > > > > > file. Otherwise, -ENOTREG is returned.
> > > > > > > >
> > > > > > > > -EINVAL is returned when O_REGULAR is combined with O_DIREC=
TORY (not
> > > > > > > > part of O_TMPFILE) because it doesn't make sense to open a =
path that
> > > > > > > > is both a directory and a regular file.
> > > > > > > >
> > > > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > > > > ---
> > > > > > > >  arch/alpha/include/uapi/asm/errno.h        | 2 ++
> > > > > > > >  arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> > > > > > > >  arch/mips/include/uapi/asm/errno.h         | 2 ++
> > > > > > > >  arch/parisc/include/uapi/asm/errno.h       | 2 ++
> > > > > > > >  arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> > > > > > > >  arch/sparc/include/uapi/asm/errno.h        | 2 ++
> > > > > > > >  arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> > > > > > > >  fs/fcntl.c                                 | 2 +-
> > > > > > > >  fs/namei.c                                 | 6 ++++++
> > > > > > > >  fs/open.c                                  | 4 +++-
> > > > > > > >  include/linux/fcntl.h                      | 2 +-
> > > > > > > >  include/uapi/asm-generic/errno.h           | 2 ++
> > > > > > > >  include/uapi/asm-generic/fcntl.h           | 4 ++++
> > > > > > > >  tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> > > > > > > >  tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> > > > > > > >  tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> > > > > > > >  tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> > > > > > > >  tools/include/uapi/asm-generic/errno.h     | 2 ++
> > > > > > > >  18 files changed, 38 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alp=
ha/include/uapi/asm/errno.h
> > > > > > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > > > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > > > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > > > > > @@ -127,4 +127,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    139     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              140     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alp=
ha/include/uapi/asm/fcntl.h
> > > > > > > > index 50bdc8e8a271..4da5a64c23bd 100644
> > > > > > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > > > @@ -34,6 +34,7 @@
> > > > > > > >
> > > > > > > >  #define O_PATH               040000000
> > > > > > > >  #define __O_TMPFILE  0100000000
> > > > > > > > +#define O_REGULAR    0200000000
> > > > > > > >
> > > > > > > >  #define F_GETLK              7
> > > > > > > >  #define F_SETLK              8
> > > > > > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips=
/include/uapi/asm/errno.h
> > > > > > > > index c01ed91b1ef4..293c78777254 100644
> > > > > > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > > > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > > > > > @@ -126,6 +126,8 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    168     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              169     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > > > > >
> > > > > > > >
> > > > > > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/pa=
risc/include/uapi/asm/errno.h
> > > > > > > > index 8cbc07c1903e..442917484f99 100644
> > > > > > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > > > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > > > > > @@ -124,4 +124,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    257     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              258     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/pa=
risc/include/uapi/asm/fcntl.h
> > > > > > > > index 03dee816cb13..0cc3320fe326 100644
> > > > > > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > > > @@ -19,6 +19,7 @@
> > > > > > > >
> > > > > > > >  #define O_PATH               020000000
> > > > > > > >  #define __O_TMPFILE  040000000
> > > > > > > > +#define O_REGULAR    0100000000
> > > > > > > >
> > > > > > > >  #define F_GETLK64    8
> > > > > > > >  #define F_SETLK64    9
> > > > > > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/spa=
rc/include/uapi/asm/errno.h
> > > > > > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > > > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > > > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > > > > > @@ -117,4 +117,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    135     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              136     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/spa=
rc/include/uapi/asm/fcntl.h
> > > > > > > > index 67dae75e5274..a93d18d2c23e 100644
> > > > > > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > > > @@ -37,6 +37,7 @@
> > > > > > > >
> > > > > > > >  #define O_PATH               0x1000000
> > > > > > > >  #define __O_TMPFILE  0x2000000
> > > > > > > > +#define O_REGULAR    0x4000000
> > > > > > > >
> > > > > > > >  #define F_GETOWN     5       /*  for sockets. */
> > > > > > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > > > > index f93dbca08435..62ab4ad2b6f5 100644
> > > > > > > > --- a/fs/fcntl.c
> > > > > > > > +++ b/fs/fcntl.c
> > > > > > > > @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> > > > > > > >        * Exceptions: O_NONBLOCK is a two bit define on pari=
sc; O_NDELAY
> > > > > > > >        * is defined as O_NONBLOCK on some platforms and not=
 on others.
> > > > > > > >        */
> > > > > > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > > > >               HWEIGHT32(
> > > > > > > >                       (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_=
NDELAY)) |
> > > > > > > >                       __FMODE_EXEC));
> > > > > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > > > > index b28ecb699f32..f5504ae4b03c 100644
> > > > > > > > --- a/fs/namei.c
> > > > > > > > +++ b/fs/namei.c
> > > > > > > > @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata =
*nd,
> > > > > > > >               if (unlikely(error))
> > > > > > > >                       return error;
> > > > > > > >       }
> > > > > > > > +
> > > > > > > > +     if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.den=
try))
> > > > > > > > +             return -ENOTREG;
> > > > > > > > +
> > > > > > > >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(n=
d->path.dentry))
> > > > > > > >               return -ENOTDIR;
> > > > > > > >
> > > > > > > > @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata=
 *nd, unsigned flags, struct file *file)
> > > > > > > >       struct path path;
> > > > > > > >       int error =3D path_lookupat(nd, flags, &path);
> > > > > > > >       if (!error) {
> > > > > > > > +             if ((file->f_flags & O_REGULAR) && !d_is_reg(=
path.dentry))
> > > > > > > > +                     return -ENOTREG;
> > > > > > > >               audit_inode(nd->name, path.dentry, 0);
> > > > > > > >               error =3D vfs_open(&path, file);
> > > > > > > >               path_put(&path);
> > > > > > > > diff --git a/fs/open.c b/fs/open.c
> > > > > > > > index 74c4c1462b3e..82153e21907e 100644
> > > > > > > > --- a/fs/open.c
> > > > > > > > +++ b/fs/open.c
> > > > > > > > @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const s=
truct path *path, int flags,
> > > > > > > >  EXPORT_SYMBOL_GPL(kernel_file_open);
> > > > > > > >
> > > > > > > >  #define WILL_CREATE(flags)   (flags & (O_CREAT | __O_TMPFI=
LE))
> > > > > > > > -#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O=
_PATH | O_CLOEXEC)
> > > > > > > > +#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O=
_PATH | O_CLOEXEC | O_REGULAR)
> > > > > > > >
> > > > > > > >  inline struct open_how build_open_how(int flags, umode_t m=
ode)
> > > > > > > >  {
> > > > > > > > @@ -1250,6 +1250,8 @@ inline int build_open_flags(const str=
uct open_how *how, struct open_flags *op)
> > > > > > > >                       return -EINVAL;
> > > > > > > >               if (!(acc_mode & MAY_WRITE))
> > > > > > > >                       return -EINVAL;
> > > > > > > > +     } else if ((flags & O_DIRECTORY) && (flags & O_REGULA=
R)) {
> > > > > > > > +             return -EINVAL;
> > > > > > > >       }
> > > > > > > >       if (flags & O_PATH) {
> > > > > > > >               /* O_PATH only permits certain other flags to=
 be set. */
> > > > > > > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > > > > > > index a332e79b3207..4fd07b0e0a17 100644
> > > > > > > > --- a/include/linux/fcntl.h
> > > > > > > > +++ b/include/linux/fcntl.h
> > > > > > > > @@ -10,7 +10,7 @@
> > > > > > > >       (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_=
NOCTTY | O_TRUNC | \
> > > > > > > >        O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYN=
C | \
> > > > > > > >        FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NO=
FOLLOW | \
> > > > > > > > -      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > > > > > > +      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REG=
ULAR)
> > > > > > > >
> > > > > > > >  /* List of all valid flags for the how->resolve argument: =
*/
> > > > > > > >  #define VALID_RESOLVE_FLAGS \
> > > > > > > > diff --git a/include/uapi/asm-generic/errno.h b/include/uap=
i/asm-generic/errno.h
> > > > > > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > > > > > --- a/include/uapi/asm-generic/errno.h
> > > > > > > > +++ b/include/uapi/asm-generic/errno.h
> > > > > > > > @@ -122,4 +122,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    133     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              134     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uap=
i/asm-generic/fcntl.h
> > > > > > > > index 613475285643..3468b352a575 100644
> > > > > > > > --- a/include/uapi/asm-generic/fcntl.h
> > > > > > > > +++ b/include/uapi/asm-generic/fcntl.h
> > > > > > > > @@ -88,6 +88,10 @@
> > > > > > > >  #define __O_TMPFILE  020000000
> > > > > > > >  #endif
> > > > > > > >
> > > > > > > > +#ifndef O_REGULAR
> > > > > > > > +#define O_REGULAR    040000000
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >  /* a horrid kludge trying to make sure that this will fail=
 on old kernels */
> > > > > > > >  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> > > > > > > >
> > > > > > > > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/to=
ols/arch/alpha/include/uapi/asm/errno.h
> > > > > > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > > > > > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > > > > > > > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > > > > > > > @@ -127,4 +127,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    139     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              140     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/too=
ls/arch/mips/include/uapi/asm/errno.h
> > > > > > > > index c01ed91b1ef4..293c78777254 100644
> > > > > > > > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > > > > > > > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > > > > > > > @@ -126,6 +126,8 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    168     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              169     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > > > > >
> > > > > > > >
> > > > > > > > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/t=
ools/arch/parisc/include/uapi/asm/errno.h
> > > > > > > > index 8cbc07c1903e..442917484f99 100644
> > > > > > > > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > > > > > > > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > > > > > > > @@ -124,4 +124,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    257     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              258     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/to=
ols/arch/sparc/include/uapi/asm/errno.h
> > > > > > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > > > > > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > > > > > > > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > > > > > > > @@ -117,4 +117,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    135     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              136     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > > > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools=
/include/uapi/asm-generic/errno.h
> > > > > > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > > > > > --- a/tools/include/uapi/asm-generic/errno.h
> > > > > > > > +++ b/tools/include/uapi/asm-generic/errno.h
> > > > > > > > @@ -122,4 +122,6 @@
> > > > > > > >
> > > > > > > >  #define EHWPOISON    133     /* Memory page has hardware e=
rror */
> > > > > > > >
> > > > > > > > +#define ENOTREG              134     /* Not a regular file=
 */
> > > > > > > > +
> > > > > > > >  #endif
> > > > > > >
> > > > > > > One thing this patch is missing is handling for ->atomic_open=
(). I
> > > > > > > imagine most of the filesystems that provide that op can't su=
pport
> > > > > > > O_REGULAR properly (maybe cifs can? idk). What you probably w=
ant to do
> > > > > > > is add in some patches that make all of the atomic_open opera=
tions in
> > > > > > > the kernel return -EINVAL if O_REGULAR is set.
> > > > > > >
> > > > > > > Then, once the basic support is in, you or someone else can g=
o back and
> > > > > > > implement support for O_REGULAR where possible.
> > > > > >
> > > > > > Thank you for the feedback. I don't quite understand what I nee=
d to
> > > > > > fix. I thought open system calls always create regular files, s=
o
> > > > > > atomic_open probably always creates regular files? Can you plea=
se give
> > > > > > me some more details as to where I need to fix this and what th=
e
> > > > > > actual bug here is that is related to atomic_open?  I think I h=
ad done
> > > > > > some normal testing and when using O_CREAT | O_REGULAR, if the =
file
> > > > > > doesn't exist, the file gets created and the file that gets cre=
ated is
> > > > > > a regular file, so it probably makes sense? Or should the behav=
ior be
> > > > > > that if file doesn't exist, -EINVAL is returned and if file exi=
sts it
> > > > > > is opened if regular, otherwise -ENOTREG is returned?
> > > > > >
> > > > >
> > > > > atomic_open() is a combination lookup+open for when the dentry is=
n't
> > > > > present in the dcache. The normal open codepath that you're patch=
ing
> > > > > does not get called in this case when ->atomic_open is set for th=
e
> > > > > filesystem. It's mostly used by network filesystems that need to
> > > > > optimize away the lookup since it's wasted round trip, and is oft=
en
> > > > > racy anyway. Your patchset doesn't address those filesystems. The=
y will
> > > > > likely end up ignoring O_REGULAR in that case, which is not what =
you
> > > > > want.
> > > > >
> > > > > What I was suggesting is that, as an interim step, you find all o=
f the
> > > > > atomic_open operations in the kernel (there are maybe a dozen or =
so),
> > > > > and just make them return -EINVAL if someone sets O_DIRECTORY. La=
ter,
> > > > > you or someone else can then go back and do a proper implementati=
on of
> > > > > O_REGULAR handling on those filesystems, at least on the ones whe=
re
> > > > > it's possible. You will probably also need to similarly patch the
> > > > > open() routines for those filesystems too. Otherwise you'll get
> > > > > inconsistent behavior vs. when the dentry is in the cache.
> > > > >
> > > > > One note: I think NFS probably can support O_DIRECTORY, since its=
 OPEN
> > > > > call only works on files. We'll need to change how we handle erro=
rs
> > > > > from the server when it's set though.
> > > >
> > > > So I think you're proposing two separate things or there's a typo:
> > > >
> > > > (1) blocking O_DIRECTORY for ->atomic_open::
> > > > (2) blocking O_REGULAR for ->atomic_open::
> > > >
> > > > The (1) point implies that O_DIRECTORY currently doesn't work corre=
ctly
> > > > with atomic open for all filesystems.
> > > >
> > > > Ever since 43b450632676 ("open: return EINVAL for O_DIRECTORY |
> > > > O_CREAT") O_DIRECTORY with O_CREAT is blocked. It was accidently al=
lowed
> > > > and completely broken before that.
> > > >
> > > > For O_DIRECTORY without O_CREAT the kernel will pass that down thro=
ugh
> > > > ->atomic_open:: to the filesystem.
> > > >
> > > > The worry that I see is that a network filesystem via ->atomic_open=
::
> > > > somehow already called open on the server side on something that wa=
sn't
> > > > a directory. At that point the damage such as side-effects from dev=
ice
> > > > opening is already done.
> > > >
> > > >
> > >
> > > Exactly. I guess you could send an immediate close, but that's not
> > > without side effects.
> > >
> > > >
> > > > But I suspect that every filesystem implementing ->atomic_open:: ju=
st
> > > > does finish_no_open() and punts to the VFS for the actual open. And=
 the
> > > > VFS will catch it in do_open() for it actually opens the file. So t=
he
> > > > only real worry for O_DIRECTORY I see is that there's an fs that ha=
ndles
> > > > it wrong.
> > > >
> > > > For (2) it is problematic as there surely are filesystems with
> > > > ->atomic_open:: that do handle the ~O_CREAT case and return with
> > > > FMODE_OPENED. So that'll be problematic if the intention is to not
> > > > trigger an actual open on a non-regular file such as a
> > > > device/socket/fifo etc. before the VFS had a chance to validate wha=
t's
> > > > going on.
> > > >
> > > > So I'm not excited about having this 70% working and punting on
> > > > ->atomic_open:: waiting for someone to fix this. One option would b=
e to
> > > > bypass ->atomic_open:: for OPENAT2_REGULAR without O_CREAT and fall=
back
> > > > to racy and pricy lookup + open for now. How problematic would that=
 be?
> > > > If possible I'd prefer this a lot over merging something that works
> > > > half-way.
> > > >
> > > > I guess to make that really work you'd need some protocol extension=
?
> > >
> > > For NFS, I think we're OK. The OPEN call on NFSv4 only works for
> > > regular files, so it should be able to handle O_REGULAR. We just need
> > > to rejigger the error handling when it's set (just return an error
> > > instead of doing the open of a directory or whatever it is).
> > >
> >
> > Thank you for the details. Do you remember which codepath this is? Is
> > this the inode_operations.atomic_open codepath or file_operations.open
> > codepath? I am a bit confused also about where exactly the error
> > handling that needs to be done.
> >
>
> I was thinking nfs_atomic_open().
>
> Looking now, I think it might actually work OK without changes. It just
> might not be terribly efficient about it.
>
> If the open_context() call returns -EISDIR or similar, then you really
> don't need to do the call to nfs_lookup() and the like. You can just
> return an immediate error when O_REGULAR is set since you know it's not
> suitable to be opened.
>

Right. And I guess we don't need to worry about O_REGULAR being an
unknown flag when it gets sent to the server (not only for NFS / but
others as well)?

> > > The others (at a quick glance):
> > >
> > > cifs: I don't see a way to specify an O_REGULAR equivalent to the
> > > SMB2_CREATE call and it looks like it can create directories. Maybe
> > > SteveF (cc'ed) knows if this is possible?
> > >
> > > ceph: I think CEPH_MDS_OP_OPEN might only work for files, in which ca=
se
> > > O_REGULAR can probably be supported similarly to NFS.
> > >
> > > fuse: probably ok? Does finish_no_open() in most cases. May depend on
> > > the userland driver though.
> > >
> > > gfs2: is ok, it just does finish_no_open() in most cases anyway
> > >
> > > vboxsf: does finish_no_open on non-creates, so you could probably jus=
t
> > > punt to that if O_REGULAR is set.
> > >
> >
> > These are all inode_operations.atomic_open code paths, right? Because
> > you mentioned finish_no_open and I see finish_no_open in the
> > atomic_open code paths as opposed to file_operations.open code paths.
> >
>
> Note that this was just a cursory look. Someone will need to do a
> deeper dive and test these cases.
>
> I think most will end up working ok, since most fall back to doing a
> finish_no_open(). There may be opportunities to optimize some of these
> cases though (similarly to how I mentioned with NFS).

I can try to look into these and see if I can implement handling for
O_REGULAR flag for these filesystems in the atomic_open code paths.
Thanks for the details.

Will I need to modify the corresponding file_operations.open code
paths as well along with atomic_open code paths?

Regards,
Dorjoy

