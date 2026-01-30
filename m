Return-Path: <linux-fsdevel+bounces-75944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNvjGHO+fGlVOgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:21:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72302BB8A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B743006B38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4562D8391;
	Fri, 30 Jan 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="BcQIzavQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065601D5147
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782716; cv=pass; b=s6+sz9reyR1t5LW+XqY/E/tW9HVCfsfoskyLbzGVSqqzGCvAFB4vE2QqPoxN9FJmdEtEbMgy7fzs3TYX+TOidaeDdIbIIRK8FuQaQPU+lW1Mj9GgOMBCvG+N89hhCvUO9gJSZpdlX9y/q3P/p+0H/ehBjvU0YnPmxUiMUTcKemo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782716; c=relaxed/simple;
	bh=piKhJd/rUT7tltziQwjJcck2kSenoYfZ1dsZHGikGa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSPGnyA4/oib6A0UllcJp5MkQLrYBZgPxHBdxu1BbQg5/ePzC0f6ZDAxGITFWR3l7EBbBQ7AcHeJMFqHAL5YmRxN4oTlwn8epxS+mihTSEF9YwzhrQgPW3GJ+jjLElmxbNrvZhFyhE8N6p/cN+OWZUCWr6y15EQuZ50Fu2KJnTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=BcQIzavQ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6446d7a8eadso1885896d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 06:18:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769782714; cv=none;
        d=google.com; s=arc-20240605;
        b=NHQEOtTf5oiEQ0fv6/595iB68dXtY/zRCVhWzH3Fni4ngQi/M0lHk/B7B16+10wRqc
         I4bHP08BwUHV6pdgeF6CkcO9hy6divW3Sg4ZTtUuWNgOk8SHAWdnBjz4zsKgnN4hDX90
         OuaV2Nd1YqQxh9mSE6FI9gijE98wQE1uLMSv5ppNflqp+izqPvqVWuTf7qWPGrR22Wpy
         YNb/fx/okGerwOunVj2hJKxPEXDI6oTptbu94a2Pn06HOarrHJ2MQshbZUpRZ6xuGmGE
         tlkSKRiu9VxH6uIo0yrjh+EkbtFBO7w4sXCju/YVnA2eg59dDlvzpJqMlN0eWIr407wq
         se/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fVl/DuPjpWBTzeLaOSIU4kHMwzFTVV5s3STIHrfTBKU=;
        fh=LeM1ARw8+7USeRYFzugKwKdoH9/bk0howN2xKVHwg5o=;
        b=Kbf8k1lZVa/fb0U3K0K6UAVYbPZUZ4jxJTXI3hsaJQtykyGP33Mey7Xva579YfHR2H
         W7ISm+HGKRGuckeGyY/dGIngu7jf6MjDynOzHiETm5F87NmlIfkKp1+2Dchj66qmJ0Co
         6b8GitIPFWQKF/ghqnyuzZm/BXmZkQ1zXFHy5UzKNIBeJac8LCQ9gLVXMcFOwUChZLe9
         lqVMUKTTkdt6onaNKhiZrCB6tPHzLtvmrhX+5w0W+RmHJbuLIijk/LS1hPmQOXZbzDE6
         4EKvLbyUvamAHzFPTNC5r1w1m5LevmfHShtVcxESiXsovdmU97qSzxNDxBlmbU2zRGIV
         16vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1769782714; x=1770387514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVl/DuPjpWBTzeLaOSIU4kHMwzFTVV5s3STIHrfTBKU=;
        b=BcQIzavQ6aDSbCLcV3Uv/G4i6vc2wK/eSgaPl/ObuwSzEIFLDA3/ujvF4b1jLtITQF
         UazOyKnUUQUZ1UNL7OUbeBd6NJKmQ+Q+lR35ICjB0/fEBlfimfgjvVj5ub4wHrb7SOFA
         o39QY7cJe1IAhbwqA+stsfu7pN9ebBpzve3hv2BLyNVBRhxBVhaTG1E9ZX6lmcBCcnhH
         45kknougxsu0eanLBMdhvYjzUoTSkpDkVYJ8lRkQN5T8A4nUtURJ8AddhsPmjaGPNBXA
         yNuAWVLfBOWROkq0hsJSdwHN5ZBJ5mX7NXBNUazyDUnXk9tmwtxgiphL5se+7cuDPQrU
         ueVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769782714; x=1770387514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVl/DuPjpWBTzeLaOSIU4kHMwzFTVV5s3STIHrfTBKU=;
        b=PFOczYKYgwgKd9n7hg3PDhgmjonipWZucznZHmLgg+GurCtNq2ho1+zAVDdASO2AVp
         BD1/ktilhRLMM/3PI+B4XHTX6E7Rk8qwquonw3Bbdoyk4fCnctcrDCSZWgrgsLkMAkl5
         LFBMBFJP72qd/RtzZoUdphGnWIRgTRcp+4W5A8KsQ7DEMcZekLre004Sj9ZgSM8W0lmC
         2KgeCZewqupCK8Rm7xKROUT/yXpJdGFW0sB0+zqo318OQUtTb0PlE5AhI2s7pvEFwGXR
         5eEMWXHGO8oM8f3lqyVVOnxbKivLmr2zTyrAinTZ+Ga+xPCWuMXwiOulricE/F7K3k02
         fFGg==
