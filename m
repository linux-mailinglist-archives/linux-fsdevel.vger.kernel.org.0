Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3943457519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhKSRRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 12:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbhKSRRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:17:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72CC061574;
        Fri, 19 Nov 2021 09:14:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l25so29000713eda.11;
        Fri, 19 Nov 2021 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ppk5Ur926Wl1zsW78xKQiXfFmizk5OSKd1LTHAlPzfc=;
        b=O7HKx80qs7iP8E12DEl9ju7gU+4Gj5C513S3ksA10FAZo3zNHBYLKx82Ovy7Hw/p5s
         uyeRKz9JJhh+MujvX1e1zy8y3sPdugDuy0k7oGNQvIrPLgUUj7Xkg5C94GES+ZXKZbwN
         V1YTRujWhvmOwZSc/DWTtkGWm1S1awZkmWkOadi8jPhynPhQysLg8pYkx4hGPT3XMaqG
         h89jRpBa+3nCHzUDDv26nOehT1ScLVXlZDpENYqwnvYZx/RA5Z3gfagmcQjceQd7xRi4
         850nlAotgZvidmYcMligZfK25eJC/EoOQOGRwGrFtkW6zQ/erbb8wEMYZCNTKz/Z+/gf
         vSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ppk5Ur926Wl1zsW78xKQiXfFmizk5OSKd1LTHAlPzfc=;
        b=TVRUSNIv+lT9l/J24+cE9171Pd3UWvNPJChvkC0NfpnR/72FUWK7xEcapB+8Sid6Sg
         35sDkgzbO3ljq23zhACdIjNVsfR1diVubCG8lB0nMpYztJVJe+96HXlAiPYgbDBxw5+p
         qBY+4SHetvLF2YNWz3zS1MLvsNmi3xo0kgk1Z9DBtOmvGFpy1+HWp5GlqIuHJml9RsDT
         lqhlT1wE77XG09RbQ9Sso/2JLtkZhQoIe27D/t4Ql1Jhk69jMBPTSFUzkn2uhL/fpdw9
         Vur7b/5nqYRefLcxxLMlzXyVLoCuewTb28D7QIFM8/8uuT90yaD7/dbW0ymnKt7KGg9q
         Y7IQ==
X-Gm-Message-State: AOAM5321nDLkbTeBti/RiQ/bGxpOqfl5PAU/Q9bMqzpug9IhJHeXR7/y
        6xaEb3j5jwcmyxu8XcWhBNqo2aO7xOA=
X-Google-Smtp-Source: ABdhPJx8RWSeWg64f5VxNtwP7s7iZ7VRFjH/PC4syNpDKnB5180kY08RNI2jF5megzjos3iibG79aQ==
X-Received: by 2002:a17:906:314e:: with SMTP id e14mr9784238eje.165.1637342049917;
        Fri, 19 Nov 2021 09:14:09 -0800 (PST)
Received: from [192.168.1.6] ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id dy4sm180529edb.92.2021.11.19.09.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 09:14:09 -0800 (PST)
Message-ID: <de336e53-68e1-1d4b-7f71-e276b5363b7c@gmail.com>
Date:   Fri, 19 Nov 2021 19:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
 <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
 <20211118142440.31da20b3@gandalf.local.home>
 <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
 <20211119092758.1012073e@gandalf.local.home>
 <47bf8da26b5ec71f98b9bc736dbca2d8277417f2.camel@HansenPartnership.com>
