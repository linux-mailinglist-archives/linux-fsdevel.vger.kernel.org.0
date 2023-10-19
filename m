Return-Path: <linux-fsdevel+bounces-735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715E7CF6B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02690282045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86F19475;
	Thu, 19 Oct 2023 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rr5penU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4819442
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:27:33 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8D115
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 04:27:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b390036045so1320251b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697714851; x=1698319651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLhirv0t6Gdj7rg3Zj76XjVTeaxSqmv9ustTaBTht3E=;
        b=Rr5penU/KlD0QQqW6FH7EQGwyUAHhPR8tO4eftmdJftyWdrTZ4OqTTq7CxYs2Zibup
         1IJd5LDRaPPZ4uuufuLVzAzWrbLguysuWj8M/V3Z1GPwLHoS83drCIudvJMrksPvEqBX
         dK2+k2MDUT80IcYIpFeEgCIDy/p1pbl8XLtVJkq7VGAxUWnDjEL2/l/O2zB8xNLchgOn
         4dALSOHWUtAsUH9mWHPmfdbryPPJnz4oKdxWacVRxuyvXK0Mi+bJN3GKhSXfEXB6z7LW
         Q+d/Ky27sVhT2WhVLJuFlHP/JvAi5iFoZQlS9ofxOSPbM0wd4L3dlgCjTtqTBVrTOXAe
         /LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714851; x=1698319651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLhirv0t6Gdj7rg3Zj76XjVTeaxSqmv9ustTaBTht3E=;
        b=OqHiLWo2BGCBOolak8HzSGUw/3/tLolZIJhKpFyTdbW5pC629Kzc/imCjFj//q3u1N
         RerDTveQrAVrrUBv/zVgDZ7QpwDVM3GnN/RWVOBASmjHcURydvYZ7Z0ggBHluxYdLbzH
         FMcOjtf/DEIp34M/afJV7KYlHx/6uHb61sl8Wj+9mvyxbkN7Js5Av6PtVkqdNqFCrAau
         73EgwQh0habi/uQF2nec4ubZ8pfbYH7VUSZbTtBAm1m6B84F78DLMV6IJJ8eH+TUNm8M
         kjLgAuGu/c2q+zxOqV+bbF3rWVZmL1U7ImOYDMOZ9Wd46wNFdZOIHOF27mgez3eHGumO
         j0Vg==
X-Gm-Message-State: AOJu0YyRFCWiDJ3gH+jbhrIWtbD9OoXxgE/TpF1mfbkyz0bxRKNCXuEe
	8Axex/wzO+dR+yj45CiiJgHrNg==
X-Google-Smtp-Source: AGHT+IHmj1OwSRNAW2Wg7BjQshnDU0lVMCjcabQ+fd7WSqpY9b2/q3in6H8np4ns+Vm1d9GhLTNpbA==
X-Received: by 2002:a05:6a00:2d1e:b0:692:ad93:e852 with SMTP id fa30-20020a056a002d1e00b00692ad93e852mr1692002pfb.2.1697714850705;
        Thu, 19 Oct 2023 04:27:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b00690fe1c928csm5238960pfb.147.2023.10.19.04.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:27:29 -0700 (PDT)
Message-ID: <d6957524-5364-4b05-a5a7-bad8dccd67f5@kernel.dk>
Date: Thu, 19 Oct 2023 05:27:28 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't take s_umount under open_mutex
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231019-gebangt-inhalieren-b0466ff3e1c2@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231019-gebangt-inhalieren-b0466ff3e1c2@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/23 3:35 AM, Christian Brauner wrote:
> On Tue, 17 Oct 2023 20:48:18 +0200, Christoph Hellwig wrote:
>> Christian has been pestering Jan and me a bit about finally fixing
>> all the pre-existing mostly theoretical cases of s_umount taken under
>> open_mutex.  This series, which is mostly from him with some help from
>> me should get us to that goal by replacing bdev_mark_dead calls that
>> can't ever reach a file system holder to call into with simple bdev
>> page invalidation.
>>
>> [...]
> 
> I've applied this so it ends up in -next now.
> @Jens, let me know if you have objections.

Looks fine to me, please add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

for the series.

-- 
Jens Axboe



