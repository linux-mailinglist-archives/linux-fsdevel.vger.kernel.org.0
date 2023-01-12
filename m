Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE366740F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 15:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjALOCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 09:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjALOCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:02:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3F4BD4C;
        Thu, 12 Jan 2023 06:02:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A997768BEB; Thu, 12 Jan 2023 15:01:59 +0100 (CET)
Date:   Thu, 12 Jan 2023 15:01:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/19] btrfs: handle recording of zoned writes in the
 storage layer
Message-ID: <20230112140159.GA6416@lst.de>
References: <20230112090532.1212225-1-hch@lst.de> <20230112090532.1212225-7-hch@lst.de> <aea095e4-a90b-ec16-f590-bfd5f13ce276@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aea095e4-a90b-ec16-f590-bfd5f13ce276@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:31:49AM +0000, Johannes Thumshirn wrote:
> What base is this against? I'm getting the following:
> Applying: btrfs: handle recording of zoned writes in the storage layer
> fs/btrfs/inode.c: In function ‘btrfs_submit_direct’:
> fs/btrfs/inode.c:7842:25: error: label ‘out_err’ used but not defined
>  7842 |                         goto out_err;
>       |                         ^~~~
> 
> 
> Specifically that hunk needs to be removed:

Yes, it needs to be removed. I didn't properly complile test this step
after the lastest rebased that added another users of out_err.  It gets
fixed later on, but I've force pushed the tree mentioned in the cover
letter to fix it up at this stage as well.
