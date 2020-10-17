Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9C291517
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Oct 2020 01:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439938AbgJQX7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 19:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439921AbgJQX7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 19:59:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4630C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2020 16:59:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q9so8672276iow.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2020 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h2GtTlshfWWUrnm7ALXf8OWo2w1JGw4rOyTg09mkVyQ=;
        b=ApP7c5sXrBNPlNOq+WcG1+06dnSbHDjMN70f3T4VJGPh1N27Qb/LtYEGbhNfSHBb7B
         nLR4DA01wYpPOnLgEiNsu6tBSIpmzoNeGFiWGS8Dx8OVcLpr+QWfzIThlZrTChAH7e/z
         6RT+zavq8V9k4N627FbdpMzyYwlBswSG7Prds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2GtTlshfWWUrnm7ALXf8OWo2w1JGw4rOyTg09mkVyQ=;
        b=meG0j1GkIXHbRybCqgC9+wc+naNzqdzojzCNe9JKYmKHcEg70n3DZsZLhCbqjclXz6
         a/RKReRrfIO5cd3L3ul+6q3hqcjWVpiuOhEFou82ojPrbjOVLuEj4+AOviSi/nTxPaFE
         0ZL/DYUOOqhFjDeYXmOdVnPSXYUVj5hIgi5K5NT6KQEB1MO/qAa9d+q9EkMchtoTStbO
         slziud+RsRpGGPBuVUpKuW/tnPS5pE8pGZK3EigxP33dmlJHyA2ln3uhaT/ue5p7ruLL
         gLtEV+Uuh59s/LhEzSojxDHFdEZvTNoJpKgmOxj9cVvy7ltX+RoaYKVLWp26nR5u5Xy/
         FRPg==
X-Gm-Message-State: AOAM532jC6R24A7hemjf5DV/LrG1LbSnwUIuXX4dfGs0sVnKIJMmTuXf
        9KeXS6XaP7AZMyagazDX6M1mqg==
X-Google-Smtp-Source: ABdhPJxOO/JhWm5ou5JikonWGPY7wHpCNLut3YTQOFiVBKXQY0qVFd6+y5r7mn+ejRfpXC6oQGaPdw==
X-Received: by 2002:a02:6d4b:: with SMTP id e11mr6791283jaf.41.1602979176779;
        Sat, 17 Oct 2020 16:59:36 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id e11sm6726478ioq.48.2020.10.17.16.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Oct 2020 16:59:36 -0700 (PDT)
Date:   Sat, 17 Oct 2020 23:59:34 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] NFS User Namespaces with new mount API
Message-ID: <20201017235933.GA1516@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201016124550.10739-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016124550.10739-1-sargun@sargun.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:45:47AM -0700, Sargun Dhillon wrote:
> This patchset adds some functionality to allow NFS to be used from
> NFS namespaces (containers).
> 
> Changes since v1:
>   * Added samples
> 
> Sargun Dhillon (3):
>   NFS: Use cred from fscontext during fsmount
>   samples/vfs: Split out common code for new syscall APIs
>   samples/vfs: Add example leveraging NFS with new APIs and user
>     namespaces
> 
>  fs/nfs/client.c                        |   2 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
>  fs/nfs/nfs4client.c                    |   2 +-
>  samples/vfs/.gitignore                 |   2 +
>  samples/vfs/Makefile                   |   5 +-
>  samples/vfs/test-fsmount.c             |  86 +-----------
>  samples/vfs/test-nfs-userns.c          | 181 +++++++++++++++++++++++++
>  samples/vfs/vfs-helper.c               |  43 ++++++
>  samples/vfs/vfs-helper.h               |  55 ++++++++
>  9 files changed, 289 insertions(+), 88 deletions(-)
>  create mode 100644 samples/vfs/test-nfs-userns.c
>  create mode 100644 samples/vfs/vfs-helper.c
>  create mode 100644 samples/vfs/vfs-helper.h
> 
> -- 
> 2.25.1
> 

Digging deeper into this a little bit, I actually found that there is some 
problematic aspects of the current behaviour. Because nfs_get_tree_common calls 
sget_fc, and sget_fc sets the super block's s_user_ns (via alloc_super) to the 
fs_context's user namespace unless the global flag is set (which NFS does not 
set), there are a bunch of permissions checks that are done against the super 
block's user_ns.

It looks like this was introduced in:
f2aedb713c28: NFS: Add fs_context support[1]

It turns out that unmapped users in the "parent" user namespace just get an 
EOVERFLOW error when trying to perform a read, even if the UID sent to the NFS 
server to read a file is a valid uid (the uid in the init user ns), and 
inode_permission checks permissions against the mapped UID in the namespace, 
while the authentication credentials (UIDs, GIDs) sent to the server are
those from the init user ns.

[This is all under the assumption there's not upcalls doing ID mapping]

Although, I do not think this presents any security risk (because you have to 
have CAP_SYS_ADMIN in the init user ns to get this far), it definitely seems
like "incorrect" behaviour.

[1]: https://lore.kernel.org/linux-nfs/20191120152750.6880-26-smayhew@redhat.com/
