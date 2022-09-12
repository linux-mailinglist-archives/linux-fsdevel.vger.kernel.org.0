Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B667D5B5256
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 02:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiILAyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 20:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILAyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 20:54:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF6927CF5;
        Sun, 11 Sep 2022 17:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F007B80C68;
        Mon, 12 Sep 2022 00:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F45C433D6;
        Mon, 12 Sep 2022 00:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662944059;
        bh=WDVtmnzEsaEU55TuvLxBRymxTuYaVUC9hgjRIe0bHt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoxnvrqSSY20wV65g7z6/rwjE02vykYR2j0xgsMFiTFS3wcFoXQgc7ddRv8HVfb3f
         Kwr6X2fw2mafz42Qbx5YdEIQQnsRulU5GDprmsG01tejmSwgFvr4Jx1B47ZL2SiCcG
         Eyn7qIRIzb0YqpOmcociLL5XyxfDzbh0zkynyL7M0TA1icIoVgkGtGXOVtBvjI1oIN
         Iw8cbqxwN+hQUZueBTkmVgQV2RAaCxx5KdzDrA5EkbLK7xfUqnQisUx0ldrLzg3M1r
         oaH/BIP5FZbUDfOMoORvOPkiaFMoOUQT1g/YGC/jN8fIFwm06y/Lc3y+CcDBzZnAwH
         78iOtWwzF2Ivg==
Date:   Sun, 11 Sep 2022 19:54:12 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 0/8] make statx() return DIO alignment information
Message-ID: <Yx6DNIorJ86IWk5q@quark>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <YxfE8zjqkT6Zn+Vn@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxfE8zjqkT6Zn+Vn@quark>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:08:51PM -0700, Eric Biggers wrote:
> On Fri, Aug 26, 2022 at 11:58:43PM -0700, Eric Biggers wrote:
> > This patchset makes the statx() system call return direct I/O (DIO)
> > alignment information.  This allows userspace to easily determine
> > whether a file supports DIO, and if so with what alignment restrictions.
> 
> Al, any thoughts on this patchset, and do you plan to apply it for 6.1?  Ideally
> this would go through the VFS tree.  If not, I suppose I'll need to have it
> added to linux-next and send the pull request myself.
> 
> - Eric

Seems that it's up to me, then.

Stephen, can you add my git branch for this patchset to linux-next?

URL: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
Branch: statx-dioalign

This is targeting the 6.1 merge window with a pull request to Linus.

Thanks!

- Eric
