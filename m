Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C04169B00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 00:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBWXzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 18:55:43 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33895 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgBWXzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:55:43 -0500
Received: by mail-il1-f196.google.com with SMTP id l4so6278289ilj.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 15:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyI3k92se2W+CzWDqJQ962MJ9vu6VkRN6rHvKfta26U=;
        b=j/KKuLEs7pdn63IWEQa5W2BKAA73q3hJpH6zlMmP6pIEkbbEb3Oanr38OoznY4ccPW
         xHcn6Fng43AAtmSJa5jswP0kB+rWT/fx5+ibV70MZ3Dw94RhtbVW7zmoda6TmYLTGOhs
         OBwJSiorMzRwpygxL/n/DlwO2rS7s7Z61vandzZaoyw5sYfMFH0G3oz/M8WAmhgK63Tm
         zLcNRqyxYz3gT1DjD+qj5oMLgbiW3HLUc+xGmWOG6nNcDG8/ShrF2opmVnI6yhgH31sP
         2uiaEHlchKgE7C0snSpWifQPXV13Yq5H1oTRUPOYa3sFrwxu+nFJqrfAMWUnVDtPDh1H
         rXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyI3k92se2W+CzWDqJQ962MJ9vu6VkRN6rHvKfta26U=;
        b=Pisbe8KUEK1bgbwUTbb5CvAk/k0Pq+OFgf9M5GcZkOlx4GLDXz9+TqD5a3q8vdpr94
         vt0/llxPsMNRzPa0YZlQYOv9HsGTxCsoyiuldv1tGdY8xlECCpyTHRv0CopfDz8wLFfx
         eXUg6Xzi958nwKYmaJ4pODKBLSfSC3BjA/6piR002C62yOTkMTTgj7DBhd7FEF9pf1o3
         fNkXSmCngANhQGaMRebcCdl5Pfu4T+hODkLyP30tG475kNZlD5c6vReR9V3mvNXgiqg/
         BlMOD2hSglCdVrbrObTCzfrjMQhdf0Ts6ho4phxGft+kIdGyX5sGYu1xxRJIzIimubWI
         wMnA==
X-Gm-Message-State: APjAAAVpckto3SsyRUVc4h+zX3uSxWBXVY1qyK8DutNX9LWl+zF5nfy1
        HXWz2wqefhjdEfqkYwI/KXkxbT/b/aY3wCG2IZ2eAw==
X-Google-Smtp-Source: APXvYqzUncGfDJnmJi4i2I2hB/7uBR13zm/JcJxswi5r6CS9cRjJPXdXjKw2XLV4txh19hOg+ABZWwjg911r7Ipvjy4=
X-Received: by 2002:a92:afc5:: with SMTP id v66mr50219366ill.123.1582502142154;
 Sun, 23 Feb 2020 15:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com> <20200220074711.GA3261162@kroah.com>
 <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com> <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
In-Reply-To: <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 23 Feb 2020 15:55:30 -0800
Message-ID: <CAOesGMj423YXNhk_vFE0ueNjzbYoD0wQ68jJApewZS8qtVX3=g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 21, 2020 at 7:19 PM Scott Branden
> <scott.branden@broadcom.com> wrote:
> > On 2020-02-19 11:47 p.m., Greg Kroah-Hartman wrote:
>
> > > Have you worked with the V4L developers to tie this into the proper
> > > in-kernel apis for this type of functionality?
> > We looked at the V4L model doesn't have any support for anything we are
> > doing in this driver.
> > We also want a driver that doesn't care about video.  It could be
> > offloading crypto or other operations.
> > We talked with Olof about all of this previously and he said leave it as
> > a misc driver for now.
> > He was going to discuss at linux plumbers conference that we need some
> > sort of offload engine model that such devices could fit into.
>
> I see. Have you looked at the "uacce" driver submission? It seems
> theirs is similar enough that there might be some way to share interfaces.

Uacce isn't a driver (or wasn't last time I looked at it, when it had
a different name). It's more of a framework for standardized direct HW
access from userspace, and relies on I/O virtualization to keep DMA
secure/partitioned, etc. VK is more of a classic PCIe device, it'll
handle DMA to/from the host, etc.

> > > Using a tty driver seems like the totally incorrect way to do this, what
> > > am I missing?
> > tty driver is used to provide console access to the processors running
> > on vk.
> > Data is sent using the bcm_vk_msg interface by read/write operations
> > from user space.
> > VK then gets the messages and DMA's the data to/from host memory when
> > needed to process.
>
> In turn here, it sounds like you'd want to look at what drivers/misc/mic/
> and the mellanox bluefield drivers are doing. As I understand, they have the
> same requirements for console, but have a nicer approach of providing
> abstract 'virtio' channels between the PCIe endpoint and the host, and
> then run regular virtio based drivers (console, tty, block, filesystem,
> network, ...) along with application specific ones to provide the custom
> high-level protocols.

This has more value on the device than on the host, as far as I've
seen it used (if you want to boot Linux on it and have things
exposed).

virtio isn't necessarily a match if all you really want is a character
stream for a console and don't need (or have performance requirements
beyond what virtio offers) other types of communication.

> This is also similar to what the drivers/pci/endpoint
> (from the other end) as the drivers/ntb (pci host on both ends) frameworks
> and of course the rpmsg/remoteproc framework do.

remoteproc is more about booting a tightly integrated device on an
embedded system. Also not a match here IMHO.

> In the long run, I would want much more consolidation between the
> low-level parts of all these frameworks, but moving your high-level
> protocols to the same virtio method would sound like a step in the
> direction towards a generialized framework and easier sharing of
> the abstractions.

For a simple naive console/character stream, doing something on top of
hvc might be easier -- it already does polling for you, etc.

Of course, the intent is not to ever use it as a console for the host
here, so that aspect of hvc isn't useful. But it gives you a bunch of
other stuff for free with just getchar/putchar interfaces to
implement.


-Olof
