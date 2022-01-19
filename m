Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50672493CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350310AbiASPTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 10:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346289AbiASPTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642605560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2Kx/KmSGjwFhe88nJ+Zwktzmmd9oPiPrRk8BrjbT0k=;
        b=CsFeeIoW6OsABLBjIq+wugJ3RPQjr9KS5vB/cb/j3SL+/HtlOvdxACC33Bl4bn1j3o2R6B
        aMbPI+/9IgtBRjPZEhfBzbiYaaFn/3mXuZ5kAwpjjDlHfqe7iiFBED9VG7+X8np5k1GPob
        yBY9uhqg0FB6Fo5pcrGUEgs++wwfktY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-wQa9HSTpPD2Ww-Ik8qJ2qg-1; Wed, 19 Jan 2022 10:19:19 -0500
X-MC-Unique: wQa9HSTpPD2Ww-Ik8qJ2qg-1
Received: by mail-ed1-f71.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so2798690edc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 07:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=N2Kx/KmSGjwFhe88nJ+Zwktzmmd9oPiPrRk8BrjbT0k=;
        b=ZuMsCP3204D0h2UnBTbmRrlsa0SB5nRjmiqxfK64LKRG5/AAco+sIrtvSokUf2GMcB
         zwWAjISw9GFBcuBKgUg1nGBiG2IKr+o9ndAycKuYClNordgSUNFeBkmWenjAFdduUMNb
         EhPVgjLz6YmgNug8l4GlmFlHI1N93d+r5f/37xoHZk72e4iAn6sRIOJ115P2xSwTwh6d
         eTLdvyiVLb42JFUNnMiX9F41CzeoZBY1oQyJ9gCBq5f2VFdm8AsrFviX6r9TP41LKltl
         6jRdeop3SfmL8qw793Iu4d1KQ9kzc8CE5jXCmPyNW54Ei5Cc6TgobGzb0+dXmf3K6aY3
         zsKA==
X-Gm-Message-State: AOAM5314zoODILJbhhbyrvHqewywTGyo2gH7Y7Sn85Jhnccqf26/ETnf
        MQAT+86QdSpjWJeTRvHp8v1qP0mPGHnBpJoL7GFOp8NnoWeYnm53xQmBKQdL5iwnzLWHBPh7rE/
        uguCXzjpkKmfVl5nQhOAYwtgTIA==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr8245393edb.271.1642605557938;
        Wed, 19 Jan 2022 07:19:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwEg/siCN/Fuz2RHHae7nJJb1hw18MrJypanl3R30CSy8Wu4eUatazRDYz27Q4bdB8Qssimg==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr8245380edb.271.1642605557772;
        Wed, 19 Jan 2022 07:19:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:fb00:c6c0:1fe6:bfa1:e868? (p200300cbc705fb00c6c01fe6bfa1e868.dip0.t-ipconnect.de. [2003:cb:c705:fb00:c6c0:1fe6:bfa1:e868])
        by smtp.gmail.com with ESMTPSA id rv9sm9351ejb.216.2022.01.19.07.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 07:19:17 -0800 (PST)
Message-ID: <035dc6b1-28cb-0563-c712-bf57ebbc91e8@redhat.com>
Date:   Wed, 19 Jan 2022 16:19:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1] proc/vmcore: fix false positive lockdep warning
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220119113702.102567-1-david@redhat.com>
 <YegpdRBSrkVBrwk3@boqun-archlinux>
 <ec19d477-a75c-1e5a-1c02-f62c8565f48d@redhat.com>
Organization: Red Hat
In-Reply-To: <ec19d477-a75c-1e5a-1c02-f62c8565f48d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.01.22 16:15, David Hildenbrand wrote:
> On 19.01.22 16:08, Boqun Feng wrote:
>> Hi,
>>
>> On Wed, Jan 19, 2022 at 12:37:02PM +0100, David Hildenbrand wrote:
>>> Lockdep complains that we do during mmap of the vmcore:
>>> 	down_write(mmap_lock);
>>> 	down_read(vmcore_cb_rwsem);
>>> And during read of the vmcore:
>>> 	down_read(vmcore_cb_rwsem);
>>> 	down_read(mmap_lock);
>>>
>>> We cannot possibly deadlock when only taking vmcore_cb_rwsem in read
>>> mode, however, it's hard to teach that to lockdep.
>>>
>>
>> Lockdep warned about the above sequences because rw_semaphore is a fair
>> read-write lock, and the following can cause a deadlock:
>>
>> 	TASK 1			TASK 2		TASK 3
>> 	======			======		======
>> 	down_write(mmap_lock);
>> 				down_read(vmcore_cb_rwsem)
>> 						down_write(vmcore_cb_rwsem); // blocked
>> 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
>> 				down_read(mmap_lock); // blocked
>> 	
>> IOW, a reader can block another read if there is a writer queued by the
>> second reader and the lock is fair.
>>
>> So there is a deadlock possiblity.
> 
> Task 3 will never take the mmap_lock before doing a
> down_write(vmcore_cb_rwsem).
> 
> How would this happen?

Ah, I get it, nevermind. I'll adjust the patch description.

Thanks!

-- 
Thanks,

David / dhildenb

