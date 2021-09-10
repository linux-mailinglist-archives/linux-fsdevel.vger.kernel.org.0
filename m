Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A864065DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhIJDBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:01:18 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58820 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJDBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:01:17 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOWji-002mkY-ON; Fri, 10 Sep 2021 02:57:54 +0000
Date:   Fri, 10 Sep 2021 02:57:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:19:56PM -0600, Jens Axboe wrote:

> Not sure how we'd do that, outside of stupid tricks like copy the
> iov_iter before we pass it down. But that's obviously not going to be
> very efficient. Hence we're left with having some way to reset/reexpand,
> even in the presence of someone having done truncate on it.

"Obviously" why, exactly?  It's not that large a structure; it's not
the optimal variant, but I'd like to see profiling data before assuming
that it'll cause noticable slowdowns.
