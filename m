Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC7393BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 05:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhE1DnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 23:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhE1DnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 23:43:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC09C061574;
        Thu, 27 May 2021 20:41:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u7so993592plq.4;
        Thu, 27 May 2021 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTczmZtH39vuAIYr9IZFW0LDYoxSDf0CdaOtPliLPq0=;
        b=fr9QruHAhI3a0NJXEp2SvgVrXR2VYTJES5QxpzXfoFidzdxxeYGSWM437MHYdyCJTh
         LDwon8zLL2y0JuUyLk/uvqElN4aSeyxmSG8s8a6lCSIt04/nvE4y0Ka75C2AN730WuwI
         dTTbwAuSnd/eEV3NQhhVxzA2H8TNwedJPAI4Vmj+EyL9xyoUk6i40kJS+zfbJzHE0wWq
         WNcP4MgwgLuglPnuafxkIBnKmmw2L7xCdaYMhAQpLX80wcwuOU3MwT+d705kiN2GMKAU
         X2yQdnfix2TBo/vSwKNhgWR3e4Jc0BEEWSYbqCaU9ddvcY0eJE9P73mNitJ53MT6QtBm
         oIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTczmZtH39vuAIYr9IZFW0LDYoxSDf0CdaOtPliLPq0=;
        b=KZ8Xhy83K4hBVST0LGTkq6GJgm/nSc+T7qKn81gp4vIPHtgsI3mKqWts8k2z8AUokl
         LlBG7La6imAUe1kdE4ukskBSTLtZNFUsYODZtJXhNtvJLUGImc9Ar4/+APHDIJdHkVSe
         nI0WNIoxqIY+jtz+7PrCHj18VLxyO91mhQJhzNB9QyZh+KNnMwPyu2zryjD0wKNNsas0
         cxQlGr5D6PF62ByQtFGZU/szgcLe7rrSsJc5gjL66AooRZJlJPZTsCU4xYNS98vB137X
         QySWN9pkum9Ami1O5Kh0Bgop1aSYtHUwr9FKTBD+BVo0y1WfhMFIcgHJesEIRIW6eGhz
         qp3A==
X-Gm-Message-State: AOAM530UcZ+tBA3ZF6JeRcLQ1T8/pafh2rrEsyvUklObyXeCg+ziF81N
        F3Wkye8JBwX0mgfKEjfJTF6l+3mg80OAHw==
X-Google-Smtp-Source: ABdhPJwPVEr+lYGKFUV+qPg7uKLRF/ECLoRvwVOAQnJa5pUqTBQJynkuNL3CQVFIFKHbHbL7hTyANg==
X-Received: by 2002:a17:902:b10a:b029:f9:a0d:14a5 with SMTP id q10-20020a170902b10ab02900f90a0d14a5mr6172012plr.44.1622173291172;
        Thu, 27 May 2021 20:41:31 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.48.252.66])
        by smtp.gmail.com with ESMTPSA id j2sm3115422pji.34.2021.05.27.20.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 20:41:30 -0700 (PDT)
Subject: Re: [PATCH V2 4/7] ext4: add new helper interface
 ext4_insert_free_data
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lishujin@kuaishou.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <83fab578-b170-c515-d514-1ed366f07e8a@gmail.com>
 <D928EE21-92AA-40D8-BEAF-33A46E7DFFD3@dilger.ca>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <b5e14639-7abf-ad9a-b7cd-8ce99e5828c1@gmail.com>
Date:   Fri, 28 May 2021 11:40:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <D928EE21-92AA-40D8-BEAF-33A46E7DFFD3@dilger.ca>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/5/28 4:09 AM, Andreas Dilger wrote:
> On May 26, 2021, at 2:43 AM, Wang Jianchao <jianchao.wan9@gmail.com> wrote:
>>
>> Split the codes that inserts and merges ext4_free_data structures
>> into a new interface ext4_insert_free_data. This is preparing for
>> following async background discard.
> 
> Thank you for your patch series.  I think this is an important area to
> improve, since the current "-o discard" option adds too much overhead
> to be really usable in practice.

Yes, indeed
The discard can help to free unusable spaces back to storage cluster.
But do discard after every commit can be disaster,
 - the jbd2 commit kthread can be blocked for long time sometimes, and
   then all of the metadata modify operations are blocked due to no log
   space
 - the flooding discard can saturate the storage backend and then the
   real write operations are blocked, especially the jbd2 log records

Even in the system with this patch, we can still observed the log write IO
can be blocked by the discard T_T...

> 
> One problem with tracking the fine-grained freed extents and then using
> them directly to submit TRIM requests is that the underlying device may
> ignore TRIM requests that are too small.  Submitting the TRIM right
> after each transaction commit does not allow much time for freed blocks
> to be aggregated (e.g. "rm -r" of a big directory tree), so it would be
> better to delay TRIM requests until more freed extents can be merged.
> Since most users only run fstrim once a day or every few days, it makes
> sense to allow time to merge freed space (tunable, maybe 5-15 minutes).
> 
> However, tracking the rbtree for each group may be quite a lot of overhead
> if this is kept in memory for minutes or hours, so minimizing the memory
> usage to track freed extents is also important.
> 
> We discussed on the ext4 developer call today whether it is necessary
> to track the fine-grained free extents in memory, or if it would be
> better to only track min/max freed blocks within each group?  Depending
> on the fragmentation of the free blocks in the group, it may be enough
> to just store a single bit in each group (as is done today), and only
> clear this when there are blocks freed in the group.
> 
> Either way, the improvement would be that the kernel is scheduling
> groups to be trimmed, and submitting TRIM requests at a much larger size,
> instead of depending on userspace to run fstrim.  This also allows the
> fstrim scheduler to decide when the device is less busy and submit more
> TRIM requests, and back off when the device is busy.

Schedule a background trim task in kernel when the storage is not so busy 
and pick up a block group that that has bigger enough free blocks.
This sounds fair. 

> 
> The other potential improvement is to track the TRIMMED state persistently
> in the block groups, so that unmount/remount doesn't result in every group
> being trimmed again.  It would be good to refresh and include patches from:
> 
> "ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim"
> https://patchwork.ozlabs.org/project/linux-ext4/list/?series=184981
> 
> and
> 
> e2fsprogs: add EXT2_FLAG_BG_WAS_TRIMMED to optimize fstrim
> https://patchwork.ozlabs.org/project/linux-ext4/list/?series=179639
> 
> along with this series.
> 

Yes， thanks a million

Best regard
Jianchao

>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

> 
> 
