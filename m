Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5C798312
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbjIHHHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 03:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbjIHHHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:07:44 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 00:07:39 PDT
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0681BE9;
        Fri,  8 Sep 2023 00:07:39 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 55B4A7A01C0;
        Fri,  8 Sep 2023 08:29:16 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Date:   Fri, 08 Sep 2023 08:29:15 +0200
Message-ID: <4319210.ejJDZkT8p0@lichtvoll.de>
In-Reply-To: <20230907234001.oe4uypp6anb5vqem@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <20230907234001.oe4uypp6anb5vqem@moria.home.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent, hi Linus, hi everyone,

Kent Overstreet - 08.09.23, 01:40:01 CEST:
> The biggest thing has just been the non stop hostility and accusations -
> everything from "fracturing the community" too "ignoring all the rules"
> and my favorite, "is this the hill Kent wants to die on?" - when I'm
> just trying to get work done.

I observed this for a while now, without commenting and found the 
following pattern on both "sides" of the story:

Accusing the other one of wrong-doing.

As long as those involved in the merging process continue that pattern 
that story of not merging bcachefs most likely will continue. And even if 
it gets merged, there would be ongoing conflict about it. Cause I have no 
control over how someone else acts. Quite the contrary: The more I expect 
and require someone else to change the more resistance I am most likely to 
meet. I only can change how I act.

This pattern stops exactly when everyone involved looks at their own part 
in this repeated and frustrating "bcachefs is not merged to the mainline 
Linux kernel" dance. And from what I observed the failure to merge it is 
not caused by a single developer. Neither from you, Kent, neither from 
anyone else. It is the combination of the single actions of several 
developers and the social interaction between them that caused the failure 
to merge it so far. Accusing the other one is giving all the power to 
change the situation to someone else.

I am sure merging it will work when everyone involved first looks at 
themselves and asks themselves the questions "Have I contributed to make 
merging bcachefs difficult and if so how and most importantly how can I act 
more constructive about it?". And I mean that for the developers who have 
been skeptical about the merge as well as the supportive developers 
including Kent. There have been actions on both "sides" that contributed 
to delay a merge. I am not going to make a list but leave it to everyone 
involved to consider themselves what those were.

For the recent requests of having it GPG signed as well as having it go 
through next: I think those requests are reasonable. As far as I read 
bcache back then went through next as well. Would it have been nice to 
have been told that earlier? Yes. But both of those requests are certainly 
not a show-stopper to have bcachefs merged at a later time.

Of course I know I have been asking others to go within and consider their 
own behavior in this mail while being perfectly aware that I cannot change 
how anyone else acts. However, maybe it is an inspiration to some to 
decide for themselves to consider a change.

In the best hopes to see bcachefs being merged to the "official" Linux 
kernel soon,
-- 
Martin


