Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228A4D5448
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbiCJWLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 17:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbiCJWLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:11:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC4187B9F
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 14:10:40 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t14so5869561pgr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xsP1WXazU8yF9ogCr3BU1JiACfVvmKTu/fnyCfbOqUk=;
        b=cWzs+wFg2VnGcpieyJaxcWJ19NFXtMUM5FJwD1QRmRVPQpOn+hrfhmieyKgY5aYyKs
         8646n/XopKrT2QSjSnJ4O3ES6AxZEwG9cNQ1HtivZA+NXFfsY0talA6ne5uswoGVjLwa
         4rbQTyibXfPzNi/8zXBv7Cho7AGRZWRnOFy98TTkL07qnEKc7NMLFULAvvzP55gDVcjs
         tpamyOMx/Dwvv2Lf1Wd9aFWv4vWxsyCxiHJcQa0ksrX1UCPeSzxA/V0QLpOdTENIl++z
         Sg+r6scTtoxN8ZP0tmofRRCDkzHSPZ1UGinWToGgROeeNgUsfNHFccXVV/+BYWLiGNyP
         AOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xsP1WXazU8yF9ogCr3BU1JiACfVvmKTu/fnyCfbOqUk=;
        b=rJJmRnQVIjIdWn1+eZza0hWmlkTtEnpr63FrIAuEpqlRo5EwWmObopMM6MTm3YURcz
         eSYBCYaCt6+4sE3rLK/+JvUKU1Fcit0Ai+FItIoHGSVHnOfadO6hLVrWDiQN3Tr2KUgX
         COpaepGeJMysCuiu6xED9JmF/PXykb19l3sPkjFWgOx5enC86FBtQnmalYexpU2c+ukS
         ZBYR7cfZ/IlVYTAmdJdx35SaAPmj/JdPaJM7VwEL9+qwGcN4P+eQuxWIe/gElbl8rn73
         7dp3IEehVuUEQeZj8s2apEg6Wae7TKCMAuR1Sk5dgd2LA6Fz7VCdWdlbzuQwmKi49s/o
         WnxA==
X-Gm-Message-State: AOAM533618iyegfJUxEBOGwlww7P1A7W/JYNk2VNCiUHie9nNXwk0Xpq
        nNdx+KG04ikBqPRX5G1rmbfFBw==
X-Google-Smtp-Source: ABdhPJxbTLA0OsiplGUL6ou0rPxtgBzbqnjcq2fP5xl4uPaTzTuWqUWDxDpJoesTUoRFLCQFyTMfIA==
X-Received: by 2002:a05:6a00:16ce:b0:4ce:118f:8e4f with SMTP id l14-20020a056a0016ce00b004ce118f8e4fmr7263609pfc.56.1646950239505;
        Thu, 10 Mar 2022 14:10:39 -0800 (PST)
Received: from ?IPV6:2600:380:7676:ce7b:11ac:aee8:fe09:2807? ([2600:380:7676:ce7b:11ac:aee8:fe09:2807])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090ab00e00b001bf2d30ee9dsm10581380pjq.3.2022.03.10.14.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:10:39 -0800 (PST)
Message-ID: <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
Date:   Thu, 10 Mar 2022 15:10:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/22 2:52 PM, Bean Huo (beanhuo) wrote:
> Micron Confidential
> 
>>>>
>>>>>
>>>>> You do both realize that this is just the file specific hint? Inode
>>>>> based hints will still work fine for UFS.
>>>>>
>>>>> --
>>>>> Jens Axboe
>>>>
>>>> Jens,
>>>>
>>>> Thanks for this reply.
>>>>
>>>> This whole patch series removes support for per-bio write_hint.
>>>> Without bio write_hint, F2FS won't be able to cascade Hot/Warm/Cold
>>>> information to SCSI / UFS driver.
>>>>
>>>> This is my current understanding. I might be wrong but I don't think
>>>> we Are concerned with inode hint (as well as file hints).
>>>
>>> But ufs/scsi doesn't use it in mainline, as far as I can tell. So how
>>> does that work?
>>
>> Hi Luca,
>>
>> I'm not aware of any Android branch on which the UFS driver or the SCSI core
>> uses bi_write_hint or the struct request write_hint member. Did I perhaps
>> overlook something?
>>
>> Thanks,
>>
> 
> 
> Bart,
> 
> Yes, in upstream linux and upstream android, there is no such code.
> But as we know, mobile customers have used bio->bi_write_hint in their
> products for years. And the group ID is set according to
> bio->bi_write_hint before passing the CDB to UFS.
> 
> 
> 	lrbp = &hba->lrb[tag];
>  
>               WARN_ON(lrbp->cmd);
>              + if(cmd->cmnd[0] == WRITE_10)
>               +{
>                 +             cmd->cmnd[6] = (0x1f& cmd->request->bio->bi_write_hint);
>               +}             
>               lrbp->cmd = cmd;
>               lrbp->sense_bufflen = UFS_SENSE_SIZE;
>               lrbp->sense_buffer = cmd->sense_buffer;
> 
> I don't know why they don't push these changes to the community, maybe
> it's because changes across the file system and block layers are
> unacceptable to the block layer and FS. but for sure we should now
> warn them to push to the community as soon as possible. 

If the code isn't upstream, it's a bit late to start thinking about
that now. This feature has existed for 5 years at this point, and the
only consumer was NVMe. The upstream kernel cares only about what is
in-tree, as that is the only part we can modify and fix. We
change/modify internal kernel APIs all the time, which is how tech debt
is removed and the long term sanity of the project is maintained. This
in turn means that out-of-tree code will break, that's just a natural
side effect and something we can't do anything about.

If at some point there's a desire to actually try and upstream this
support, then we'll be happy to review that patchset. Or you can
continue to stay out-of-tree and just patch in what you need. If you're
already modifying core code, then that shouldn't be a problem.

-- 
Jens Axboe

