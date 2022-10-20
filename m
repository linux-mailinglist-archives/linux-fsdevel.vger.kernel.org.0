Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA160609E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 14:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJTMxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJTMxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:53:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27617F2A8
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 05:53:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h185so19117593pgc.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1tSUOR0CGd4Km4WU9EABqtl9X4dWfnj8PpCfOdNXBc=;
        b=3Fin5tR+DxTOnCymWvNQXvC4DP5A9CvW/OpgGKccrmRGVFcE1OuUJQGkrqlo+ckrFh
         U+MGbaf9A8ztgk82880CFy4vbbjNXjhtqi5eSxxDu3XyziyuvWI7H9MeAMWY9hrAejxi
         5j3rfjrvbU7Jl3E5wgG3nrBCZsTDZVxaUgfEZrWPMEwVm19q7lbCXQAV/HzVjWBqk9GO
         L885iNCloh3qLdmRxDaEq+Ev5GUBKwzDFWxEGiVCxKxZsoqeQIyFeiWyyAZSrDkSNbV9
         FtkzOyVRIr86K6bOzCntYKwU4AnrmZYaZKMBUbcAFaKDCq/xXZjENs8qIFYfy1MYehUi
         L4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1tSUOR0CGd4Km4WU9EABqtl9X4dWfnj8PpCfOdNXBc=;
        b=O3FTv+G1Qix5E9zyol+3ljD95bKMBTKQL3Mu8qMhOFjX+RWY/Ycz8yAIu0jGdQzLXH
         oYfK7Grd0SXRKnRgaEaU1jezY72j8X3CCHfkE6OyTYupNDFgwH/DM/Rr7+uYxm+UNZwz
         yQCFxBqemjjGCp1aXcdJQNCiFbZN0xszWIwn7TnQdzcXUGZtxWAcZLOlG/26hbfBbhrM
         wciWwIdLvCrVewEYT+4uo6/ogwIKFcFP6+k2dwBGUaB1OHdKeZb3XK8uMLINJDlHQO9T
         nSAmC8K54UcsOC4d9NL9+wPcRHQOLTAVU3g/53feeyF3sUI0zGRGlhXf5IVXqFQNMUVe
         YzGA==
X-Gm-Message-State: ACrzQf2SEpwneo/7AJWoVxAu1S8purWZKjP7iL6Kvgf1tFyzmI4oH76n
        ZhzckdlF1UsS4ddtt/Cr3D/T8Uic7cqdEyPz
X-Google-Smtp-Source: AMsMyM7f5pr+Q4da5tL5VdWH16B7hstNTIj3sdj6G8HPE6MKotRnhdQnl2hrqR7v/as4WRggLhM+mw==
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id w18-20020a631612000000b004614180d88bmr11920615pgl.434.1666270389223;
        Thu, 20 Oct 2022 05:53:09 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 186-20020a6215c3000000b005626ef1a48bsm13162954pfv.197.2022.10.20.05.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:53:08 -0700 (PDT)
Message-ID: <80702edc-3e81-441b-efe7-a746c36f1d01@kernel.dk>
Date:   Thu, 20 Oct 2022 05:53:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC for-next v2 0/4] enable pcpu bio caching for IRQ I/O
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1666122465.git.asml.silence@gmail.com>
 <Y1EHjbhS1wuw3qcr@infradead.org>
 <dd22bf6a-8620-49c1-ec27-195e39cb4c33@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dd22bf6a-8620-49c1-ec27-195e39cb4c33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/20/22 5:40 AM, Pavel Begunkov wrote:
> On 10/20/22 09:32, Christoph Hellwig wrote:
>> On Tue, Oct 18, 2022 at 08:50:54PM +0100, Pavel Begunkov wrote:
>>> This series implements bio pcpu caching for normal / IRQ-driven I/O
>>> extending REQ_ALLOC_CACHE currently limited to iopoll. The allocation side
>>> still only works from non-irq context, which is the reason it's not enabled
>>> by default, but turning it on for other users (e.g. filesystems) is
>>> as a matter of passing a flag.
>>>
>>> t/io_uring with an Optane SSD setup showed +7% for batches of 32 requests
>>> and +4.3% for batches of 8.
>>
>> This looks much nicer to me than the previous attempt exposing the bio
>> internals to io_uring, thanks.
> 
> Yeah, I saw the one Jens posted before but I wanted this one to be more
> generic, i.e. applicable not only to io_uring. Thanks for taking a look.

It is indeed better like that, also because we can get rid of the alloc
cache flag long term and just have it be the way that bio allocations
work.

-- 
Jens Axboe


