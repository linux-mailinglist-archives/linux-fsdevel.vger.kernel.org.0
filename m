Return-Path: <linux-fsdevel+bounces-77318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDwFBB6Gk2mb6AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 22:03:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC91479F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8110430297BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7927B4FB;
	Mon, 16 Feb 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCuwqOsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048238635D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771275796; cv=pass; b=oWX4XYDbfoXQvXW/PwKaUYsv6F1SP8UZxQ1vZKE/jrDE5MgxW7qbhLQxXfzlMjhG7C8EcHWJ7OD7sdTFtcLrCxQcv0BxzQa2bCggdJuRw1a3WetfpaD4FkgRGd3H1JAAQh/LiS1B3wS53W+hfy6MSZdgTJAsH6uI8ZlX/maiCeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771275796; c=relaxed/simple;
	bh=yJb2daOWsnYknC8FY5KUHYJ9EkLXP2y09l0uu22wH8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoIQexk1xDH5cRHgC5/PYUrng6A1IHSaxWinWT2QXyF0Z9lt5W+a5AkWL8IXnqxrhVylFIbpbT1eoPXuyKftfLviLjo/TAGUP31MwjDp3j1xQIingFd9wCkm18raqPRuqFSSaNF6KZG/4++ZzxUtSYetCCRUy0m5SzldoHg5sug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCuwqOsU; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so6068007a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 13:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771275793; cv=none;
        d=google.com; s=arc-20240605;
        b=YTJyI8BqcuSRETCNh6u9I3GDce+IQUhyhFSiN2m40kNEX3WlgWugQVE+EtfqASTqR9
         j8Yk+VT+DnhX1qTSSW/06qh9TXoGjRJX18yIqU/R4RjZ92kJ1gKbuKQVp4XqIxB+vEg3
         OjKlsToqmSwlVI7MUTgXe8LXZ36YVzYQuyJR93sBuaypSRu1XEIWrNcvr9ziIPgyXzsa
         V5BEUWRatcVabnrdW3XYvlMEug/8aqNFkRVh60Qkoy6AOX9/JSVjBQrDpoJ45zl5pwYX
         H/pFNZU5sKhCM73p5DyU/Tl3U1cUwl5WSAgtO4pwvylGKCCvYOBn7Cnzw2rxN5gvRpfp
         xtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TxIpgwQZVocfIRubKoNkP1ZJhXBb9/ixcNn4Ztz6uRo=;
        fh=Qj8eTm1JUlB/97sLUdb9p0CmSXSOhlYAdH2H9o7sCko=;
        b=jM9CCFv3k4LXWX/G8wbZAkwNp+DeRw+105iMGvtOEi6p65Mw5UvZr35prKJ+xMxUBB
         WSPNWee8rBaOV9xHSgyzD+RHe+sNuuZl7gLAwhmWzygdQkw77OyGJGIxhEhyRzxod3Nt
         vYkscaDotlkDyCb//Gk/2eO1saItIu68bXn4UnSB8vn6ZPL8sjGasIFHfzvg5n8G8JW3
         ImjZYv8MU+AFEEgVIk51oWLhX4n1j50AEbMdeduGR00473Pmn1Nolf3sm1m4I7o6qiA7
         3ytbJWQMQ5Yk0U5ECRkOyPbeyy+20rGWcqiGSAxSO6YT7Qt5CYzpb0OW7AO7rhB+a4hc
         tn0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771275793; x=1771880593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxIpgwQZVocfIRubKoNkP1ZJhXBb9/ixcNn4Ztz6uRo=;
        b=lCuwqOsUskfgW0ZGtRPxel/5vcQ1VOu9heFdh8fpyyxs0H15J71m2z4jeyFPsMr/J0
         ef8yuo0VAAQdpY+eUOp67h6RnwbVbIfmqSYnFlr0/eAOqZ01FGmE8Z/Z8sDazAIjMrOq
         6cGDkf9N/25nWmbQ7y3jlcPJEUSqCkm6fgeHutT7zO3Bsx49ZzhyLh95Z8kwwIaIqh9W
         vzVV7fSWLL7C9tBX9pn0nsIoFRKUpFTeYBowQxRRH12xNcghzQFLSQYqs04HSBqfigNX
         +dxqdPYDFxVn854VM12upBbcBcPQJIDGC3QiYjiM+0VCpga+pY/BIZQlq2pChM+hIe86
         csDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771275793; x=1771880593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxIpgwQZVocfIRubKoNkP1ZJhXBb9/ixcNn4Ztz6uRo=;
        b=A2vYW17xTAGmbbriynjLupYzhUAfH4He8J56Yv2DEyU83djtvsr4nwM58f1tW6xFU8
         X9gKzIhGk/hU4M4SOXvPwRiIgcx3T19sNLCqR53GCFOVcjwjlPmHKVfQyOaBvclDbis1
         B8FR2dymPBY2KOfkbKdCoFgWy1UF5DrTRPP4/mfFSaK4yxZwHj8pAguUWOWXiJ6NflPk
         I+/HRXVWnJb6GvjyNzqqPSZMGQ8VrShggDbTtYhLsHb+v3NdrVpR+qiBRB+tq3+FYYp8
         vS2Qp8YK0aAObQoU18NL9sPVMup2ijN6rDUuK0o8ANCuFWzxyoYlVbYJ1bkIX6g2ytdJ
         D0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVXNhBERuTToEgHnazEhSQNKP3H3rvAn5I2FfUiCINfB0+Ms0G75BuoRfzn4H368zJ/A6t2jQPiFuo6cieQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMDZYYMPxfujT9cwwz7nIlKfEGtXDezsgE4Bu8+jQdQL88BBO
	Sqxs/W0iKmVmS0DB8LOPeQ+o+YEhBXPrZe6efB5FlmTJUYrsiY9dJSIMjarQt8+bz05x8l10oWa
	DGXwBqvqVT42hxndSTg+BIWOwL0H+rbc=
