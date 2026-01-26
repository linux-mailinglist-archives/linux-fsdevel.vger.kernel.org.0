Return-Path: <linux-fsdevel+bounces-75482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDEiOP2Wd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:31:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BB8AB2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A86C3007215
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C551339709;
	Mon, 26 Jan 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k15Bf4xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92228DB54
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445109; cv=pass; b=gXPtEnABtdxjkyl/2Qx1XglT7FtR0DyQFcoKENICeg2cKfdPjNtj0ga5+l4IoFcjomGFBSX8J4AxkW99dyW1isvWRi162czcqW/K/pKnVXnVw6ti/Cw00eUbvkxD7Q+tiDRyD8PV5yyPWBNVceHbrgu9/EzsRMkpzlbGIveoxII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445109; c=relaxed/simple;
	bh=p6BQxZozJdPyoOf50ZnelOl/FQ1XkIrvFMt2Eb6DJ0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiM1AfEAjbV7kEOi2vhxCosY6fP/pVwJc2sSFKST+nPDvOS8pJdBDMufFgXahRxNCuC2LL9lF1PQwLtZMNrqDdPk82my1EVhED+byug4evnKkFsytlBAhp6g4IuB2VzcFL2hL94CsizsKnQg8f8SVKGteO8PoddkkpbX9PNOk8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k15Bf4xw; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93f5b804d4aso1527069241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 08:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769445107; cv=none;
        d=google.com; s=arc-20240605;
        b=fKAjv6K8nNV8gogs/OzhPh1xdMgmaymo5M3LOJRZNBj/tWSu5nsjiHiVOJ3lcPj1Zd
         cBs9tixGUapHhTN+0d6d4ucplOpPb5U8NF3eaHcbmyVBiK+YFriApAlhpUxvSAP399zo
         h/UtrJyhZmNpSZMHCKJTIGqx8lYWK7CM8oggfO09YZvfGauavpq05MMtnyGUGhCkx8L7
         HIbgR/HANYr8v5wEUiUBiWauMj1FTw6c/rtQ2QzB1Xvj8ozQlAQjitN5Jc5b3CnjhffZ
         bBjsXiHvafn8ej1wWOrBqXw/FnW43mZ55qbI8H+/Ps9BRbXy1e7hb7NoGyr14bB2Yf0C
         3Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLEdG+m+UBILny12hs55bC7sHrgdEuCjEe/oVZx4K7s=;
        fh=TF7g1YF6yTOFIC5AWUBNR3HuSFfe/FR4zacRq4VNi8I=;
        b=DZhVN9nqVSeIBbWbx0XI6AeBpPJuLaEoHcKNRg2DqXobwxZGfRqQ4jfpStxX27AnHD
         HFSBvtvTYDjj2vPpwttEVJkhejNdxT3I9zkY4uiFnDTDNtnMePfhkMGw67VdxsviWitr
         l85MtT1jwKEduuSufwRkQtaCrTlb2aJ8s9LY8ZXApJ4JbK6eno0M4W519CMNmUHFIji3
         3HMl1XqUHXLCT7VrSEuoFGE4YPB5UyGD/LVZrawrShx4ARM1n+ExM2eR6Mnj/dX1tSJg
         hI5QEFvu+w993avwcopJiNH/U7zF6G1nqOnLVdZ+fluUkUJaaXCghXzZRA0GEsPyU2Vq
         NDmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769445107; x=1770049907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLEdG+m+UBILny12hs55bC7sHrgdEuCjEe/oVZx4K7s=;
        b=k15Bf4xwp7HBL7/+T0JMSl4ibyulDTWe4AksuEZSoC5cqDL9M5M46gQI9mBL1K+1qq
         Cg9DkLOQxeWY01wnxAixb40DRTlAbTvq8BokomwbaeSzxObCrSkcIgptKvrNZb+D+jOM
         /J0nfxH8YODt3/wZhNcC5z0y/8Ia1AJ8HE0mI1+o0Ak3UkeVWlyRda6nHMShL7oZ9rid
         WIzOi1GE1p/hYFpLmMJt7ioxL90JoHmXLSgcU1F7HiKGyWTIais0YGV20iWZhfiIzWwC
         qx5MiBMaykuusTL+U1CObK0uIecd+Exdl/DnYigFv7c/0LjBzkVI5yeY5vKy7WORGKLG
         iHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445107; x=1770049907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLEdG+m+UBILny12hs55bC7sHrgdEuCjEe/oVZx4K7s=;
        b=aYXqoPLCyksR0aQAmXCvNeUgiy5a/ovX82484KMa03tg7YjHsFWl4C/V7rjGFJkpJ/
         YorlKut+ncQKK7lIH13URlIm14w/D6k4HXiciJpTs4daQbOWh0cZZ94Ydcu3TsCQ8MQh
         DKCdSDnjyaSaJdISovaj+uxw5Vc2HxOvooRB2tREO9H9ZTxEaRaE3R2E7aCM1QB5ScoN
         zRgNpTNlrF0THe261VxXQtoqJC6Jgkw7DbN8VTo28/AibAcjlVG1Jc5XbpAZDidRf3Sq
         7AsJjO7N5YnGbW0znXpMXA8qo1mzLpFZTTnnXWIWcMmZfApRDzEdGuXzkq/tsGRVTImg
         fu2w==
