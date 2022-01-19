Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6471E493CC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355472AbiASPPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 10:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355331AbiASPPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642605320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhiyyGkhKIQBD9y1CvQ+4U+Kmf7dcrXMU0CgM1XnnpI=;
        b=U/wPP1qdQMqjjLS+J3Y+X+16vU5Cppbos9k2Z3sRqHMg35Uy2eRHSQSr/7dhKKpHytrSu7
        w9f/xuHTn51vEOBRYYq5mjO3qjGsmDrtpTXkKWauilwMdEBTfwuXdbTcM+C1I7BA+c6lRj
        HlTv2XLDWGwXlPiExAXegxyvvnAmQB4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-PBp57vk2PMOfxNR72w9bKg-1; Wed, 19 Jan 2022 10:15:19 -0500
X-MC-Unique: PBp57vk2PMOfxNR72w9bKg-1
Received: by mail-ed1-f70.google.com with SMTP id t11-20020aa7d70b000000b004017521782dso2757050edq.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 07:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VhiyyGkhKIQBD9y1CvQ+4U+Kmf7dcrXMU0CgM1XnnpI=;
        b=tPkizG/urjLJq3B7FiTWNh+tNKodDc20IkaCij2DeAuq9kHX7ks4QJ2AI0SjelaKEN
         bGZTIQuhMclF1HeSL6ll3jDNk9ph+ie5KMj8DeqwKTrmewNwtJvG9DDHjU+JhyuHhVMb
         AKcOCv0g0CKat3Z/LTiZlf/uhyTXR2kx98yd74CfM5xlgfBo5x6J5ydX5YU6r8ohnPpH
         duLG+5m4/e0M7u7Wh+CFyKH8z9yvOOpmHsisq+GoNApIhSkLKZ0yHA4aeu+Z/09Cie0N
         j71q/+TrB7noIySGd3ZuorFqqmZhVIoWIOFHc9AQXpYQTLl5nkGurEg54auWPWWVI8mq
         Nuug==
X-Gm-Message-State: AOAM530Rh/wYdfnoOSnBJYRcazCZDVApuDwvoCJ3pZUtMgqkpOOOi0DS
        NWI/FpAAEQ27wIXYPuoV8S8PLcy3vYACgSCaPa+rbuMqG2XnLC9Cz7dDuzcaVx+XfBuuxcZw5Oi
        0NorwJrC7Iz+3uZw1Um472f2lZg==
X-Received: by 2002:a05:6402:22cb:: with SMTP id dm11mr368404edb.375.1642605318291;
        Wed, 19 Jan 2022 07:15:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQZPjexJYBmnBwPzHL0GlxJX389hy6WmeWAsZPKQQv3SHfkBwtwlUfjT/aKiBMYeyF3B3VNw==
X-Received: by 2002:a05:6402:22cb:: with SMTP id dm11mr368379edb.375.1642605318104;
        Wed, 19 Jan 2022 07:15:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:fb00:c6c0:1fe6:bfa1:e868? (p200300cbc705fb00c6c01fe6bfa1e868.dip0.t-ipconnect.de. [2003:cb:c705:fb00:c6c0:1fe6:bfa1:e868])
        by smtp.gmail.com with ESMTPSA id a27sm21089edj.17.2022.01.19.07.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 07:15:17 -0800 (PST)
Message-ID: <ec19d477-a75c-1e5a-1c02-f62c8565f48d@redhat.com>
Date:   Wed, 19 Jan 2022 16:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1] proc/vmcore: fix false positive lockdep warning
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YegpdRBSrkVBrwk3@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.01.22 16:08, Boqun Feng wrote:
> Hi,
> 
> On Wed, Jan 19, 2022 at 12:37:02PM +0100, David Hildenbrand wrote:
>> Lockdep complains that we do during mmap of the vmcore:
>> 	down_write(mmap_lock);
>> 	down_read(vmcore_cb_rwsem);
>> And during read of the vmcore:
>> 	down_read(vmcore_cb_rwsem);
>> 	down_read(mmap_lock);
>>
>> We cannot possibly deadlock when only taking vmcore_cb_rwsem in read
>> mode, however, it's hard to teach that to lockdep.
>>
> 
> Lockdep warned about the above sequences because rw_semaphore is a fair
> read-write lock, and the following can cause a deadlock:
> 
> 	TASK 1			TASK 2		TASK 3
> 	======			======		======
> 	down_write(mmap_lock);
> 				down_read(vmcore_cb_rwsem)
> 						down_write(vmcore_cb_rwsem); // blocked
> 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
> 				down_read(mmap_lock); // blocked
> 	
> IOW, a reader can block another read if there is a writer queued by the
> second reader and the lock is fair.
> 
> So there is a deadlock possiblity.

Task 3 will never take the mmap_lock before doing a
down_write(vmcore_cb_rwsem).

How would this happen?


-- 
Thanks,

David / dhildenb

