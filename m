Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFB7B6FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjJCR0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjJCR0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:26:33 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6DC9B;
        Tue,  3 Oct 2023 10:26:30 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-690d2e13074so931697b3a.1;
        Tue, 03 Oct 2023 10:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353989; x=1696958789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fknAfY11L/9gxT0vXVMMsVASZEDtw9GtR6xKe9bO34=;
        b=KMo1V8Xb9ZsyN2j6PjewdGonBwYhZo7sO+QBaHmVwDvekC+ZH/onNaKqoHzn2WHv8D
         mvbZsbF1seYHAx/CRbr6R1K2gk0+HjdhlJ9eu11iNCpYCXQHkZIF2YG4/zlhEDP9Rm0J
         brIiAt1B5CNxlSdFnz+QfS0OEPd5H/Q+ZL+PV8bz/H4KdSGQssJBjhs7Jg3hNH9rY4gP
         QcXlRtR5JlnJhxd5to93+DG6Bn3lj0aTEYR1bh0eJQbUKVudtJodjPvsDwj8iN5kV8U2
         8Qhf9UilsY1uWFT0yWBjyvjI7qZOmAns21IqbQj6b1Ru2Al8XoT7AZs3mV0Mtcy0dXRO
         YEQg==
X-Gm-Message-State: AOJu0YzL+Qi8mFBe+nMe3DgCYaAoNnTnMgyig5UEurEAu6mCrbgbSdKp
        Tn9QebOIhPLES72kYQukVqc=
X-Google-Smtp-Source: AGHT+IGD+SjIPu0gGWesMY0iCUc0T46m7xItZn2/xV0q1FD+vezjYwQVFt/fEmUjWQxR0w809mRU0w==
X-Received: by 2002:a05:6a20:9698:b0:15d:624c:6e43 with SMTP id hp24-20020a056a20969800b0015d624c6e43mr93646pzc.3.1696353989551;
        Tue, 03 Oct 2023 10:26:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id j18-20020aa783d2000000b0067b643b814csm1625249pfn.6.2023.10.03.10.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 10:26:28 -0700 (PDT)
Message-ID: <123f0c8c-46a3-4cb2-9078-ad71d6cf91ef@acm.org>
Date:   Tue, 3 Oct 2023 10:26:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
 <yq14jj8trfu.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq14jj8trfu.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 18:40, Martin K. Petersen wrote:
> 
> Niklas,
> 
>> I don't know which user facing API Martin's I/O hinting series is
>> intending to use.
> 
> I'm just using ioprio.

Hi Martin,

Do you plan to use existing bits from the ioprio bitmask or new bits? 
Bits 0-2 are used for the priority level. Bits 3-5 are used for CDL. 
Bits 13-15 are used for the I/O priority. The SCSI and NVMe standard 
define 64 different data lifetimes (six bits). So there are 16 - 3 - 3 - 
6 = 4 remaining bits.

Thanks,

Bart.
