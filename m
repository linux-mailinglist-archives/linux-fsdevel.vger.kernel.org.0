Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1A300FF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 23:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbhAVW1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 17:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbhAVTxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:53:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF60C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 11:53:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so6187014wrt.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PoUmh0Zl4Lb/uiEcNMHSPKB/LP5kBHU4jtL2CNFSwg0=;
        b=Edv6LgmbQVxdfoYI4iSF5u5Zu1luRTcHIoKh+PkgJyW3e75qA0YgQxa2mtpt0oXyrB
         rk028dil8ZU4RT2qmFI6yyzYzSY/Dn+wbycdNJLpbLK5kRivbnd3cyTFHq+X2MwvAiL6
         Ip5DTRHUaHOSriYo9VaWAB8d3/qH+AGQzr3zRCF3VAB5HKzw6U1bK+xjSK4+FAztvd53
         Tw1nhSn3hYHfGXup7hzP2A2cr08hXlqM87aWrL1nqF0F05TGK+Cqx8n414NzxaF1tIYN
         8qIlabiR7ljBHs6Scll61MPzSqXCwJx6iF9N5nHiqnw4U9kZkfi9VtDfX1dmr2IvlAeQ
         LKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PoUmh0Zl4Lb/uiEcNMHSPKB/LP5kBHU4jtL2CNFSwg0=;
        b=V/sk13ESAIOj9uQLHPKNr7m6aCccsQoXl4wXBpwpEbCva8/+muVrhg1TuNCBevgzUo
         gi4EYjXGOnyBtTZZoWzm7ASTVTNttFJAcetTbCuHAXO55H6/40qoO9AdyydDgBSHSbjE
         GswnhHJ7HLiEYDkcRrBS9FFwyhGAX13ksfr2vbPAp/XpqOM5sc1wjWHSVbW1JVM+27pZ
         63bHDuu2uePvxjPJB2h5k4rq+Jk4qC+pnqbSR6vA4EOjJVu88LlwmOdgW1VR79PBDy6q
         sYboELmcEif4wZTMdt40hyaq9hd+v6TXdNpzPYa+XeM+I0qAMGkY+wCj3f7bkrv2BgKY
         A41A==
X-Gm-Message-State: AOAM5305HeB2aHmCsmC3Tev45BR9wCdIF3Yac+4chBZx+41NBEgtEL+j
        lGz1ovvYwXLXbOmeVdJGTG8k2w==
X-Google-Smtp-Source: ABdhPJxMgUW7s07FwzLU3EyePjayZSFS+FWRLnpef3DwMsKkS7JflDGbeSTF677fq/i3IA8hi3MSJg==
X-Received: by 2002:a05:6000:1d0:: with SMTP id t16mr6094745wrx.203.1611345179578;
        Fri, 22 Jan 2021 11:52:59 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d3sm6023321wrp.79.2021.01.22.11.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 11:52:58 -0800 (PST)
Subject: Re: [PATCH 6/6] mm: Forbid splitting special mappings
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20201013013416.390574-1-dima@arista.com>
 <20201013013416.390574-7-dima@arista.com>
 <20210122125858.GC24102@willie-the-truck>
 <20210122130003.GD24102@willie-the-truck>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <6afa94d4-40d9-3a34-381d-f14d07338628@arista.com>
Date:   Fri, 22 Jan 2021 19:52:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122130003.GD24102@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:00 PM, Will Deacon wrote:
> On Fri, Jan 22, 2021 at 12:58:58PM +0000, Will Deacon wrote:
>> On Tue, Oct 13, 2020 at 02:34:16AM +0100, Dmitry Safonov wrote:
>>> Don't allow splitting of vm_special_mapping's.
>>> It affects vdso/vvar areas. Uprobes have only one page in xol_area so
>>> they aren't affected.
>>>
>>> Those restrictions were enforced by checks in .mremap() callbacks.
>>> Restrict resizing with generic .split() callback.
>>>
>>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>>> ---
>>>  arch/arm/kernel/vdso.c    |  9 ---------
>>>  arch/arm64/kernel/vdso.c  | 41 +++------------------------------------
>>>  arch/mips/vdso/genvdso.c  |  4 ----
>>>  arch/s390/kernel/vdso.c   | 11 +----------
>>>  arch/x86/entry/vdso/vma.c | 17 ----------------
>>>  mm/mmap.c                 | 12 ++++++++++++
>>>  6 files changed, 16 insertions(+), 78 deletions(-)
>>
>> For arm64:
>>
>> Acked-by: Will Deacon <will@kernel.org>
> 
> Wait -- this got merged ages ago! Why am I reading such old email?

It's alright, thanks for looking at this again!

-- 
          Dmitry
