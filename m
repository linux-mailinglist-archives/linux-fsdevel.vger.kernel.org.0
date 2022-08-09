Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528958DCB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245287AbiHIRDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245517AbiHIRCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA726F0;
        Tue,  9 Aug 2022 10:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285D060BBE;
        Tue,  9 Aug 2022 17:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D3C433D6;
        Tue,  9 Aug 2022 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064557;
        bh=oAX6iFe0Ls7l4dfrf9XPhU+sbEN8AoDTrN65o8ZLhXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYl7CXTiECvji7OvuNzdwtxBQvA/rbtg4FzTr/1T4eh49p8ktBvALXptrqJLyW+S1
         IqwzKS4uSw/360b2a100y/3S8oi5wPsTc6v6WHFSUr/2Lo1wezRsfWs/ddIDtnctw7
         Ey25cLt9AdUAidQ1DWeGD9hvty0JkQC4dGM9yB8Y/XLhdgXxz+pFwBLJAxdM77ZgRY
         Us43JollW1wMJki4Z1mWzzcA5ss2AxnYwlCp1rL+Wd7u3zwwuax8R/9wuY/+oS1zjK
         Ek9d2wt6fgAxMhCjNOEdFhgPRvZWB2fiCxRFINKGSckyKSasxG8P0r9ERWZ1Oqemsz
         36eGZAU90iWRg==
Date:   Tue, 9 Aug 2022 19:02:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [GIT PULL] setgid inheritance for v5.20/v6.0
Message-ID: <20220809170233.sdkawtukkbd2uvj3@wittgenstein>
References: <20220809103957.1851931-1-brauner@kernel.org>
 <CAHk-=wi5pHi37dk0Ru93yvmJYU-FpcTpJ6tRcOQqO83SDkgMeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5pHi37dk0Ru93yvmJYU-FpcTpJ6tRcOQqO83SDkgMeQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09, 2022 at 09:58:56AM -0700, Linus Torvalds wrote:
> On Tue, Aug 9, 2022 at 3:40 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Finally a note on __regression potential__. I want to be very clear and open
> > that this carries a non-zero regression risk which is also why I defered the
> > pull request for this until this week because I was out to get married last
> > week and wouldn't have been around to deal with potential fallout:
> 
> .. excuses, excuses.

I had to choose whether I'll be physically slapped for working or
virtually slapped for sending in the PR late. This time I took the
virtual beating. ;)

> 
> Congratulations.

Thank you!
Christian
