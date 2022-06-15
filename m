Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC354C5A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiFOKPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 06:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346842AbiFOKNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:13:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181525C6F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 03:13:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e11so11016296pfj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u65QQc2UhosWLMahxlQMn59AukfWR4oEL4oKp6IP8R4=;
        b=p6mwc20X/Q1hFeLzxCcgv78Ie6ePALgDnjKy0f6FJRwbFLlEtcyClUGIdIrRdeQuXG
         S/APdh60P9Vj8ZWvK21slVtmWATXSGVi+5VECU1WfwLJvu2C/wmcawnZDXRiot0hlSHm
         Rj7uCUvqbhfhVQA2GJoevnDtzp3l7dads+GM0V7twfGct+XRmzBvtEqdoi5foez5H8Tl
         y+0lXd+AX5G7s1qiOthMz582qdHInuCvPvzrWtGgxndpyZsnunHSHy2OoTApYkKzSehV
         bDdojCchjZBnfLQaL4EpQdwXR+4O+F/a96TGh2BXnAkuyMFutgthOpv/gugFEo+C2bE3
         9Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u65QQc2UhosWLMahxlQMn59AukfWR4oEL4oKp6IP8R4=;
        b=y8nJhlb7SGhDHovf9QQyJX0HNRtpI4gHaLZNlNAOpq04Zhq7Ibtrq+RSuR5FFBT2U/
         SVL43vk4ARI/cPHlRdoKFOJwEaLWeRKtp+1PDHAjOBCxnoGO9L85TNOBnq54eH29oWZS
         c4F/bIYiNy5KpR+kC196ssCtyAQa7gN8vIG9mYAf/cehmUynqDqkvvv70/VLZ7iVpJJJ
         6L1vAzeinezwOBT7QVKyR5KTzOCOauo63cWp3qDHOqsYMWWnMYW/HuQOKuUtyu5SWOhP
         8u2Qgr9pdwirDIvGp5Dj40uVOFC8MyvBPP8doYoBeE/sErTmaYKlgWWM7EkY1WKaZjOd
         Q11Q==
X-Gm-Message-State: AOAM530k92knlUxEc4WMHn6QYLsS4L3kNfnta3E6L/Q0WXpPeLGrnLx2
        SdhlfrRC0TeDAulpKsVgf1AkPA==
X-Google-Smtp-Source: ABdhPJyRk1EuvqaSy5Q9Ox2cFgvalWMPQnJzgUhcIvPfkO5QikvHoHYqXNW1DdxHoCrhz1YsvIMCUg==
X-Received: by 2002:a63:81c3:0:b0:3fc:c510:1a3 with SMTP id t186-20020a6381c3000000b003fcc51001a3mr8220683pgd.581.1655288010235;
        Wed, 15 Jun 2022 03:13:30 -0700 (PDT)
Received: from [10.255.194.85] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id jd13-20020a170903260d00b0016184e7b013sm8885181plb.36.2022.06.15.03.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 03:13:27 -0700 (PDT)
Message-ID: <0e27425e-1fb6-bc7c-9845-71dc805897c3@bytedance.com>
Date:   Wed, 15 Jun 2022 18:13:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: Re: [PATCH 0/5 v1] mm, oom: Introduce per numa node oom for
 CONSTRAINT_MEMORY_POLICY
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
 <YoJ/ioXwGTdCywUE@dhcp22.suse.cz>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <YoJ/ioXwGTdCywUE@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, I've done some benchmarking in the last few days.

On 2022/5/17 00:44, Michal Hocko wrote:
> Sorry, I have only now found this email thread. The limitation of the
> NUMA constrained oom is well known and long standing. Basically the
> whole thing is a best effort as we are lacking per numa node memory
> stats. I can see that you are trying to fill up that gap but this is
> not really free. Have you measured the runtime overhead? Accounting is
> done in a very performance sensitive paths and it would be rather
> unfortunate to make everybody pay the overhead while binding to a
> specific node or sets of nodes is not the most common usecase.

## CPU consumption

According to the result of Unixbench. There is less than one percent 
performance loss in most cases.

On 40c512g machine.

