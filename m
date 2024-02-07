Return-Path: <linux-fsdevel+bounces-10649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01984D0E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49970B26281
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D72127B41;
	Wed,  7 Feb 2024 18:04:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043E83A1C
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329062; cv=none; b=qea0VtIvb2iBvp5oqlTimemGV/bUpfN1n9if1t6bf6GbcMppAW7iwG2hjeA3m2HMVzOAyfzSQDqNOT5lgVvjjq5NmdH9fiGHD84yvJAT4rHfFAONw8mYe1G4sCQiIk53zMHDieoS2w2oz8VSiWBJF0gewKDkYDzJ6GuMvph+9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329062; c=relaxed/simple;
	bh=RapUaBGe1lYCwsplJVpK2NUlbFD7FrMX8LDA0xc8fIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di5JRBWV0ze2VqiaHGho8s+2AzWgNjp2PbKqu2CjW206ieaW/UF5XXk7ckmchFVCRoYDg3j8gC2sXt4/CpjWFb9JDKzf5JkCN4rukcUbUx6arzQ/D3H8hu90NSQ5tDmQL3fJ/uJ62JHiJtrKyU2OgjABMMW0nqqtLjsfRCHfALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29041136f73so693612a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 10:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329059; x=1707933859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RapUaBGe1lYCwsplJVpK2NUlbFD7FrMX8LDA0xc8fIs=;
        b=qnFIMjZfUK7QmyWC2Bg+s+YAeEY3YmEixCRCxSvUEx93VWzKaDl2PKRQR5HdDnAOdk
         1kk7nkA4WIg+9hm1EQ+oWcuGXjc5mKjzIvRScoqDmMz+CGmq5E77tSEHn/I3pn/yAAJy
         UQft3mQPI4TwsokXQwDOqwjaTzzy/TnYPKWpc3NzbS30aGuj77WC9Lw+S4VARUYeBkP8
         26J9d62HnUnn3fpRYbo6jVT7sB+E+g6lo+QPt7Zo6NArRqIFFtjR77SVUfcCURC+QlcD
         A2bmyzDkmTnutlp+ELy+IDZznQHdqRxhTIFKm0sEo+kXX/emg0fMS5VDnCVwtysH2POq
         EsKg==
X-Gm-Message-State: AOJu0YwlEi4BWOjRCY716mmZYzTiS+APvEBPib2HDP4remSfZeOvm1v5
	iZTMDS9MtjHBli+6OTN+lpio20zmdpY/VdafWfX6F8LkVKykQIsdb+jeZM9P
X-Google-Smtp-Source: AGHT+IHm7aEZkmDzqVKwUsR/MzPVlNZXcmQDG+ZynKHIgIaAHtqJcbX00iS0lrxpwCeD27tdnTu6lA==
X-Received: by 2002:a17:90a:600f:b0:290:4637:1808 with SMTP id y15-20020a17090a600f00b0029046371808mr3692861pji.26.1707329058878;
        Wed, 07 Feb 2024 10:04:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg6jQcuWjCxx46f4bqrK6MgJkYB1EmdCHPYLoyyIMKkjotZZVB7Qy1WJUzq37JHtQNgc2L+NfRLaJq3xchd4t7fDiunFOqSlj63Mdou0/qQ8VSaQQliOSNrmP3I8ryRyVUfyh1EPhaEDSGAiplJQaV6RUmzM4fwqxAENXZu16uaWRC9M7DJI3zPYTAlm0mD708D5xNdZ9y8XdMJVChrNUXXHjpkrqLcJ5xPrRQ
Received: from ?IPV6:2620:0:1000:8411:8633:8b18:c51e:4bae? ([2620:0:1000:8411:8633:8b18:c51e:4bae])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001d71df54cdasm1722197plg.274.2024.02.07.10.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:04:17 -0800 (PST)
Message-ID: <ac14af5d-181e-4b4c-ad6f-12ea7b7ae3ef@acm.org>
Date: Wed, 7 Feb 2024 10:04:14 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240206234718.1437772-1-bvanassche@acm.org>
 <20240207-geliebt-badeort-a81cde648cfc@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240207-geliebt-badeort-a81cde648cfc@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 00:56, Christian Brauner wrote:
> What's changed that voids Al's objections on that patch from 2018?
> Specifically
> https://lore.kernel.org/all/20180406021553.GS30522@ZenIV.linux.org.uk
> https://lore.kernel.org/all/20180520052720.GY30522@ZenIV.linux.org.uk

Thanks for having drawn my attention to Al's feedback. I had not yet
noticed his feedback but I plan to take a close look at it.

Thanks,

Bart.

