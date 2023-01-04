Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215CE65CCEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 07:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjADGSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 01:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjADGSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:18:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B29EE3E;
        Tue,  3 Jan 2023 22:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BDDB615AF;
        Wed,  4 Jan 2023 06:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D047C433D2;
        Wed,  4 Jan 2023 06:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672813098;
        bh=DBY4jMEWOuEAJNxXAZ5rQGraJjDahePvtutNdyhGoYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBmEiefA3TOk9FCHuqvw17zbZUJREr6j9bKMK1k2EJf0l3mgnCPAB28AQQbEfNKgU
         XtZViSO+OWn+QAfZvWJpzaz9UYxy5qrK6LLBG5DFYwy+sBBgXDT17fjM3MbbvyBsB+
         sdcELjlC2rBFGROjYj1nipCoSLz+rOUzykpsox0WVLZpbFRnhOV0dS4Xcia6cUQo9g
         TV/NYAhkxUXzDuF2Mr4tVMuLer6kpt/v9VSzrupmxtupwau7DWlN446lVja6CN6b+O
         l84fFh/w7n+zKdYEsOUkJiwFrTslui8UlO0sbfpDHwzP6hI6+heKBq4FeDXtFSFKpE
         yrAPd7EycKjpw==
Date:   Tue, 3 Jan 2023 22:18:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Separate mailing list (and git and patchwork) for fsverity?
Message-ID: <Y7UaKGqKPHsZyZn8@sol.localdomain>
References: <Y5jRbLEJh3S46Jer@sol.localdomain>
 <Y6ObULdVm2UN5kw1@sol.localdomain>
 <Y6SLC9DG1s/4NhPL@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6SLC9DG1s/4NhPL@mit.edu>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:51:23AM -0500, Theodore Ts'o wrote:
> On Wed, Dec 21, 2022 at 03:48:32PM -0800, Eric Biggers wrote:
> > > What would people say about having a separate mailing list, git repo, and
> > > patchwork project for fsverity?  So the fsverity entry would look like:
> > > 
> > > FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
> > > [...]
> > > L:      linux-fsverity@vger.kernel.org
> > > Q:      https://patchwork.kernel.org/project/linux-fsverity/list/
> > > T:      git git://git.kernel.org/pub/scm/fs/fsverity/fsverity.git
> > > [...]
> 
> This makes sense to me.  I wonder if we should use the new
> https://lists.linux.dev mailing list hosting service with a mailing
> list name fsverity@lsts.linux.dev?
> 
> The thinking was that we would eventually migrate lists from vger to
> the new list infrastructure, so it might make sense to just use it for
> a new list.  All mailing lists lists.linux.dev are archived on
> lore.kernel.org, so other than the e-mail address and using something
> a bit more modern than Majordomo for list management, it's mostly the
> same.
> 
> 						- Ted

Thanks Ted!  I'm half-tempted to still use linux-fsverity@vger.kernel.org, for
consistency with most of the existing lists...  But it does seem that the ship
on new lists using lists.linux.dev has already sailed.  So I think I'll go with
fsverity@lists.linux.dev.

Any other opinions from anyone on this, or on the proposed new git repo and
branches, before I send off the helpdesk request?

- Eric
