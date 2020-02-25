Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2016F2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 23:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgBYWhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 17:37:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40114 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgBYWhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:37:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so375682pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ujUSpbSlCH5ZCbsE0Im09CK5jyllUEPbsT32AKCmZZ8=;
        b=DyLkCv60xAdLCmRKcDclI0CdjpCht6vI0Kff3FlLtJ7IJj+r1jKD0DZHiRDVNX9oU2
         4ILDtH0EHnHCBkWm9pY11x/hcehrKdRPZLnZ0B+wuKFb3zlDp6C5dn106hviyEbF5k2w
         /2q2TLjsB4pOYE7UmuaRr59Z8/Ete9pGvTXVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ujUSpbSlCH5ZCbsE0Im09CK5jyllUEPbsT32AKCmZZ8=;
        b=YTUrIrlzqoBKMELAjkJgGDF59gfrjzsVvuM09pI5mMS5viNSCgmdTT4UgHbQ2oTwKQ
         goFh/rukiNaVL0qLiQCYEGOucF+z1mAATEvF+YT9N7fyBQPXQ59PZs1L+e7t+46NYU46
         9CkHBXdXt+72HCwDB2yzeth9aaBrP/iETJ3HfLQCxv/kf/YnwWxazz7SAYGBaxRxWycl
         VZFVktMDci1GhT9xnOsr8wlY03qzjUxp4j1T+A5Qb/+7GdTjY/4MPDL+s9JJtR1WUXg0
         KCMkVZg3SKKNJQJie3HV8cvzk3TmmWTaDhBE8A4D5goI9Z7SoxF5BX4ArA1igSikucQF
         OHUg==
X-Gm-Message-State: APjAAAWqwQW4ULmCKOiRAPiE61svxLiaMT7JjjEw5RUK6SSxgb13icSO
        fcJWH2ugx/edFAIunN2GK12i3A==
X-Google-Smtp-Source: APXvYqyClLjlKFFh151KqjRXFbjTgwsEjNcVLzqq++3PiVnTCzW7kl9YidPkNzPtFOSSHwlCCAAalw==
X-Received: by 2002:a17:902:bf41:: with SMTP id u1mr738034pls.207.1582670259870;
        Tue, 25 Feb 2020 14:37:39 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x12sm111778pfr.47.2020.02.25.14.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 14:37:39 -0800 (PST)
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220074711.GA3261162@kroah.com>
 <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com>
 <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
 <CAOesGMj423YXNhk_vFE0ueNjzbYoD0wQ68jJApewZS8qtVX3=g@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d35204c1-054e-ec5b-069b-42a053a3863f@broadcom.com>
Date:   Tue, 25 Feb 2020 14:37:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMj423YXNhk_vFE0ueNjzbYoD0wQ68jJApewZS8qtVX3=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Olof/All,

I'm trying to digest all the feedback of what needs to be done.
I will be fixing up all the valuable comments about general issues but 
would like to know
what needs to be done about the tty interface.

The VK devices are configured to write serial data to circular buffers 
in memory or out a UART.
When we configure a system using the UART we connect a cable to the host 
and open a tty device.
When we don't connect a UART cable to the host we open the tty device in 
our driver instead.
In this case the memory is exposed to the host via PCI BAR memory space.
The bcm-vk host driver then accesses PCI space and presents a tty 
interface to the host.
We implemented a tty device to present the tty interface.
Host doesn't change anything other than opening a different devnode in 
UART vs. PCI case.

Based on all the comments: what interface should we be providing in 
driver instead?

On 2020-02-23 3:55 p.m., Olof Johansson wrote:
> On Sat, Feb 22, 2020 at 12:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Feb 21, 2020 at 7:19 PM Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>> On 2020-02-19 11:47 p.m., Greg Kroah-Hartman wrote:
>>>> Have you worked with the V4L developers to tie this into the proper
>>>> in-kernel apis for this type of functionality?
>>> We looked at the V4L model doesn't have any support for anything we are
>>> doing in this driver.
>>> We also want a driver that doesn't care about video.  It could be
>>> offloading crypto or other operations.
>>> We talked with Olof about all of this previously and he said leave it as
>>> a misc driver for now.
>>> He was going to discuss at linux plumbers conference that we need some
>>> sort of offload engine model that such devices could fit into.
>> I see. Have you looked at the "uacce" driver submission? It seems
>> theirs is similar enough that there might be some way to share interfaces.
> Uacce isn't a driver (or wasn't last time I looked at it, when it had
> a different name). It's more of a framework for standardized direct HW
> access from userspace, and relies on I/O virtualization to keep DMA
> secure/partitioned, etc. VK is more of a classic PCIe device, it'll
> handle DMA to/from the host, etc.
>
>>>> Using a tty driver seems like the totally incorrect way to do this, what
>>>> am I missing?
>>> tty driver is used to provide console access to the processors running
>>> on vk.
>>> Data is sent using the bcm_vk_msg interface by read/write operations
>>> from user space.
>>> VK then gets the messages and DMA's the data to/from host memory when
>>> needed to process.
>> In turn here, it sounds like you'd want to look at what drivers/misc/mic/
>> and the mellanox bluefield drivers are doing. As I understand, they have the
>> same requirements for console, but have a nicer approach of providing
>> abstract 'virtio' channels between the PCIe endpoint and the host, and
>> then run regular virtio based drivers (console, tty, block, filesystem,
>> network, ...) along with application specific ones to provide the custom
>> high-level protocols.
> This has more value on the device than on the host, as far as I've
> seen it used (if you want to boot Linux on it and have things
> exposed).
>
> virtio isn't necessarily a match if all you really want is a character
> stream for a console and don't need (or have performance requirements
> beyond what virtio offers) other types of communication.
>
>> This is also similar to what the drivers/pci/endpoint
>> (from the other end) as the drivers/ntb (pci host on both ends) frameworks
>> and of course the rpmsg/remoteproc framework do.
> remoteproc is more about booting a tightly integrated device on an
> embedded system. Also not a match here IMHO.
>
>> In the long run, I would want much more consolidation between the
>> low-level parts of all these frameworks, but moving your high-level
>> protocols to the same virtio method would sound like a step in the
>> direction towards a generialized framework and easier sharing of
>> the abstractions.
> For a simple naive console/character stream, doing something on top of
> hvc might be easier -- it already does polling for you, etc.
>
> Of course, the intent is not to ever use it as a console for the host
> here, so that aspect of hvc isn't useful. But it gives you a bunch of
> other stuff for free with just getchar/putchar interfaces to
> implement.
>
>
> -Olof

