Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CF2E2D1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 05:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgLZEvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 23:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgLZEvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 23:51:31 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6EC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Dec 2020 20:50:50 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kt1XP-004DJd-Ex; Sat, 26 Dec 2020 04:50:43 +0000
Date:   Sat, 26 Dec 2020 04:50:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/4] fs: make unlazy_walk() error handling consistent
Message-ID: <20201226045043.GA3579531@ZenIV.linux.org.uk>
References: <20201217161911.743222-1-axboe@kernel.dk>
 <20201217161911.743222-2-axboe@kernel.dk>
 <66d1d322-42d4-5a46-05fb-caab31d0d834@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d1d322-42d4-5a46-05fb-caab31d0d834@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 25, 2020 at 07:41:17PM -0700, Jens Axboe wrote:
> On 12/17/20 9:19 AM, Jens Axboe wrote:
> > Most callers check for non-zero return, and assume it's -ECHILD (which
> > it always will be). One caller uses the actual error return. Clean this
> > up and make it fully consistent, by having unlazy_walk() return a bool
> > instead. Rename it to try_to_unlazy() and return true on success, and
> > failure on error. That's easier to read.
> 
> Al, were you planning on queuing this one up for 5.11 still? I'm fine
> with holding for 5.12 as well, would just like to know what your plans
> are. Latter goes for the whole series too, fwiw.

Seeing that it has not sat in -next at all, what I'm going to do is
to put it into 5.11-rc1-based branch.  It's really been too late for
something like that for this cycle and IME a topic branch started
before the merges for previous cycle are over is too likely to require
backmerges, if not outright rebases.  So let's branch it at -rc1 and
it'll go into #for-next from the very beginning.
