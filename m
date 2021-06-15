Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474A13A78B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFOIGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhFOIGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623744283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ3dVIBtoSwO39R+hFiZcOjeq+PcftU2mloldEk3r0o=;
        b=LawVtAQgMB9TZmIKW8G9bVKWPKxB4+5ivjKOA+d8rrEpEpqZDB07EB+D/QwmRW1CBHnrFk
        QSsyPl2+/777RImEm2cKzZQNI3egd1USeiSj1Mcfo+YOo+66kbrg4OrKVGyJjgskq35SSp
        NZt0+1uNhVXFHfr69N/Bu7Uiv7p0ktk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-6u-erLQQPsesDWm2zsqFqw-1; Tue, 15 Jun 2021 04:04:39 -0400
X-MC-Unique: 6u-erLQQPsesDWm2zsqFqw-1
Received: by mail-wm1-f71.google.com with SMTP id g14-20020a05600c4eceb02901b609849650so211257wmq.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 01:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BQ3dVIBtoSwO39R+hFiZcOjeq+PcftU2mloldEk3r0o=;
        b=OP5NRp2U3PozAQHs7w3XjUtg9mDO125zsVjKQvNY9E0pxj2FzEWk4Dh4GMPm56sODS
         FExNOK2j7hAUYXTufxNJ5lR4SBKGeAy84hwsCpyxnvHYVJi215kTFhgUTObqvp/wF9cP
         DhfZN9VZVhVOjOS6+K8i0nFW4UOamOqgiZHpJtMbgdLfJ0IKnZYzfmwSnqbliLSRtKVM
         uy+gt+CGaRk68x2K4NQDR6EeakZDEO58YaCFk+9w4KNtxrKLUZJ3kpjJPA++Eem776ep
         4q5y24g9xQDEjJpM8fFg7yVk9y1/bZzUVRE3rdA88HBWputWtpQ28Xby+fO2w0Qjp65L
         DlWA==
X-Gm-Message-State: AOAM530RL5IQkHCeN5bgxKil4x6/1Z8SR2KKn52z9Kta1P6p6wr6otpD
        lDtQ+mAIz/KZPvofCqeMo7z6w+BQRVwZyxNC4YNfF2k5EFu4wB7c84kI5rD+jCVQnNfYj3l5ZF/
        vMIEQdhDVF6UFGqKMgDEO3nsR/Q==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr3705073wmc.96.1623744277939;
        Tue, 15 Jun 2021 01:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8zKcj+0CHWNbpopi15qK/VY149FzjCqfOGVYh24AlZU3SNfDxUiS6IcZoR2LoqC+8dPMiWA==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr3705056wmc.96.1623744277769;
        Tue, 15 Jun 2021 01:04:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6136.dip0.t-ipconnect.de. [91.12.97.54])
        by smtp.gmail.com with ESMTPSA id s1sm1510041wmj.8.2021.06.15.01.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 01:04:37 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHY0XSBtbS9jb21wYWN0aW9uOiBsZXQg?=
 =?UTF-8?Q?proactive_compaction_order_configurable?=
To:     "Chu,Kaiping" <chukaiping@baidu.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
 <a3f6628a-8165-429f-0383-c522b4c49197@redhat.com>
 <af26c999229a4c0dbb8c772ce50f60e4@baidu.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3d4f59ce-8f83-4892-c210-649780b247f3@redhat.com>
