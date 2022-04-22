Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1F50AFB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 07:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiDVFzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 01:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiDVFzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:55:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13764F466;
        Thu, 21 Apr 2022 22:52:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12A5268B05; Fri, 22 Apr 2022 07:52:15 +0200 (CEST)
Date:   Fri, 22 Apr 2022 07:52:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422055214.GA11281@lst.de>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com> <20220421234837.3629927-7-kent.overstreet@gmail.com> <20220422042017.GA9946@lst.de> <YmI5yA1LrYrTg8pB@moria.home.lan> <20220422052208.GA10745@lst.de> <YmI/v35IvxhOZpXJ@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmI/v35IvxhOZpXJ@moria.home.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:40:15AM -0400, Kent Overstreet wrote:
> Wasn't just bcachefs, it affected bcache too, as Coly also reported.

Well, I've not seen a good bug report for that, but I'd gladly look at it.

> And I wrote
> that code originally (and the whole fucking modern bvec iter infrastracture,
> mind you) so please don't lecture me on making assumptions on block layer
> helpers.

Well, most of what we have is really from Ming.  Because your original
idea was awesome, but the code didn't really fit.  Then again I'm not
sure why this even matters.

I'm also relly not sure why you are getting so personal.  

> Now yes, I _could_ do a wholesale conversion of seq_buf to printbuf and delete
> that code, but doing that job right, to be confident that I'm not introducing
> bugs, is going to take more time than I really want to invest right now. I
> really don't like to play fast and loose with that stuff.

Even of that I'd rather see a very good reason first.  seq_bufs have been
in the kernel for a while and seem to work fine.  If you think there are
shortcomings please try to improve it, not replace or duplicate it.
Sometimes there might be a good reason to replace exiting code, but it
rather have to be a very good reason.
