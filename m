Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE06571E43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiGLPID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 11:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiGLPGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:06:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE84BAAA4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 08:01:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 73so7781263pgb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C6szfa/YFuVli7Zl8D3g07FtZCaBqKl0sr0C3s801fw=;
        b=wvGh1LaGBDR/G4joma/N0cvbJnBEIUQnqZL1xqzrAx2II/seQanvVrR3VC/+z7Zjld
         zVpL3S1Sbap6Qr3EziCQwuz57jjlFSyqAIG//PrF57ckKsOjYnNA74IslrVRV8nnnvRN
         3wVRUsNjq8E8LfWdZImw+6t4uy2qdxEczsZkafnLIRX6/tVcYH4YdvtrreW/yTwotczk
         0N6jnX5GZaEEOxdbD89BmI2kjEa6YY8NeG+QQlMPkGzOPlGhGFtT53OgEj7W2CYR3byM
         LQOFNKZQ1nRsJMbeAYgWlG0zgQMstkobCqEuCJ2MiVopQxFfrxJf8bduX6B6jN534ryq
         abmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C6szfa/YFuVli7Zl8D3g07FtZCaBqKl0sr0C3s801fw=;
        b=50RzxtrHC/CR5+OVrjQwp0U343i7UNJAW1OH1kuFky/+cgHKRdxmf4kcRui72LBMoH
         y71MJ9IBnuZOO9Tjk6x7wgx4SBDndz5pjmzifPM+48ptyOHjGg3ajae2pWr/xcoHHNUK
         5UF5rOdt9HdP0Zw3ZduVwk6KPRrIsm8jLS2uZRq8f+spybhp80rSwKZk3h8s1c5Spxm7
         g7JPTJn+aRiwPealmai5cFY3tyYTAdV52k3ySUHgltRAJTD5Tdszc660wDhDKRLioaPI
         XOyCHRVvPEx/Uzik6EwTwo+4GC89/8RmNb9xYbpJr+xOHH0NNZu4/qfmTw08f3OqxXwe
         YQBA==
X-Gm-Message-State: AJIora90NBTIXL4cY/EAhoE2/0xhCSI+gNvlXAzwvl50UwualAhhGuMx
        q0lzd1fJR0bFUoomGNZr+fPmcewoPvHwTzFe
X-Google-Smtp-Source: AGRyM1uF2yZ0fhTWiRIzaCuJhrMoYd2YKnjhN3avJPfSwtQ8ASEEXv5DvqmJeYAEZYa99COktBhysA==
X-Received: by 2002:a63:9752:0:b0:3c6:5a7a:5bd6 with SMTP id d18-20020a639752000000b003c65a7a5bd6mr21070507pgo.390.1657638073175;
        Tue, 12 Jul 2022 08:01:13 -0700 (PDT)
Received: from [10.4.113.6] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b0016bfbd99f64sm6892899plg.118.2022.07.12.08.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:01:12 -0700 (PDT)
Message-ID: <6f6a2257-3b60-e312-3ee3-fb08b972dbf2@bytedance.com>
Date:   Tue, 12 Jul 2022 23:00:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for
 CONSTRAINT_{MEMORY_POLICY,CPUSET}
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, akpm@linux-foundation.org,
        surenb@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, david@redhat.com,
        imbrenda@linux.ibm.com, adobriyan@gmail.com,
        yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        hezhongkun.hzk@bytedance.com
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
 <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
 <41ae31a7-6998-be88-858c-744e31a76b2a@bytedance.com>
 <Ys14oIHL85d/T7s+@dhcp22.suse.cz>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Ys14oIHL85d/T7s+@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/12/22 9:35 PM, Michal Hocko Wrote:
> On Tue 12-07-22 19:12:18, Abel Wu wrote:
> [...]
>> I was just going through the mail list and happen to see this. There
>> is another usecase for us about per-numa memory usage.
>>
>> Say we have several important latency-critical services sitting inside
>> different NUMA nodes without intersection. The need for memory of these
>> LC services varies, so the free memory of each node is also different.
>> Then we launch several background containers without cpuset constrains
>> to eat the left resources. Now the problem is that there doesn't seem
>> like a proper memory policy available to balance the usage between the
>> nodes, which could lead to memory-heavy LC services suffer from high
>> memory pressure and fails to meet the SLOs.
> 
> I do agree that cpusets would be rather clumsy if usable at all in a
> scenario when you are trying to mix NUMA bound workloads with those
> that do not have any NUMA proferences. Could you be more specific about
> requirements here though?

Yes, these LC services are highly sensitive to memory access latency
and bandwidth, so they are provisioned by NUMA node granule to meet
their performance requirements. While on the other hand, they usually
do not make full use of cpu/mem resources which increases the TCO of
our IDCs, so we have to co-locate them with background tasks.

Some of these LC services are memory-bound but leave much of cpu's
capacity unused. In this case we hope the co-located background tasks
to consume some leftover without introducing obvious mm overhead to
the LC services.

> 
> Let's say you run those latency critical services with "simple" memory
> policies and mix them with the other workload without any policies in
> place so they compete over memory. It is not really clear to me how can
> you achieve any reasonable QoS in such an environment. Your latency
> critical servises will be more constrained than the non-critical ones
> yet they are more demanding AFAIU.

Yes, the QoS over memory is the biggest block in the way (the other
resources are relatively easier). For now, we hacked a new mpol to
achieve weighted-interleave behavior to balance the memory usage across
NUMA nodes, and only set memcg protections to the LC services. If the
memory pressure is still high, the background tasks will be killed.
Ideas? Thanks!

Abel
