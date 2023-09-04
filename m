Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0ED79180C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjIDN05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbjIDN04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:26:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F06CD7;
        Mon,  4 Sep 2023 06:26:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BEDD68AFE; Mon,  4 Sep 2023 15:26:49 +0200 (CEST)
Date:   Mon, 4 Sep 2023 15:26:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yukuai3@huawei.com, zhang_shurong@foxmail.com,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [syzbot] [xfs?] [ext4?] kernel BUG in __block_write_begin_int
Message-ID: <20230904132649.GA4819@lst.de>
References: <000000000000e76944060483798d@google.com> <ZPWWZeWliX7RhOAZ@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPWWZeWliX7RhOAZ@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 06:33:41PM +1000, Dave Chinner wrote:
> It appears that 0010:__block_write_begin_int() has iterated beyond
> the iomap that was passed in, triggering the BUG_ON() check in
> iomap_to_bh().

Yes, I'll look into it.
