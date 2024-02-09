Return-Path: <linux-fsdevel+bounces-11028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC684FF4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8E52813E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4720DE8;
	Fri,  9 Feb 2024 21:57:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D862D294
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515846; cv=none; b=R0iuDaSN6rPtrGhG437XGxKULnq99BwxC2U4wOltFnXv84Sb9+bJTonDRuT+/HjO2E8/ynvFV6mwFLjLNwqRMfmOXF6M8Y4/KqsXbzjTNKcaoWcj4JFoYEhE6mAbUaHQGdLGcTao0bfFeG26EKrrSm+thmRqETPiwx/XVgNqKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515846; c=relaxed/simple;
	bh=c0mfDbADGEw9TbZGVrQJOrXbLsG3BFBcmUOmUynfdvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X65AdnsulpnxAI8kqjkZghGqOG6DF0vd/OLyItfJ2lMhU6o1NXe14MwJuYMBiHeIIitg0pYGU8b6XFGifI0jqYFZN7Zt54N6PZxFjAxrNoOjhMEE8qHE6INOdEiGxvTD2u4YwKQxlf87hQ4Jpaoe2d5QvNpcRD+kSPCVY34G/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d72f71f222so12650375ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 13:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707515844; x=1708120644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0mfDbADGEw9TbZGVrQJOrXbLsG3BFBcmUOmUynfdvs=;
        b=NotyswZlcRl+0YGWYE7wm+rflSDicP4vqSsT41uNmASflL610fQHxjawGMtubYN7xQ
         krCRykeeBlda2AxekK6nVBat5s1i8GHwmPOgmceCexbpckkrc5Buu9x9j9xhimwWU4nM
         UcMFXIHpib2upsNj6rlxjrozdf7t8AsxI67bS9vtM0mQs5BuCmNFjWKz/H/3R1q/woUD
         25uajCcijxbGube66AWYgfxTR7VKHA0yKYuvHT5UNYPTpluYAZ/km/Ew1BiHBUPc5BT1
         puo42rnu7vLA3xfOBoD9U7O91v9uOdNZWfdZaJumBDYOePKGrsEKEWyki4vwIlMZgprK
         IMpA==
X-Gm-Message-State: AOJu0YzmwR7Vk5sXhYCioETf7UHoFrCunQVydamWP8KBjG0zX4RGVWZq
	iEfW3I2gFxRTenzJHDjHkEhQnuk2YX6i+PQrTaQesybvXQTu2qcj
X-Google-Smtp-Source: AGHT+IHWWAFPB+A28ZKHS5O/A1ePPYyZFhQ6ddgiUGsMTIHeFtkmpCkT70lvY+e9ay/GIsjSOiedtQ==
X-Received: by 2002:a17:902:ce92:b0:1d9:542c:ebf9 with SMTP id f18-20020a170902ce9200b001d9542cebf9mr632733plg.45.1707515844348;
        Fri, 09 Feb 2024 13:57:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNG/f6rrAkIq1rnZlsLJ3QjGUigjwUyiCzdiu4iba/w/nqgUW3ls4BvRzmxdTM3Lc3JsWLDDymO2g/ukQSpVKCCcPGlM8Ot2k7OUQQK44OOggm9fVBq+qTiOW0oUzgEoN9cP0qUWHou234H2S5aV2fEto=
Received: from ?IPV6:2620:0:1000:8411:a246:a93a:6012:6a43? ([2620:0:1000:8411:a246:a93a:6012:6a43])
        by smtp.gmail.com with ESMTPSA id ko7-20020a17090307c700b001d94a3f3987sm1950121plb.184.2024.02.09.13.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:57:23 -0800 (PST)
Message-ID: <8e6759b1-15da-40b7-85a5-7c6ae91d51e5@acm.org>
Date: Fri, 9 Feb 2024 13:57:22 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/hfsplus: wrapper.c: fix kernel-doc warnings
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20231206024317.31020-1-rdunlap@infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231206024317.31020-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 18:43, Randy Dunlap wrote:
> - * @op: direction of I/O
> - * @op_flags: request op flags
> + * @opf: request op flags

(just noticed this patch)

The new comment is worse than the original comments. This would be a
better explanation of the 'opf' argument:

+ * @opf: I/O operation type and flags

Thanks,

Bart.

