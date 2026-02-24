Return-Path: <linux-fsdevel+bounces-78281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NFWLzfGnWkkSAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:39:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C81892BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A738D31BF8C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5827F4F5;
	Tue, 24 Feb 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EymRLdch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054927380A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947226; cv=pass; b=C3T0Lr50gYq2hqCxrSjr6TXfvzkk+nF4yZnnB4mxjQ6UZ0BT57W1Lau3LShJH02t5OB1bmsbLC1sjMGepF2gC++YqA7gHswYLjQcHbq0NpXiqIsUj8itypjBzTot4h1KMWMg6fxqopcIIOaW5ABsJ4ZZmD4jI1Pl9q1Oa9sxagw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947226; c=relaxed/simple;
	bh=mcIhrVy4N2qlGxdPCkr+8Ie+aeZgHuS6eyHLWbWlvk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnoTLLi1p9cdtCtvGBxQ4swLYpQG18WtaOWF+2uQH1IHmDZ/PjpEaKhszOgzX1qXsA6yeEIEGOidaaLggQvzChXCfNluitFB6/gHKb3R0ZLDtWjT4cV6GN2yPD6q0WQydWmOlISWVuq1+0IpHzZZmRIufsEO95D049w9u9/zKdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EymRLdch; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50336cffef9so44103291cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 07:33:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771947223; cv=none;
        d=google.com; s=arc-20240605;
        b=L0rWWuO3oQqv0pMzvsfY5yqXzdxtQphom8iBEeG2F9F4LWzMyPkA0vTwo+s1ZEVKx1
         grRo+/ukBUFcX4aHOZdL/OZQvJsSJr1avRVQZJbtsTC054vwSCDEHy74tRSbXm+j2sRk
         kE1p9KmGKleogtBR8RFsOHLbHA4hHY6JwNBTp0iXJ0Ekqi9qFBVhLItz2cVj2rqI7R5I
         FBOqS5nhu9FvUYo0INUbgvznt5k+0R8oKD6aU/5c4ZNGFpyTYyn0VdksPPUJ0FlNVU6G
         7mxK/Q0GNkwzqoWMDoaL/LJVoehpuk13WGwoLHa+u9iJH8brKJDzmisFYiH10ITRma9n
         sFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j8vK2PoxqyfTvn1s+umNDZZz0IG/77B9ZtXLXLB4Zjg=;
        fh=r5jrcNWk+QyCSpn/VlN4XChGHoOqBd1B5+Ha6qngoUE=;
        b=Df/8GUlN8JfcblNtObqrPxO+Q2FULKrf0T0rFEQoMj0xGyf9z7m9Sj/PHKmmCuXfBh
         ekG5SGPQA4+O1OCIX/S1CNUrDlnwut9D02XF1Gr7Bz5rW+ZrFSQzk4TVJeB40bji/3Ee
         Gp9RUKCSNkxXfCIwilTncfU94Om6h1aQ26hXPZgoBs8AYq1IdaxC/Kg7u/9juISEIDZg
         JzR06yIo2OCQp4jSykY7zdjrE1tS1yoJsjTvy6JpS7cZdp7f8swKlRmz+aPu6fevAizS
         Y0Z5VMQbQ1IQGWEb3Ei37uwAri4EujW3yGvG9Da2bg5y6mH9Ct/C4rcqrMowwFLXDBLQ
         ti8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771947223; x=1772552023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8vK2PoxqyfTvn1s+umNDZZz0IG/77B9ZtXLXLB4Zjg=;
        b=EymRLdchX5/QVSwlLsWI4fBShcIsj0moilkCndhKtm2Bo1VGLunwOgDkbkINMagVHB
         amEODb57eJnFlMCGxHFzpcjwnaXolgYBUI4iWhWcShot6i+awB2bAEAdCx1kcbAd+RJ3
         dYOUiWgw86oUcIYibWEnfpni4wZkywr2tBNpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771947223; x=1772552023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8vK2PoxqyfTvn1s+umNDZZz0IG/77B9ZtXLXLB4Zjg=;
        b=ekq5B4KYk8Iu44JhOvzLmDc6u671q18M2jinLoxsLmFiHJRAPQf2H+sG8RttQxeG4I
         PWNMkfEfbiCEanwfMloMhMdnYN1es8zcQbaRjzkW4dUtpOupKgpyajatM/S7TtCy+06k
         o4/HT0EL1r/rGOW0YhSwZopaD7Ob8+T/L/WkyT+fIYkwmV4yxHOUy1KOXN3JTsqgVWRl
         ZgWsObDgEDFecde8alO9x1Mt6ANiIPLa6khX1rmXdVzlcg9BNXg01Gw94WgxWtG1xM6M
         6iFuaTtU4vrIdQw3eVZeDuIQz6cwFC1s/XrYCUfVURuOD2rKxy9zHTH04GNrt4RKb3+/
         THKg==