X-Gm-Message-State: AOJu0YzgE/Atc8VO9ArPjiYN88IlDfKHlchCtVh9VhMls7pMeFncklKh
	Hc56WzatNAbmZ5ogvJGoYoPBzVQxFZthF37moeLt+tC0cKcHv+/vF8rR+3apgRTt795+3DQBDTW
	JNnufJcrrDHEoU8+VQUvDEQdEyTfVuygXsWcn
X-Gm-Gg: AZuq6aIjWd1bu1q7vKMm2JZdF0QTRO6Avw3bI+xNw4nr5URdPynK4AmfQTHaPoMv0i/
	Gz2dHNP/tqujWKB2dRPbwcHPrr6WgimOiZD8vPsjIKJ54oCKbcQzkUym+2qof4MU3A0XakrarO6
	x0sn7e/yBMhg5lk46Vxbc4IyuABHeyDhKZVpUIoQ9K9ypXWYSh3tuLCnOMSXwK2YQewcq0LFjm4
	gG/tyBC3fp0+f/hgL/CNOU5Mc8jdmhngwRz0JlR1HhoNniBtAHYOb4XwSLAahd4YeTp0N3y83dG
	olDz9Y3cb9b7NbharET6fqxr5MvmF8E=
X-Received: by 2002:a05:6102:390e:b0:5f1:4c53:3c21 with SMTP id
 ada2fe7eead31-5f5764b39admr1232363137.24.1769445107366; Mon, 26 Jan 2026
 08:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
 <20260126154156.55723-2-dorjoychy111@gmail.com> <7vfuydqp3hrlnld2mf6j5u4bmcecpaxz4pbkbrp2cnsk5lddsu@mvnaqal25dty>
In-Reply-To: <7vfuydqp3hrlnld2mf6j5u4bmcecpaxz4pbkbrp2cnsk5lddsu@mvnaqal25dty>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 26 Jan 2026 22:31:35 +0600
X-Gm-Features: AZwV_Qi7-EVaz0cX2dmb6DU2kC1JdiZA1e7wBkn1bRq9vbx7DRiN4oX1T9BaVA0
Message-ID: <CAFfO_h6Jv-86pcG-ZVayEnydY+MJZoXhkT0ORey8yd8NqVzyvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] open: new O_REGULAR flag support
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75482-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,oracle.com,gmail.com,arndb.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 162BB8AB2D
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:10=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 26-01-26 21:39:21, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > A relevant error code ENOTREGULAR(35) has been introduced. For example,
> > if open is called on path /dev/null with O_REGULAR in the flag param,
> > it will return -ENOTREGULAR.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -ENOTREGULAR is returned.
> >
> > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > part of O_TMPFILE) because it doesn't make sense to open a path that
> > is both a directory and a regular file.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
> The feature looks useful to me (but the justification with the danger of
> being tricked into opening some device nodes would be nice to have here i=
n
> the changelog).
>

Good suggestion. Will put something related to this in v3 submission.

> > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include=
/uapi/asm/fcntl.h
> > index 03dee816cb13..efd763335ff7 100644
> > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > @@ -19,6 +19,7 @@
> >
> >  #define O_PATH       020000000
> >  #define __O_TMPFILE  040000000
> > +#define O_REGULAR    060000000
>
> This looks wrong? O_REGULAR is overlapping with O_PATH and __O_TMPFILE???
>

Yes, this is wrong (pointed out by Arnd as well -
https://lore.kernel.org/linux-fsdevel/6c9d7f9b-36ea-4222-8c10-843f726b6e62@=
app.fastmail.com/).
Arnd also pointed out if we should use an earlier bit (e.g.,
000000100) or use a new one (e.g., 0100000000) which I asked about in
the thread. Please let us know in the thread if you have any
suggestions on this so that we can all be on the same page. Thanks!

Regards,
Dorjoy

