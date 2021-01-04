Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74812E902B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 06:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbhADFb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 00:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADFb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 00:31:58 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3742C061574
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jan 2021 21:31:17 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwISW-006gPQ-K7; Mon, 04 Jan 2021 05:31:12 +0000
Date:   Mon, 4 Jan 2021 05:31:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
Message-ID: <20210104053112.GH3579531@ZenIV.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191323.173773-1-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:13:20PM -0700, Jens Axboe wrote:
> Hi,
> 
> Wanted to throw out what the current state of this is, as we keep
> getting closer to something palatable.
> 
> This time I've included the io_uring change too. I've tested this through
> both openat2, and through io_uring as well.
> 
> I'm pretty happy with this at this point. The core change is very simple,
> and the users end up being trivial too.
> 
> Also available here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=nonblock-path-lookup

OK, pushed with modifications into vfs.git #work.namei

Changes: dropped a couple of pointless pieces in open_last_lookups()/do_open(),
moved O_TMPFILE rejection into build_open_flags() (i.e. in the third of your
commits).  And no io_uring stuff in there - your #4 is absent.

I've not put it into #for-next yet; yell if you see any problems with that
branch, or it'll end up there ;-)