X-Gm-Message-State: AOJu0YwvU3EbdbFrnyK0iDNd+WRmc4scct4UO0jWyhc3MFGYnfg50f5z
	A+7Cht7/1Eun9D/msKh19IpadqdysHZqHOYe1hlVK0r7bE2/4n3QBzU+iMbhEPFNNEC0TzjU6fQ
	QOgzWkyM/Q8AiDy3KzlQNEYz5Az/FGNaufQ/SltA6KA==
X-Gm-Gg: AZuq6aJ+Qc0KH6g9vunbfFpactnmU2rTpdBF6U2z7eue2XhSa5EzQ7aSIkPhx66Z1mw
	gY6JYhx2Vsq1zXUgmISbyqAUT88TTh31Q1EMoCMA9d1fjKLoCl+6L7CgdXDwMOX0GszoVUcfuAE
	mjo8UGsPYz3iQ7esSGdc7XCmZQtELHmTelV/e6pkO7RvI2lf3XgbfuAqoawHUUEwdcjf6tNNR9Q
	uYwwzwuRU0oRATtxKqDM7usGfov9et2ypq+rofrvknJt4pwL79QLnPD0hVCdDNZk4OAE1BMsJzE
	Bouv8FLV/9wQauKyEaSgOk7Hyblr0DvMJzocm+D+Dy9qu1xrKr2hOAX0eg==
X-Received: by 2002:a53:d017:0:b0:649:612e:3f38 with SMTP id
 956f58d0204a3-649a8525a37mr2096730d50.93.1769782713797; Fri, 30 Jan 2026
 06:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129173515.1649305-1-me@snai.pe> <20260129173515.1649305-2-me@snai.pe>
 <60f683fa-bd25-4656-ae53-fc247962bac7@wdc.com>
In-Reply-To: <60f683fa-bd25-4656-ae53-fc247962bac7@wdc.com>
From: Snaipe <me@snai.pe>
Date: Fri, 30 Jan 2026 15:17:56 +0100
X-Gm-Features: AZwV_Qjt4KKY3U0TehHyeXb0kQJInVupAcf9pqh5qn3uwMjTD9tSxhXopaIQL_Q
Message-ID: <CACyTCKj_=U-upyY+p_8ns9EpDp0utNJjN-ozCV8=m6tEoOPeoA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] fs,ns: allow copying of shm_mnt mount trees
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[snai.pe:s=snai.pe];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[snai.pe];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75944-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[snai.pe:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@snai.pe,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72302BB8A7
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:39=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 1/29/26 6:39 PM, Snaipe wrote:
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index d82910f33dc4..f51ad2013662 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -38,6 +38,9 @@
> >   #include "pnode.h"
> >   #include "internal.h"
> >
> > +/* For checking memfd bind-mounts via shm_mnt */
> > +#include "../mm/internal.h"
> > +
>
> Hi,
>
> I don't want to comment on the rest of the change as I don't know enough
> of the subject but this screams layering violation to me.

Yes -- which is why I was a bit uncomfortable to do this. I tried a
couple of other approaches before this which did not involve including
mm/internal.h and poking at shm_mnt, but they ended up not working.
The only reason I ended up settling on this is that there is precedent
in including mm/internal.h in other parts of the kernel (fs/exec.c
being one example). This may be a bad justification, but if there's a
better way to do what I'm trying to do here I'm gladly taking it.

--=20
Franklin "Snaipe" Mathieu
=F0=9F=9D=B0 https://snai.pe

