Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2C30D2DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 06:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBCFXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 00:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhBCFXA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:23:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DCBD64E24;
        Wed,  3 Feb 2021 05:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612329738;
        bh=cLNqVKFCW+BN80pXVHFeKzr4oNTwQ9E0KfoXAi7zrIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaO5bxjyzzw4Vmr+uTv4uCsf/zpdHQr4gp8MCzgkAGOsj90nf+8Oam6AoppLSCIz9
         k10PqVSkqMADuT3ByUx3l1QLCUZj+BDYyGHCPNqHu4TkbMvU4I50pinhH6nAF/5lLL
         W1voVC4IyjK+pvUdKyjcCaFAUEDsJMcD1DwFKACXP81UwQ1sznnELlVsK+LzzjMT+y
         m0UpuTHHJetNKJwrqadmF/jaBH9pNbesr38OjLVoo1wWqOK3O3qFVk9ryn/2qHgOf/
         NZ2//TuHHKXad0zqMT4I0L0UzRyng5NrMy5nuNUcUqlTHs58RBTLh2YwG7Nmf6wpdL
         35iiURpKWp4Fg==
Date:   Tue, 2 Feb 2021 21:22:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/12] lazytime fix and cleanups
Message-ID: <YBozCMnv1BT8ZyXG@sol.localdomain>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210111151517.GK18475@quack2.suse.cz>
 <X/y4s12YrXiUwWfN@sol.localdomain>
 <YBowmPPHfZUTBgz1@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBowmPPHfZUTBgz1@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:11:52AM -0500, Theodore Ts'o wrote:
> On Mon, Jan 11, 2021 at 12:44:35PM -0800, Eric Biggers wrote:
> > > 
> > > The series look good to me. How do you plan to merge it (after resolving
> > > Christoph's remarks)? I guess either Ted can take it through the ext4 tree
> > > or I can take it through my tree...
> > 
> > I think taking it through your tree would be best, unless Al or Ted wants to
> > take it.
> 
> I'm happy to take it through the ext4 tree.  Are you planning on
> issuing a newer version of this patch series to resolve Christoph's
> comments?
> 
> 					- Ted

I already sent out v3 of this series several weeks ago
(https://lkml.kernel.org/r/20210112190253.64307-1-ebiggers@kernel.org),
and Jan applied it already.

- Eric
