Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD95623A8FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHCO42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgHCO41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:56:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BACDC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 07:56:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b79so35304128qkg.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uoxUh7w9S9WoHetqVWaE7PcRU88z96URBWxyZ+DAwkc=;
        b=gJfhM6esZzSfXkUvP5yQrCmFvH8pvz4rJ+mEBVt7IlRuA6L3Y8qq1USaYHHgw5mOQ5
         l1z+gyKki5iyIqvlp4BgRrKd7gdcnw7HGeYtxpcbn/z1xWf3k1IBd3kjKGBKgFG08Tqt
         x3q0RiWPelTZDyOz5bVJSh4JZ927D/eswkAe8OXZ9bXVuWzWY0FauBGvH+w+EkW9L/g5
         qDNxk1OifG1rBTL73R8+tRFWskO4NTDBQzhRPb8QA3WtJWfTL65MvhSausBX+rymJ6Yo
         cJo5oNM9Hmw+g5rPAjw5TrCks1EV6nddKOL7VQG4u7dSbYwP7oqt19nuMN+mSOMa9NSF
         wjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uoxUh7w9S9WoHetqVWaE7PcRU88z96URBWxyZ+DAwkc=;
        b=iOCOCfBaZLYb8AZC9gHX7uOjThAwHnIwK3swYPJuq+uDrlto6CHQ7ROIMeXZEuiXD/
         61BAL6RN0BWVBfjGuCsvbgaFYAfJIjPhK0USlV0p67rqlmdtOSoYBsvq6tsQKHt9K8Mt
         SAMQxIF4VloBUN0WFLT1Q/TSy0kVw3+zEzjvL0ux0E3ggyj8xga7JwAAPsXv0r7WwenX
         ml03/uUwFrN9jXaatjlWg7T79H7tfhwep1Y1oRpA0ARuPZEBfwjlXJBHBLcKOWy/WbA7
         HPoocp3tYOx6FmGBkS/28LZsJyHsxdFQWClP1YvRjV/LDdiw1IlbCcyDzxwH1zD7rhVl
         ZPKg==
X-Gm-Message-State: AOAM531ysh4tVMVz4iVZa7lHbHTSrES/0lgG9yYEIFZCfuINt+KkWzGw
        acTqlyPXUyUgi4kVxgTygWOe2Q==
X-Google-Smtp-Source: ABdhPJybT0NeMC+s5f4yB6V+6S6WlOdq+mDZaFmpgmNNrtR1kY4sdRYJIO1H091jYtQK+uaIOX0MRQ==
X-Received: by 2002:a37:910:: with SMTP id 16mr15814433qkj.466.1596466586662;
        Mon, 03 Aug 2020 07:56:26 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i65sm20542228qkf.126.2020.08.03.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:56:25 -0700 (PDT)
Date:   Mon, 3 Aug 2020 10:56:23 -0400
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: add file system helpers that take kernel pointers for the init
 code v4
Message-ID: <20200803145622.GB4631@lca.pw>
References: <20200728163416.556521-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:33:53PM +0200, Christoph Hellwig wrote:
> Hi Al and Linus,
> 
> currently a lot of the file system calls in the early in code (and the
> devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> This is one of the few last remaining places we need to deal with to kill
> off set_fs entirely, so this series adds new helpers that take kernel
> pointers.  These helpers are in init/ and marked __init and thus will
> be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> though unfortunately.

Reverting this series from next-20200803 fixed the crash below on shutdown.

[ 7303.287890][    T1] systemd-shutdown[1]: All loop devices detached.
[ 7303.287930][    T1] systemd-shutdown[1]: Detaching DM devices.
[ 7303.441674][    T1] printk: shutdown: 9 output lines suppressed due to ratelimiting
[ 7303.443999][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
[ 7303.444027][    T1] CPU: 120 PID: 1 Comm: shutdown Not tainted 5.8.0-next-20200803 #2
[ 7303.444053][    T1] Call Trace:
[ 7303.444069][    T1] [c000000015d27b70] [c0000000006f3778] dump_stack+0xfc/0x174 (unreliable)
[ 7303.444103][    T1] [c000000015d27bc0] [c0000000000c9328] panic+0x214/0x4ac
[ 7303.444140][    T1] [c000000015d27c60] [c0000000000d4d28] do_exit+0xda8/0xee0
[ 7303.444178][    T1] [c000000015d27d60] [c0000000000d4f1c] do_group_exit+0x5c/0xd0
list_empty at include/linux/list.h:282
(inlined by) thread_group_empty at include/linux/sched/signal.h:671
(inlined by) do_group_exit at kernel/exit.c:888
[ 7303.444205][    T1] [c000000015d27da0] [c0000000000d4fac] sys_exit_group+0x1c/0x20
sys_exit_group at kernel/exit.c:914
[ 7303.444234][    T1] [c000000015d27dc0] [c00000000002c628] system_call_exception+0xf8/0x1d0
[ 7303.444262][    T1] [c000000015d27e20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 7304.936912][    T1] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100 ]---

> 
> The series sits on top of my previous
> 
>   "decruft the early init / initrd / initramfs code v2"
> 
> series.
> 
> 
> Git tree:
> 
>     git://git.infradead.org/users/hch/misc.git init_path
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/init_path
> 
> 
> Changes since v3:
>  - rename fs/for_init.c to fs/init.c
>  - document the purpose of the routines in fs/init.c with a comment
>  - don't mark devtmpfs __init as that will cause it to get overwritten
>    by initmem poisoning
>  - add an init_dup helper to make Al more happy than with the version
>    commit to the "decruft the early init / initrd / initramfs code v2"
>    series
> 
> Changes since v2:
>  - move to fs/for_init.c
>  - reuse the init routines in devtmpfs after refactoring devtmpfsd
>    (and thus the broken error handling in the previous version)
>  - actually use kern_path in a place where user_path_at sneaked back in
> 
> Changes since v1:
>  - avoid most core VFS changes
>  - renamed the functions and move them to init/ and devtmpfs
>  - drop a bunch of cleanups that can be submitted independently now
> 
> 
> Diffstat:
