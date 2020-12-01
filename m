Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710492CAE88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgLAVgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 16:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgLAVgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:36:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189EC0613CF;
        Tue,  1 Dec 2020 13:35:38 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so5081377wrm.13;
        Tue, 01 Dec 2020 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MennaIdlw2rEfhCE57v1/ns19QjTPenrLTqIfgoLes4=;
        b=oDLZiMXNP1Qpp/9lQP8OXFoKc5aMJnzV3TCR5AMdYEQNy10OOR6q4SFp/Z/np5DNPz
         fC9MUO8KQm1bK0OA86alShZykConycG+bOdcfix9ealb6IZ5ImvuE/bMxKom6fIrat/Q
         QG5hGize0Pd303ToGTILDNGVdhauUtlFJAGZKY+zZbZk8WHx+jfLUFBU5k+UPWzKYY7A
         p/L2yBK3bxAI1VstY2+uoqxj0PmV4YnVcPgLwYWATu2Fj8YRJfmzlu+Dj1zS+b2/lMIK
         vNOj3b5ueYTldjX78BENmO4/E5utXFspw61jc8QnRhg9ZkEafma+/rYZ/XdzuUYiUKog
         568A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MennaIdlw2rEfhCE57v1/ns19QjTPenrLTqIfgoLes4=;
        b=ZvQDZS9/BDjj8DbYHEu4KiATsLTvgGREIeIrFkn+CNm86e+fSxEdG75WcKgpE2H+xz
         hiY90pOXbedwnI9QI5DU/NpLC7Newgg6CL/LY2T4Nbmyxo3Y+DmcCFdpd4Nd6PcrU3w8
         b2EBCssp0m9c3CwNdhbxebZp4kEb5pK3vagdvPqTEhf9jcnn/7yCnG9YMdXRIAnOt6e8
         MOdRx5eYDX9Xjyuysry4PSxqesBX0dPUE+QEBe3y/J4rRbhOAajNr4rF5hK+K5URFhGO
         tHghM6P4Lk9fCFuzQIjqTPk1JQQ7fK445ZRK/j+yfKbH/lgiMxY3395Y3YncdO2QvSr5
         DnZg==
X-Gm-Message-State: AOAM532UwvenC0XKRYN9UOqlM7KJ/EUX5M6PhQG+pTkPqd3KddjTII7l
        MEbvP8+lLU/lNO3fyny2RHuQzfPr+9nWSQ==
X-Google-Smtp-Source: ABdhPJypKIOGoGzHXfvUCF1MBGOs/Z8aeKjMSOFB6aLlqfr3TdAVnqM+BkpSQGwadQ5RgM7SF1M5dA==
X-Received: by 2002:a5d:5741:: with SMTP id q1mr6519927wrw.160.1606858537307;
        Tue, 01 Dec 2020 13:35:37 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id v3sm1348933wrq.72.2020.12.01.13.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:35:36 -0800 (PST)
Subject: Re: [PATCH man-pages v6] Document encoded I/O
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
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
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <2aca4914-d247-28d1-22e0-102ea5ff826e@gmail.com>
Date:   Tue, 1 Dec 2020 22:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <559edb86-4223-71e9-9ebf-c917ae71a13d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michael,

On 12/1/20 9:20 PM, Michael Kerrisk (man-pages) wrote:
>>>>>> +.SS Security
>>>>>> +Encoded I/O creates the potential for some security issues:
>>>>>> +.IP * 3
>>>>>> +Encoded writes allow writing arbitrary data which the kernel will decode on
>>>>>> +a subsequent read. Decompression algorithms are complex and may have bugs
>>>>>> +which can be exploited by maliciously crafted data.
>>>>>> +.IP *
>>>>>> +Encoded reads may return data which is not logically present in the file
>>>>>> +(see the discussion of
>>>>>> +.I len
>>>>>> +vs.
>>>>>
>>>>> Please, s/vs./vs/
>>>>> See the reasons below:
>>>>>
>>>>> Michael (mtk),
>>>>>
>>>>> Here the renderer outputs a double space
>>>>> (as for separating two sentences).
>>>>>
>>>>> Are you okay with that?
>>
>> Yes, that should probably be avoided. I'm not sure what the
>> correct way is to prevent that in groff though. I mean, one
>> could write
>>
>> .RI "vs.\ " unencoded_len
>>
>> but I think that simply creates a nonbreaking space,
>> which is not exactly what is desired.
> 
> Ahh -- found it. From https://groff.ffii.org/groff/groff-1.21.pdf,
> we can write:
> 
> vs.\&
> 
> to prevent the double space.

Nice to see it's possible.
However, I would argue for simplicity,
and use a simple 'vs',
which is already in use.

Cheers,

Alex

> 
> Thanks,
> 
> Michael
> 
> 
