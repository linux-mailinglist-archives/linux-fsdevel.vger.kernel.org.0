Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5F37FA67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhEMPQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 11:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhEMPP7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 11:15:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8501C61406;
        Thu, 13 May 2021 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620918887;
        bh=lvISWgCHqfDjlJaGVkO7Xg7MmWmSFb0/oMlT49Ld9Eo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y53olRElXk6w7ILXRmCrP6SlN0fwUP3L2li2hqoEs+uwcJ2SEbgrWit+/+Nqd2cqi
         G+qW4fikwoQrhAouGtk166RZzVx6Pd6FEwZ9DrgPyzSCxxTsRW/OUczJy688dWLhHB
         Zl5B8dRSH72HqomxduxvvtcLdpHrE0YW/4Q/KqsqqYOM96Js4f6Ua0kE9XoQ8PXdqf
         tpio6vqE/c8Yd7Iwy/16cpLLSZ+CpSOlsmN7lo/Qs8g6tHtfiomHxzqXXHJLh+Ui+A
         dZbsMrp7Y5jnzSY0t6W8cuzJUrVcpm5oL68+XuLDkpRm+zJCLm5yEdXuzqW9M2gw/1
         hsB2eExu6Eegg==
Message-ID: <69b577faaff376bde047edb9dfbda0b770ab0ca4.camel@kernel.org>
Subject: Re: [PATCH] netfs: Make CONFIG_NETFS_SUPPORT auto-selected rather
 than manual
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, geert@linux-m68k.org
Cc:     linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date:   Thu, 13 May 2021 11:14:45 -0400
In-Reply-To: <162090298141.3166007.2971118149366779916.stgit@warthog.procyon.org.uk>
References: <162090298141.3166007.2971118149366779916.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-05-13 at 11:49 +0100, David Howells wrote:
> Make the netfs helper library selected automatically by the things that use
> it rather than being manually configured, even though it's required.
> 
> Fixes: 3a5829fefd3b ("netfs: Make a netfs helper module")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-mm@kvack.org
> cc: linux-cachefs@redhat.com
> cc: linux-afs@lists.infradead.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: ceph-devel@vger.kernel.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/CAMuHMdXJZ7iNQE964CdBOU=vRKVMFzo=YF_eiwsGgqzuvZ+TuA@mail.gmail.com
> ---
> 
>  fs/netfs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
> index 578112713703..b4db21022cb4 100644
> --- a/fs/netfs/Kconfig
> +++ b/fs/netfs/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  config NETFS_SUPPORT
> -	tristate "Support for network filesystem high-level I/O"
> +	tristate
>  	help
>  	  This option enables support for network filesystems, including
>  	  helpers for high-level buffered I/O, abstracting out read
> 
> 

Makes sense. No one is going to enable this w/o a fs that uses it, so
might as well make it automagic.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

