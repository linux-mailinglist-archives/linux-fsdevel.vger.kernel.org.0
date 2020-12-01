Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57A2CAF34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgLAV46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 16:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgLAV44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:56:56 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467FC0613CF;
        Tue,  1 Dec 2020 13:56:16 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so7517146ejb.13;
        Tue, 01 Dec 2020 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNnSqF/Fgsu1DQVw32weknFsudeLTkbDdXCXF6duIjg=;
        b=WUyjwP0N8x13LpAJ80dRQGOSLcBTimpb6+GC9S1Lea4ou8RMgJ0QSRM0vRD9iHj1Pi
         Kj9Ic4ge77zi17ujW0Q5PtjRvbL9vdk+9W76uYaKzVpx8CtAXtY8GQ/upvQc1Inj03sH
         FEcsX1sFwFdHUOI5SP2ca329ACt4NGV1+nyh7ozCe5+vJLwWBFd8p3BSLmEmJFD+z+kJ
         Efyp10R9En4ECUnJsMUwF2KFhhzV06eDd3RqATmb1nI9LHl3s+L6jNK3aqb5t4SPNfVA
         7mRpmZMG1Fl7oAg8HtklgUkAr8xA2GqhyMCobWDRcx4ymIJGdvVayJDH/UcFTb0UUSTo
         DODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNnSqF/Fgsu1DQVw32weknFsudeLTkbDdXCXF6duIjg=;
        b=oLzTBxVojVBicp7JvphebpbComd/DAZRPjzgW39hz0pEKetVd1r9JdP6FvybgPA+yJ
         /Mbvh55/Zc+yj1wcYmnG6AnnUtAngtNUeQvwxlJ+n95/BKztvGPsiUG403IAW2fSCjuG
         TBVLOixTB5BwRA6fp2rnSucPTSWL2wIPKGzNSxYP0Tdla86xH8k1XtmIXU0KCkzefnpt
         ZrKIKg8tiIkFh+Ww+yFdv7RffO9sGmAye0c2t1FyIcPEajbXzMDkq7DDWkYTO39fHrdg
         LlR5xh6ih1jKz06qb6h998GgSGqISXmQTUnbkXT62Q2S4sBYrbwCV8UZnRZ8LlYLe18V
         Y7EQ==
X-Gm-Message-State: AOAM5301tNIdpkPMMt+LPXAOgD+lcO2iJ1OJsEh4yPaqVKYg1XYHG7Fd
        rSbsLgn3eYzr17gpM1lwxRLx4/Z6Y+DJ/Q==
X-Google-Smtp-Source: ABdhPJzy50Df1rha71bsRACYAHo7n7GTztz5ioMnv+AuuWOkLyme1ispZa3ChJXbHGwizZTbREmNpw==
X-Received: by 2002:a17:906:259a:: with SMTP id m26mr4967204ejb.399.1606859774329;
        Tue, 01 Dec 2020 13:56:14 -0800 (PST)
Received: from ?IPv6:2001:a61:3aad:c501:15d9:d9fb:bc21:cb92? ([2001:a61:3aad:c501:15d9:d9fb:bc21:cb92])
        by smtp.gmail.com with ESMTPSA id b7sm460989ejz.4.2020.12.01.13.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:56:13 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v6] Document encoded I/O
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
 <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
 <559edb86-4223-71e9-9ebf-c917ae71a13d@gmail.com>
 <2aca4914-d247-28d1-22e0-102ea5ff826e@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7e2e061d-fd4b-1243-6b91-cc3168146bba@gmail.com>
Date:   Tue, 1 Dec 2020 22:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2aca4914-d247-28d1-22e0-102ea5ff826e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alex,

On 12/1/20 10:35 PM, Alejandro Colomar (man-pages) wrote:
> Hi Michael,
> 
> On 12/1/20 9:20 PM, Michael Kerrisk (man-pages) wrote:
>>>>>>> +.SS Security
>>>>>>> +Encoded I/O creates the potential for some security issues:
>>>>>>> +.IP * 3
>>>>>>> +Encoded writes allow writing arbitrary data which the kernel will decode on
>>>>>>> +a subsequent read. Decompression algorithms are complex and may have bugs
>>>>>>> +which can be exploited by maliciously crafted data.
>>>>>>> +.IP *
>>>>>>> +Encoded reads may return data which is not logically present in the file
>>>>>>> +(see the discussion of
>>>>>>> +.I len
>>>>>>> +vs.
>>>>>>
>>>>>> Please, s/vs./vs/
>>>>>> See the reasons below:
>>>>>>
>>>>>> Michael (mtk),
>>>>>>
>>>>>> Here the renderer outputs a double space
>>>>>> (as for separating two sentences).
>>>>>>
>>>>>> Are you okay with that?
>>>
>>> Yes, that should probably be avoided. I'm not sure what the
>>> correct way is to prevent that in groff though. I mean, one
>>> could write
>>>
>>> .RI "vs.\ " unencoded_len
>>>
>>> but I think that simply creates a nonbreaking space,
>>> which is not exactly what is desired.
>>
>> Ahh -- found it. From https://groff.ffii.org/groff/groff-1.21.pdf,
>> we can write:
>>
>> vs.\&
>>
>> to prevent the double space.
> 
> Nice to see it's possible.
> However, I would argue for simplicity,
> and use a simple 'vs',
> which is already in use.

Indeed better. Thanks for noticing that.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
