Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74F664B288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 10:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiLMJki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLMJkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:40:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321FE15A19;
        Tue, 13 Dec 2022 01:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0168B80B73;
        Tue, 13 Dec 2022 09:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA86C433D2;
        Tue, 13 Dec 2022 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670924433;
        bh=94w9PQjxXcHSOdNO2ViYGpWqz7tr3/iZR+3+yFegweE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVamNgLrq9RgdNb2QHI4sORF1eidc1gT/INF9gIEFlkz7rhfbUEzbfKaU6V4SAy6P
         MMydcluzBR6Ovux0Igz8jvX4+wjgSIsMRRHmrYDmyKlPXJXtz+XjOGrnFrWNC1oVcM
         o7kF+F5Bp2S5di7E45j86ePqLzlmCSSHpYZFrc4PHPJ4lXjUhP62Yy1jwe3bMIfIY0
         OQkSs/cenNOTqyyRuQ/8TyaYM7/kJVkYRIwrqHKALKnNBkN1C8mTowwDkACSmTZJ5V
         q1g2/B6ny2kD23LHQ6LYjUHpw+dSt98yBpqaKWF3vNNK27Sh18Tut/QMbt+rwD8xHf
         ei9dXkQ2x1Teg==
Date:   Tue, 13 Dec 2022 10:40:29 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fs idmapped updates for v6.2
Message-ID: <20221213094029.4csl2ff7ovtkxikt@wittgenstein>
References: <20221212131915.176194-1-brauner@kernel.org>
 <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 12, 2022 at 07:40:29PM -0800, Linus Torvalds wrote:
> On Mon, Dec 12, 2022 at 5:19 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Please note the tag contains all other branches for this cycle merged in.
> 
> Well, considering that the explanation basically assumed I had already
> merged those (and I had), I wish you also had made the diffstat and
> the shortlog reflect that.

I wasn't sure what the best way was.
I'll make a note to use a better shortlog this time.

> 
> As it was, now the diffstat and shortlog ends up containing not what
> this last pull request brought in, but what they *all* brought in...

I didn't want it to look like I was trying to hide the pretty obvious
ugliness of the branch by editing the shortlog.

> 
> I'm also not super-happy with how ugly your history for this branch
> was. You had literally merged the acl rework branch three times - at
> different points of that branch.

I hate the history of that branch. And I have zero idea why I didn't
rebase when I applied it before I pushed it into linux-next.

I really had to fight the __very__ strong urge to rebase before sending
this pr. I had to step outside for a walk to resist it.

> 
> Do we have other ugly history in the tree? Yes. But we've been getting
> better. This was _not_ one of those "getting better" moments.
> 
> Oh well. I can see what you wanted to do, and I agree with the end
> result, I just don't particularly like how this was done.
> 
> I've pulled it.

Thank you!
Christian