Date:   Tue, 15 Jun 2021 10:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <af26c999229a4c0dbb8c772ce50f60e4@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.06.21 03:11, Chu,Kaiping wrote:
> 
> 
>> -----邮件原件-----
>> 发件人: David Hildenbrand <david@redhat.com>
>> 发送时间: 2021年6月9日 18:45
>> 收件人: Chu,Kaiping <chukaiping@baidu.com>; mcgrof@kernel.org;
>> keescook@chromium.org; yzaikin@google.com; akpm@linux-foundation.org;
>> vbabka@suse.cz; nigupta@nvidia.com; bhe@redhat.com;
>> khalid.aziz@oracle.com; iamjoonsoo.kim@lge.com;
>> mateusznosek0@gmail.com; sh_def@163.com
>> 抄送: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
>> linux-mm@kvack.org
>> 主题: Re: [PATCH v4] mm/compaction: let proactive compaction order
>> configurable
>>
>> On 28.04.21 04:28, chukaiping wrote:
>>> Currently the proactive compaction order is fixed to
>>> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
>>> normal 4KB memory, but it's too high for the machines with small
>>> normal memory, for example the machines with most memory configured as
>>> 1GB hugetlbfs huge pages. In these machines the max order of free
>>> pages is often below 9, and it's always below 9 even with hard
>>> compaction. This will lead to proactive compaction be triggered very
>>> frequently. In these machines we only care about order of 3 or 4.
>>> This patch export the oder to proc and let it configurable by user,
>>> and the default value is still COMPACTION_HPAGE_ORDER.
>>>
>>> Signed-off-by: chukaiping <chukaiping@baidu.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> ---
>>>
>>> Changes in v4:
>>>       - change the sysctl file name to proactive_compation_order
>>>
>>> Changes in v3:
>>>       - change the min value of compaction_order to 1 because the
>> fragmentation
>>>         index of order 0 is always 0
>>>       - move the definition of max_buddy_zone into #ifdef
>>> CONFIG_COMPACTION
>>>
>>> Changes in v2:
>>>       - fix the compile error in ia64 and powerpc, move the initialization
>>>         of sysctl_compaction_order to kcompactd_init because
>>>         COMPACTION_HPAGE_ORDER is a variable in these architectures
>>>       - change the hard coded max order number from 10 to MAX_ORDER -
>> 1
>>>
>>>    include/linux/compaction.h |    1 +
>>>    kernel/sysctl.c            |   10 ++++++++++
>>>    mm/compaction.c            |   12 ++++++++----
>>>    3 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>>> index ed4070e..a0226b1 100644
>>> --- a/include/linux/compaction.h
>>> +++ b/include/linux/compaction.h
>>> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int
>> order)
>>>    #ifdef CONFIG_COMPACTION
>>>    extern int sysctl_compact_memory;
>>>    extern unsigned int sysctl_compaction_proactiveness;
>>> +extern unsigned int sysctl_proactive_compaction_order;
>>>    extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>>>    			void *buffer, size_t *length, loff_t *ppos);
>>>    extern int sysctl_extfrag_threshold; diff --git a/kernel/sysctl.c
>>> b/kernel/sysctl.c index 62fbd09..ed9012e 100644
>>> --- a/kernel/sysctl.c
>>> +++ b/kernel/sysctl.c
>>> @@ -196,6 +196,7 @@ enum sysctl_writes_mode {
>>>    #endif /* CONFIG_SCHED_DEBUG */
>>>
>>>    #ifdef CONFIG_COMPACTION
>>> +static int max_buddy_zone = MAX_ORDER - 1;
>>>    static int min_extfrag_threshold;
>>>    static int max_extfrag_threshold = 1000;
>>>    #endif
>>> @@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table,
>> int write,
>>>    		.extra2		= &one_hundred,
>>>    	},
>>>    	{
>>> +		.procname       = "proactive_compation_order",
>>> +		.data           = &sysctl_proactive_compaction_order,
>>> +		.maxlen         = sizeof(sysctl_proactive_compaction_order),
>>> +		.mode           = 0644,
>>> +		.proc_handler   = proc_dointvec_minmax,
>>> +		.extra1         = SYSCTL_ONE,
>>> +		.extra2         = &max_buddy_zone,
>>> +	},
>>> +	{
>>>    		.procname	= "extfrag_threshold",
>>>    		.data		= &sysctl_extfrag_threshold,
>>>    		.maxlen		= sizeof(int),
>>> diff --git a/mm/compaction.c b/mm/compaction.c index e04f447..171436e
>>> 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -1925,17 +1925,18 @@ static bool kswapd_is_running(pg_data_t
>>> *pgdat)
>>>
>>>    /*
>>>     * A zone's fragmentation score is the external fragmentation wrt to
>>> the
>>> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
>>> + * sysctl_proactive_compaction_order. It returns a value in the range
>>> + * [0, 100].
>>>     */
>>>    static unsigned int fragmentation_score_zone(struct zone *zone)
>>>    {
>>> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>> +	return extfrag_for_order(zone, sysctl_proactive_compaction_order);
>>>    }
>>>
>>>    /*
>>>     * A weighted zone's fragmentation score is the external
>>> fragmentation
>>> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
>>> - * returns a value in the range [0, 100].
>>> + * wrt to the sysctl_proactive_compaction_order scaled by the zone's size.
>>> + * It returns a value in the range [0, 100].
>>>     *
>>>     * The scaling factor ensures that proactive compaction focuses on larger
>>>     * zones like ZONE_NORMAL, rather than smaller, specialized zones
>>> like @@ -2666,6 +2667,7 @@ static void compact_nodes(void)
>>>     * background. It takes values in the range [0, 100].
>>>     */
>>>    unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
>>> +unsigned int __read_mostly sysctl_proactive_compaction_order;
>>>
>>>    /*
>>>     * This is the entry point for compacting all nodes via @@ -2958,6
>>> +2960,8 @@ static int __init kcompactd_init(void)
>>>    	int nid;
>>>    	int ret;
>>>
>>> +	sysctl_proactive_compaction_order = COMPACTION_HPAGE_ORDER;
>>> +
>>>    	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>>>    					"mm/compaction:online",
>>>    					kcompactd_cpu_online, NULL);
>>>
>>
>> Hm, do we actually want to put an upper limit to the order a user can supply?
> No，we should allow user to configure the order from 1 to MAX_ORDER - 1.

Ah, I missed that we enforce an upper limit of "MAX_ORDER - 1" -- thanks.


-- 
Thanks,

David / dhildenb

