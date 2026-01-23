Return-Path: <linux-fsdevel+bounces-75284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFW9IFV2c2kEwAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:23:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125776305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC6B6300B26C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63371302151;
	Fri, 23 Jan 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkoyQRiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644C2E5B09
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174601; cv=pass; b=k3ftAS9lqvB4ydyxVzyhoFCF/7Y4dGdek7oCkJBmYn+pNRWf6clUIkY6JDvq94IGT79cvRaCTbY7ONyPswc82bUBmXRUqtLSH1zAFLqAPJrXMYXHofzitjsbIZyYVKImml1XsXxjxx5CFJFHm0+l8DfotoCIaAy6tZAdodr7poE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174601; c=relaxed/simple;
	bh=2yMX4KMIacTi5G1FaT6jVtT+6BVY1UFvsXDRT1eQCDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=on5qKvMoUNnPAI0GDbLp+evoqA7pWjljZ4vfUvjbT5lM3V8rmMWMGbnN2xDke7HK6XgpFnOMlf48ak9H5F0iYoOzpQRc/RX+ltSmsLjIZGmP2r2W4Yxgl79ZuDa8dNWfBO1txtB2eJksbFYkGZ8Oo07njcFtCOy99ZxxNBNYrJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkoyQRiZ; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f573ba819so682697241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 05:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769174599; cv=none;
        d=google.com; s=arc-20240605;
        b=eDrgUGH5R046MPnRTBFnz4MQiFsYvpi8YpSQtGn9hDHGgSt1mlLh3Z7LbC3rW1jsM+
         9YDAjB79RqnUbhVH7CKK61QNyDOvqV/CKGUB6FDDNYLI6KBevJ9Gn9ycVOZ0WQLCeRJn
         sj2tt2li/wen61HOsh/HR2Z8qV8kUkCZVxvutLruF09KLemU4L2ldtpdpTXRcHjR3CUL
         Uav96DHjTNVVWbeOV1+eMoJzjB6q/Ie8gaTtlgUvJFgsvd7J79uoojucTVb0V4KIC87X
         2zSrGvcPT9YZMdCMh7WcJ0vcvVdkt0rs3vF8bjqIXKIYWU8n+x5uKdo1ujIqcPni9fML
         ZTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        fh=sewuEdI6NcwtfcBYM3nxBK0CE/YYoZRKD6qQeg3/qmc=;
        b=DnT5UgRkM+UmuqUg9TOya2BWX/OZ09xaAMIjRvUh5ZTmqkW1O9GLiu+p87n/g8nxmK
         9HIaVTmC151NQ4iCnM7ONuWyjrio/yf4jUZQRdITSob6XbZjFMKZEVrfKqLOzX0X3Vex
         +/mKiC/GsCVOAcqdq5RAzS1bD0RQStlkVOiQfE0oY8w66sgcdZ4MqNvbfinW3c/R9cSf
         HS7fkuxq0kAsJE0ndDb4cQh5OJCBxTnZQv0hp5VDDCiAehx+75AzK5iDOanGXvLZcmhC
         xDTE8p3/HqECrmnAkFb8uiY90cafUSAwKdRetUTeaJRjL+ukSoYetoxfFyKlxBgI6utQ
         g9FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769174599; x=1769779399; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        b=NkoyQRiZO9++ahzHH1OJ5cCT3E2o0WVv3qA2Qem70FoCG8ghW61cHe4bSRBatgsOm5
         A9UVv1hPLOdqS7Om0j7zlcMFFBFxVAx1uBlswhWJlXn3OASJqKNdFhdsiFhkTqg9kX7H
         xjegM32LrT1LO+E+NmFwksOsoU/PioZNNfbxLms6YJ73QwTqql0xy6uHu8v6t5HbKdX1
         i9yLP0dUZ+jNxtpqiNPKX3OTx+CZM48wY44I/D/1o6pVuDZ/7wY+Jlkug/UcX9Oi+mCW
         OqBmRXD2GC/fp3HrUbK+h4svEPIprnXIEdwdawESvoKrh/ycipkVN9urALaU/ZPu6A9e
         gyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769174599; x=1769779399;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        b=bynNS5Av9UAh6u7F2egTs2/1ftQJdjZn3QZIIX+rH4TeMOPGZEok1qM1ErYljCFzxx
         rQYdpR+t4ljQkPdWoepTstyWjvoAOwKjkx83M37T89cwB+6vkxC4IddymfthQ+eYBqA+
         0ITmFSHZmPoidlhnVaZF5Pz2KGslvRWd+p8dB4Gft8gwwQzkxnu9Cbnv7udzeCmom1vc
         Af9gZDhH1wicRcvGVV8lDTltZpn262b78hHNZqc0tK0lU+FbdVWdX6U2K2mJC+zLSgBh
         4xdZvqAN9ARpV24gRuKdf1+6YXsgJpXnWs1NKuklJS0lhf7vLSBVT8Sw7bbmt1qpyoTB
         jONg==
X-Gm-Message-State: AOJu0YyPnsWpL6rKQb5cDEfZaPUsu738lzf4uTgg4SK6xOeXnrehRtSA
	ccF/gfZidDSeVzsDobXt0+XITGtmBAb7ngJ0QG+I2lM9JUDmE5PNpiwpmfQpvAZYbnJUozyMh/V
	Q4nIGuNG2kBpef4dkUYqyQlxsA3dL61zDBw==
X-Gm-Gg: AZuq6aLDc4qN4Ltt7jaEgBqJviAPquA7KauceegvyWAyTP+suug4ptIJM1NTb4xS5DH
	wu8xhjqPBzkDKCCfJ9X0UHU0D1wqbYNUp3XkCfkzqIfkitnqsOiuOkk70mlmlcFdYjesN6irwte
	Mif2CG/KQQBtZMUmvUwj1cqSrflqvK+Wv7fdzPIt/d8Aom1yvUw7AlaTtSS9SLXQYq5Z/Sb0GuJ
	oKupH4a1jLgzxVmM0OB4dtjuFQR0t6echAh/KpyPcrboET067/mPFtvKfSDqyXYeHes6dk=
X-Received: by 2002:a05:6102:38cb:b0:5ef:7220:bca6 with SMTP id
 ada2fe7eead31-5f54bcbc2c0mr848495137.33.1769174599222; Fri, 23 Jan 2026
 05:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120142439.1821554-1-cel@kernel.org> <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
In-Reply-To: <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 23 Jan 2026 14:22:43 +0100
X-Gm-Features: AZwV_QjeaJNq0W-Cpcx_JErnCmrcMqvA53IgZ6NSy4KMyZ7YPDQ4CrxDdLy3saQ
Message-ID: <CALXu0Uc3gkrCmFApP1xswew9AmfotgZXR4uZXr_RetyEtC2pPA@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75284-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1125776305
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 13:12, Christian Brauner <brauner@kernel.org> wrote:
>
> > Series based on v6.19-rc5.
>
> We're starting to cut it close even with the announced -rc8.
> So my current preference would be to wait for the 7.1 merge window.

My preference would be to move forward with 6.19 as a target, as there
are requests to have this in some distros using 6.x LTS kernels (Bosch
for example).

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

