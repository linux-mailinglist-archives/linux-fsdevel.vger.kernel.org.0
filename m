Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9039D9DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFGKlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 06:41:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:61744 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhFGKlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:41:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623062365; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3jHXwHBsk2WR74vNGkm4rdGC2KO8IbBgA0Iao19OUr8=; b=DAAnAK1h8ZytVYJOXffk/hstbKPdzeCFe/4OCmTRP50fyM01tl4pgfa+7EUyI2oBiKclEE3o
 I2Wt2/M810RbUAmAWVlxPo3RDR9prtywU8e+EXD4CT60/OXFvtMtaPXv4I0UbROUwW4QbA3e
 uDp0HCsY3yfuEo9Gw4B2mIPO+2M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60bdf73fed59bf69ccbff952 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Jun 2021 10:38:55
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B64CC433D3; Mon,  7 Jun 2021 10:38:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.157.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 628AFC4338A;
        Mon,  7 Jun 2021 10:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 628AFC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH v3 1/2] mm: compaction: support triggering of proactive
 compaction by user
To:     akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        hannes@cmpxchg.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, aarcange@redhat.com,
        cl@linux.com, xi.fengfei@h3c.com, mchehab+huawei@kernel.org,
        andrew.a.klychkov@gmail.com, dave.hansen@linux.intel.com,
        bhe@redhat.com, iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com,
        sh_def@163.com, vinmenon@codeaurora.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <cover.1622454385.git.charante@codeaurora.org>
 <7db6a29a64b29d56cde46c713204428a4b95f0ab.1622454385.git.charante@codeaurora.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <ef2510b2-875c-4b81-056d-043996b62c07@codeaurora.org>
Date:   Mon, 7 Jun 2021 16:08:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7db6a29a64b29d56cde46c713204428a4b95f0ab.1622454385.git.charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A gentle ping.

--Charan

On 5/31/2021 4:24 PM, Charan Teja Reddy wrote:
> The proactive compaction[1] gets triggered for every 500msec and run
> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
> pages based on the value set to sysctl.compaction_proactiveness.
> Triggering the compaction for every 500msec in search of
> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
> especially on the embedded system usecases which may have few MB's of
> RAM. Enabling the proactive compaction in its state will endup in
> running almost always on such systems.
> 
> Other side, proactive compaction can still be very much useful for
> getting a set of higher order pages in some controllable
> manner(controlled by using the sysctl.compaction_proactiveness). Thus on
> systems where enabling the proactive compaction always may proove not
> required, can trigger the same from user space on write to its sysctl
> interface. As an example, say app launcher decide to launch the memory
> heavy application which can be launched fast if it gets more higher
> order pages thus launcher can prepare the system in advance by
> triggering the proactive compaction from userspace.
> 
> This triggering of proactive compaction is done on a write to
> sysctl.compaction_proactiveness by user.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
> changes in V2:
>  - https://lore.kernel.org/patchwork/patch/1431283/
> 
> changes in V1:
>  -  https://lore.kernel.org/lkml/1619098678-8501-1-git-send-email-charante@codeaurora.org/
> 
>  Documentation/admin-guide/sysctl/vm.rst |  3 ++-
>  include/linux/compaction.h              |  2 ++
>  include/linux/mmzone.h                  |  1 +
>  kernel/sysctl.c                         |  2 +-
>  mm/compaction.c                         | 44 ++++++++++++++++++++++++++++++---
>  5 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 586cd4b..5e8097d 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -126,7 +126,8 @@ compaction_proactiveness
>  
>  This tunable takes a value in the range [0, 100] with a default value of
>  20. This tunable determines how aggressively compaction is done in the
> -background. Setting it to 0 disables proactive compaction.
> +background. On write of non zero value to this tunable will immediately
> +trigger the proactive compaction. Setting it to 0 disables proactive compaction.
>  
>  Note that compaction has a non-trivial system-wide impact as pages
>  belonging to different processes are moved around, which could also lead
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 4221888..04d5d9f 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -84,6 +84,8 @@ static inline unsigned long compact_gap(unsigned int order)
>  extern unsigned int sysctl_compaction_proactiveness;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
> +extern int compaction_proactiveness_sysctl_handler(struct ctl_table *table,
> +		int write, void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
>  extern int sysctl_compact_unevictable_allowed;
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0d53eba..9455809 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -815,6 +815,7 @@ typedef struct pglist_data {
>  	enum zone_type kcompactd_highest_zoneidx;
>  	wait_queue_head_t kcompactd_wait;
>  	struct task_struct *kcompactd;
> +	bool proactive_compact_trigger;
>  #endif
>  	/*
>  	 * This is a per-node reserve of pages that are not available
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 14edf84..bed2fad 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2840,7 +2840,7 @@ static struct ctl_table vm_table[] = {
>  		.data		= &sysctl_compaction_proactiveness,
>  		.maxlen		= sizeof(sysctl_compaction_proactiveness),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= compaction_proactiveness_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &one_hundred,
>  	},
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 84fde27..197e203 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2708,6 +2708,30 @@ static void compact_nodes(void)
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
>  
> +int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
> +		void *buffer, size_t *length, loff_t *ppos)
> +{
> +	int rc, nid;
> +
> +	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
> +	if (rc)
> +		return rc;
> +
> +	if (write && sysctl_compaction_proactiveness) {
> +		for_each_online_node(nid) {
> +			pg_data_t *pgdat = NODE_DATA(nid);
> +
> +			if (pgdat->proactive_compact_trigger)
> +				continue;
> +
> +			pgdat->proactive_compact_trigger = true;
> +			wake_up_interruptible(&pgdat->kcompactd_wait);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * This is the entry point for compacting all nodes via
>   * /proc/sys/vm/compact_memory
> @@ -2752,7 +2776,8 @@ void compaction_unregister_node(struct node *node)
>  
>  static inline bool kcompactd_work_requested(pg_data_t *pgdat)
>  {
> -	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
> +	return pgdat->kcompactd_max_order > 0 || kthread_should_stop() ||
> +		pgdat->proactive_compact_trigger;
>  }
>  
>  static bool kcompactd_node_suitable(pg_data_t *pgdat)
> @@ -2905,7 +2930,8 @@ static int kcompactd(void *p)
>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>  		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
>  			kcompactd_work_requested(pgdat),
> -			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC)) &&
> +			!pgdat->proactive_compact_trigger) {
>  
>  			psi_memstall_enter(&pflags);
>  			kcompactd_do_work(pgdat);
> @@ -2917,10 +2943,20 @@ static int kcompactd(void *p)
>  		if (should_proactive_compact_node(pgdat)) {
>  			unsigned int prev_score, score;
>  
> -			if (proactive_defer) {
> +			/*
> +			 * On wakeup of proactive compaction by sysctl
> +			 * write, ignore the accumulated defer score.
> +			 * Anyway, if the proactive compaction didn't
> +			 * make any progress for the new value, it will
> +			 * be further deferred by 2^COMPACT_MAX_DEFER_SHIFT
> +			 * times.
> +			 */
> +			if (proactive_defer &&
> +				!pgdat->proactive_compact_trigger) {
>  				proactive_defer--;
>  				continue;
>  			}
> +
>  			prev_score = fragmentation_score_node(pgdat);
>  			proactive_compact_node(pgdat);
>  			score = fragmentation_score_node(pgdat);
> @@ -2931,6 +2967,8 @@ static int kcompactd(void *p)
>  			proactive_defer = score < prev_score ?
>  					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
>  		}
> +		if (pgdat->proactive_compact_trigger)
> +			pgdat->proactive_compact_trigger = false;
>  	}
>  
>  	return 0;
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
