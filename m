Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27C265D079
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjADKOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 05:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjADKOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:14:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94EE1CFD4
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 02:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CD13B815C5
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A4C433EF;
        Wed,  4 Jan 2023 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672827287;
        bh=o1ZgDAhliFI1HaUfvWtATz1x8GBVWkMv233Y8Sapi6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sns5c48imLNoSvHIlc0qJGxedZ+4viU1i1FjZbwV5h89foPwQgpYb4mS7iaUMJqVj
         qrtEAk+Q9urGr0ESQ9M6Aa260ErYMRXi+zE58ljXOoBlf991adQuVf1dps8jUkagkf
         TuHpzSijNdjTUK7i78kSZjSmB0clgZCvLJTmGzW4OAu60sYbk3eW//LIviujxk/hOj
         ahcgqIH8HrrWrP+f6UTS/ykpSrMIw10tZl4jZ9cMxmlyRE1Z6C8z5EPhnNe440qyVf
         XlhJR2kZIe8XkxUrOQI3nl61bAqLJLAAndv3mKNwdIgsCUJLSxm8lhjyL7AEmJ5q9d
         X8QLtkzBX2yhw==
Date:   Wed, 4 Jan 2023 11:14:43 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     hooanon05g@gmail.com, linux-fsdevel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [GIT PULL] acl updates for v6.2
Message-ID: <20230104101443.knstpogkznjlz6qh@wittgenstein>
References: <20221212111919.98855-1-brauner@kernel.org>
 <29161.1672154875@jrobl>
 <20221227183115.ho5irvmwednenxxq@wittgenstein>
 <16855.1672793848@jrobl>
 <32ce10e7-62ff-92f1-cac4-00037a2110a5@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32ce10e7-62ff-92f1-cac4-00037a2110a5@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:04:06AM +0100, Linux kernel regression tracking (#info) wrote:
> [TLDR: This mail in primarily relevant for Linux kernel regression
> tracking. See link in footer if these mails annoy you.]
> 
> On 04.01.23 01:57, hooanon05g@gmail.com wrote:
> > Christian Brauner:
> >> On Wed, Dec 28, 2022 at 12:27:55AM +0900, J. R. Okajima wrote:
> > 	:::
> >>> I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).
> >>
> >> Hey, I'll try to take a look before new years.
> > 
> > Now it becomes clear that the problem was on my side.
> > The "acl updates for v6.2" in mainline has nothing to deal with it.
> > Sorry for the noise.
> 
> In that case:
> 
> #regzbot resolve: turns out it was a local problem and not regression in
> the kernel

When and how did regzbot start tracking this? None of the mails that
reported this issue to me contained any reference to regzbot.

If something is currently classified as a regression it'd be good to let
the responsible maintainers and developers know that.

Christian
