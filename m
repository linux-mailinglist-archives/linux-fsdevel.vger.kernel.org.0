Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA13CC479
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhGQQjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 12:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhGQQjS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 767CE61159;
        Sat, 17 Jul 2021 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626539781;
        bh=aS/8fXKGqP+eRkRmy4zGdgvreLyHM+o3rXjR4DSYef4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcY0aTikovMEKpcRgpONj6NzjFolN5kFoimT1/1jnxNIhCMiOhY3hu+aQYoI4isg3
         CtT1zwAb+v0CbL1vFwXZivuc3OYqEVS9W0TfHKPsr1HF1y5kHfnEKPskJMvvMN8cRg
         jokzTFQ2kbK5aEfrUnuNhWFARgFc/7Y7YdkhM+wZ5aeW4hjw1rqH+d7nWoote3K8zG
         XijF6pT5q4SvZt8IVrcLBBQ2xrYG1LJmMAmWyztgbwqIOXkjrvO5hW0XN4xiMZIqdg
         93KJkWL//yUYCpTRMTDX8juYeTqXVNeplzpvsHYWvUTQdpysk0cwEPAHieg0k7IbN1
         Cqky9kQHl8Eqg==
Received: by pali.im (Postfix)
        id EF34895D; Sat, 17 Jul 2021 18:36:18 +0200 (CEST)
Date:   Sat, 17 Jul 2021 18:36:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210717163618.vt6zjnhaiey6l64m@pali>
References: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

I would like to remind that there are still two open questions about
this ntfs driver which needs to be resolved by vfs maintainers (Al?)
prior merging / accepting this driver into kernel tree.

1) Should this new ntfs driver use and implement old FAT ioctl calls?
These ioctls are added in patch: Add file operations and implementation.
First time I wrote about them in email:
https://lore.kernel.org/linux-fsdevel/20200921133647.3tczqm5zfvae6q6a@pali/

2) Should kernel have two ntfs drivers? And if yes, how they would
interact to userspace? Both Christoph and me think that not, see email:
https://lore.kernel.org/linux-fsdevel/20201031085142.GA5949@lst.de/
