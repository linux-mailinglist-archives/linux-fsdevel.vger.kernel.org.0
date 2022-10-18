Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC918602504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJRHIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 03:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRHIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3866BD5F;
        Tue, 18 Oct 2022 00:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A10B46147B;
        Tue, 18 Oct 2022 07:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA899C433C1;
        Tue, 18 Oct 2022 07:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666076879;
        bh=Fj9VdPapWV4U5Y1IbjLNZkEft7nk+xSTK0xPlMf5QSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqiiypT/X4Mi6+oIg09YWnzQ1pcaPbHl6AtT7QUP0efAmdx4C87r8NdT83fk3rk24
         7bhbddb7xXglJZbhIRye0aeEQA1B3zTiEXb8shIkDsb9dgPF9QfJagb4uKzlbn2X/1
         jmLH4Kl4MQp3+ThgwiSTe+NkLViqj5d0DlvKmnEEeSHxJjcDMAG5HyZRVoOFRXhTdG
         GC54LvENZti2NWaPoQ+rQJB9o7ZIBVD6mtNZwm6Xe/7D644PscfKsxdBBwLhf+ovk7
         dNDVuNxvRRFFEn51EOVnjJRh4uu+6SmuV+fUKqILHpF1eJKH6sfMfWpqIDijKPZncb
         e6FkMYGLds4hw==
Date:   Tue, 18 Oct 2022 00:07:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 0/8] make statx() return DIO alignment information
Message-ID: <Y05QzQM2ed8sOJxC@sol.localdomain>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <YxfE8zjqkT6Zn+Vn@quark>
 <Yx6DNIorJ86IWk5q@quark>
 <20220913063025.4815466c@canb.auug.org.au>
 <20221018155524.5fc4e421@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018155524.5fc4e421@canb.auug.org.au>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:55:24PM +1100, Stephen Rothwell wrote:
> Hi Eric,
> 
> On Tue, 13 Sep 2022 06:30:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > On Sun, 11 Sep 2022 19:54:12 -0500 Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > Stephen, can you add my git branch for this patchset to linux-next?
> > > 
> > > URL: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
> > > Branch: statx-dioalign
> > > 
> > > This is targeting the 6.1 merge window with a pull request to Linus.  
> > 
> > Added from today.
> 
> I notice that this branch has been removed.  Are you finished with it
> (i.e. should I remove it from linux-next)?
> 

Yes, I think so.  This patchset has been merged upstream.  Any more patches
related to STATX_DIOALIGN should go in through the VFS or filesystem-specific
trees.

- Eric
