Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752B4F4D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581783AbiDEXk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444567AbiDEPlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8CF955A;
        Tue,  5 Apr 2022 07:05:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFC8768AFE; Tue,  5 Apr 2022 16:05:52 +0200 (CEST)
Date:   Tue, 5 Apr 2022 16:05:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/12] btrfs: simplify scrub_recheck_block
Message-ID: <20220405140552.GA15376@lst.de>
References: <20220404044528.71167-1-hch@lst.de> <20220404044528.71167-6-hch@lst.de> <cbdccdb8-8571-20a4-f0cb-e0363397757c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbdccdb8-8571-20a4-f0cb-e0363397757c@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:49:55PM +0300, Nikolay Borisov wrote:
> This line comes from a patch which is not yet in misc-next as a result the 
> patch fails to apply. So which branch are those changes based off?

The series is against 5.18-rc1.  The whole branch can be found here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-cleanup-part1
