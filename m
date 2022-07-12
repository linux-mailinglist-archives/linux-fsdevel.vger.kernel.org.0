Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6D571836
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiGLLMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiGLLMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:12:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043CB1847
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 04:12:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so7351614pjs.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qb55Kbq0y4vwgfIg3wFDxJyNQoImybJoWJeGkFEBt8Y=;
        b=1j7HJgDk+BOlvIrPto5v/w0UyoFz/lnQv9wgfOdsMphjfRFqT2DIg1DRCHe62jotIw
         Wcd/TP+YDwzfz1hnJ6brTDEGw2ZuVW3aJM4o1q8Q0gS/+iGgF/XMxyvjeSCbVzLv2yv/
         AZOOfT7iwDEcacqkH1Rg/gSvMy7ht63jN/2WIxL6byrFEmQFcJ+MCxNo/6iVX5tgrM46
         jeNMwF7+1ZlSigpdyBSpowNoE2GVGisPcjq7xOSY0ZJs36ILM/NQQSm4zFPQUpdNls/C
         2lw78hd8AKVpILhM+sGMlgeveyvYN0B+WRx8Por5mmiOEpPIllo6NLOIUa7ziMhmBgP1
         rMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qb55Kbq0y4vwgfIg3wFDxJyNQoImybJoWJeGkFEBt8Y=;
        b=E8LV6YRmmhDueA/xzjz7K/WlaReWVvT0K4/PfrKxFx87/2QVIRpVFHadZwz3eQCZh6
         OGLw4BOpqxCKy04CznuTetXjoldFGm3Ukjuq2ruRfyCpRfmsRbbRerTNHDVpp6lhsbYj
         tD0qquIu9c+HuToxP+judeQPlf3EKWZStEbvymOzJvQ7QoGhEqxyajDRPApmWctdspb6
         BCfzvxUNR1dPxvVbsr6IVvPA7jk7ZP8dYmF7nbRkRZZAueODl3OEWC39AihgkALXlDoW
         uyV0uXpqifPuJi7FcYNHBBJIReo0CfYvEi/z1c13t0KdpUukDkZ4mqE0/NI5Ov63fJ2t
         yVbA==
X-Gm-Message-State: AJIora8WalcKnqfI4TPVY5zrVsE3g3g6q69JHWMZP2c1gF+zMRJBCddc
        QaiwX6aw9miU3b8Xj32wBt1ZDA==
X-Google-Smtp-Source: AGRyM1uY3FpE7QhDTBbilYTgVnALa3bIqWVrC/zDtaL3RXmhC1OZWn1T+qY6Y660eckXwBBY0oBkyA==
X-Received: by 2002:a17:90b:2c0b:b0:1ef:aa42:f19b with SMTP id rv11-20020a17090b2c0b00b001efaa42f19bmr3729663pjb.211.1657624355862;
        Tue, 12 Jul 2022 04:12:35 -0700 (PDT)
Received: from [10.4.113.6] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090340c700b0016c59b38254sm1550585pld.127.2022.07.12.04.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 04:12:35 -0700 (PDT)
Message-ID: <41ae31a7-6998-be88-858c-744e31a76b2a@bytedance.com>
Date:   Tue, 12 Jul 2022 19:12:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for
 CONSTRAINT_{MEMORY_POLICY,CPUSET}
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Gang Li <ligang.bdlg@bytedance.com>
Cc:     akpm@linux-foundation.org, surenb@google.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
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
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Michal,

On 7/8/22 4:54 PM, Michal Hocko Wrote:
> On Fri 08-07-22 16:21:24, Gang Li wrote:
>> TLDR
>> ----
>> If a mempolicy or cpuset is in effect, out_of_memory() will select victim
>> on specific node to kill. So that kernel can avoid accidental killing on
>> NUMA system.
> 
> We have discussed this in your previous posting and an alternative
> proposal was to use cpusets to partition NUMA aware workloads and
> enhance the oom killer to be cpuset aware instead which should be a much
> easier solution.
> 
>> Problem
>> -------
>> Before this patch series, oom will only kill the process with the highest
>> memory usage by selecting process with the highest oom_badness on the
>> entire system.
>>
>> This works fine on UMA system, but may have some accidental killing on NUMA
>> system.
>>
>> As shown below, if process c.out is bind to Node1 and keep allocating pages
>> from Node1, a.out will be killed first. But killing a.out did't free any
>> mem on Node1, so c.out will be killed then.
>>
>> A lot of AMD machines have 8 numa nodes. In these systems, there is a
>> greater chance of triggering this problem.
> 
> Please be more specific about existing usecases which suffer from the
> current OOM handling limitations.

I was just going through the mail list and happen to see this. There
is another usecase for us about per-numa memory usage.

Say we have several important latency-critical services sitting inside
different NUMA nodes without intersection. The need for memory of these
LC services varies, so the free memory of each node is also different.
Then we launch several background containers without cpuset constrains
to eat the left resources. Now the problem is that there doesn't seem
like a proper memory policy available to balance the usage between the
nodes, which could lead to memory-heavy LC services suffer from high
memory pressure and fails to meet the SLOs.

It's quite appreciated if you can shed some light on this!

Thanks & BR,
Abel
