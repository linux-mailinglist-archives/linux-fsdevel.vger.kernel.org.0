Return-Path: <linux-fsdevel+bounces-95-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2DE7C59AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C98A1C20E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC628DA6;
	Wed, 11 Oct 2023 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DE1A59F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:56:21 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ACD98;
	Wed, 11 Oct 2023 09:56:19 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bf55a81eeaso270835ad.0;
        Wed, 11 Oct 2023 09:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043379; x=1697648179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/Cv7Nd9TpaBHaZP+kl37itMKz+kx+gxJ8bgWLYJbKw=;
        b=I8xYUf0Fx+0BKw/Nd/+VZ4kZNye2fO0atjLkP5AodzoUZaDSk/pes63aNOhCtqOuGs
         ZTO9QfGw9Waos+xoEBzAAS8LwhhMoVB5pZtB+6tztcReYFIRYNjeD6EhZANAi/Mj/vGO
         judvHsRh0j4ltj5HGsRtRaeDgB+6dfEUvqX84LCbHl8w4D2erri9JhQTgS0v6JPS1fSB
         YYXmfbIaTSpoksT8ngGWIkd8X5fIrPFKJYlz+Fxli8nKadHPRzW1KUVmjQJOnO+Oey4/
         8zd0wH4BxdHrF6it8twpkJ4hwNPjlQNDI19ruEApsON46F+MSsshU6mENippkcuyN9LK
         FUgg==
X-Gm-Message-State: AOJu0Yy2Q4+GvnVn4JgqUa3ksMzL2Jo6a9MnIkmsXYZ4Hhvbtfi+qeN3
	koyKeYbSHMr6xyBVkHakCjQ=
X-Google-Smtp-Source: AGHT+IGfkszq35vECGxayqgD7G6bdJGRz3vHBpurE3uPcz6M2u5ehswy8SX8d5eeW/m0lW5nKvthuA==
X-Received: by 2002:a17:902:ed93:b0:1c6:25b2:b720 with SMTP id e19-20020a170902ed9300b001c625b2b720mr17025371plj.44.1697043378230;
        Wed, 11 Oct 2023 09:56:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:19de:6b54:16fe:c022? ([2620:15c:211:201:19de:6b54:16fe:c022])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b001bf8779e051sm48696plb.289.2023.10.11.09.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 09:56:17 -0700 (PDT)
Message-ID: <75fbd722-1bd5-453a-8b39-c988654d3bab@acm.org>
Date: Wed, 11 Oct 2023 09:56:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] fs: Restore write hint support
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <CGME20231005194217epcas5p1538a3730290bbb38adca08f8c80f328e@epcas5p1.samsung.com>
 <20231005194129.1882245-5-bvanassche@acm.org>
 <d25ae351-5131-1b3e-4ae8-bacb674008de@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d25ae351-5131-1b3e-4ae8-bacb674008de@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 22:42, Kanchan Joshi wrote:
> On 10/6/2023 1:10 AM, Bart Van Assche wrote:
>> +static inline enum rw_hint bio_get_data_lifetime(struct bio *bio)
>> +{
>> +	/* +1 to map 0 onto WRITE_LIFE_NONE. */
>> +	return IOPRIO_PRIO_LIFETIME(bio->bi_ioprio) + 1;
>> +}
>> +
>> +static inline void bio_set_data_lifetime(struct bio *bio, enum rw_hint lifetime)
>> +{
>> +	/* -1 to map WRITE_LIFE_NONE onto 0. */
>> +	if (lifetime != 0)
>> +		lifetime--;
> 
> How the driver can figure when lifetime is not set, and when it is set
> to WRITE_LIFE_NONE? If it uses IOPRIO_PRIO_LIFETIME (as patch 8 does),
> it will see 0 in both cases.
> F2FS fs-based whint_mode seems to expect distinct streams for
> WRITE_LIFE_NOT_SET and WRITE_LIFE_NONE.

I will remove the -1 / +1 from the above code.

Thanks,

Bart.