X-Gm-Gg: AZuq6aJj+NiyNT4If9zGEv/EwXZEhGdRwe2wkB+Gn2zQ4Z1dAhZ3Y4pk6yor4mu/CRU
	/zmoEcWDfa7+4gLo4H6cLD9aP1SY8TuKWkDVL/m6r/uJPt9xcxulsgN+X1rkxPHXc9m1c0/I8gP
	p0nXJGe7wzXla1ZvcV/PjwqYHpI72Aa061QOaQ1kcMQnUX2taYSYXzx32EVIGXx35IZhE5Rz9+b
	OgGFDXnHAPp/ZqXCZu9WL08QY5Bx3+isAUVbG8hA0qNX8HtiGcFQVWT5pCdQvOoPNHhTF3g84Hi
	ls+kYEOxJdznUmRot5g=
X-Received: by 2002:aa7:c503:0:b0:658:ecd:3787 with SMTP id
 4fb4d7f45d1cf-65bc4258f9cmr3878184a12.6.1771275793066; Mon, 16 Feb 2026
 13:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215124511.14227-1-jaime.saguillo@gmail.com> <aZHscwK0j3068kFS@redhat.com>
In-Reply-To: <aZHscwK0j3068kFS@redhat.com>
From: Jaime <jaime.saguillo@gmail.com>
Date: Mon, 16 Feb 2026 21:03:00 +0000
X-Gm-Features: AaiRm52IQ6gpGF-MKkDwIHybqoRiyZmRRKgngJnEohKwmvgXvR5fOuFdbOZ-Crc
Message-ID: <CALGGytNS0exYxBL6=_h186pLnwXeb-CKqvKMXqeqWLoGWfN55A@mail.gmail.com>
Subject: Re: [PATCH] proc: array: drop stale FIXME about RCU in task_sig()
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77318-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaimesaguillo@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 61EC91479F9
X-Rspamd-Action: no action

Thanks, Oleg, for the review and Ack.

I=E2=80=99ll watch for the task_ucounts/RCU cleanup.

Thanks,
Jaime

On Sun, 15 Feb 2026 at 15:55, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 02/15, Jaime Saguillo Revilla wrote:
> > task_sig() already wraps the SigQ rlimit read in an explicit RCU
> > read-side critical section. Drop the stale FIXME comment and keep using
> > task_ucounts() for the ucounts access.
> >
> > No functional change.
> >
> > Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
> > ---
> >  fs/proc/array.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > index f447e734612a..90fb0c6b5f99 100644
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -280,7 +280,7 @@ static inline void task_sig(struct seq_file *m, str=
uct task_struct *p)
> >               blocked =3D p->blocked;
> >               collect_sigign_sigcatch(p, &ignored, &caught);
> >               num_threads =3D get_nr_threads(p);
> > -             rcu_read_lock();  /* FIXME: is this correct? */
> > +             rcu_read_lock();
> >               qsize =3D get_rlimit_value(task_ucounts(p), UCOUNT_RLIMIT=
_SIGPENDING);
>
> I think that task_ucounts/rcu interaction need cleanups, I'll try to do
> this next week(s)...
>
> But as for this change I agree: the code is correct and "FIXME' adds the
> unnecessary confusion.
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>

