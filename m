Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D684590C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhKVPDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbhKVPDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:03:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8B0C06175A;
        Mon, 22 Nov 2021 07:00:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so78299424edc.6;
        Mon, 22 Nov 2021 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dd2xl/UAkYn51WmVZ2VSCh8BeesXpSLDPTwNcY7Z73o=;
        b=gkbgbtTE+CezDs8TOZ+JQjqb1dVmpeks6KubnBKiSXOqGxn7KOTsX8t5+242eVev2Q
         jugeKfyhk1jJTll9KPXA2LMq/exNtR5n6p1HjzwnlkWxbnlW5wbUy1zIxKyF7y4SNxeB
         XC/gIZun0oFX4Ej/dGHWngs4g/eTHgIav5ZruuiHXvl3hWfe85LIRNvOojfbwzYuGHqz
         bd6bl7YlgzpV5J2Kz9X1S4zcbyyNANVbJKTZr46sktN2Pq4Dds0Cz8+VZ9lcbcbEXFDl
         7oJWG8t8D2BZY6zzwB/2zfayZeNdZgk4mc0ewg+YKPCBdRv6Ip5ri6Os0B2c2uotS6FS
         lbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dd2xl/UAkYn51WmVZ2VSCh8BeesXpSLDPTwNcY7Z73o=;
        b=7WfFvDillw9K1UGQ4psodAlt0Gy7Y+6ZE1WUwyc2kIzePvTC1dreTE3vnS98ZE0Tgv
         FnkQpA1DKgHuY22JdHUsxZE+cPkuIewyOYvEgbtgPPAC+5839eZkUWjr2o9bS+2e8jID
         uhvKrU92qteMQ1myR37EB/czMBPUsCFhNHgh859hDERpkHYOzlFYu7xa/7uBKAQRsE7o
         54VANEXbOagzXc9WlEMjpFL4Km8t2usQ6tBONqrdexJXhEOISH4c4Zue2sv6iTWX0YSH
         GmFYPqIBlWBbSTsJr44qxE/VLyCjCqAGYNfgAgae6J71TqiJr8W6Nnlh19zSUtkptig8
         kZRA==
X-Gm-Message-State: AOAM532ReO9GWQbeWqXPy2HicUuascMq4/r9LpZiMhuno+geOYwWtku5
        E+ueF9q1cJHU8djWdWJmm1c=
X-Google-Smtp-Source: ABdhPJwjGQ/ioew2oywVvtOA+TOt9CLYfuLAtK78l/ffxgr8D34KnzE4Qv373SSMjd8Xu97X4CfiHQ==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr66720388edb.12.1637593229048;
        Mon, 22 Nov 2021 07:00:29 -0800 (PST)
Received: from [192.168.1.6] ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id hq37sm3978859ejc.116.2021.11.22.07.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 07:00:28 -0800 (PST)
Message-ID: <e94c2ba9-226b-8275-bef7-28e854be3ffa@gmail.com>
Date:   Mon, 22 Nov 2021 17:00:25 +0200
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
 <ba0f624c-fc24-a3f4-749a-00e419960de2@gmail.com>
 <4d2b08aa854fcccd51247105edb18fe466a2a3f1.camel@HansenPartnership.com>
From:   Yordan Karadzhov <y.karadz@gmail.com>
In-Reply-To: <4d2b08aa854fcccd51247105edb18fe466a2a3f1.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 22.11.21 г. 15:44 ч., James Bottomley wrote:
> Well, no, the information may not all exist.  However, the point is we
> can add it without adding additional namespace objects.
> 
>> Let's look the following case (oversimplified just to get the idea):
>> 1. The process X is a parent of the process Y and both are in
>> namespace 'A'.
>> 3. "unshare" is used to place process Y (and all its child processes)
>> in a new namespace B (A is a parent namespace of B).
>> 4. "setns" is s used to move process X in namespace C.
>>
>> How would you find the parent namespace of B?
> Actually this one's quite easy: the parent of X in your setup still has
> it.

Hmm, Isn't that true only if somehow we know that (3) happened before (4).

> However, I think you're looking to set up a scenario where the
> namespace information isn't carried by live processes and that's
> certainly possible if we unshare the namespace, bind it to a mount
> point and exit the process that unshared it.  If will exist as a bound
> namespace with no processes until it gets entered via the binding and
> when that happens the parent information can't be deduced from the
> process tree.
> 
> There's another problem, that I think you don't care about but someone
> will at some point: the owning user_ns can't be deduced from the
> current tree either because it depends on the order of entry.  We fixed
> unshare so that if you enter multiple namespaces, it enters the user_ns
> first so the latter is always the owning namespace, but if you enter
> the rest of the namespaces first via one unshare then unshare the
> user_ns second, that won't be true.
> 
> Neither of the above actually matter for docker like containers because
> that's not the way the orchestration system works (it doesn't use mount
> bindings or the user_ns) but one day, hopefully, it might.
> 
>> Again, using your arguments, I can reformulate the problem statement
>> this way: a userspace program is well instrumented
>> to create an arbitrary complex tree of namespaces. In the same time,
>> the only place where the information about the
>> created structure can be retrieved is in the userspace program
>> itself. And when we have multiple userspace programs
>> adding to the namespaces tree, the global picture gets impossible to
>> recover.
> So figure out what's missing in the /proc tree and propose adding it.
> The interface isn't immutable it's just that what exists today is an
> ABI and can't be altered.  I think this is the last time we realised we
> needed to add missing information in/proc/<pid>/ns:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eaa0d190bfe1ed891b814a52712dcd852554cb08
> 
> So you can use that as the pattern.
> 

OK, if everybody agrees that adding extra information to /proc is the right way to go, we will be happy to try 
developing another PoC that implements this approach.

Thank you very much for all your help!
Yordan

> James
> 
> 
