Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33055243B40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMOKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:10:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29746 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgHMOKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597327829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUbuth9YsAKh0CAOKDQ5MQczPX5161xmlduVV3vT8TM=;
        b=SxESRVCU3YHs3aVZ1Iu32VmWG4k+OAXQRUwmop3bZEd9nniv5W0UAAuF7z6konKdheJzI/
        FB14lwiCfz5ibr1BKpzAsQPU8OfmEgjJkvF+gfJo8pPdv3OoPuAKX68Y20cjRCSWfwKhiy
        9dvQwpSpo5fEJv4XpY43iSJMbnHbdkA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-PBHEkx_6PqSm9t9V6NYO9g-1; Thu, 13 Aug 2020 10:10:28 -0400
X-MC-Unique: PBHEkx_6PqSm9t9V6NYO9g-1
Received: by mail-wr1-f69.google.com with SMTP id b13so2142243wrq.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 07:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rUbuth9YsAKh0CAOKDQ5MQczPX5161xmlduVV3vT8TM=;
        b=a8YlT/LCeMo0Cz0FhoYtzUN8pRkCKJOdWx5HAfHYTHZU1klOxsojQbv6v9HgN3DrE5
         ps9VFizq6aWzlyBJJBDGqCXpYPCZ0b2u6oDT3cALWiXVXIZgqcvEikkEZBBhAJAmFLyz
         pDjrip6ePwjqpL/7c0kM7BPVN2Wb3NN5JePUtkGDQbjmGm/5C7c4ilpfJ1c03OVw54Kv
         /nSVkSoEVi7t8DjfSX4tjLufqGXzRYrbYEVgBsjnOfL/gC0qiDg6MTtSgArazY1DWgJQ
         C1mPe4K/tGUsvMjaL3BbCgHhuE5D1TiBNbZRxxQBSAs/epaYe0V/sqDU60LcjapfC7Gn
         9mJg==
X-Gm-Message-State: AOAM531jexKNi5EYX4kYBBR2jWFkMWHBFKc/5nGxb0NjHhqPfO7SWNhw
        nFHyqboknXtf9k23Nwt9iuHsIJw4AVheLNh0xZ88yvmyZXCuc3kKg9VQiv0pbHl84eZn6QoyVax
        U/ZJWr1TULXfQIYklvi+1EDx0eQ==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr4485461wma.176.1597327827022;
        Thu, 13 Aug 2020 07:10:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfcHDY8aqtPDjUrHw9QpQSceS/wlBCck79TPwzjfMd/JIYRTJ5uKRTxFiNJ91HMcVXAf4w7w==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr4485434wma.176.1597327826767;
        Thu, 13 Aug 2020 07:10:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51ad:9349:1ff0:923e? ([2001:b07:6468:f312:51ad:9349:1ff0:923e])
        by smtp.gmail.com with ESMTPSA id 32sm11176734wrh.18.2020.08.13.07.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:10:26 -0700 (PDT)
Subject: Re: [RFC PATCH 6/7] core/metricfs: expose x86-specific irq
 information through metricfs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Adams <jwadams@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>
References: <20200807212916.2883031-1-jwadams@google.com>
 <20200807212916.2883031-7-jwadams@google.com>
 <87mu2yluso.fsf@nanos.tec.linutronix.de>
 <2500b04e-a890-2621-2f19-be08dfe2e862@redhat.com>
 <87a6yylp4x.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ffeac3eb-fbd5-a605-c6a5-0456813bd918@redhat.com>
Date:   Thu, 13 Aug 2020 16:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87a6yylp4x.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/20 14:13, Thomas Gleixner wrote:
>>>> Add metricfs support for displaying percpu irq counters for x86.
>>>> The top directory is /sys/kernel/debug/metricfs/irq_x86.
>>>> Then there is a subdirectory for each x86-specific irq counter.
>>>> For example:
>>>>
>>>>    cat /sys/kernel/debug/metricfs/irq_x86/TLB/values
>>> What is 'TLB'? I'm not aware of any vector which is named TLB.
>> There's a "TLB" entry in /proc/interrupts.
> It's TLB shootdowns and not TLB.

Yes but it's using the shortcut name on the left of the table.

> +METRICFS_ITEM(LOC, apic_timer_irqs, "Local timer interrupts");
> +METRICFS_ITEM(SPU, irq_spurious_count, "Spurious interrupts");
> +METRICFS_ITEM(PMI, apic_perf_irqs, "Performance monitoring interrupts");
> +METRICFS_ITEM(IWI, apic_irq_work_irqs, "IRQ work interrupts");
> +METRICFS_ITEM(RTR, icr_read_retry_count, "APIC ICR read retries");
> +#endif
> +METRICFS_ITEM(PLT, x86_platform_ipis, "Platform interrupts");
> +#ifdef CONFIG_SMP
> +METRICFS_ITEM(RES, irq_resched_count, "Rescheduling interrupts");
> +METRICFS_ITEM(CAL, irq_call_count, "Function call interrupts");
> +METRICFS_ITEM(TLB, irq_tlb_count, "TLB shootdowns");

Paolo

