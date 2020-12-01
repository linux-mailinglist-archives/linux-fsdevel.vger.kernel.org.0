Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD12CAF3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 23:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgLAV7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 16:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgLAV7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:59:03 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7747C0613CF;
        Tue,  1 Dec 2020 13:58:22 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so5750363edt.9;
        Tue, 01 Dec 2020 13:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EposTtMUZs+gVLdh7FbWQARWbgt/pepc/iVKswV5VXg=;
        b=czectvghT+DvD0u82I0a5rIOUEyNZn+zUX5SGMK/SVj0uEjfNvsozxOtRUz3Pwh0sL
         /J6F88vEI/JK7I/B46sW+b3WADEyvQKh6mwdJGvHf0uU9ZOT+bXFxFDX1cfoQfTvDGLH
         qPn7e/3eXr1N6Pcz6O3L7oilzdYLGl66kp7IVfOXFAfeI13tdH820iy6iFce7lxrJeCn
         ZbCFYJp6Bcx0PF/PmNQqHEx0tzFFmGYmKetUxseRx3XasyjXjuewVsEaqVk9lR0kk37s
         vRlc4ajxaeVeTj1EJmxfcYC9PmSDtaojaxrweqlLfX++R2RpJ3XLSvwBeZFApqBIIV0N
         U/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EposTtMUZs+gVLdh7FbWQARWbgt/pepc/iVKswV5VXg=;
        b=t6B6B5bWd6lsmkw4n4tGUOzyczZTLY0gMQnxRixQjcl0zD101mxdu7tOV+aWTcMqXE
         nnsmS7hDl7Y2mxnzwo7FG4+AUHr+RewXTt7258RNZVNAH1fl8SYfOFp+ipHptsWbRA5M
         2Q0Li31O4Jo6tES0o6vu30WIVXJ4OI7mmtqdFoZNHhRftdymNNQZaoENyUDw6Fu/Fe3I
         dV5qxcyyfOrEkS8BNJ+8ZJjHkQwT+UbOEpygZ5egd/t+hNYAmcZKGvKGx1c3j23Vy7qh
         4VabHGUaKzG/NKMi6F6VpYkBdg6dDPfab+ZwWTPYQoRk7eNtHuqLNwjpl5mIDIlihPki
         TgPw==
X-Gm-Message-State: AOAM530wzsbAeI1TuMqPd39Y1LVRLsAZlLV/xCMqLXVyv7MlJo6Bd8Ks
        oUlEHKppGGgVUtqoHCkMT+hYSUWlPcWlLA==
X-Google-Smtp-Source: ABdhPJxZ9JjKMOhsfMIpiZ7jpLcp8xPPe2HB7YbPwl1v2A7vVpgZjc7rXyWypI7ES0Sh76Zlj7necQ==
X-Received: by 2002:aa7:cd84:: with SMTP id x4mr5167286edv.192.1606859901120;
        Tue, 01 Dec 2020 13:58:21 -0800 (PST)
Received: from ?IPv6:2001:a61:3aad:c501:15d9:d9fb:bc21:cb92? ([2001:a61:3aad:c501:15d9:d9fb:bc21:cb92])
        by smtp.gmail.com with ESMTPSA id f7sm455575ejd.13.2020.12.01.13.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:58:20 -0800 (PST)
Cc:     mtk.manpages@gmail.com,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v6] Document encoded I/O
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
 <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
 <20201201202144.ulbfnawi2ljmm6mn@localhost.localdomain>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <437a22f6-8724-6dfc-ac40-0c947817d7a3@gmail.com>
Date:   Tue, 1 Dec 2020 22:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201202144.ulbfnawi2ljmm6mn@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Branden,

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

Yes, I spotted it about two minutes before your mail. And before that, I 
was thinking, "should we really bother Branden with a question like 
this?" :-)

> I'm attaching a couple of pages from some introductory material I wrote
> for the groff Texinfo manual in the forthcoming 1.23.0.

As ever, thanks for jumping in, Branden.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
