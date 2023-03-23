Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE906C683C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCWM0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCWM0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A4027D51;
        Thu, 23 Mar 2023 05:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E391D6267B;
        Thu, 23 Mar 2023 12:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8231C433D2;
        Thu, 23 Mar 2023 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679574366;
        bh=hSIUlO1HxyEpsf7qIxo9KBJ0VL8excdKGJYYFukRPL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6MeQSnsMeVy2O0Vk8RTY0vHNrmj2AIgXtab/TGNOFfzWTZud+JQGikV8JyH/6bL2
         HXj5AQv7PGMyWu5gO4aQNckaFR7jMxyPlxC/GN/SkGd9UjEckISINsL0GjCLdhE22C
         5zuGNqdawoE4Z0VJ+MBNSEjFCrSN9mJPfzKZRDpc=
Date:   Thu, 23 Mar 2023 13:26:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, rafael@kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] kobject: introduce kobject_del_and_put()
Message-ID: <ZBxFW5Yi0rwLvTsx@kroah.com>
References: <20230322165830.55071-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322165830.55071-1-frank.li@vivo.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:58:30AM +0800, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -convert to inline helper
> v2:
> -add kobject_del_and_put() users
>  include/linux/kobject.h | 13 +++++++++++++
>  lib/kobject.c           |  3 +--
>  2 files changed, 14 insertions(+), 2 deletions(-)

Meta-comment, something is wrong with this email as it is not linked to
the rest of the series.

You can see that by looking at this message in lore.kernel.org:
	https://lore.kernel.org/r/20230322165830.55071-1-frank.li@vivo.com

No 2-10 patches linked there (they show up as a separate series.)

So even if I wanted to take this series now, we can't as our tools can't
find them...

thanks,

greg k-h
