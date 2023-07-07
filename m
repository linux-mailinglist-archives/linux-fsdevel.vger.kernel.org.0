Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22E74ADB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjGGJSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGJSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:18:23 -0400
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEB1FED
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 02:18:19 -0700 (PDT)
Date:   Fri, 7 Jul 2023 05:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688721498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UBtSAf9M3yHlwuCRGGEsx8Cg1RJFv64iXVl/BM8QpOE=;
        b=EeTSjl43WDyruqd7JEj/Zj/qAlPNIONzqHAnZR0eyeXoMZsId44d9/5+KsrD1ObzHR5cSl
        4+5RzTdhNFzB1JZYhBoFbq4e/FoSdzUphgS6BMh9t4exsIw1XKVnzZt8RPEgDgH42geomZ
        QRRXu12CM7rh2GX8jfuAyq1TPrTRxhI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707091810.bamrvzcif7ncng46@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 10:48:55AM +0200, Christian Brauner wrote:
> > just merge it and let's move on to the next thing."
> 
> "and let the block and vfs maintainers and developers deal with the fallout"
> 
> is how that reads to others that deal with 65+ filesystems and counting.
> 
> The offlist thread that was started by Kent before this pr was sent has
> seen people try to outline calmly what problems they currently still
> have both maintenance wise and upstreaming wise. And it seems there's
> just no way this can go over calmly but instead requires massive amounts
> of defensive pushback and grandstanding.
> 
> Our main task here is to consider the concerns of people that constantly
> review and rework massive amounts of generic code. And I can't in good
> conscience see their concerns dismissed with snappy quotes.
> 
> I understand the impatience, I understand the excitement, I really do.
> But not in this way where core people just drop off because they don't
> want to deal with this anymore.
> 
> I've spent enough time on this thread.

Christain, the hostility I'm reading is in your steady passive
aggressive accusations, and your patronizing attitude. It's not
professional, and it's not called for.

Can we please try to stay focused on the code, and the process, and the
_actual_ concerns?

In that offlist thread, I don't recall much in the way of actual,
concrete concerns. I do recall Christoph doing his usual schpiel; and to
be clear, I cut short my interactions with Christoph because in nearly
15 years of kernel development he's never been anything but hostile to
anything I've posted, and the criticisms he posts tend to be vague and
unaware of the surrounding discussion, not anything actionable.

The most concrete concern from you in that offlist thread was "we don't
want a repeat of ntfs", and when I asked you to elaborate you never
responded.

Huh.

And: this pull request is not some sudden thing, I have been steadily
feeding prep work patches in and having ongoing discussions with other
filesystem people, including presenting at LSF to gather feedback, since
_well_ before you were the VFS maintainer.

If you have anything concrete to share, any concrete concerns you'd like
addressed - please share them! I'd love to work with you.

I don't want the two of us to have a hostile, adversarial relationship;
I appreciate the work you've been doing in the vfs, and I've told you
that in the past.

But it would help things if you would try to work with me, not against
me, and try to understand that there's been past discussions and
consensus that was built before you came along.

Cheers,
Kent
