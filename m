Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573B32CAE80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 22:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgLAVfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgLAVfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:35:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2893CC0613CF;
        Tue,  1 Dec 2020 13:34:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k10so7557731wmi.3;
        Tue, 01 Dec 2020 13:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FnnA7YCm5kIjNwSDbnjuaUqX+0RY801uOYLHEzntnsQ=;
        b=UryDIZ0jgaMwfFh62tzh9Vv5zjzTHRFGLHAqLfEDeNnUkIOLtIS7PjDwquNcVjrVmk
         C0jydjO3/K/xj7JZpEd3EdrcV2OYHqBuuzkNqNH8llEdibUDhMX5b+EYlHzlhdWq92yq
         OnGkRyJLhQqyDIGm87hDhc1DYIzU/GbPEDTSxcnBNcB7BX/pWvFMtB/ZqsneoLhHqxrL
         54vKOpKLoehXJDNVa5mllSBFbxt+IEdV+d6VT1GXP2+FgadxiwUJDVfkqKX6n/dRSxi+
         p6Nh21UwQHycPLR0cjjc91LhcH5sIjNmVHGt9SMdu22rwa4GBuY6f0RixxVuFgt4rFwM
         KEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FnnA7YCm5kIjNwSDbnjuaUqX+0RY801uOYLHEzntnsQ=;
        b=JyPKmM6x90QyBLqYJohgCm1XKHDxVE66+frmRU7aJ2x1JjmTPJCpQh8rAf7BdVTJBp
         rDdetc/n2w6RtJ+CfOioj5JFHBHlNCzO3VaGKIL81cyQKRQWxPdaXj3e2hI08KLIxWVs
         fa7RC+2tjG+yrTuQIk2TWQ43Teuitn5Y+okdj23Km0L6nGbiyo6UvN/hjOLkndWFcfK8
         /TY9HGRXL3mrfHIZc89OvH2GffM1wjy+7pBCj2Lr6ayr15EhQz4Vik6UrabZEZ8Z9G48
         jtEAxy2ffh/eIWTQu+xJoZrIYnn84x/jLg9UlKib8oYTO7hz4JGiUViyOpM5fHi1rHKd
         9/pw==
X-Gm-Message-State: AOAM532e3RuVWeJSYgwocGKROtrDsdkYMP6oevMxP0f3BR8XruFZXX7w
        LMlG/6i5ebzNP1FxsOpxRthc+HgAe9lPAg==
X-Google-Smtp-Source: ABdhPJzJB0fT/0w670/t7g/4JErTNT1EQbI+5BEPtjshIdwuY5K5PLQjmZAw7pDG59iwQ88pM/jVow==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr4708239wmc.161.1606858462650;
        Tue, 01 Dec 2020 13:34:22 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id q16sm1346279wrn.13.2020.12.01.13.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:34:22 -0800 (PST)
Subject: Re: [PATCH man-pages v6] Document encoded I/O
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
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
 <20201201202144.ulbfnawi2ljmm6mn@localhost.localdomain>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <66e17b5b-a63e-9551-02a1-ff8bcfa45b93@gmail.com>
Date:   Tue, 1 Dec 2020 22:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201202144.ulbfnawi2ljmm6mn@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Branden,

A good read, as always!

Thanks,

Alex

On 12/1/20 9:21 PM, G. Branden Robinson wrote:
> At 2020-12-01T21:12:47+0100, Michael Kerrisk (man-pages) wrote:
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
> Use the non-printing input break escape sequence, "\&", to suppress
> end-of-sentence detection.  This is not a groffism, it goes back to
> 1970s nroff and troff.
> 
> I'm attaching a couple of pages from some introductory material I wrote
> for the groff Texinfo manual in the forthcoming 1.23.0.
> 
> Regards,
> Branden
> 
