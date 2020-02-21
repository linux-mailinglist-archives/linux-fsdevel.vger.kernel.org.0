Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7929E1686A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgBUS2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:28:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38252 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUS2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:28:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so2918841wmj.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 10:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+l+qFonj7f23vQK1lgbHd1m+mxJ9Bc4ZwbsX0TJ5N0A=;
        b=CaS40LxDMt/ExdrwPwyWY3fN1LS8vl8hcd5kz/nwtaebYodzStTnGMe0zFCahsWxOn
         Um10s9pqVHZXW8yMsepx4FWtH05k5Ak6u7RP4eS6oEwSrKt3a2ZVWQ3T4h7jJypjmdL7
         4qlT6Q0Df5pKVD1NMnB4+HRM0RyeUZ6TQkf5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+l+qFonj7f23vQK1lgbHd1m+mxJ9Bc4ZwbsX0TJ5N0A=;
        b=KxOWv2N1fsWaIUt8hHGr4bHyNNSTpQTFjPgKTYbjnyT9JzYMUzoFzyAOjxc9qQUjN3
         klIotY6CSbGppis4y/cY9OymBMBA0fiLy3QBqGpuL39QgA9eyNv3jYey4CmAwkx2UFCb
         rW630WhiisYkCiQxkjyxBuYD3VBxEBdzvrBYukk4BcNzNK74qc8tdkQkThLz/hLxU132
         4cpBhLAu+2IKDaMlhHPo+DEKgVblKTcFh4Mq2UhSGgNSgyABLbn2bw2qOyLaxNmij9UZ
         kxpG6KGDmtUff+zijQAydTk+bx25D/e0rlpj+B4IMn8ttEc2gqjjGpURG8++6ePtT+Hd
         T3/Q==
X-Gm-Message-State: APjAAAUppVT6jG/UP0LCU9oZ0sxCKr7BTQne+EsxZKe9AQmHDsJlmEZM
        UY0tHdRP8Hd5OPljtNICln6MQw==
X-Google-Smtp-Source: APXvYqzTYqf6p2n3M1EPoZeZQmQ0OhQ2/tZGFDSlGLsM8NFmoMrT5Q0l+CXBdKbPHTsEaq54HF6FWQ==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr5287800wmi.51.1582309684109;
        Fri, 21 Feb 2020 10:28:04 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 18sm4953110wmf.1.2020.02.21.10.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:28:02 -0800 (PST)
Subject: Re: [PATCH v2 5/7] bcm-vk: add bcm_vk UAPI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-6-scott.branden@broadcom.com>
 <20200220075045.GB3261162@kroah.com>
 <030219dc-539a-a2db-5ab2-1de7336a811c@broadcom.com>
 <CAK8P3a1v7S4Ma67vRyfSY=v9z9bt9ZrftOYhgYvsECWXykGTJg@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <ae33411a-23cb-6562-d57b-f40cba7f6503@broadcom.com>
Date:   Fri, 21 Feb 2020 10:27:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1v7S4Ma67vRyfSY=v9z9bt9ZrftOYhgYvsECWXykGTJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-02-21 12:34 a.m., Arnd Bergmann wrote:
> On Fri, Feb 21, 2020 at 2:16 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
>
>
>>>> +struct vk_access {
>>>> +    __u8 barno;     /* BAR number to use */
>>>> +    __u8 type;      /* Type of access */
>>>> +#define VK_ACCESS_READ 0
>>>> +#define VK_ACCESS_WRITE 1
>>>> +    __u32 len;      /* length of data */
>>> Horrible padding issues, are you sure this all works properly?
>> Haven't had any issues.
>>>> +    __u64 offset;   /* offset in BAR */
>>>> +    __u32 *data;    /* where to read/write data to */
>>> Are you _SURE_ you want a pointer here?  How do you handle the compat
>>> issues with 32/64 user/kernel space?
>> Don't care about 32-bit user space for this driver.
>> I don't think there isn't even enough memory in such systems for the
>> number of streams of video buffers needed for transcoding.
>> This driver is only used in high end 64-bit x86 servers.
> Please see Documentation/core-api/ioctl.rst
>
> All ioctl interfaces should be written in a portable way that works with
> compat user space and avoids all padding in order to not leak kernel
> data into user space.
>
> If the driver is passing video buffers for transcoding, shouldn't the driver
> use the existing drivers/media interfaces for that? If it needs features
> that are not present there, they can probably be added.
It doesn't utilize any media interfaces.  It is just an offload engine.  
Really, it could be offloading anything.
There is no infrastructure for other drivers in place that perform such 
transcoding operations.
Perhaps I shouldn't mention it is doing video in this driver.
>
>          Arnd

