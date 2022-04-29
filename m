Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69F514107
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 05:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiD2Dmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiD2Dmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:42:52 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5CBC879;
        Thu, 28 Apr 2022 20:39:35 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id s14so6044238plk.8;
        Thu, 28 Apr 2022 20:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qUwunun/VVG6pwTOWhDwXkr9BbstGxHqbcx5TzpKkl0=;
        b=0kLl6Xc3IU3alOBNuzWMaJk0lmKyuIBgV+ZxRbEIw7TUal4PFFHNwG7nawdWDBjmzh
         eHFnIXfXEKB7C0wJJiHEdXFluZCsZmSew0QClY4Bn/QaRJEqBQ0/m6D23XQAu/W0scGW
         fyR3KQCIJVXYKd+nJHDiUNX/dxnzPRg2/RYMgcsB2++dMzioYYHjCi2f178HKpF4WP0T
         8ZdHHQ2aiPKYP2BEf39H10Gw2AszoHHuDgxjPDp/nV0A6NgAx2rABGPk0C7JoGjo9fE+
         X42buy0W9FOZVWBRhQkOFBRIf4teOJ7yYw/zSZqzHamxdx8wjoueilOlMfEMDnOl3IQa
         IgLQ==
X-Gm-Message-State: AOAM533K1aUtO1rjW8hccpzJm1kOcQReM0P/0TBc3qX/OLFjFF549B0h
        eW/UdqoE3rKi4hbMvxEjSLc=
X-Google-Smtp-Source: ABdhPJxtxVjuFEv0W1FHl8AvFyGb++7DZPYLFEeHuA6owahJDEYGMQWByu+vBRdjF/5hfBrS312ruw==
X-Received: by 2002:a17:902:7884:b0:158:b5b6:572c with SMTP id q4-20020a170902788400b00158b5b6572cmr37168381pll.144.1651203575217;
        Thu, 28 Apr 2022 20:39:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id z2-20020a655a42000000b003c14af505efsm4537074pgs.7.2022.04.28.20.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 20:39:33 -0700 (PDT)
Message-ID: <8f00ce03-ec87-b356-29a1-3b01d6c75efa@acm.org>
Date:   Thu, 28 Apr 2022 20:39:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
 <20220428074926.GG9558@test-zns>
 <a6d1c61a-14f2-36dc-5952-4d6897720c7a@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a6d1c61a-14f2-36dc-5952-4d6897720c7a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/22 14:37, Damien Le Moal wrote:
> On 4/28/22 16:49, Nitesh Shetty wrote:
>> On Thu, Apr 28, 2022 at 07:05:32AM +0900, Damien Le Moal wrote:
>>> On 4/27/22 21:49, Nitesh Shetty wrote:
>>>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>>>> The patch series covers the points discussed in November 2021 virtual call
>>>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>>>> We have covered the Initial agreed requirements in this patchset.
>>>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>>>> implementation.
>>>>>>
>>>>>> Overall series supports –
>>>>>>
>>>>>> 1. Driver
>>>>>> - NVMe Copy command (single NS), including support in nvme-target (for
>>>>>>      block and file backend)
>>>>>
>>>>> It would also be nice to have copy offload emulation in null_blk for testing.
>>>>>
>>>>
>>>> We can plan this in next phase of copy support, once this series settles down.
>>>
>>> So how can people test your series ? Not a lot of drives out there with
>>> copy support.
>>>
>>
>> Yeah not many drives at present, Qemu can be used to test NVMe copy.
> 
> Upstream QEMU ? What is the command line options ? An example would be
> nice. But I still think null_blk support would be easiest.

+1 for adding copy offloading support in null_blk. That enables running 
copy offloading tests without depending on Qemu.

Thanks,

Bart.
