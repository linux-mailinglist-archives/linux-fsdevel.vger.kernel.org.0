Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F203C55A677
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiFYDLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 23:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFYDLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:11:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481369988;
        Fri, 24 Jun 2022 20:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E6B4B8216B;
        Sat, 25 Jun 2022 03:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D834CC34114;
        Sat, 25 Jun 2022 03:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656126663;
        bh=kVaUrRS0BBe7WiOdmUXAm8KCrP62LmXzg0L4lJ0jQSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/++7NbtvvX7um9vYzK00E7pGt2oSlb6nZwKcjujY7mGjKRnfbEXuDlMR/1sHvzS7
         BUn2Me247rRoMqLLQ+ncIZuaEpMTbyQU96AzqVB4HDXYV83hKeIfECkRAp0rYnIbIa
         nAmVo5Z1JDepeA2yerW6XojpT4S2lkx2hdSHlk4lDPlq8JkbzzwgJgncN6pHbgPmd2
         wedhaH+71IpJS0F/cNUw0pvTgAyEymPScDRU4vzQYn8CHcyj7Z8dopGRGHAXZwtn2R
         pttyP0Za08RwwzVA5A+7c8jNodcLLUJv14XTXgOVH/L2muIzgnUEvEoIbrOF23KQGb
         qobCR8UmXhyzw==
Date:   Fri, 24 Jun 2022 20:11:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Tso <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Delegating fstests maintenance work (Was: Re: [PATCH 3/4]
 xfs/{422,517}: add missing killall to _cleanup())
Message-ID: <YrZ8x9/PUpBe9mtX@magnolia>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
 <YrSrLgU1OIgaaxiB@magnolia>
 <CAOQ4uxjCUdzVdMUR9gj4xHfS-wHo5HsJnkTAAWjKeEwdVvX5iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjCUdzVdMUR9gj4xHfS-wHo5HsJnkTAAWjKeEwdVvX5iQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:49:29AM +0300, Amir Goldstein wrote:
> [+fsdevel]
> 
> >
> > I swear I'll send all these some day, if I ever get caught up...
> > Delegating LTS maintenance is a big help, but as it is I still can't
> > stay abreast of all the mainline patchsets /and/ send my own stuff. :(
> 
> I have to repeat what I said in LSFMM about the LTP project and
> what fstests could be like.
> 
> Companies put dedicated engineers to work as proactive LTP
> maintainers. There is absolutely no reason that companies won't
> do the same for fstests.
> 
> If only every large corp. that employs >10 fs developers will assign
> a halftime engineer for fstests maintenance, their fs developer's
> work would become so much more productive and their fs product
> will become more reliable.
> 
> I think the fact that this is not happening is a failure on our part to
> communicate that to our managers.

I'd enjoy that too; I'll bring it up the next time they start asking
about budgeting here (which means in 2 weeks).

> From my experience, if you had sent stuff like your fstests cleanups
> to the LTP maintainers and ask for their help to land it, they would
> thank you for the work you did and take care of all the testing
> on all platforms and fixing all the code style and framework issues.

Though to be fair -- a lot of the fstests changes backing up in
djwong-dev exist to enable testing of the online fsck feature.  This
whole year I've deprioritized sending any of those patches to
concentrate on writing the design documentation for online fsck[1].  Now
that I've submitted *that*, I'm hoping to start code review once I
convince a few people to grok the design doc.

So perhaps next week I'll resume the patchbombing that I've become
infamous for doing.

In the mean time, no objections to merging /this/ series.  The group
labelling is a little odd and I think that should be separate fix from
adding _require_freeze), but if zorro's ok with its present form then so
be it.

--D

[1] https://lore.kernel.org/linux-xfs/165456652256.167418.912764930038710353.stgit@magnolia/

> LTP maintainers constantly work on improving the framework and
> providing more features to test writers as well as on converting old
> tests to use new infrastructure.
> 
> Stuff like Dave's work on sorting up the cleanup mess or the groups
> cleanup and groups speedup - all of those do not have to add load
> to busy maintainers - life can be different!
> 
> Taking responsibility away from developers to deliver their own tests
> is a slippery slope, but getting help and working together is essential
> for offloading work from busy maintainers.
> 
> Thanks,
> Amir.
