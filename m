Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2C45709C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 15:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhKSO3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhKSO3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:29:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC48C061574;
        Fri, 19 Nov 2021 06:26:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v1so10054054edx.2;
        Fri, 19 Nov 2021 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NFE0LMqy6rnH3GGdUb3C1I3IPgyszFGdbTI0C5bvQow=;
        b=FhmoHDnEbtFKj0inh7p/00rj06peGT9vcTvet0Im+BoGJ4VBo4WOG7By84D/8JRTia
         /bcTjMHYIV37fOV5wBwVcYrX6T2aXgZOWh8gBXF59mfghmMG0mX/TnQUDHzI0QRiS+hP
         WTVMP0dTUdUpAPJsTSXRmpJsFQsLu7Ckyub2srWnTodcs3qcvrxope+Gj/q8urfRSIRX
         ECT7mXHFCjHxXY6C30Ys315PuHUWuc1o+i1FXKUw3Z7A/jo/iq1bmJIdwOMG1NyUNnmR
         AOIm39C+psx9W8CacyQKZkC4kfpe+tB4xxsO4xW5RKoRzftb+IBaHjBE+qFRbsS02zLt
         S1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NFE0LMqy6rnH3GGdUb3C1I3IPgyszFGdbTI0C5bvQow=;
        b=NURADy2endGL3IrAd/CzQVZecUeDViw0a6RDK0F4j5/9TyALdKYF/jG9ScOwC1bjbk
         yM1b3Ib/oVZY9N2COOgdBBFL5Bv5KfSecDJThuFv2fFpzLq+3mOpa3I0KK9X4BnNg2ec
         HyYiZ9mc6SxLOPYLkJZtDVHPkihKdReNxK2+TsJuNchNDMytEdLME5UxqJVOnbg+7ls1
         VrihmRf8oYpUClkjDLvGHkHIelZGPcZl0pb9C4X8VqHbZXPM4QgWgEJeRDXXcxa+R2vk
         foGvMljrBY9/48SdtLnQ1ynqPvEs4tJurbJXZIwQG3GMr4ejtp0lLd63KiL8HNICFwhR
         XvNw==
X-Gm-Message-State: AOAM531EABquYuWR5I7ErUDPncNP8aDD2zBfyF1MOeYkDWomEvwAZuai
        NGN23AYYzQvbE2VCOYEiL0w=
X-Google-Smtp-Source: ABdhPJy6xhIdXVP5Uwc7Ce5MRoo5VgJmKhMjOyCqhARaKRLQ2a+Lql9DOUq+rFaarH9zIrxu/4viQA==
X-Received: by 2002:a17:906:3ec6:: with SMTP id d6mr8285031ejj.300.1637331974780;
        Fri, 19 Nov 2021 06:26:14 -0800 (PST)
Received: from [192.168.1.6] ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id b11sm1675832ede.62.2021.11.19.06.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 06:26:14 -0800 (PST)
Message-ID: <1613eb28-f5d2-6ede-b0a1-f48c5ce240fc@gmail.com>
Date:   Fri, 19 Nov 2021 16:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        hagen@jauu.net, rppt@kernel.org,
        James.Bottomley@HansenPartnership.com, akpm@linux-foundation.org,
        vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
References: <20211118181210.281359-1-y.karadz@gmail.com>
 <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
From:   Yordan Karadzhov <y.karadz@gmail.com>
In-Reply-To: <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Eric,

Thank you very much for pointing out all the weaknesses of this Proof-of-Concept!

I tried to make it clear in the Cover letter that this is nothing more than a PoC. It is OK that you are giving it a 
'Nacked-by'. We never had an expectation that this particular version of the code can be merged. Nevertheless, we hope 
to receive constructive guidance on how to improve. I will try to comment on your arguments below.

On 18.11.21 г. 20:55 ч., Eric W. Biederman wrote:
> 
> Adding the containers mailing list which is for discussions like this.
> 
> "Yordan Karadzhov (VMware)" <y.karadz@gmail.com> writes:
> 
>> We introduce a simple read-only virtual filesystem that provides
>> direct mechanism for examining the existing hierarchy of namespaces
>> on the system. For the purposes of this PoC, we tried to keep the
>> implementation of the pseudo filesystem as simple as possible. Only
>> two namespace types (PID and UTS) are coupled to it for the moment.
>> Nevertheless, we do not expect having significant problems when
>> adding all other namespace types.
>>
>> When fully functional, 'namespacefs' will allow the user to see all
>> namespaces that are active on the system and to easily retrieve the
>> specific data, managed by each namespace. For example the PIDs of
>> all tasks enclosed in the individual PID namespaces. Any existing
>> namespace on the system will be represented by its corresponding
>> directory in namespacesfs. When a namespace is created a directory
>> will be added. When a namespace is destroyed, its corresponding
>> directory will be removed. The hierarchy of the directories will
>> follow the hierarchy of the namespaces.
> 
> It is not correct to use inode numbers as the actual names for
> namespaces.

It is unclear for me why exposing the inode number of a namespace is such a fundamental problem. This information is 
already available in /proc/PID/ns. If you are worried by the fact that the inode number gives the name of the 
corresponding directory in the filesystem and that someone can interpret this as a name of the namespace itself, then we 
can make the inum available inside the directory (and make it identical with /proc/PID/ns/) and to think for some other 
naming convention for the directories.


> 
> I can not see anything else you can possibly uses as names for
> namespaces.
> 
> To allow container migration between machines and similar things
> the you wind up needing a namespace for your names of namespaces.
> 

This filesystem aims to provide a snapshot of the current structure of the namespaces on the entire host, so migrating 
it to another machine where this structure will be anyway different seems to be meaningless by definition, unless you 
really migrate the entire machine.

This may be a stupid question, but are you currently migrating 'debugfs' or 'tracefs' together with a container?

> Further you talk about hierarchy and you have not added support for the
> user namespace.  Without the user namespace there is not hierarchy with
> any namespace but the pid namespace. There is definitely no meaningful
> hierarchy without the user namespace.
> 

I do agree that the user namespace plays a central role in the global hierarchy of namespaces.

> As far as I can tell merging this will break CRIU and container
> migration in general (as the namespace of namespaces problem is not
> solved).
> 
> Since you are not solving the problem of a namespace for namespaces,
> yet implementing something that requires it.
> 
> Since you are implementing hierarchy and ignoring the user namespace
> which gives structure and hierarchy to the namespaces.
> 

If we provide a second version of the PoC that includes the use namespace, is this going make you do a second 
consideration of the idea?
It is OK if you give us a second "Nacked-by" after this ;-)

Once again, thank you very much for your comments!

Best,
Yordan


> Since this breaks existing use cases without giving a solution.
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Eric
> 
