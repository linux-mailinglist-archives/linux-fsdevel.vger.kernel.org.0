Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6F5BEBC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiITRVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiITRVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:21:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276E5F7FD;
        Tue, 20 Sep 2022 10:21:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B875568AFE; Tue, 20 Sep 2022 19:21:06 +0200 (CEST)
Date:   Tue, 20 Sep 2022 19:21:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Gao Xiang <xiang@kernel.org>, Chris Mason <clm@fb.com>,
        linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chao Yu <chao@kernel.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: improve pagecache PSI annotations v2
Message-ID: <20220920172106.GA24750@lst.de>
References: <20220915094200.139713-1-hch@lst.de> <166368389821.10447.12312122039024559092.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166368389821.10447.12312122039024559092.b4-ty@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:24:58AM -0600, Jens Axboe wrote:
> Applied, thanks!

I think Andrew applied these as well already.  I'll let you two fight
that out as I'm happy as long as it goes in :)

