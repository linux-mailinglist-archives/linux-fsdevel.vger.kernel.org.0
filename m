Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BAE6EFDD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjDZXHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjDZXHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AFC1BD3;
        Wed, 26 Apr 2023 16:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A4E63997;
        Wed, 26 Apr 2023 23:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2946C4339B;
        Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682550440;
        bh=EzrAzHGqX33HLlqpfsl59P+BWciRL4LLNL4FJ5YxYiw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=huemn0yp2XzRUtzI1j/YWNYRt1QKV1SVDVfajDMru9/LkNbnuOgXFP3lMOAewzkEw
         SFF3oLTNxd72taeJdoC8laOtlFG8z9pxPaFk08isrDw/5LQ+gUxIpqOwd2IOZSFHNw
         4HYKoKLprsc12RNLmO3wSw8omR8cHmCcDPa7+6xfQmB55f1oTV8EE1H27j6Pls93PV
         Vp8gC4W2lzsIGyOAAPyzt57VCNGwzu0LHwHQBJ7Pg0/TaE/8XeLwZP00zH/DE2R/VR
         NQgC/FuN1OP8CVZJl+9K/8e1+I0LNNqhbulyDD+LaQvunkEVwhC25NS9T0BTLO3FNI
         B6MP2MQraMVWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB86DE5FFC8;
        Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 0/8] acl: remove generic posix acl handlers
 from all xattr handlers
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168255044069.16014.2458183090274454828.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Apr 2023 23:07:20 +0000
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        reiserfs-devel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        sforshee@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner (Microsoft) <brauner@kernel.org>:

On Mon, 30 Jan 2023 17:41:56 +0100 you wrote:
> Hey everyone,
> 
> after we finished the introduction of the new posix acl api last cycle
> we still left the generic POSIX ACL xattr handlers around in the
> filesystems xattr handler registered at sb->s_xattr for two reasons.
> First, because a few filesystems rely on the ->list() method of the
> generic POSIX ACL xattr handlers in their ->listxattr() inode operation.
> Second, during inode initalization in inode_init_always() the registered
> xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
> inode->i_opflags.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,6/8] fs: simplify ->listxattr() implementation
    https://git.kernel.org/jaegeuk/f2fs/c/a5488f29835c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


