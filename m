Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943612135E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 10:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGCIMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 04:12:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbgGCIMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593763935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aL1ix2yKSa96qtp2+jnkXvtwe2HET4gQ2cg4dTxzFd8=;
        b=ZrVG7LgvDRAT79GS8Nx09aysPud6T7/DtUycSy7oh3Q7rWXuc9fjoXbxt8+U37/ZjdzO27
        WT/GFeq34mcTJZwzcb/HcP4vXwGc0WJj6wLxGPaulEW9ivKMgwAdVeDHrZx98g7n/h8AQ3
        W863BQQvAMf6VgHwNE9Q++51esQhWCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-AlCQ-sBIPX6HVMPStWsM3w-1; Fri, 03 Jul 2020 04:12:14 -0400
X-MC-Unique: AlCQ-sBIPX6HVMPStWsM3w-1
Received: by mail-wr1-f70.google.com with SMTP id e11so31105241wrs.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 01:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aL1ix2yKSa96qtp2+jnkXvtwe2HET4gQ2cg4dTxzFd8=;
        b=SQrYna83mDkvoYtWnjC5zKEe4Pte4sN/cF92gquxbc+AKhztZrzQKq+FsT4bYC6lyx
         ujipdT7q3S4IXCDihTVP5jAXwGQ9S7/WAjUQS2ob9ta9BMl8lxiphf8tp69nZMocGn3x
         +HwdlNsrhqhuKdFTft07jxThIiuPGwF93ucI0Aq8S6Xt8XJWT8GdDHM5oye0g/etoPt/
         e/8d3d+WWR6BZi7O7SUM+JzNs2w0+hlcWrrNCmPN/JuWgBeUuvm35nO4b8DjP9T87Tu8
         le8ILNFQB4LkTuLxz46EZKz9LwASCDl7u9W+vcZ78ABLsVP63TmIVP+LtNrByDD8y4YM
         FP3Q==
X-Gm-Message-State: AOAM53285HO8kpU0ze/nE/7JIbgOpVzWllxFG7SITX83b6zPvvbJtxPe
        HUefPS3AvhSYc4xxG6c4kfCmhLCwQXa7h8+w8jKFoGbhVLh6mXRQKxW97N+HzB785RW2SDybepO
        CbYxzpxnbCgqM/TLkiJxYHbSOSQ==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr36721017wmk.170.1593763932664;
        Fri, 03 Jul 2020 01:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJVYGoEOd49GzQeCEYy4tVXg5FJD/xHq5tF4vz9PCFVsuygmM68EUfqOhMRS1DSdtX7W+9zQ==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr36720996wmk.170.1593763932436;
        Fri, 03 Jul 2020 01:12:12 -0700 (PDT)
Received: from localhost.localdomain ([151.29.191.109])
        by smtp.gmail.com with ESMTPSA id v11sm49685250wmb.3.2020.07.03.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:12:11 -0700 (PDT)
Date:   Fri, 3 Jul 2020 10:12:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     zhe.he@windriver.com
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200703081209.GN9670@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410114720.24838-1-zhe.he@windriver.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 10/04/20 19:47, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
> 
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
> 
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
> 
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
> 
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---

Not sure if this approch can fly, but I also encountered the same
warning (which further caused hangs during VM install) and this change
addresses that.

I'd be interested in understanding what is the status of this problem/fix.

On a side note, by looking at the code, I noticed that (apart from
samples) all callers don't actually check eventfd_signal() return value
and I'm wondering why is that the case and if is it safe to do so.

Thanks,

Juri

