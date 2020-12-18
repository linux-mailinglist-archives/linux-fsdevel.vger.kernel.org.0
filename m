Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74102DE111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbgLRKdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 05:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732959AbgLRKdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:33:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A209C0617A7;
        Fri, 18 Dec 2020 02:32:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a6so1841054wmc.2;
        Fri, 18 Dec 2020 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eRyQ3rtg2wCEW40PuTawW3Ghf9YcbftBcSCQW+iKYu0=;
        b=fJtkchlhOrvwywsetLugbNGmYiBZ0eVjwNyih9mCJiigPxQ5zaACsry4MBnG9mm13h
         Ko7IeAIUgzWYYTJirA4c61c+xUJocK5T2OH6dyZSAInKCwq4wlXHSGLM23mjuctTBZ2D
         jvt624tnZ4pio0FmuAx4JcFhwb/6kEJWYuik3O6p4dzOnz6KWqtJwkHbNcOJi/kCxywK
         DyGnAAqydJxoKpAUw8/Mn8cbBvy3/02fMTV6U9m28MsTU9UFMqs+A5dLXLGxeAPJJPtn
         cWYyjcfLoaEKX5VzrBZz7nfL6MBhsxRFxCBdh1U9qD+bMZoa9gKSHqrWqOW/gtyjIdqH
         hLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRyQ3rtg2wCEW40PuTawW3Ghf9YcbftBcSCQW+iKYu0=;
        b=doJVbDPS+WAsTUvudSvj4/10aUQietCoG/b/o7HYA70JZG3a6CE4KK8e16Vt/ZGXiO
         GoyZL8+Rz1NRbxjVRch84vS3+sh74pYVxlGbcFXzSJRU2AU1GsDnYA9m49zgrcYlP6hs
         uPJhw3wJsxzZDrbgtAz+XnIKI6DiRM5wzV5JYCLTGya63783bRdflPOz3qjwVLGrYp8A
         ItNosq/ZC6j0r6SgR1DbnFS9V9YlILWiueXwDmLfms5+2F7UjPT09tKDWaYmAKELzvI0
         jEvMDfaLf9VhA34sy1jPdrxE8F4WkO4CklUtzhqVzb3wJzVz71IqiFTUPLWIxrGx3qA7
         7IdA==
X-Gm-Message-State: AOAM533D8C57OqUwonm2TFEV0gINKmbHBBooOyumNyjv8VwAf7TPgY1x
        pgfKp87S94C/7nxZB1LFaszRG4A5yn0=
X-Google-Smtp-Source: ABdhPJzF74er/ywlXf7hXg9lTU5chkJy2tginvHaUBccJeaYfHipUDNMXcSA6KfqXe0placlHIGLkA==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr3674294wmb.12.1608287539678;
        Fri, 18 Dec 2020 02:32:19 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id v20sm13400786wra.19.2020.12.18.02.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 02:32:19 -0800 (PST)
Subject: Ping: [PATCH man-pages v6] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
 <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
 <559edb86-4223-71e9-9ebf-c917ae71a13d@gmail.com>
 <2aca4914-d247-28d1-22e0-102ea5ff826e@gmail.com>
 <7e2e061d-fd4b-1243-6b91-cc3168146bba@gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <48cc36d0-5e18-2429-9503-729ce01ac1c8@gmail.com>
Date:   Fri, 18 Dec 2020 11:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7e2e061d-fd4b-1243-6b91-cc3168146bba@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Omar,

Linux 5.10 has been recently released.
Do you have any updates for this patch?

Thanks,

Alex

On 12/1/20 10:56 PM, Michael Kerrisk (man-pages) wrote:
> Hi Alex,
> 
> On 12/1/20 10:35 PM, Alejandro Colomar (man-pages) wrote:
>> Hi Michael,
>>
>> On 12/1/20 9:20 PM, Michael Kerrisk (man-pages) wrote:
>>>>>>>> +.SS Security
>>>>>>>> +Encoded I/O creates the potential for some security issues:
>>>>>>>> +.IP * 3
>>>>>>>> +Encoded writes allow writing arbitrary data which the kernel will decode on
>>>>>>>> +a subsequent read. Decompression algorithms are complex and may have bugs
>>>>>>>> +which can be exploited by maliciously crafted data.
>>>>>>>> +.IP *
>>>>>>>> +Encoded reads may return data which is not logically present in the file
>>>>>>>> +(see the discussion of
>>>>>>>> +.I len
>>>>>>>> +vs.
>>>>>>>
>>>>>>> Please, s/vs./vs/
>>>>>>> See the reasons below:
>>>>>>>
>>>>>>> Michael (mtk),
>>>>>>>
>>>>>>> Here the renderer outputs a double space
>>>>>>> (as for separating two sentences).
>>>>>>>
>>>>>>> Are you okay with that?
>>>>
>>>> Yes, that should probably be avoided. I'm not sure what the
>>>> correct way is to prevent that in groff though. I mean, one
>>>> could write
>>>>
>>>> .RI "vs.\ " unencoded_len
>>>>
>>>> but I think that simply creates a nonbreaking space,
>>>> which is not exactly what is desired.
>>>
>>> Ahh -- found it. From https://groff.ffii.org/groff/groff-1.21.pdf,
>>> we can write:
>>>
>>> vs.\&
>>>
>>> to prevent the double space.
>>
>> Nice to see it's possible.
>> However, I would argue for simplicity,
>> and use a simple 'vs',
>> which is already in use.
> 
> Indeed better. Thanks for noticing that.
> 
> Thanks,
> 
> Michael
> 
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
