Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CF388B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbhESKWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 06:22:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21520 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbhESKV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 06:21:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621419640; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Ic8FJNP9L+1A0PI/Lman567/Hir6/FYMQCBLwb1m9Po=; b=iQo28teU5kpdyv/7X5/kNAdWMtNlRt3eh7fwgxLWHIY6wS+vbgHTEjwV+kBtC/Z5SxrtS46r
 Y3Oct2QDQaiM3EOBxBV/qRDmETzunDDBEgsPIS2WH1iAcog6gW06bHKRFTtjkQX3tefKResg
 aXNCy7Cl2R0LSEG6padDfqc1gcM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60a4e6431449805ea2b9a16e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 10:19:47
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A3C8C4323A; Wed, 19 May 2021 10:19:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.156.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15BCEC433F1;
        Wed, 19 May 2021 10:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15BCEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIFYyXSBtbTogY29tcGFjdGlvbjogc3Vw?=
 =?UTF-8?Q?port_triggering_of_proactive_compaction_by_user?=
To:     "Chu,Kaiping" <chukaiping@baidu.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
 <79279be3573542dea0266f8e9d4d5368@baidu.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <e17fb3b8-2737-0d4c-eede-093a2aa2ed8b@codeaurora.org>
Date:   Wed, 19 May 2021 15:49:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <79279be3573542dea0266f8e9d4d5368@baidu.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Kaiping for your review comments!!

On 5/19/2021 7:11 AM, Chu,Kaiping wrote:
>> This triggering of proactive compaction is done on a write to
>> sysctl.compaction_proactiveness by user.
> If you want to trigger compaction from userspace, you can use " echo 1 > /proc/sys/vm/compact_memory", there is no need to be so complex.

1) compact_memory is intended for debug interface. And moreover we can't
issue the compaction in some controlled manner as write to this node
triggers the full node compaction. This patch aims at users who want to
do the compaction in some controlled manner from user space. Example
user is app launcher preparing the system before launching a memory
hungry app.

2) Also, with the current implementation of proactive compaction, say
user sets the sysctl.compaction_proactiveness, the values can have
effect only in the next HPAGE_FRAG_CHECK_INTERVAL_MSEC(500msec), IOW,
the proactive compaction can run with the new settings only after
500msec which can make the user to wait for 500msec after setting a
value in the compaction_proactiveness to think that the value written is
came into effectiveness. Say user want to launch a gaming application
which has higher memory requirements and its launch time is proportional
to the available higher order pages. So, what he can do to get the
larger number of pages is set the compaction_proactivness to higher
value, continue launching the application and once finishes can set the
proactivness to original value. But with the current implementation the
value set may not come into effectiveness at all because of the 500msec
delay.Thus,the patch also handles the scenario of requiring the
proactive compaction to run immediately once user sets the
'compaction_proactiveness'.

May be I need to update the commit log even more clear about why can't
we use the 'compact_memory' and requirements to need to run the
proactive compaction immediately once user changes the
compaction_proactivness.

> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
