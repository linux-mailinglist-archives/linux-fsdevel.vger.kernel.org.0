Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38A458EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKVNGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 08:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhKVNGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:06:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7137BC061574;
        Mon, 22 Nov 2021 05:03:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so76564349edb.8;
        Mon, 22 Nov 2021 05:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LbGEf5GHWoQZD/8TVHybOWntAXf/J1wPL0Oe7Sj6fwM=;
        b=U6XCs3aFRlpIjALmouQ+c7S8ArTehkXiU43ifOrfsioV2zpCSd//zElj+rd3MDIJgm
         EieTIoe3u8Or/XPF0IenuYZQTREbw4MvyyKVCHe5W9pTW07q/BAOtX8p74GygTb0zvl+
         nTkdFfGYm8Akrcu6RWnpak3GpqAvb07UI1VWYgoyAoLqlLYLwNqFLf5+GMZC3xBOGotG
         3ZVX+Z4iZD3qOXal/oaVSVdbuIUFRAOu+Y0CYuoP6vfYZSsWjKwSkSu3IWmYD1fq1LaL
         VNBD8BvnIIBFmW3sfO437TPc0+ruZjX717bGtUEeKfSITMYADBz5ngTGpVAdfBgWQ6Fo
         UApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LbGEf5GHWoQZD/8TVHybOWntAXf/J1wPL0Oe7Sj6fwM=;
        b=ojik9nkhRPHqOJ81sbOK+Har8xgpOfgaqrbbrpN/SQRwcZ4wVBB5FfZcju0fWLnbGE
         UK/qD3dtf48UC+CwNA0aShgu9t49qYhlhUSbImSpMIHldLZfA2B7t3csE9ESmVjcsnkH
         sCD17OPIiL2urrKv/XKyBpLvV4INtB1qhZIhQYFKuJwfQi+8HidR7dJ8vYrYfVu6rSY3
         gSBnTF6S5NZDcSiWkM96FDrJnbE4/H4h1K74xsJK7RWGTqvTIypSBvvOP3khnOeDiLrO
         3BK62i2fDAQ+S7wqIgwtRj9KypF3K6zWL3cQt7Awy+WIn6e8dFPYDHJtV3Pf9u278MkK
         zvpg==
X-Gm-Message-State: AOAM532SFmA3DJU+2z3e4jx6ji76l1wsVR4EsYahvDKO+aPVNUC/YyrT
        cK+evEXK8geobdfVx/6RwPbCPtyBYME=
X-Google-Smtp-Source: ABdhPJwmMidLN3aGkqPZBTcqXv4vkWR34Umsi4cVNV0voEd9ZwdJUYi/W/kTYqJXpBb6vzofFn20bA==
X-Received: by 2002:a17:907:90c3:: with SMTP id gk3mr40636348ejb.282.1637586179479;
        Mon, 22 Nov 2021 05:02:59 -0800 (PST)
Received: from [192.168.1.6] ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id l18sm3688076ejo.114.2021.11.22.05.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 05:02:58 -0800 (PST)
Message-ID: <ba0f624c-fc24-a3f4-749a-00e419960de2@gmail.com>
Date:   Mon, 22 Nov 2021 15:02:56 +0200
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
 <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
 <20211119114736.5d9dcf6c@gandalf.local.home>
 <20211119114910.177c80d6@gandalf.local.home>
 <cc6783315193be5acb0e2e478e2827d1ad76ba2a.camel@HansenPartnership.com>
From:   Yordan Karadzhov <y.karadz@gmail.com>
In-Reply-To: <cc6783315193be5acb0e2e478e2827d1ad76ba2a.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 20.11.21 г. 1:08 ч., James Bottomley wrote:
> [trying to reconstruct cc list, since the cc: field is bust again]
>> On Fri, 19 Nov 2021 11:47:36 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>>> Can we back up and ask what problem you're trying to solve before
>>>> we start introducing new objects like namespace name?
>>
>> TL;DR; verison:
>>
>> We want to be able to install a container on a machine that will let
>> us view all namespaces currently defined on that machine and which
>> tasks are associated with them.
>>
>> That's basically it.
> 
> So you mentioned kubernetes.  Have you tried
> 
> kubectl get pods --all-namespaces
> 
> ?
> 
> The point is that orchestration systems usually have interfaces to get
> this information, even if the kernel doesn't.  In fact, userspace is
> almost certainly the best place to construct this from.
> 
> To look at this another way, what if you were simply proposing the
> exact same thing but for the process tree.  The push back would be that
> we can get that all in userspace and there's even a nice tool (pstree)
> to do it which simply walks the /proc interface.  Why, then, do we have
> to do nstree in the kernel when we can get all the information in
> exactly the same way (walking the process tree)?
> 


I see on important difference between the problem we have and the problem in your example. /proc contains all the 
information needed to unambiguously reconstruct the process tree.

On the other hand, I do not see how one can reconstruct the namespace tree using only the information in proc/ (maybe 
this is because of my ignorance).

Let's look the following case (oversimplified just to get the idea):
1. The process X is a parent of the process Y and both are in namespace 'A'.
3. "unshare" is used to place process Y (and all its child processes) in a new namespace B (A is a parent namespace of B).
4. "setns" is s used to move process X in namespace C.

How would you find the parent namespace of B?

Again, using your arguments, I can reformulate the problem statement this way: a userspace program is well instrumented 
to create an arbitrary complex tree of namespaces. In the same time, the only place where the information about the 
created structure can be retrieved is in the userspace program itself. And when we have multiple userspace programs 
adding to the namespaces tree, the global picture gets impossible to recover.

Thanks!
Yordan


> James
> 
> 
> 
