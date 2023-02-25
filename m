Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8E6A274D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 05:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBYE5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 23:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBYE5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 23:57:38 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6A126E3;
        Fri, 24 Feb 2023 20:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LwwfGwh1NUFEtOE3QzG3Y8rHSX6HMo3n+NJS/9JIysw=; b=rKBEGxVBeRvKtZBigOPBfKfhAV
        pTN+3AF6p08268Xp5eV+o5HxeBI0Ztt/bzgJ1kjzUDM0/nHw0ceyGG666zvjb1mG+/zVPWd7u7tUe
        ylEEWWr4PkfLQCVe8G5qXDtFaIhKCAAyR+fTNWS6wTPLA8ZRs8mkK4ufF/nFdAOrOP3HCcWT3592Z
        pYns3/mHd94YPacpNKOPOQduDmp2cJqvMGbhEL0GKPw6gXk9fdkhOmLSiohwjHU912Rnj7S8CKTon
        HEmkeOJFewRMRYTz8BTPHufNfuRgg5GYDk47BOo+m7pPWoTPyqqmP4/NeJL9SlwUNZi9iKVbLNUDw
        +aP86Fyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVmcp-00CBLY-0g;
        Sat, 25 Feb 2023 04:57:35 +0000
Date:   Sat, 25 Feb 2023 04:57:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git misc bits
Message-ID: <Y/mVP5EsmoCt9NwK@ZenIV>
References: <Y/gxyQA+yKJECwyp@ZenIV>
 <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
 <Y/mEQUfLqf8m2s/G@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/mEQUfLqf8m2s/G@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 03:45:06AM +0000, Al Viro wrote:
> On Fri, Feb 24, 2023 at 07:33:12PM -0800, Linus Torvalds wrote:
> > On Thu, Feb 23, 2023 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > That should cover the rest of what I had in -next; I'd been sick for
> > > several weeks, so a lot of pending stuff I hoped to put into -next
> > > is going to miss this window ;-/
> > 
> > Does that include the uaccess fixes for weird architectures?
> > 
> > I was hoping that was coming...
> 
> Missed -next; I'll look for tested-by/reviewed-by/etc. and put the same
> patches into #fixes; we have a week until the end of merge window, and
> those are fixes, after all...

Collected and pushed out as #fixes; exact same patches as the last time.
I hope I hadn't missed anyone's ACKs/Tested-by/whatnot...

Let's have it sit around for at least a few days, OK?  I mean, I'm pretty
certain that these are fixes, but they hadn't been in any public tree -
only posted to linux-arch.  At least #fixes gets picked by linux-next...

Al, still crawling through bloody piles of mail - iov_iter threads, in
particular ;-/
