Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268AE1330E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgAGUyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 15:54:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36576 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGUyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:54:51 -0500
Received: from ip-109-41-1-29.web.vodafone.de ([109.41.1.29] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iovsF-0001ps-Uy; Tue, 07 Jan 2020 20:54:48 +0000
Date:   Tue, 7 Jan 2020 21:54:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: Re: [PATCH v9 0/4] Add pidfd_getfd syscall
Message-ID: <20200107205449.5dcp7o3hplg7r3fw@wittgenstein>
References: <20200107175927.4558-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107175927.4558-1-sargun@sargun.me>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:59:23AM -0800, Sargun Dhillon wrote:
> This patchset introduces a mechanism (pidfd_getfd syscall) to get file
> descriptors from other processes via pidfd. Although this can be achieved
> using SCM_RIGHTS, and parasitic code injection, this offers a more
> straightforward mechanism, with less overhead and complexity. The process
> under manipulation's fd still remains valid, and unmodified by the
> copy operation.
> 
> It introduces a flags field. The flags field is reserved a the moment,
> but the intent is to extend it with the following capabilities:
>  * Close the remote FD when copying it
>  * Drop the cgroup data if it's a fd pointing a socket when copying it
> 
> The syscall numbers were chosen to be one greater than openat2.
> 
> Summary of history:
> This initially started as a ptrace command. It did not require the process
> to be stopped, and felt like kind of an awkward fit for ptrace. After that,
> it moved to an ioctl on the pidfd. Given the core functionality, it made
> sense to make it a syscall which did not require the process to be stopped.
> 
> Previous versions:
>  V8: https://lore.kernel.org/lkml/20200103162928.5271-1-sargun@sargun.me/
>  V7: https://lore.kernel.org/lkml/20191226180227.GA29389@ircssh-2.c.rugged-nimbus-611.internal/
>  V6: https://lore.kernel.org/lkml/20191223210823.GA25083@ircssh-2.c.rugged-nimbus-611.internal/
>  V5: https://lore.kernel.org/lkml/20191220232746.GA20215@ircssh-2.c.rugged-nimbus-611.internal/
>  V4: https://lore.kernel.org/lkml/20191218235310.GA17259@ircssh-2.c.rugged-nimbus-611.internal/
>  V3: https://lore.kernel.org/lkml/20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal/
>  V2: https://lore.kernel.org/lkml/20191209070446.GA32336@ircssh-2.c.rugged-nimbus-611.internal/
>  RFC V1: https://lore.kernel.org/lkml/20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal/

I don't see anything wrong with this series anymore:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Other Acked-bys/Reviewed-bys and reviews of course strongly encouraged!
Christian