X-Forwarded-Encrypted: i=1; AJvYcCVWOcMM7jtzfeuuk5Tp2o2hKqc76ECrW6VM5HagS5WPIDBp27rEV5YDOtCHCQlln0lIe/IkX/bZrJDojSWn@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCSEWMeZI9KmxqmN8gYWlYecVdrlPeTRrza5TkOnX8F9dutbs
	VYVg3vxtLZvGHOZOww4w8ZyUNrAJb1HbsWZvpLt9tg5nCikwooeg4Mc+3IqYa6kVElj9fVN5OOh
	3XcVXZb0I6GX9VMgoJftAybItD5e2VdEvLd/0+NiVEQ==
X-Gm-Gg: AZuq6aISOg0YfN1Th4JidzDjJe9Y1DA2FIkvnBzKd2fVE3j8Jbw0WZZh9sjfZ/h1fna
	Z+VmXgA9jolc5QvKbpbFALEvREB23dZgb2vnCzsotCkCpZCrlO7l9QbGRLO6TXhuZQe0dfOWtrJ
	Ej8o6NqHGxqrEo5NqFZqgMsoDSPbep9YmYyEx+ROuUEhKlm68v4KIqT1fLBHE62rYSLdWxSIK88
	p0rHqt2LQ302AULk7YZh4qbkMsEl3R+pWJmFsXoC2QHjjufOG16r24B1w31CSvioSC7gV+7UYxt
	+BmmPw==
X-Received: by 2002:a05:622a:1b8b:b0:4ff:c14d:65cc with SMTP id
 d75a77b69052e-5070bcb2d46mr155016191cf.51.1771947223251; Tue, 24 Feb 2026
 07:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220204102.21317-1-jiharris@nvidia.com> <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
 <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com> <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
 <aZyhkJSO7Ae7y1Pv@fedora.fritz.box>
In-Reply-To: <aZyhkJSO7Ae7y1Pv@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Feb 2026 16:33:32 +0100
X-Gm-Features: AaiRm53a5UNONpLiEimd4xU0OpNMNm9R7JWewPURY4JHQLrXCzVRugCMPz4D-pE
Message-ID: <CAJfpegvFhvbzTEjyPXP4jX26qPOVYCyvBmzrbkO3CWOmVCHhSw@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT
 is set
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Jim Harris <jim.harris@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mgurtovoy@nvidia.com, ksztyber@nvidia.com, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78281-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,szeredi.hu:dkim,birthelmer.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 127C81892BC
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 at 19:55, Horst Birthelmer <horst@birthelmer.de> wrote:

> What is wrong with a compound doing LOOKUP + MKNOD + OPEN?
> If the fuse server knows how to process that 'group' atomically
> in one big step it will do the right thing,
> if not, we will call those in series and sort out the data
> in kernel afterwards.
>
> If we preserve all flags and the real results we can do pretty
> much exactly the same thing that is done at the moment with just
> one call to user space.
>
> That was actually what I was experimenting with.
>
> The MKNOD in the middle is optional depending on the O_CREAT flag.

Okay, I won't stop you experimenting.

My thinking is that it's simpler as a separate op (dir handle and name
are the same for LOOKUP and MKNOD).   But adding this special "stop if
error or non-regular, else skip create if positive" dependency would
also work.

Thanks,
Miklos

