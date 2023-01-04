Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70F65D0CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjADKhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 05:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjADKhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:37:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19ABA0
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 02:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14E8DB815DD
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 10:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FF0C433D2;
        Wed,  4 Jan 2023 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672828630;
        bh=llwZlULU1z6WUfYouUqOo/UOnfd4afkGw39BMbnwf30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paTMZJPuCjq11JphDmnFln9k0xtXd/xRxPbkSwKD6YUAc+vZbYR11EPIFGAYfd9pU
         RiJILvYXESCymY+bDHqre3t8/HQlPU79/RnE4al4XjDBLve7LFzN8Gt4A5G6L/xv11
         OJYd6CXxHsq3sa94m6IJLE5CxjlVJAGbD0r2hOhrRmZkxu+JqFlehvGqhcL8qJntl/
         WZA5cMHbHN+Ydw4r3HpjLr0i9XfnO7OcxKs5/Il4eArDTRIvCyiZjQPcsLcCNwnaqG
         eTleODeG68Zb2TG251QWAWKelT0A1HsB/f/nK8KsqFxx+Lw/gOX4oFEv80RPen47Hj
         JDiSUugZTfRxQ==
Date:   Wed, 4 Jan 2023 11:37:06 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     hooanon05g@gmail.com, linux-fsdevel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [GIT PULL] acl updates for v6.2
Message-ID: <20230104103706.fc2lerbxodewiz6l@wittgenstein>
References: <20221212111919.98855-1-brauner@kernel.org>
 <29161.1672154875@jrobl>
 <20221227183115.ho5irvmwednenxxq@wittgenstein>
 <16855.1672793848@jrobl>
 <32ce10e7-62ff-92f1-cac4-00037a2110a5@leemhuis.info>
 <20230104101443.knstpogkznjlz6qh@wittgenstein>
 <90148f55-62f5-cd9e-4d38-33ad38bab5ff@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90148f55-62f5-cd9e-4d38-33ad38bab5ff@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:26:41AM +0100, Thorsten Leemhuis wrote:
> 
> 
> On 04.01.23 11:14, Christian Brauner wrote:
> > On Wed, Jan 04, 2023 at 11:04:06AM +0100, Linux kernel regression tracking (#info) wrote:
> >> [TLDR: This mail in primarily relevant for Linux kernel regression
> >> tracking. See link in footer if these mails annoy you.]
> >>
> >> On 04.01.23 01:57, hooanon05g@gmail.com wrote:
> >>> Christian Brauner:
> >>>> On Wed, Dec 28, 2022 at 12:27:55AM +0900, J. R. Okajima wrote:
> >>> 	:::
> >>>>> I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).
> >>>>
> >>>> Hey, I'll try to take a look before new years.
> >>>
> >>> Now it becomes clear that the problem was on my side.
> >>> The "acl updates for v6.2" in mainline has nothing to deal with it.
> >>> Sorry for the noise.
> >>
> >> In that case:
> >>
> >> #regzbot resolve: turns out it was a local problem and not regression in
> >> the kernel
> > 
> > When and how did regzbot start tracking this? None of the mails that
> > reported this issue to me contained any reference to regzbot.
> > 
> > If something is currently classified as a regression it'd be good to let
> > the responsible maintainers and developers know that.
> 
> That happens these days (again) -- since five, too be more precise, as I
> recently (again) changed how to handle that mails (some maintainers
> hated getting mails about adding reports to the tracking, but I recently
>  decided they have to deal with that locally).
> 
> But the mail that added this thread to the tracking was before that,
> sorry. :-/
> https://lore.kernel.org/all/2aa5cc7e-ca00-22a7-5e2f-7eb73556181e@leemhuis.info/

Ok, no problem. It's just odd because the mail you link here is a reply to
https://lore.kernel.org/all/29161.1672154875@jrobl
which has both mine and the original reporters mail address. Which means
a reply to it could've just kept all recipients which means that they
somehow must've been removed before it got sent.

Just in the future it would be great to be notified early when something
is classified as a regression.
