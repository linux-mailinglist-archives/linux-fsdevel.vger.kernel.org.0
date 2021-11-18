Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9608A455849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 10:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbhKRJxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 04:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245294AbhKRJxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:53:06 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F67C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 01:50:04 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 8so5439928pfo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3HQ5IYVEiqW+9JbVKAMAdi66pgrzu4Y9QOo0iHu1JDU=;
        b=PtudUEDeYjc1lbFt/YcrJoXefINi2/DLtR2e3eV0uycMEN4jzjuk5iUdoe/5/twlA4
         EyZLMpRyfY1Wx3XBAseVofCGj3X0uV35THwhEG4J+FmPiLq8RqBhe3ZXXSrJxN+PbiZj
         39sJKyzvjDyo/xjvs53RR9FQ5TKO1PA0MWlSs84Y7TnxR81S4omEkGxLB69WVR9b+bu8
         TPgFlQjYqbr927M1DOcTw1uO7Z/ZVRxh8423WyH2a5F+ORKcJIASeR+bmH24NnXtnb7f
         1f1xVdqxNLCBr9sXm+LDUA9OvDZ3YJPVo1MxfUq9WetnTlb+L6YawBu6nqo4iI0ZTMZ3
         MdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3HQ5IYVEiqW+9JbVKAMAdi66pgrzu4Y9QOo0iHu1JDU=;
        b=VAZfA29JOBTWa9UfVYdwVVXPBJnBBtLdKwo3Ks6obwX62e9hkTRJrIp/8DJIqjYxNB
         QzDOAIj2uZ2aUDieZyeyqPbwo31J2FbkkM5bZ3bdK6LTuMQp+UiHUtQpN/xU2FfSTrJU
         9nUSu0Tfeh0ObmDH2s07VLJd73hmdnXYOv+9w+QKMC1y5pxC0gCJhDlZOxQdHW0xGqVi
         tyO5nmOaaLcupiewEkRI1/OM+NZuGaiOX9y9kYnleGUbtzCsNBieQ7FmvNgDskzKOhh2
         pi2905z6gBHAJJVzoyLgLuATqpSdo52sNETtTlZg77VRxV9xfk0iPHFQUQY2KSj3E8di
         qPvg==
X-Gm-Message-State: AOAM533UA7xiGicDLdVRzZbwSuCcU023FHOiiJPgTwPLs7YSpPXOopqG
        m7gw+Y5yBN2Lz/WLPb0HFjGaRQ==
X-Google-Smtp-Source: ABdhPJx4EMKtBe0WnpdPtMWMcYIpYkXHpyKXoHzrcv2OhxF2rykg5u9Y7Q+XOCzGlPXHjnutDYHJWQ==
X-Received: by 2002:aa7:88d3:0:b0:49f:baac:9b51 with SMTP id k19-20020aa788d3000000b0049fbaac9b51mr13931939pff.44.1637229003752;
        Thu, 18 Nov 2021 01:50:03 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e14sm2903051pfv.18.2021.11.18.01.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 01:50:03 -0800 (PST)
Message-ID: <1d04e306-064e-b9eb-8846-2d12458988a9@bytedance.com>
Date:   Thu, 18 Nov 2021 17:49:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: Re: Re: Re: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add
 per-process numa_balancing
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
 <20211109162647.GY3891@suse.de>
 <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
 <20211117082952.GA3301@suse.de>
 <816cb511-446d-11eb-ae4a-583c5a7102c4@bytedance.com>
 <20211117101008.GB3301@suse.de>
 <f0193837-2f2c-b55f-cd79-b80d931e7931@bytedance.com>
 <20211118085819.GD3301@suse.de>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211118085819.GD3301@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/21 4:58 PM, Mel Gorman wrote:
> On Thu, Nov 18, 2021 at 11:26:30AM +0800, Gang Li wrote:
>> 3. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
> 
> If PR_SET_NUMAB_ENABLE enables numa balancing for a task when
> kernel.numa_balancing == 0 instead of returning an error then sure.

Of course.

I'll send patch v2 soon.
-- 
Thanks,
Gang Li

