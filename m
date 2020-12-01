Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCE2CAD2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392395AbgLAUUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390839AbgLAUUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:20:55 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67104C0613CF;
        Tue,  1 Dec 2020 12:20:14 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so6886137ejb.13;
        Tue, 01 Dec 2020 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8LOvIW9VGbu6yVQC0pyKrIyyIVofSPETZZoCASouyA=;
        b=nA1Jz7HZaeXfSEKiNPJl/q7u9GSnhYFlckUd4kro9jPGdVi0T8Em3lTAoIT1xvRgSB
         7rL2vrF2S25FyAHKz0G1FXswTlv/ts7BhgGmIp2b7QUaH1DYqohXDxf2kGAYWe3tB3Pv
         +mghG8BXdVUAAyr4cZ7WiTCv1L5V73RKBVb+bALOHd2mDPZs0x/Samby5ciP/SAD3YTD
         u1hwmNmrhkPkfgCUhqd7QtvB6Av0TyK+KIOVQgnTXgXaMQZMbr1B9Nn+DQoQczMboPI7
         TvVaaujMkvmU2RFADjNYfXWXkyVvw9R2bIRn2w2HemlJyDKfkCbrgUjjmrOt9EZw+Ekh
         HjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8LOvIW9VGbu6yVQC0pyKrIyyIVofSPETZZoCASouyA=;
        b=hF6S3oS6sJYWqqa4Jv2UeylExCsWmG/8sCMGF/nvvYzT1fzA+0L0dV6MJeWebkj9za
         ANZsqc3y0gQm9iUg0wTrp2YdQd5oNz4SANB9tVBpukabvbNpvVSkHz2+JHlGSuelJ9hZ
         tj4oWGZfZeV/47bZ7ahaGr9WGWWa7bJFNKlQ+oh7rLMMOb3Cr2f65Q3C1g+VV3eeKPM/
         cxIB0FOdrwXr5T78/LhemJ+z5jIsEXJLxxJe8FdcFWuF8wqzx8ZmAINgJrHrbgE/ww/J
         8mUDI6jZGo1JhrXbJRMoruteH5oztiDQgSAK7AsNLOtzumnBjLm0V2s5jwT2rUcBWzYf
         T/qA==
X-Gm-Message-State: AOAM5306rzW8ebrbk1U1f9zf21320sw2LX3sep5WTqvg6x7wXsDNljI9
        NVrvdch/hcIzzxwKFNJXwt/8ZOACs7WQ+A==
X-Google-Smtp-Source: ABdhPJyVEOSJCwPaRQEfj3znNBo7PAU3VOgN6sVUI122w7l2cuG77aZZvke/Tq680gXd7mM2umrqNw==
X-Received: by 2002:a17:907:2131:: with SMTP id qo17mr1104442ejb.546.1606854012831;
        Tue, 01 Dec 2020 12:20:12 -0800 (PST)
Received: from ?IPv6:2001:a61:3aad:c501:15d9:d9fb:bc21:cb92? ([2001:a61:3aad:c501:15d9:d9fb:bc21:cb92])
        by smtp.gmail.com with ESMTPSA id r7sm417224edv.39.2020.12.01.12.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 12:20:12 -0800 (PST)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <559edb86-4223-71e9-9ebf-c917ae71a13d@gmail.com>
Date:   Tue, 1 Dec 2020 21:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> +.SS Security
>>>>> +Encoded I/O creates the potential for some security issues:
>>>>> +.IP * 3
>>>>> +Encoded writes allow writing arbitrary data which the kernel will decode on
>>>>> +a subsequent read. Decompression algorithms are complex and may have bugs
>>>>> +which can be exploited by maliciously crafted data.
>>>>> +.IP *
>>>>> +Encoded reads may return data which is not logically present in the file
>>>>> +(see the discussion of
>>>>> +.I len
>>>>> +vs.
>>>>
>>>> Please, s/vs./vs/
>>>> See the reasons below:
>>>>
>>>> Michael (mtk),
>>>>
>>>> Here the renderer outputs a double space
>>>> (as for separating two sentences).
>>>>
>>>> Are you okay with that?
> 
> Yes, that should probably be avoided. I'm not sure what the
> correct way is to prevent that in groff though. I mean, one
> could write
> 
> .RI "vs.\ " unencoded_len
> 
> but I think that simply creates a nonbreaking space,
> which is not exactly what is desired.

Ahh -- found it. From https://groff.ffii.org/groff/groff-1.21.pdf,
we can write:

vs.\&

to prevent the double space.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
