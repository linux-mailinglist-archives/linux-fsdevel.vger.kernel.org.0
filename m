Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6F779000
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjHKM6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjHKM6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:58:15 -0400
Received: from out-98.mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF830D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 05:58:13 -0700 (PDT)
Date:   Fri, 11 Aug 2023 08:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691758692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NyTmJR796ZfrySFKjmIufn+myHzYvXaZMV7CqGf2O0=;
        b=rfjNlZDokECYCT6aBlDOG2B8kWX8el9xIHkvGN9lzMokT2ezRRzyt5BPMl+v8jok6qWBnU
        xkafGNgCrxefin+YtO7550sR5NZDhD7LqLt5FMlfacGZ7NepU1wHaZUyCBbm0PFFBHpwXt
        SGb8OI7FJ0BjDWNRuF7hSlsw2YRebBs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811125801.g3uwnouefoleq4nx@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:54:42PM +0200, Christian Brauner wrote:
> The technical aspects were made clear off-list and I believe multiple
> times on-list by now. Any VFS and block related patches are to be
> reviewed and accepted before bcachefs gets merged.

Christian, you're misrepresenting.

The fact is, the _very same person_ who has been most vocal in saying
"all patches need to go in prior through maintainers" was also in years
past one of the people saying that patches only for bcachefs shouldn't
go in until the bcachefs pull. And as well, we also had Linus just
looking at the prereq series and saying acks would be fine from Jens.

> This was also clarified off-list before the pull request was sent. Yet,
> it was sent anyway.

All these patches have hit the list multiple times; the one VFS patch is
question is a tiny new helper and it's been in your inbox.

> On the receiving end this feels disrespectful. To other maintainers this
> implies you only accept Linus verdict and expect him to ignore
> objections of other maintainers and pull it all in.

Well, it is his kernel :)

And more than that, I find Linus genuinely more pleasant to deal with; I
always feel like I'm talking to someone who's just trying to have an
intelligent conversation and doesn't want to waste time on bullshit.

Look, in the private pre-pull request thread, within _hours_ he was
tearing into six locks and the statistics code.

I post that same code to the locking mailing list, and I got - what, a
couple comments to clarify? A spelling mistake pointed out?

So yeah, I appreciate hearing from him.

The code's been out on the mailing list for months and you haven't
commented at all. All I need from you is an ack on the dcache helper or
a comment saying why you don't like it, and all I'm getting is
complaints.

> That would've caused massive amounts of frustration and conflict
> should that have happened. So this whole pull request had massive
> potential to divide the community.

Christian, I've been repeatedly asking what your concerns are: we had
_two_ meetings set up for you that you noshow'd on. And here you are
continuing to make wild conflicts about frustration and conflict, but
you can't seem to name anything specific.

I don't want to make your life more difficult, but you seem to want to
make _mine_ more difficult. You made one offhand comment about not
wanting a repeat of ntfs3, and when I asked you for details you never
even responded.

> Timeline wise, my preference would be if we could get the time to finish
> the super work that Christoph and Jan are currently doing and have a
> cycle to see how badly the world breaks. And then we aim to merge
> bcachefs for v6.7 in November. That's really not far away and also gives
> everyone the time to calm down a little.

I don't see the justification for the delay - every cycle there's some
amount of vfs/block layer refactoring that affects filesystems, the
super work is no different.
