Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B369F45D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 13:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjBVMTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 07:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBVMTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:19:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6DA38654
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 04:18:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50FB6B812AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 12:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C876DC433D2;
        Wed, 22 Feb 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677068198;
        bh=0FFKXjJuKrOLXsl1KVqqjL0bjWfISrxIpFQKxTMwogY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZn5+/ext0H7N+bfYZGHWrMkkUNWHPNE6/SgTBZjroEKU3MPCQ/esnCXlbtM9ujRb
         S1KzAllJCdN3hhxNJs5j0MgF8iaqH9CVhfJLQvw0a/9bxrvcu8OBR8bpEz2X29XB3U
         UauOy53ZOQjzukUzO1JT0Lv1xySQNrysxBHdbK4XwgNxIdP6ErcklOYES6URr9tERr
         +63R3V7Rf/OrWD+spUjPNpEeO9UFwAOrX88UZNzCyNbi1xxwBzuSgt2ySxRZnzNZ2p
         NaoPGuM7sNT8TR7593MhbYcILpJY6TeGKgQp7CTuaXlBz9PxgoeXZsViGiSXnfT0hI
         M8USVScHw8f0A==
Date:   Wed, 22 Feb 2023 13:16:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] zonefs changes for 6.3-rc1
Message-ID: <20230222121632.orfbx5dxiajmayse@wittgenstein>
References: <20230222010246.1090081-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230222010246.1090081-1-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:02:46AM +0900, Damien Le Moal wrote:
> Linus,
> 
> The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:
> 
>   Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc1
> 
> for you to fetch changes up to 2b188a2cfc4d8f319ad23832ec1390bdae52daf6:
> 
>   zonefs: make kobj_type structure constant (2023-02-13 08:03:48 +0900)
> 
> Please note that this pull request generates a conflict if fs/zonefs/super.c
> between commits:
> 
>   c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
>   f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
>   f861646a6562 ("quota: port to mnt_idmap")
> 
> from the vfs-idmapping tree and commits:
> 
>   4008e2a0b01a ("zonefs: Reorganize code")
>   d207794ababe ("zonefs: Dynamically create file inodes when needed")
> 
> from the zonefs tree. The conflict resolution looks very messy but is in fact
> only due to a few lines. I am including the resolution diff below for your
> reference.

Linus just fyi, I referenced this at the end of my pull request as well
but I was under the impression that the merge conflict had been resolved
in the meantime. Since it hasn't, thank you for providing the
resolution, Damien! I appreciate it.

Christian
