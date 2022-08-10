Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E621958F221
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiHJSIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHJSIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:08:16 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296B3AE66;
        Wed, 10 Aug 2022 11:08:14 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id w14so14904835plp.9;
        Wed, 10 Aug 2022 11:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WAz9mh0IMcPdbiRN1XIuRByL3cLsDNo1Q7uXhFSH7jI=;
        b=kycvjobjoL11wFj3wtElhmyJWrZ2B+EF11vjqLiHL5X7z97Ea9AP5xztT3xskAO/7t
         SxDjw1iVR2ipVYRFF7idyGdkuj71jroXA/lOyvl86ggTjE0Ts6NMzbeQUQ8RzQPfB3WQ
         Ul1SJUuEjeIfRCPiHrKZIovmwOnSjdNUS0YCHqppzcditcufWvaNYeYcHQYe1QDJzlvd
         d7IOYYSnRPTSsDgyVH2QP9i9iV+sK7GC/JGvCBqDA9GAkRZeEhxu8AOsW/UJtXoSE0tL
         MRyxznMA5FOVKIEGm9706quYpHc3/1urwXKfrOVvUu6bI/Ltk3wl5TAPCjqmAaPi1mqp
         E7Lg==
X-Gm-Message-State: ACgBeo3sbVefQmjLYpxIggKadMdPkhRTFjqocctUBUFNbyu8N9JFOg8e
        xrsAVQUgDdGl7RDfw1io/gs=
X-Google-Smtp-Source: AA6agR5jM/nbSx9z0HeWh1HFzKrkMa4Kzfp81C3UpA7WpcMCn3mLxDqfU0xqc4p9uyEAeY5jej6aDA==
X-Received: by 2002:a17:903:11c7:b0:171:2818:4cd7 with SMTP id q7-20020a17090311c700b0017128184cd7mr7466175plh.136.1660154893409;
        Wed, 10 Aug 2022 11:08:13 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:85c9:163f:8564:e41f? ([2620:15c:211:201:85c9:163f:8564:e41f])
        by smtp.gmail.com with ESMTPSA id n28-20020a056a00213c00b0052b94e757ecsm2283678pfj.213.2022.08.10.11.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 11:08:12 -0700 (PDT)
Message-ID: <8aa0e7a4-265c-21f4-bdb4-57641d15b7b9@acm.org>
Date:   Wed, 10 Aug 2022 11:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
 <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
 <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
 <24b7e027-e098-269b-ccf7-b14deb499c33@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <24b7e027-e098-269b-ccf7-b14deb499c33@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/22 07:36, Damien Le Moal wrote:
> On 2022/08/08 8:37, Bart Van Assche wrote:
>> Thanks for having taken a look. Please help with verifying whether the
>> following patch is sufficient to fix the reported warning: "[PATCH]
>> tracing: Suppress sparse warnings triggered by is_signed_type()"
>> (https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).
> 
> With the current Linus tree, I do not see this sparse warning. However, applying
> the above patch, "make M=fs/zonefs C=1" generates a lot of warnings:

That doesn't make sense to me. My patch reduces the number of sparse 
warnings that are reported.

> make -j64 M=fs/zonefs C=1
>    CC [M]  fs/zonefs/super.o
>    CC [M]  fs/zonefs/sysfs.o
>    CHECK   fs/zonefs/sysfs.c
>    CHECK   fs/zonefs/super.c
> fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
> include/linux/kernel.h, arch/x86/include/asm/percpu.h,
> arch/x86/include/asm/preempt.h, include/linux/preempt.h,
> include/linux/spinlock.h, ...):
> ./arch/x86/include/asm/bitops.h:66:1: warning: unreplaced symbol 'return'

I think that you are hitting a bug in sparse. See also 
https://lore.kernel.org/all/e91d351c-3c16-e48d-7e9d-9f096c4acbc9@debian.org/T/. 
I also see the above warnings if I use the sparse binary from Debian 
testing. I do not see these sparse warnings if I download the sparse 
source code and compile that source code myself.

Bart.
