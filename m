Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7615A4EC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiH2OFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiH2OFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A14D12774;
        Mon, 29 Aug 2022 07:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 988FA60EFF;
        Mon, 29 Aug 2022 14:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88248C433D6;
        Mon, 29 Aug 2022 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661781905;
        bh=cwGcbZqZdPxg0smFd+twhvuBiWgn2+zCOBNbQ5ivJG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2lGtrVQjiHKIC8t1Pf7QpN0PZXlSRlDSt3cuUJnxG3KwzApk3h7O+J9BUN2bIkFs
         nBrv4RTv/KY/0fYG8VbRo10l9QeMPYKWLL0cy46ihZyy8k7wz1CqmKLAEqSGYqC2Vo
         lH45AbZ8qfI+/HiIm58Ydo2rTvpj9gMrbOKk1SlC4QN8N6m3TxqzMOcCC/xxCdkK2b
         o0a00YkvbdeZpKcV4QxZC7sodEA9K46Rv8dWQxFII0sVDnaEbAPnxBne+Oo2IE805y
         iuG30VXxw3H+XYisfQt8OOM4XsH6GWUY+Q6tGu5Ht+R/d7GNAaSg9PYsdDyECJd+mR
         FxyXyGt57F5sA==
Date:   Mon, 29 Aug 2022 16:05:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jules Maselbas <jmaselbas@kalray.eu>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/afs: Fix repeated word in comments
Message-ID: <20220829140500.muhtvecw5e3jwmez@wittgenstein>
References: <20220826100052.22945-8-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826100052.22945-8-jmaselbas@kalray.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc afs development list + maintainer]

On Fri, Aug 26, 2022 at 12:00:36PM +0200, Jules Maselbas wrote:
> Remove redundant word `the`.
> 
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---
>  fs/afs/flock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/afs/flock.c b/fs/afs/flock.c
> index c4210a3964d8..801fe305878f 100644
> --- a/fs/afs/flock.c
> +++ b/fs/afs/flock.c
> @@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
>  }
>  
>  /*
> - * Kill off all waiters in the the pending lock queue due to the vnode being
> + * Kill off all waiters in the pending lock queue due to the vnode being
>   * deleted.
>   */
>  static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
> -- 
> 2.17.1
> 
