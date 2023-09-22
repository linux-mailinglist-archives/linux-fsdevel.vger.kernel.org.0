Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E27AB1F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjIVMRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjIVMRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:17:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AC194;
        Fri, 22 Sep 2023 05:16:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A2BC433C8;
        Fri, 22 Sep 2023 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695385016;
        bh=86SHythj7h2wsQ6mMdf+CBzjLh0q/GCEyBdeIHWGAdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iFtpUaOxiBpGCMbx7YAzBEY0NjFf5PlAKTI+GdD5VBOcPN00+JhyrU3MrBAnVPbKp
         h6NmyQhqu2Bb63sgfW2rn1AIBlzjms0r3yqzZ9hro3acdsmhX/PhDiMxHjevu6GnKP
         wqnX7qiHO8a8Ht82dFre7f3GHA7q/7NJKuxCWQowulFgvTINaS1nOULVdXXFLxJLtT
         pcH6PDt6GVzNSebBYcP0omk/5NVMV12qbGl5KueSQ7D/rpKDkk+uKv7nW1kwgNOxG7
         BFc6Smz6DmivWQHR56X7kz73wTBs5ZEqFKi18bNnrLSOWaiziexvJXJ2MaImf7baLw
         VLl8fjQpuIGvQ==
Date:   Fri, 22 Sep 2023 14:16:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <20230922-hingen-lektion-af64b9787eba@brauner>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:24:43AM -0700, Linus Torvalds wrote:
> On Thu, 21 Sept 2023 at 04:21, Christian Brauner <brauner@kernel.org> wrote:
> >
> >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc3.vfs.ctime.revert
> 
> So for some reason pr-tracker-bot doesn't seem to have reacted to this
> pull request, but it's in my tree now.

I think vger was somehow backed up again. We've been hit kinda hard by
this recently. I've asked Konstantin whether he'd move us to the new
kernel.org managed mailing infra (which will happen eventually anyway)
so hopefully we'll have less of these delays in the very near future...
