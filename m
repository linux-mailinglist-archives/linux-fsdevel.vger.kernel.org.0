Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15332DA7FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 07:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLOGM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 01:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgLOGMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:12:19 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E56C061793
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 22:11:39 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp3YZ-001NP4-V6; Tue, 15 Dec 2020 06:11:32 +0000
Date:   Tue, 15 Dec 2020 06:11:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
Message-ID: <20201215061131.GG3579531@ZenIV.linux.org.uk>
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

I'll review tomorrow morning (sorry, half-asleep right now)
