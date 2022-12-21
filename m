Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6436539E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 00:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLUXsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 18:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUXsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:48:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF02333A;
        Wed, 21 Dec 2022 15:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5446181B;
        Wed, 21 Dec 2022 23:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B06C433D2;
        Wed, 21 Dec 2022 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671666514;
        bh=dfwaApWQ0HHasq7Na874WL021J+XeyqZRnuKNQdoIeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbiOFI5ce6MhuC0e2A8vQiFx/g2qB5m5bAuRy9qk5Mm6jsrk+zWBi3jlAng6HxqRS
         tkK0WMTApgo6M0Jbg3095s4Q1pMoYgKZS/ZWlc2VENkPe/bJziiHDjmGYr3gWqg0q/
         P5+W7XUBFaQXduCjSECo0Fbaa9symmfh45iWALREkyJEsVUmBrV0KR4cgEcWC69XAU
         8kNNFUCCnqTZJM2oskc545+E3tIgEQDhY12cdfhUl6fXV7rYVW+Hdy9jUErqQrqK/S
         rcWGayoxy12exGtux3xcFCjCAkcRBWcdnXHle4L7F66IcCQHm+yINcrctCpSdkJen2
         YhHnAN0ngueAA==
Date:   Wed, 21 Dec 2022 15:48:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Separate mailing list (and git and patchwork) for fsverity?
Message-ID: <Y6ObULdVm2UN5kw1@sol.localdomain>
References: <Y5jRbLEJh3S46Jer@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jRbLEJh3S46Jer@sol.localdomain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:24:28AM -0800, Eric Biggers wrote:
> Currently, fsverity development is reusing the same mailing list, git repo
> (though a different branch), and patchwork project as fscrypt --- mainly just
> because I was a little lazy and didn't bother to ask for new ones:
> 
> FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT
> [...]
> L:      linux-fscrypt@vger.kernel.org
> Q:      https://patchwork.kernel.org/project/linux-fscrypt/list/
> T:      git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
> [...]
> 
> FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
> [...]
> L:      linux-fscrypt@vger.kernel.org
> Q:      https://patchwork.kernel.org/project/linux-fscrypt/list/
> T:      git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
> [...]
> 
> I think this is causing some confusion.  It also makes it so that people can't
> subscribe to the list for just one or the other.
> 
> What would people say about having a separate mailing list, git repo, and
> patchwork project for fsverity?  So the fsverity entry would look like:
> 
> FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
> [...]
> L:      linux-fsverity@vger.kernel.org
> Q:      https://patchwork.kernel.org/project/linux-fsverity/list/
> T:      git git://git.kernel.org/pub/scm/fs/fsverity/fsverity.git
> [...]
> 
> For the branches in the git repo, I'm thinking of using 'for-next' and
> 'for-current'.  (I'd also update the fscrypt ones to match; currently they are
> 'master' and 'for-stable'.)
> 
> If people are okay with these changes, I'll send off the needed requests to
> helpdesk and linux-next to make these changes, and send Linus a pull request to
> update MAINTAINERS.  (And update fsverity-utils to point to the new list.)
> 

Any thoughts on this from anyone?

- Eric
