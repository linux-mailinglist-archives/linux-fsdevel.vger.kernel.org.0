Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA41A74F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406733AbgDNHiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 03:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgDNHiS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:38:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22E420575;
        Tue, 14 Apr 2020 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586849898;
        bh=c3VeZmnJ21uO4nl4ipI0bU3GZYnYIrzWwg7ElW9HfPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e94n9Y+GtlyXQJiMemhpG+YBmqCcUf11viZViWfVtiWxBg6xFDMrZBSTun5L7rD3o
         eGdz5EqGWdIqYwfU6XQgFo7vt5kxDHs9afTdqsJFjtwQwVZHlTMiE76GMfFJqRqQRv
         cTzrdlOP+2fzUpFhH3I95pdBlcXkVof8bn0PWzS0=
Date:   Tue, 14 Apr 2020 09:38:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] blktrace: fix use after free
Message-ID: <20200414073816.GC4111599@kroah.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-1-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:18:57AM +0000, Luis Chamberlain wrote:
> After two iterations of RFCs I think this is ready now. I've taken
> the feedback from the last series, both on code and commit log.
> I've also extended the commit log on the last patch to also explain
> how the original shift to async request_queue removal turned out
> to actually be a userspace regression and added a respective fixes
> tag for it.
> 
> You can find these patches on my 20200414-dev-blkqueue-defer-removal-patch-v1
> branch based on linux-next tag next-20200414 on kernel.org [0].
> 
> Further review and rants are appreciated.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200414-dev-blkqueue-defer-removal
> 
> Luis Chamberlain (5):
>   block: move main block debugfs initialization to its own file
>   blktrace: fix debugfs use after free
>   blktrace: refcount the request_queue during ioctl
>   mm/swapfile: refcount block and queue before using
>     blkcg_schedule_throttle()
>   block: revert back to synchronous request_queue removal

Looks good from a debugfs point of view, thanks for doing this cleanup.

greg k-h
