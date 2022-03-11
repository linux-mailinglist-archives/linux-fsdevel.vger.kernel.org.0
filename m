Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A04D66A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiCKQqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 11:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiCKQqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:46:07 -0500
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899081C1EF8;
        Fri, 11 Mar 2022 08:45:03 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 6so7931689pgg.0;
        Fri, 11 Mar 2022 08:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E5Rh7fNKmDbNOiCA65wqlhJIxWl5SUHmk0p+XbHj9Es=;
        b=uVblCE7AH+3gSeqJeRRFswQnwOlgdvgqvGBXQbcrraDIjc/5zJzykppVPXhgIlPn8K
         1btKEHtu+Jjjy9GcwnpEaAQrG6FwE2luIwvr5SP7w6uFmYNbU1DseCXb0h4EBayxAXHD
         sTxqBcPOQCERKxo3K74Y/ufFh7gZw3/5bTgPdA6wyu7ILk5GuH+J+UwIFn4w6nYmnoqC
         bUPTbaHRQk+zx3axmpLDbbJjBB19XBXnM/d/GLFtPvKswKNeukcl7GMvBvLUDGTEnI7S
         v98yB68gh6Azcx02zadxk6EAKFoo399L2WmpcbPvMTVLghs+3K63JBFKboRatvZYo0Vw
         jAWA==
X-Gm-Message-State: AOAM5300LvR6OdnfbwKbSKoI/zOFRhGR5bbGQpynmPeVMD1Ox/c+wu3B
        L4bzg+UysjOFHZ1mLyYxzrI=
X-Google-Smtp-Source: ABdhPJz4EFo8AESgB57XfMxnPtCXO4rpfMMukfL94/sEfG3NNBKJLhbov5D59jzFpme6r510OGixTg==
X-Received: by 2002:a05:6a00:887:b0:4f2:6d3f:5b53 with SMTP id q7-20020a056a00088700b004f26d3f5b53mr11093540pfj.21.1647017102717;
        Fri, 11 Mar 2022 08:45:02 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o7-20020a63f147000000b00373facf1083sm8820705pgk.57.2022.03.11.08.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 08:45:02 -0800 (PST)
Message-ID: <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
Date:   Fri, 11 Mar 2022 08:45:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
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
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
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

On 3/10/22 14:10, Jens Axboe wrote:
> On 3/10/22 2:52 PM, Bean Huo (beanhuo) wrote:
>> Yes, in upstream linux and upstream android, there is no such code.
>> But as we know, mobile customers have used bio->bi_write_hint in their
>> products for years. And the group ID is set according to
>> bio->bi_write_hint before passing the CDB to UFS.
>>
>>
>> 	lrbp = &hba->lrb[tag];
>>   
>>                WARN_ON(lrbp->cmd);
>>               + if(cmd->cmnd[0] == WRITE_10)
>>                +{
>>                  +             cmd->cmnd[6] = (0x1f& cmd->request->bio->bi_write_hint);
>>                +}
>>                lrbp->cmd = cmd;
>>                lrbp->sense_bufflen = UFS_SENSE_SIZE;
>>                lrbp->sense_buffer = cmd->sense_buffer;
>>
>> I don't know why they don't push these changes to the community, maybe
>> it's because changes across the file system and block layers are
>> unacceptable to the block layer and FS. but for sure we should now
>> warn them to push to the community as soon as possible.
> 
> If the code isn't upstream, it's a bit late to start thinking about
> that now. This feature has existed for 5 years at this point, and the
> only consumer was NVMe. The upstream kernel cares only about what is
> in-tree, as that is the only part we can modify and fix. We
> change/modify internal kernel APIs all the time, which is how tech debt
> is removed and the long term sanity of the project is maintained. This
> in turn means that out-of-tree code will break, that's just a natural
> side effect and something we can't do anything about.
> 
> If at some point there's a desire to actually try and upstream this
> support, then we'll be happy to review that patchset. Or you can
> continue to stay out-of-tree and just patch in what you need. If you're
> already modifying core code, then that shouldn't be a problem.

Hi Jens,

The "upstream first" policy applies to the Android kernel (see also 
https://arstechnica.com/gadgets/2021/09/android-to-take-an-upstream-first-development-model-for-the-linux-kernel/). 
If anyone requests inclusion in the Android kernel tree of a patch that 
is not upstream, that request is rejected unless a very strong reason 
can be provided why it should be included in the Android kernel only 
instead of being sent upstream. It is not clear to me why the patch Bean 
mentioned is not upstream nor in the upstream Android kernel tree.

 From a UFS vendor I received the feedback that the F2FS write hint 
information helps to reduce write amplification significantly. If the 
write hint information is retained in the upstream kernel I can help 
with making sure that the UFS patch mentioned above is integrated in the 
upstream Linux kernel.

Thanks,

Bart.


