Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5722A3BA83A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGCKY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 06:24:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38586 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhGCKY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 06:24:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625307743; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=UesrN2+v7aKqvcUg70DeSyfvBOp+xLNDroyqYVLCYC8=; b=rCpGokWO0wu8p/anrrawCz7AbNCNhTisUclbSlskgSKQ37kXX33UuSdQ1BZltw0nH6xWx7xb
 bGnZ81zzz/HacCQu4y0Bl8MSMlyPB+sDDp/lm+PsrcsmnADWfLDvWb20EPo1EqqeJToidZs1
 sj/ILtifoGGwZ24f7bX0A0p2nSg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60e03a5e5e3e57240b1f8696 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 03 Jul 2021 10:22:22
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0137AC4323A; Sat,  3 Jul 2021 10:22:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.159.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A04B9C433D3;
        Sat,  3 Jul 2021 10:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A04B9C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V4,0/3] mm: compaction: proactive compaction trigger by
 user
To:     akpm@linux-foundation.org, vbabka@suse.cz, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, rientjes@google.com, mchehab+huawei@kernel.org,
        lokeshgidra@google.com, andrew.a.klychkov@gmail.com,
        xi.fengfei@h3c.com, nigupta@nvidia.com,
        dave.hansen@linux.intel.com, famzheng@amazon.com,
        mateusznosek0@gmail.com, oleksandr@redhat.com, sh_def@163.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <c0150787-5f85-29ac-9666-05fabedabb1e@codeaurora.org>
Date:   Sat, 3 Jul 2021 15:52:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1624028025.git.charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A gentle ping to have your valuable comments.

Thanks,
Charan

On 6/18/2021 8:48 PM, Charan Teja Reddy wrote:
> These patches support triggering of proactive compaction by user on write
> to the /proc/sys/vm/compaction_proactiveness.
> 
> Changes in V4:
>   -- Changed the code as the 'proactive_defer' counter is removed.
>   -- No changes in the logic of triggering the proactive compaction.
>   -- Removed the 'proactive_defer' counter.
> 
> Changes in V3:
>   -- Fixed review comments from Vlastimil and others.
>   -- Fixed wake up logic when compaction_proactiveness is zero.
>   -- https://lore.kernel.org/patchwork/patch/1438211/
> 
> Changes in V2:
>   -- remove /proc/../proactive_compact_memory interface trigger for proactive compaction
>   -- Intention is same that add a way to trigger proactive compaction by user.
>   -- https://lore.kernel.org/patchwork/patch/1431283/
> 
> Changes in V1:
>   -- Created the new /proc/sys/vm/proactive_compact_memory in
>      interface to trigger proactive compaction from user 
>   -- https://lore.kernel.org/lkml/1619098678-8501-1-git-send-email-charante@codeaurora.org/
> 
> 
> Charan Teja Reddy (3):
>   mm: compaction:  optimize proactive compaction deferrals
>   mm: compaction: support triggering of proactive compaction by user
>   mm: compaction: fix wakeup logic of proactive compaction
> 
>  Documentation/admin-guide/sysctl/vm.rst |  3 +-
>  include/linux/compaction.h              |  2 ++
>  include/linux/mmzone.h                  |  1 +
>  kernel/sysctl.c                         |  2 +-
>  mm/compaction.c                         | 61 +++++++++++++++++++++++++++------
>  5 files changed, 56 insertions(+), 13 deletions(-)
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
