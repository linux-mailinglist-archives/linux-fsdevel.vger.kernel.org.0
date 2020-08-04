Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4123B4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgHDGP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 02:15:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:47993 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHDGP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:15:58 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200804061555epoutp024c210fdeccb38cc7266a08ce8ff1c300~n-BP2p5Gu1706717067epoutp02O;
        Tue,  4 Aug 2020 06:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200804061555epoutp024c210fdeccb38cc7266a08ce8ff1c300~n-BP2p5Gu1706717067epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596521755;
        bh=WGzv8NvtDPsUEvGi0v3GFu8hR6WxwFX6S6UJ+258u7E=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Zr4ktLrjBPQk+pKfB9PS4O/XEwTqcwPiOyOGEjnXpccoLSwvCg2SKn6YI+Zwl5M6q
         xDLbwyw80HYBmaaZ2IeK4iB4hYTf5jtJd5uSDkTQXP7y9xdE36sbBNgUCqbOfzb3V6
         y9QiQ39ZHRnZOVYtbaNmR9D8jQHGHXRSqsrP5gXo=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200804061554epcas5p3f803017cdad58a0ada3d25bbe48905bf~n-BOw_nJK0164801648epcas5p3p;
        Tue,  4 Aug 2020 06:15:54 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-95-5f28fd1aebec
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.4C.09475.A1DF82F5; Tue,  4 Aug 2020 15:15:54 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] arm64: add support for PAGE_SIZE aligned kernel
 stack
Reply-To: v.narang@samsung.com
From:   Vaneet Narang <v.narang@samsung.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Maninder Singh <maninder1.s@samsung.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gladkov.alexey@gmail.com" <gladkov.alexey@gmail.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "walken@google.com" <walken@google.com>,
        "bernd.edlinger@hotmail.de" <bernd.edlinger@hotmail.de>,
        "laoar.shao@gmail.com" <laoar.shao@gmail.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200803123447.GA89825@C02TD0UTHF1T.local>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200804061526epcms5p3ff393f7e51d28ed896105c868bd31e5b@epcms5p3>
Date:   Tue, 04 Aug 2020 11:45:26 +0530
X-CMS-MailID: 20200804061526epcms5p3ff393f7e51d28ed896105c868bd31e5b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+69vb10q7mUTo+w6axzKjCEIOOwjGVLnDmTzGCMM9kmrCk3
        wAaFtDLEZVlRwPEpdpBBgfI1RsVOTIXyUSkFGdSBGkoYW+MEFKdjMCS0IjJkawtx/z3nOb88
        z3nfHIYUWWhfJlF+nFPIpUkSWkAZr+7e9brvyq7Y4MxGMRo2cei7zAOosllPI7NVhpYccwCt
        qPv5aGh1mkTnS0cpVDo5RaO5HwoA0jwq46NVYxYf1c4dQqfrm2k0bm4kkNWRTaOh/GQ0PpDD
        Q433b/GR4e4vPHSl6xqFRjoraXS1OodCDWPDBOqovMZDNksNgVq7swEyfzNBoAbdLA+pZ4wE
        6nq6RKGn6q9Q1q2wd7ZhvVYP8PITNcAaVSGNK1TDFO7Q/M7HWWY7H9cY0nDdzZ8obGjKpbG1
        bJnC3VV6Pr78/dd4/p6dwnPmURoXtTQBvGDYEu39keCtOC4p8QtOseftTwUJuQ4LSC0Snbjd
        aKNUoG9DHvBiILsXltZr+HlAwIhYE4DqcwV0HmAYIesNV9p9XIwPGw3n/7QAlxaxW+DArybg
        8QOh9b8Hu3Ca9YfzWUddtpjdCQs6HZQrkmTvvABH7PU8T5cQlp25R3m0H2xrbHXneLEIFnSf
        Jzz+i/C3C7P8dT3XXw08Wgyzb18nPdobTiyZ1vyX4KLzLM9VBtl8ABdaimjPoQTAiuXBtdRw
        aLqkdTcL2Q+gdtziTqLYHfCx3jWwi9kHNbpMN0+yW2HbbCXpmoxkd8Pmzj0e5GVY+vPFNWQD
        LFyeItYHa9euawm80dOxFgnhVG65OwayGNp1wLPnLgBv/lFCF4NXNM9WrflfseZZcQ0gm8Bm
        LlWZHM8pw1JD5Vx6kFKarEyTxwfJUpINwP3J/aPawZ2Jh0G9gGBAL4AMKREL5xd2xoqEcdKM
        k5wiJVaRlsQpe4EfQ0k2CSWPh2JEbLz0OPc5x6VyivVbgvHyVRHK6Kh/LAGYAK+eO5s2ebAO
        nMFxq6Wk6fDHF2an+myCmTd64pZOhwfn3Ij0s4SKwzNijFXO8pOnIpqOWYseRlptRw33+xbT
        L+fq4yNq3pVJn2gPbNtI6w32Nytt1JGA2tda20ZPPEh5jxnwWdw/4izOK1k+UqwfM8qqr2ye
        EY4lRqRhxfMtAfX7Z4Z6dKKmB+KQWmfZ9KHBBJ0dDOZXaZsDxfuub/37kw9LQmRAFjYU0WVN
        UDmwObLZufh+uR+RET0pCu2MFyxQ/bquu4WXpp8L93IaoxpE8MdAW4wq96+yjXt1j3akyBPT
        D08Eb+91XvzyVHXAt6PHPqvatBpYUSehlAnSEH9SoZT+C/G1hfVTBAAA
