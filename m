Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E0654563
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 17:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiLVQv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 11:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiLVQvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:51:54 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802930F5E
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 08:51:53 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BMGpOt9009971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 11:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671727886; bh=8VQE476fItcQEyvNi8YKNC8SHTVYFOvKq/RWJ11ZYc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y1HUp4TlkjWs/IvOpsjLbqbpZe+niMvbTyQFgq18Rn7JlP6ObL6lD9ZL5Xnb/S0ue
         7iHqTFmahQYKRygUKPKZDG8lqTJ8ZzzJIfFiovx5n6ShIphokTD5AF1yJhNOU8A8O2
         hyU19A5xaWaML2UA+BXAGFCY3f51984ew9C5fSNV8mrd9gB2NefJn6U/o338pQKl16
         bWZ/t/Sf4bjjkjzOCuuRpEy4IFbCPX2c+X/kAQAFZW9JzTBbaQhIiLnUcUTH6208gg
         7unZOMQnyuw8bTiHMGjyn04+lWpvvkSCvQzOVH/QpmmM3Q4olO1oAhAP6SHieRES+t
         JdB6A/aagyooQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C831615C39F2; Thu, 22 Dec 2022 11:51:23 -0500 (EST)
Date:   Thu, 22 Dec 2022 11:51:23 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Separate mailing list (and git and patchwork) for fsverity?
Message-ID: <Y6SLC9DG1s/4NhPL@mit.edu>
References: <Y5jRbLEJh3S46Jer@sol.localdomain>
 <Y6ObULdVm2UN5kw1@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6ObULdVm2UN5kw1@sol.localdomain>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 03:48:32PM -0800, Eric Biggers wrote:
> > What would people say about having a separate mailing list, git repo, and
> > patchwork project for fsverity?  So the fsverity entry would look like:
> > 
> > FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
> > [...]
> > L:      linux-fsverity@vger.kernel.org
> > Q:      https://patchwork.kernel.org/project/linux-fsverity/list/
> > T:      git git://git.kernel.org/pub/scm/fs/fsverity/fsverity.git
> > [...]

This makes sense to me.  I wonder if we should use the new
https://lists.linux.dev mailing list hosting service with a mailing
list name fsverity@lsts.linux.dev?

The thinking was that we would eventually migrate lists from vger to
the new list infrastructure, so it might make sense to just use it for
a new list.  All mailing lists lists.linux.dev are archived on
lore.kernel.org, so other than the e-mail address and using something
a bit more modern than Majordomo for list management, it's mostly the
same.

						- Ted
