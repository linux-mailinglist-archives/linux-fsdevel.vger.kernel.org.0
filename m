Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2832432C548
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450678AbhCDAT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:58 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:40212 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572955AbhCCPEw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:04:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614783872; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=apZmXTWwqH3OC7fNpu7dz9ehXMHteTrrn76iMve0R98=;
 b=NzQBeJAbKxPZd5rx39g3nHZ5cOGnG/DYS199Cw8MBgh0DgLT0beJ19YAX+DaEFEEQOACtBSw
 c3YpR272QbV39CZDiYG/RJ3PmyXJeC8y5qye7mJFAJHoRsOkEbkZjj7H3Q2K3lgrD0yXfdJx
 I7X1MJt8ViMHttt2dsrjqEiW30w=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 603f9e3fc862e1b9fd8f1e02 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 14:33:35
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8FC21C433C6; Wed,  3 Mar 2021 14:33:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37FD3C433ED;
        Wed,  3 Mar 2021 14:33:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 20:03:33 +0530
From:   pintu@codeaurora.org
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        iamjoonsoo.kim@lge.com, sh_def@163.com, mateusznosek0@gmail.com,
        bhe@redhat.com, vbabka@suse.cz, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org,
        mgorman@techsingularity.net, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
In-Reply-To: <BYAPR12MB3416C9FD5D10AFB930E1C023D8999@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
 <BYAPR12MB3416C9FD5D10AFB930E1C023D8999@BYAPR12MB3416.namprd12.prod.outlook.com>
Message-ID: <d3a2ef132c8deee8ced530367c81479c@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-03 01:48, Nitin Gupta wrote:
>> -----Original Message-----
>> From: pintu=codeaurora.org@mg.codeaurora.org
>> <pintu=codeaurora.org@mg.codeaurora.org> On Behalf Of Pintu Kumar
>> Sent: Tuesday, March 2, 2021 9:56 AM
>> To: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; linux-
>> mm@kvack.org; linux-fsdevel@vger.kernel.org; pintu@codeaurora.org;
>> iamjoonsoo.kim@lge.com; sh_def@163.com; mateusznosek0@gmail.com;
>> bhe@redhat.com; Nitin Gupta <nigupta@nvidia.com>; vbabka@suse.cz;
>> yzaikin@google.com; keescook@chromium.org; mcgrof@kernel.org;
>> mgorman@techsingularity.net
>> Cc: pintu.ping@gmail.com
>> Subject: [PATCH] mm/compaction: remove unused variable
>> sysctl_compact_memory
>> 
>> External email: Use caution opening links or attachments
>> 
>> 
>> The sysctl_compact_memory is mostly unsed in mm/compaction.c It just 
>> acts
>> as a place holder for sysctl.
>> 
>> Thus we can remove it from here and move the declaration directly in
>> kernel/sysctl.c itself.
>> This will also eliminate the extern declaration from header file.
> 
> 
> I prefer keeping the existing pattern of listing all compaction related 
> tunables
> together in compaction.h:
> 
> 	extern int sysctl_compact_memory;
> 	extern unsigned int sysctl_compaction_proactiveness;
> 	extern int sysctl_extfrag_threshold;
> 	extern int sysctl_compact_unevictable_allowed;
> 

Thanks Nitin for your review.
You mean, you just wanted to retain this extern declaration ?
Any real benefit of keeping this declaration if not used elsewhere ?

> 
>> No functionality is broken or changed this way.
>> 
>> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
>> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
>> ---
>>  include/linux/compaction.h | 1 -
>>  kernel/sysctl.c            | 1 +
>>  mm/compaction.c            | 3 ---
>>  3 files changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h 
>> index
>> ed4070e..4221888 100644
>> --- a/include/linux/compaction.h
>> +++ b/include/linux/compaction.h
>> @@ -81,7 +81,6 @@ static inline unsigned long compact_gap(unsigned int
>> order)  }
>> 
>>  #ifdef CONFIG_COMPACTION
>> -extern int sysctl_compact_memory;
>>  extern unsigned int sysctl_compaction_proactiveness;  extern int
>> sysctl_compaction_handler(struct ctl_table *table, int write,
>>                         void *buffer, size_t *length, loff_t *ppos); 
>> diff --git
>> a/kernel/sysctl.c b/kernel/sysctl.c index c9fbdd8..66aff21 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -198,6 +198,7 @@ static int max_sched_tunable_scaling =
>> SCHED_TUNABLESCALING_END-1;  #ifdef CONFIG_COMPACTION  static int
>> min_extfrag_threshold;  static int max_extfrag_threshold = 1000;
>> +static int sysctl_compact_memory;
>>  #endif
>> 
>>  #endif /* CONFIG_SYSCTL */
>> diff --git a/mm/compaction.c b/mm/compaction.c index 190ccda..ede2886
>> 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2650,9 +2650,6 @@ static void compact_nodes(void)
>>                 compact_node(nid);
>>  }
>> 
>> -/* The written value is actually unused, all memory is compacted */ 
>> -int
>> sysctl_compact_memory;
>> -
> 
> 
> Please retain this comment for the tunable.

Sorry, I could not understand.
You mean to say just retain this last comment and only remove the 
variable ?
Again any real benefit you see in retaining this even if its not used?


Thanks,
Pintu