40 parallel copies of tests:
+----------+----------+-----+----------+---------+---------+---------+
| numastat | FileCopy | ... |   Pipe   |  Fork   | syscall |  total  |
+----------+----------+-----+----------+---------+---------+---------+
| off      | 2920.24  | ... | 35926.58 | 6980.14 | 2617.18 | 8484.52 |
| on       | 2919.15  | ... | 36066.07 | 6835.01 | 2724.82 | 8461.24 |
| overhead | 0.04%    | ... | -0.39%   | 2.12%   | -3.95%  | 0.28%   |
+----------+----------+-----+----------+---------+---------+---------+

1 parallel copy of tests:
+----------+----------+-----+---------+--------+---------+---------+
| numastat | FileCopy | ... |  Pipe   |  Fork  | syscall |  total  |
+----------+----------+-----+---------+--------+---------+---------+
| off      | 1515.37  | ... | 1473.97 | 546.88 | 1152.37 | 1671.2  |
| on       | 1508.09  | ... | 1473.75 | 532.61 | 1148.83 | 1662.72 |
| overhead | 0.48%    | ... | 0.01%   | 2.68%  | 0.31%   | 0.51%   |
+----------+----------+-----+---------+--------+---------+---------+

## MEM consumption

per task_struct:
sizeof(int) * num_possible_nodes() + sizeof(int*)
typically 4 * 2 + 8 bytes

per mm_struct:
sizeof(atomic_long_t) * num_possible_nodes() + sizeof(atomic_long_t*)
typically 8 * 2 + 8 bytes

zap_pte_range:
sizeof(int) * num_possible_nodes() + sizeof(int*)
typically 4 * 2 + 8 bytes

> Also have you tried to have a look at cpusets? Those should be easier to
> make a proper selection as it should be possible to iterate over tasks
> belonging to a specific cpuset much more easier - essentialy something
> similar to memcg oom killer. We do not do that right now and by a very
> brief look at the CONSTRAINT_CPUSET it seems that this code is not
> really doing much these days. Maybe that would be a more appropriate way
> to deal with more precise node aware oom killing?

Looks like both CONSTRAINT_MEMORY_POLICY and CONSTRAINT_CPUSET can
be uesd to deal with node aware oom killing.

I think we can calculate badness in this way:
    If constraint=CONSTRAINT_MEMORY_POLICY, get badness by `nodemask`.
    If constraint=CONSTRAINT_CPUSET, get badness by `mems_allowed`.

example code:
```
long oom_badness(struct task_struct *p, struct oom_control *oc)
	long points;

	...

	if (unlikely(oc->constraint == CONSTRAINT_MEMORY_POLICY)) {
		for_each_node_mask(nid, oc->nodemask)
			points += get_mm_counter(p->mm, -1, nid)
	} else if (unlikely(oc->constraint == CONSTRAINT_CPUSET)) {
		for_each_node_mask(nid, cpuset_current_mems_allowed)
			points += get_mm_counter(p->mm, -1, nid)
	} else {
		points = get_mm_rss(p->mm);
	}
	points += get_mm_counter(p->mm, MM_SWAPENTS, NUMA_NO_NODE) \
		+ mm_pgtables_bytes(p->mm) / PAGE_SIZE;

	...

}
```

> 
> [...]
>>   21 files changed, 317 insertions(+), 111 deletions(-)
> 
> The code footprint is not free either. And more importantnly does this
> even work much more reliably? I can see quite some NUMA_NO_NODE
> accounting (e.g. copy_pte_range!).Is this somehow fixable?

> Also how do those numbers add up. Let's say you increase the counter as
> NUMA_NO_NODE but later on during the clean up you decrease based on the
> page node?
 > Last but not least I am really not following MM_NO_TYPE concept. I can
 > only see add_mm_counter users without any decrements. What is going on
 > there?

There are two usage scenarios of NUMA_NO_NODE in this patch.

1. placeholder when swap pages in and out of swapfile.
```
	// mem to swapfile
	dec_mm_counter(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
	inc_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);

	// swapfile to mem
	inc_mm_counter(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
	dec_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
```

In *_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE),
NUMA_NO_NODE is a placeholder. It means this page does not exist in any
node anymore.

2. placeholder in `add_mm_rss_vec` and `sync_mm_rss` for per process mm 
counter synchronization with SPLIT_RSS_COUNTING enabled.


MM_NO_TYPE is also a placeholder in `*_mm_counter`, `add_mm_rss_vec` and 
`sync_mm_rss`.

These placeholders are very strange. Maybe I should introduce a helper
function for mm->rss_stat.numa_count counting instead of using
placeholder.


