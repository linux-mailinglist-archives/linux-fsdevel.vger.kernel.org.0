Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB273393B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 04:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhE1CMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 22:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhE1CMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 22:12:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1AC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 19:10:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j12so1394703pgh.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=v+SsYqHRR/RJ2vuPiv+eqG29wbplMivXPG8IiOrrLnM=;
        b=sIbw/QaVCgWRNBJNdHkNrAqeT3Pjq7PWyq5SAhXrEPVzo0yXmysC4kjRVwzApIyJNA
         xWJ4kS8DWQ3xk4FFLqulePDZ7gqBjqHDYjEeXKehf3PKj47PiCEQRycUK0FwHj+KBEGF
         TpcfEySwaXHWINwsdTgw4rRtnZsG7qzRS/u3k8QNdcn9cMUxNwyqnWEwLYjyp2y3cHoO
         jxRsufKBHgwGNPLqnTgA9bal4bY/uL6aBR/rBrX9+MrLVwhkwrSCG+SPb1Z0/4oisNLA
         noTSOmgrPp/3IvAkYPbA+9ra9kjDfiqZO5a/dKYb/Sx3J5Y7culyEvsso+gkJBy6NTBR
         Y8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=v+SsYqHRR/RJ2vuPiv+eqG29wbplMivXPG8IiOrrLnM=;
        b=jull+2CT1m0OR1EOdr0zoKzfVcfWCOKieEoXv9FfB/34GZL93O+cQwRbHwIfwjZe7D
         5HYSEkG/8m6uByFyBmk/JmeqB2gr7SX1ksNmlgNtKpbuVg1/MQYMY/Vrrg6IkFz/ukjh
         W+P+sqfxUgL9rnvJN6L1JFSo/ZzMko72PxllAEgr0WugMd3owel0Ph8ztc/rexIEUmd7
         PONxtbeab3oRkx4mVq6BHei/5Xne4B/yzJmrH2ySSd5ZrMVzw66uILh7HTG245484BrZ
         /O2dYR1pcpm7HNjldwEM4QP/rzTS65BU7xACEG8NCtaF1rh6Tlmz0EB/I/pHgVi3tJr7
         lFEw==
X-Gm-Message-State: AOAM5331aM12HKz16gs3L7qAhz80ad8BJmSBsfGPfIgjoWMoXVGwcAw2
        vE69pGtC47t7eNxzl2OHZSotJA==
X-Google-Smtp-Source: ABdhPJxQPhDpq0Ub4uva2R6FuXj7T55eOSlSy33otSXAEV5oqDlsIzviCKGT+I9tdtgTwgix2LBYLg==
X-Received: by 2002:a62:148c:0:b029:2cf:3c2d:7ba with SMTP id 134-20020a62148c0000b02902cf3c2d07bamr1399070pfu.79.1622167829740;
        Thu, 27 May 2021 19:10:29 -0700 (PDT)
Received: from [10.86.119.121] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id l1sm2829449pjt.40.2021.05.27.19.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 19:10:29 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] fs/proc/kcore.c: add mmap interface
To:     Andrew Morton <akpm@linux-foundation.org>, adobriyan@gmail.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com,
        chenying.kernel@bytedance.com, zhengqi.arch@bytedance.com
References: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
 <20210526173953.49fb3dc48c0f2a8b3c31fe2b@linux-foundation.org>
 <d71a4ffa-f21e-62f5-7fa6-83ca14b3f05b@bytedance.com>
 <20210527153055.aefeee8d8385da8152bdbacc@linux-foundation.org>
From:   zhoufeng <zhoufeng.zf@bytedance.com>
Message-ID: <d36b56ca-6405-d7dc-a531-fcbe0acc425d@bytedance.com>
Date:   Fri, 28 May 2021 10:10:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527153055.aefeee8d8385da8152bdbacc@linux-foundation.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



ÔÚ 2021/5/28 ÉÏÎç6:30, Andrew Morton Ð´µÀ:
> On Thu, 27 May 2021 14:13:09 +0800 zhoufeng <zhoufeng.zf@bytedance.com> wrote:
> 
>>> I'm surprised that it makes this much difference.  Has DRGN been fully
>>> optimised to minimise the amount of pread()ing which it does?  Why does
>>> it do so much reading?
>> DRGN is a tool similar to Crash, but much lighter. It allows users to
>> obtain kernel data structures from Python scripts. Based on this, we
>> intend to use DRGN for kernel monitoring. So we used some pressure test
>> scripts to test the loss of monitoring.
>> Monitoring is all about getting current real-time data, so every time
>> DRGN tries to get kernel data, it needs to read /proc/kcore. In my
>> script, I tried to loop 1000 times to obtain the information of all the
>> processes in the machine, in order to construct a scene where kernel
>> data is frequently read. So, the frequency in the default version of
>> kcore, pread is very high. In view of this situation, our optimization
>> idea is to reduce the number of context switches as much as possible
>> under the scenario of frequent kernel data acquisition, to reduce the
>> performance loss to a minimum, and then move the monitoring system to
>> the production environment.
> 
> Why would a pread() cause a context switch?
> 

Sorry, my English is poor. I mean trigger the system call.

>> After running for a long time in a
>> production environment, the number of kernel data reads was added as
>> time went on, and the pread number also increased. If users use mmap,
>> it's once for all.
