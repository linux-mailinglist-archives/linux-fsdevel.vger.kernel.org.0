Return-Path: <linux-fsdevel+bounces-1544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85A7DBD81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A746528147B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8318C23;
	Mon, 30 Oct 2023 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FE18C15
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:10:07 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CFC107;
	Mon, 30 Oct 2023 09:10:05 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-565334377d0so3624316a12.2;
        Mon, 30 Oct 2023 09:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682205; x=1699287005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpkKpncMF7S21legcE/MGbAj6ldQwiGQZNkAtlSsPNA=;
        b=DMv9d93rqapiGxTt856UH0bI8jWlfsqWQk44ADn6Dr+EYg/9g08oL7WKo3YF9yUbOh
         59PfSfZ8IogTxThfMGTP+OPMWoWa1lypnYBozEPfsW6oyKOsUy1Xym+J1JDxW3eOzQrh
         EfW1fvb3JxZnqfgkq5zs6Y0wRumbUchD5HixPIZfQjczUrLgikdnS6vlUbm2A4G73wKY
         WbEb372Z3k+3OQti1Kb8AbJ1uVeTCljJQsVhEpHvnS0Plcy8Wn1H0Vo/rejutYC+Gr7g
         z7RL9WlhEjrTMbfcWUAjK+53nRMT/534tG9hmKH74TMmQ0ck+8li9cwO0gtrqxwsVBFV
         +/DA==
X-Gm-Message-State: AOJu0YzQqy8LwSDa+2+6bhnQz8FwoTBAFPbKTychUb7h20JdkX79rdiQ
	l4zwihXSWyEzAnBpPASYMSI=
X-Google-Smtp-Source: AGHT+IFzpB4GKHPmFrqewL+GTf38pwW8k5daaR1FoMvl9JxQcyI5bmalJkU2VEzqFhxQp0WZk7BStg==
X-Received: by 2002:a05:6a20:8f18:b0:162:ee29:d3c0 with SMTP id b24-20020a056a208f1800b00162ee29d3c0mr14057683pzk.42.1698682204916;
        Mon, 30 Oct 2023 09:10:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e9c6:ed35:71cd:afbd? ([2620:15c:211:201:e9c6:ed35:71cd:afbd])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79571000000b0068bbe3073b6sm6016125pfq.181.2023.10.30.09.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 09:10:04 -0700 (PDT)
Message-ID: <9b0990ec-a3c9-48c0-b312-8c07c727e326@acm.org>
Date: Mon, 30 Oct 2023 09:10:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] fs: Move enum rw_hint into a new header file
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20231017204739.3409052-1-bvanassche@acm.org>
 <CGME20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3@epcas5p2.samsung.com>
 <20231017204739.3409052-2-bvanassche@acm.org>
 <b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/23 04:11, Kanchan Joshi wrote:
> On 10/18/2023 2:17 AM, Bart Van Assche wrote:
>> +/* Block storage write lifetime hint values. */
>> +enum rw_hint {
>> +	WRITE_LIFE_NOT_SET	= 0, /* RWH_WRITE_LIFE_NOT_SET */
>> +	WRITE_LIFE_NONE		= 1, /* RWH_WRITE_LIFE_NONE */
>> +	WRITE_LIFE_SHORT	= 2, /* RWH_WRITE_LIFE_SHORT */
>> +	WRITE_LIFE_MEDIUM	= 3, /* RWH_WRITE_LIFE_MEDIUM */
>> +	WRITE_LIFE_LONG		= 4, /* RWH_WRITE_LIFE_LONG */
>> +	WRITE_LIFE_EXTREME	= 5, /* RWH_WRITE_LIFE_EXTREME */
>> +} __packed;
>> +
>> +static_assert(sizeof(enum rw_hint) == 1);
> 
> Does it make sense to do away with these, and have temperature-neutral
> names instead e.g., WRITE_LIFE_1, WRITE_LIFE_2?
> 
> With the current choice:
> - If the count goes up (beyond 5 hints), infra can scale fine but these
> names do not. Imagine ULTRA_EXTREME after EXTREME.
> - Applications or in-kernel users can specify LONG hint with data that
> actually has a SHORT lifetime. Nothing really ensures that LONG is
> really LONG.
> 
> Temperature-neutral names seem more generic/scalable and do not present
> the unnecessary need to be accurate with relative temperatures.

Thanks for having taken a look at this patch series. Jens asked for data
that shows that this patch series improves performance. Is this
something Samsung can help with?

Thanks,

Bart.

