Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDD5BD15C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiISPpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiISPpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:45:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9431A06B;
        Mon, 19 Sep 2022 08:45:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDEA568BEB; Mon, 19 Sep 2022 17:45:33 +0200 (CEST)
Date:   Mon, 19 Sep 2022 17:45:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: improve pagecache PSI annotations v2
Message-ID: <20220919154533.GA710@lst.de>
References: <20220915094200.139713-1-hch@lst.de> <20220915130138.GO32411@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915130138.GO32411@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 03:01:38PM +0200, David Sterba wrote:
> On Thu, Sep 15, 2022 at 10:41:55AM +0100, Christoph Hellwig wrote:
> > 
> >  - spell a comment in the weird way preferred by btrfs maintainers
> 
> What? A comment is a standalone sentence or a full paragraph, so it's
> formatted as such. I hope it's not weird to expect literacy either in
> the language of comments or the programming language. The same style can
> be found in many other kernel parts so please stop the nags at btrfs.

That is not what most of the kernel seems to think.  The usual style is
to have multi-line comments start with a capitalized word and end with a
dot and thus form one or more complete sentences, but single line
comments most of the time do not form complete sentences and thus
do not start with a capitalized word and do not end with a dot.
