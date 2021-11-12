Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0244E2F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhKLIbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 03:31:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230464AbhKLIbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636705692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMC8qd8+7Ca3YzZrzMvAHcyUG/VYuDrlF+fpPBuOn/k=;
        b=BSKYBrihtfLciAohXUI22PJW/0oD+URIL075irffkSf0uSpj2ol5pzvmIb936BQvB5BB2c
        fkiCVIdGQc2bmfjA9U0BcZ6WCcRh86cskdDirJfMtzIPe3vlASQ3pn6Z8t6Y4kDWgCfBVI
        Q1TYf2/a9pZF2GrdB3cTz3alOuJr3Fs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-JKgx06c4OwSo_xKUBq2W5Q-1; Fri, 12 Nov 2021 03:28:11 -0500
X-MC-Unique: JKgx06c4OwSo_xKUBq2W5Q-1
Received: by mail-wm1-f70.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso3948127wmc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 00:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=MMC8qd8+7Ca3YzZrzMvAHcyUG/VYuDrlF+fpPBuOn/k=;
        b=QC7snsDs0TOhJbjhhKv0OpMerjhEps6/i0265dt/WPAhu0iL/I/t/h7VuTmNy61pE8
         D+VShw7agFuZhYIq7vAPjZhKDJzk/rZdP+iP1uwgyYSfWJIe1Enom6J9kng4U1MiUZqT
         lz0Ux2NZKuX98XPk5LVgK7492UyB9QIdCqTMFHeKzepnsTRjyu9VPv3oMzPhllbYOqy4
         ZNNB2MZgqVAiRADGwlmmVpK04Pl0ONy32WvrA0xVMiEzthkE18PjkX4Cxd4l6vg2VcGz
         qff1ZQ76aamHTEo2evCHlKO1JeSIihQe5TBUSDPmFMWTo8sr4zYNU/LTusz3mpiKTle+
         euAw==
X-Gm-Message-State: AOAM532RBxwq4meRfVUaE/NwD+e3hVt5Xq68KcAAJ4DRN6bBVTB36oSX
        iC06g7GLsY0m+EfPNbDlUCuy4tL5JuQOeojuZKDksgQk3PoylXbiaplfeSLRc2Wi6BBlcMjM5Qc
        7WIYp1J68tuKv0yTZfem1U1pTBQ==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr15121525wmq.175.1636705690193;
        Fri, 12 Nov 2021 00:28:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwH8UrEY9r4Zje19aA2qqBcbz8L5l097Cntjyi4QFVNg8xl1fM/LhGyVqNJE+EScdUvyPHnHw==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr15121486wmq.175.1636705689955;
        Fri, 12 Nov 2021 00:28:09 -0800 (PST)
Received: from [192.168.3.132] (p4ff23f5f.dip0.t-ipconnect.de. [79.242.63.95])
        by smtp.gmail.com with ESMTPSA id g5sm8146127wri.45.2021.11.12.00.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 00:28:09 -0800 (PST)
Message-ID: <d8cd422d-54aa-8695-6563-a98b8a61c280@redhat.com>
Date:   Fri, 12 Nov 2021 09:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20211111192243.22002-1-david@redhat.com>
 <20211112033028.GP27625@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] proc/vmcore: don't fake reading zeroes on surprise
 vmcore_cb unregistration
In-Reply-To: <20211112033028.GP27625@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.11.21 04:30, Baoquan He wrote:
> On 11/11/21 at 08:22pm, David Hildenbrand wrote:
>> In commit cc5f2704c934 ("proc/vmcore: convert oldmem_pfn_is_ram callback
>> to more generic vmcore callbacks"), we added detection of surprise
>> vmcore_cb unregistration after the vmcore was already opened. Once
>> detected, we warn the user and simulate reading zeroes from that point on
>> when accessing the vmcore.
>>
>> The basic reason was that unexpected unregistration, for example, by
>> manually unbinding a driver from a device after opening the
>> vmcore, is not supported and could result in reading oldmem the
>> vmcore_cb would have actually prohibited while registered. However,
>> something like that can similarly be trigger by a user that's really
>> looking for trouble simply by unbinding the relevant driver before opening
>> the vmcore -- or by disallowing loading the driver in the first place.
>> So it's actually of limited help.
> 
> Yes, this is the change what I would like to see in the original patch
> "proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore callbacks".
> I am happy with this patch appended to commit cc5f2704c934.

Good, thanks!

> 
>>
>> Currently, unregistration can only be triggered via virtio-mem when
>> manually unbinding the driver from the device inside the VM; there is no
>> way to trigger it from the hypervisor, as hypervisors don't allow for
>> unplugging virtio-mem devices -- ripping out system RAM from a VM without
>> coordination with the guest is usually not a good idea.
>>
>> The important part is that unbinding the driver and unregistering the
>> vmcore_cb while concurrently reading the vmcore won't crash the system,
>> and that is handled by the rwsem.
>>
>> To make the mechanism more future proof, let's remove the "read zero"
>> part, but leave the warning in place. For example, we could have a future
>> driver (like virtio-balloon) that will contact the hypervisor to figure out
>> if we already populated a page for a given PFN. Hotunplugging such a device
>> and consequently unregistering the vmcore_cb could be triggered from the
>> hypervisor without harming the system even while kdump is running. In that
> 
> I am a little confused, could you tell more about "contact the hypervisor to
> figure out if we already populated a page for a given PFN."? I think
> vmcore dumping relies on the eflcorehdr which is created beforehand, and
> relies on vmcore_cb registered in advance too, virtio-balloon could take
> another way to interact with kdump to make sure the dumpable ram?

This is essentially what the XEN callback does: check if a PFN is
actually populated in the hypervisor; if not, avoid reading it so we
won't be faulting+populating a fresh/zero page in the hypervisor just to
be able to dump it in the guest. But in the XEN world we usually simply
rely on straight hypercalls, not glued to actual devices that can get
hot(un)plugged.

Once you have some device that performs such checks instead that could
get hotunplugged and unregister the vmcore_cb (and virtio-balloon is
just one example), you would be able to trigger this.

As we're dealing with a moving target (hypervisor will populate pages as
necessary once the old kernel accesses them), there isn't really a way
to adjust this in the old kernel -- where we build the eflcorehdr. We
could try to adjust the elfcorehdr in the new kernel, but that certainly
opens up another can of worms.

But again, this is just an example to back the "future proof" claim
because Dave was explicitly concerned about this situation.

-- 
Thanks,

David / dhildenb

