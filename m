Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF04339F5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhCMRK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 12:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhCMRKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:10:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563E5C061574;
        Sat, 13 Mar 2021 09:10:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so16966134wmi.3;
        Sat, 13 Mar 2021 09:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uxXcx5tCWVJlzcshWXHiDgaPyurgvL5/J2tFChe0zBg=;
        b=lgAtaOsdhAi+Qaq0ZXhJ2RyjVzIA0NdwA81J/CeE/nDSCHejnq3mlfAGnCNvlBSiuM
         m8QS9KwANjL59/D0JMCuaOgEeruMzzcpyy9rSz177MUhiBCDviF+3aEDUM2gHMuoEjy3
         iK5oMmo+rcGzXUAsvJRjKrN28CQbFOdGzFSg9psocKDwQ8yO1CUHMNt8UPsV26LFOO3L
         DI8zkATPjqON6uKDG+i2Ch3WxUFy2wbfSWgHBrL2Fa6eNauGoli5Maxsf+XHmQDMMgRo
         TdT4be9bRftf43D8qRJ8roWClk22dajSCu5U8TigzbZk2qAG/Agv8reDwTFtFlAL5vZI
         KbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxXcx5tCWVJlzcshWXHiDgaPyurgvL5/J2tFChe0zBg=;
        b=mTsS7VSTd99xMPxqhin+VBL2oVBXGicxpEO1aa4VkJbnjiLZnEKgoGgEu66GQfM5Eg
         U6fK4Tlo0GGI3p32E3v4WzqkxZ3IoNNCgrr+wwPSe4FV7BbO+CFDqd/WTyR9aCYNvGDf
         14nWx/0bZQJaPJBOBUw6Kih2cHIEcQb9RmxHAb8yUrpswYbwCQjVaKDwSgmaBagqyGJ9
         x/vqeMSeD2JBOrY7KfpplI6rL4eFb3nFjsd6plbMC3DIcqpiPlqLyaLzke3CLMIvuasM
         KV2Rz+dz8DeoxkEThsXhMg/TiLDDf+9e7BSTJZiEOMO1WPCbgSspXFgoslcUVzEDNnUU
         zyvA==
X-Gm-Message-State: AOAM531LG9/q/99gbrEeCwstG3Rp1Gd20AoKy1ToscUK8FPxO42pI7a6
        2p67FukVLa9DQOY519kxQA1jY7HpbOZN8g==
X-Google-Smtp-Source: ABdhPJzx5pXKZyc0H0ELXyqikd7atH4DO/6lXbTiNri/jZCpws6ukyPErnUKkKVIf4gI0gutocBhLA==
X-Received: by 2002:a7b:c096:: with SMTP id r22mr18576100wmh.102.1615655406109;
        Sat, 13 Mar 2021 09:10:06 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id q4sm7481816wma.20.2021.03.13.09.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 09:10:05 -0800 (PST)
Subject: Re: epoll_wait.2: epoll_pwait2(2) prototype
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Willem de Bruijn <willemb@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org
References: <eb42faba-2235-4536-df49-795ef2719552@gmail.com>
 <20210313170250.GA15968@altlinux.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <db9dbcc6-91e0-bfc3-0f19-b91fd2afec24@gmail.com>
Date:   Sat, 13 Mar 2021 18:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313170250.GA15968@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dmitry,

On 3/13/21 6:02 PM, Dmitry V. Levin wrote:
> Hi Alex,
> 
> On Sat, Mar 13, 2021 at 05:48:08PM +0100, Alejandro Colomar (man-pages) wrote:
>> Hi Willem,
>>
>> I checked that the prototype of the kernel epoll_pwait2() syscall is
>> different from the one we recently merged; it has one more parameter
>> 'size_t sigsetsize':
[...]
>>
>> I'm could fix the prototype, but maybe there are more changes needed for
>> the manual page.
>>
>> Would you mind fixing it?
> 
> Looks like the 6th argument of epoll_pwait and epoll_pwait2 syscalls
> is already described in "C library/kernel differences" subsection of
> epoll_pwait2(2).

Ahhh, I didn't see it, ok.  That's in BUGS by mistake.  I'll move it to 
NOTES, where it should be.

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
