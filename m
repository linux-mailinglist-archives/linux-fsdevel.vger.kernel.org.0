Return-Path: <linux-fsdevel+bounces-778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A57CFFED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D9AB21348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D52FE0B;
	Thu, 19 Oct 2023 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E94225B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:48:58 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A511F;
	Thu, 19 Oct 2023 09:48:57 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6b709048d8eso4790951b3a.2;
        Thu, 19 Oct 2023 09:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697734137; x=1698338937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OQ/V/nmMT5goORuYpAJZd1eIlhxBW5C6vgEyeLZR4c=;
        b=L1/DXn807zm/g/dH07Hcwzz33jtIlsDI+3q2cq3nbRozNeTaSQ4l1qItCkEftjke3Q
         re1zyPW6Ewd7vclBAWfYjE0GFYsftjJDxieQ348D8X3J2p+oCBUOcGuzkqAPa+Wbid+W
         PTN9Lw4cAT2mxeWCvGsSxgy2YwI9drPocws0WFbZoHIkN13twOGr3r9b6SVEb7orD8ol
         dKIv5FlCFukm2O1IcBNb5D6uVqao4N4kQ3kCIvauozmxPk7pHUuUb6l6h7FSZjXKlWkh
         h914PXkH7izqojQwP55R/Hsj8dRlWO6tgzzkDZJxkUmsQ6lNTMddBDE+RiejctoCr4bi
         P+kA==
X-Gm-Message-State: AOJu0YxGIM564eg8xsj75J57m9OlLO2vZojacMjNZn+cG6qDYY7fvkV3
	Oq52p7/gkPWSNcCl1yHNQiw=
X-Google-Smtp-Source: AGHT+IGSWSvk10pYjqYsDI8lv9W77YvQn0x4qX8bJ2rKwADb9C4yARLDafmx85viOsU9fxSPgWbHCg==
X-Received: by 2002:a05:6a21:71c7:b0:157:609f:6057 with SMTP id ay7-20020a056a2171c700b00157609f6057mr2435162pzc.27.1697734137082;
        Thu, 19 Oct 2023 09:48:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3306:3a7f:54e8:2149? ([2620:15c:211:201:3306:3a7f:54e8:2149])
        by smtp.gmail.com with ESMTPSA id f3-20020a6547c3000000b005b82611378bsm3196957pgs.52.2023.10.19.09.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:48:56 -0700 (PDT)
Message-ID: <7908138a-3ae5-4ff5-9bda-4f41e81f2ef1@acm.org>
Date: Thu, 19 Oct 2023 09:48:54 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] Pass data temperature information to SCSI disk
 devices
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <20231017204739.3409052-1-bvanassche@acm.org>
 <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
 <e8b49fac-77ce-4b61-ac4d-e4ace58d8319@acm.org>
 <e2e56cdf-0cfe-4c5b-991f-ea6a80452891@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e2e56cdf-0cfe-4c5b-991f-ea6a80452891@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/23 17:33, Damien Le Moal wrote:
> On 10/19/23 04:34, Bart Van Assche wrote:
 >> On 10/18/23 12:09, Jens Axboe wrote:
>>> I'm also really against growing struct bio just for this. Why is patch 2
>>> not just using the ioprio field at least?
>>
>> Hmm ... shouldn't the bits in the ioprio field in struct bio have the
>> same meaning as in the ioprio fields used in interfaces between user
>> space and the kernel? Damien Le Moal asked me not to use any of the
>> ioprio bits passing data lifetime information from user space to the kernel.
> 
> I said so in the context that if lifetime is a per-inode property, then ioprio
> is the wrong interface since the ioprio API is per process or per IO. There is a
> mismatch.
> 
> One version of your patch series used fnctl() to set the lifetime per inode,
> which is fine, and then used the BIO ioprio to pass the lifetime down to the
> device driver. That is in theory a nice trick, but that creates conflicts with
> the userspace ioprio API if the user uses that at the same time.
> 
> So may be we should change bio ioprio from int to u16 and use the freedup u16
> for lifetime. With that, things are cleanly separated without growing struct bio.

Hmm ... I think that bi_ioprio has been 16 bits wide since the 
introduction of that data structure member in 2016?

>> Is it clear that the size of struct bio has not been changed because the
>> new bi_lifetime member fills a hole in struct bio?
> 
> When the struct is randomized, holes move or disappear. Don't count on that...

We should aim to maximize performance for users who do not use data 
structure layout randomization.

Additionally, I doubt that anyone is using full structure layout 
randomization for SCSI devices. No SCSI driver has any 
__no_randomize_layout / __randomize_layout annotations although I'm sure 
there are plenty of data structures in SCSI drivers for which the layout 
matters.

Thanks,

Bart.