From:   Yordan Karadzhov <y.karadz@gmail.com>
In-Reply-To: <47bf8da26b5ec71f98b9bc736dbca2d8277417f2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 19.11.21 г. 18:42 ч., James Bottomley wrote:
> [resend due to header mangling causing loss on the lists]
> On Fri, 2021-11-19 at 09:27 -0500, Steven Rostedt wrote:
>> On Fri, 19 Nov 2021 07:45:01 -0500
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>>
>>> On Thu, 2021-11-18 at 14:24 -0500, Steven Rostedt wrote:
>>>> On Thu, 18 Nov 2021 12:55:07 -0600
>>>> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>>>    
>>>>> It is not correct to use inode numbers as the actual names for
>>>>> namespaces.
>>>>>
>>>>> I can not see anything else you can possibly uses as names for
>>>>> namespaces.
>>>>
>>>> This is why we used inode numbers.
>>>>    
>>>>> To allow container migration between machines and similar
>>>>> things the you wind up needing a namespace for your names of
>>>>> namespaces.
>>>>
>>>> Is this why you say inode numbers are incorrect?
>>>
>>> The problem is you seem to have picked on one orchestration system
>>> without considering all the uses of namespaces and how this would
>>> impact them.  So let me explain why inode numbers are incorrect and
>>> it will possibly illuminate some of the cans of worms you're
>>> opening.
>>>
>>> We have a container checkpoint/restore system called CRIU that can
>>> be used to snapshot the state of a pid subtree and restore it.  It
>>> can be used for the entire system or piece of it.  It is also used
>>> by some orchestration systems to live migrate containers.  Any
>>> property of a container system that has meaning must be saved and
>>> restored by CRIU.
>>>
>>> The inode number is simply a semi random number assigned to the
>>> namespace.  it shows up in /proc/<pid>/ns but nowhere else and
>>> isn't used by anything.  When CRIU migrates or restores containers,
>>> all the namespaces that compose them get different inode values on
>>> the restore.  If you want to make the inode number equivalent to
>>> the container name, they'd have to restore to the previous number
>>> because you've made it a property of the namespace.  The way
>>> everything is set up now, that's just not possible and never will
>>> be.  Inode numbers are a 32 bit space and can't be globally
>>> unique.  If you want a container name, it will have to be something
>>> like a new UUID and that's the first problem you should tackle.
>>
>> So everyone seems to be all upset about using inode number. We could
>> do what Kirill suggested and just create some random UUID and use
>> that. We could have a file in the directory called inode that has the
>> inode number (as that's what both docker and podman use to identify
>> their containers, and it's nice to have something to map back to
>> them).
>>
>> On checkpoint restore, only the directories that represent the
>> container that migrated matter, so as Kirill said, make sure they get
>> the old UUID name, and expose that as the directory.
>>
>> If a container is looking at directories of other containers on the
>> system, then it gets migrated to another system, it should be treated
>> as though those directories were deleted under them.
>>
>> I still do not see what the issue is here.
> 
> The issue is you're introducing a new core property for namespaces they
> didn't have before.  Everyone has different use cases for containers
> and we need to make sure the new property works with all of them.
> 
> Having a "name" for a namespace has been discussed before which is the
> landmine you stepped on when you advocated using the inode number as
> the name, because that's already known to be unworkable.
> 
> Can we back up and ask what problem you're trying to solve before we
> start introducing new objects like namespace name?  The problem
> statement just seems to be "Being able to see the structure of the
> namespaces can be very useful in the context of the containerized
> workloads."  which you later expanded on as "trying to add more
> visibility into the working of things like kubernetes".  If you just
> want to see the namespace "tree" you can script that (as root) by
> matching the process tree and the /proc/<pid>/ns changes without
> actually needing to construct it in the kernel.  This can also be done
> without introducing the concept of a namespace name.  However, there is
> a subtlety of doing this matching in the way I described in that you
> don't get proper parenting to the user namespace ownership ... but that
> seems to be something you don't want anyway?
> 


The major motivation is to be able to hook tracing to individual containers. We want to be able to quickly discover the 
PIDs of all containers running on a system. And when we say all, we mean not only Docker, but really all sorts of 
containers that exist now or may exist in the future. We also considered the solution of brute-forcing all processes in 
/proc/*/ns/ but we are afraid that such solution do not scale. As I stated in the Cover letter, the problem was 
discussed at Plumbers (links at the bottom of the Cover letter) and the conclusion was that the most distinct feature 
that anything that can be called 'Container' must have is a separate PID namespace. This is why the PoC starts with the 
implementation of this namespace. You can see in the example script that discovering the name and all PIDs of all 
containers gets quick and trivial with the help of this new filesystem. And you need to add just few more lines of code 
in order to make it start tracing a selected container.

Thanks!
Yordan

> James
> 
> 
> 