X-CMS-RootMailID: 20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96
References: <20200803123447.GA89825@C02TD0UTHF1T.local>
        <1596386115-47228-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96@epcms5p3>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mark,

>> currently THREAD_SIZE is always in power of 2, which will waste
>> memory in cases there is need to increase of stack size.
>
>If you are seeing issues with the current stack size, can you please
>explain that in more detail? Where are you seeing problems? Which
>configuration options do you have selected?
>
>I'm not keen on making kernel stack sizes configurable as it's not
>currently possible for the person building the kernel to figure out a
>safe size (and if this were possible, it's be better to handle this
>automatically).
>
>If the stack size is too small in some configurations I think we need to
>ensure that it is appropriately sized regardless of whether the person
>building the kernel believes they can identify a reasonable size.

Motivation behind these changes is saving memory on our system. 
Our system runs around 2500 threads concurrently so saving 4Kb  
might help us in saving 10MB memory.

To ensure 12KB is sufficient for our system we have used stack tracing and 
realised maximum stack used is not more than 9KB. 
 /sys/kernel/tracing/stack_max_size

Tracing interface defined by kernel to track maximum stack size can be used
by others to decide appropriate stack size.

>> Thus adding support for PAGE_SIZE(not power of 2) stacks for arm64.
>> User can decide any value 12KB, 16KB, 20 KB etc. based on value
>> of THREAD_SHIFT. User can set any value which is PAGE_SIZE aligned for
>> PAGE_ALIGNED_STACK_SIZE config.
>> 
>> Value of THREAD_SIZE is defined as 12KB for now, since with irq stacks
>> it is enough and it will save 4KB per thread.
>
>How are you certain of this?

Prev ARM64 uses 16KB stack size to store IRQ stack and thread on the same kernel stack.
Now since these are stored seperately so maximum kernel stack requirement is also reduced. 
ARM still uses 8KB stack to store both SVC and IRQ mode stack. So ARM64 shouldn't
have requirement more than double when compared to ARM. 
So considering these points we realised 12KB stack might be sufficient
for our system. Analyzing stack using stack tracer confirmed max stack requirement.

This is still configurable, if some system has higher stack requirement then user can 
go with 16KB but there should be option to change it.

 
Regards,
Vaneet Narang
