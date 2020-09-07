Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69BC25F885
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgIGKf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 06:35:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgIGKfy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:35:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B4C3B13F;
        Mon,  7 Sep 2020 10:35:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DFD741E12D1; Mon,  7 Sep 2020 12:35:49 +0200 (CEST)
Date:   Mon, 7 Sep 2020 12:35:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        yebin <yebin10@huawei.com>, Andreas Dilger <adilger@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2 v2] bdev: Avoid discarding buffers under a filesystem
Message-ID: <20200907103549.GA20428@quack2.suse.cz>
References: <20200904085852.5639-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904085852.5639-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri 04-09-20 10:58:50, Jan Kara wrote:
> this patch set fixes problems when buffer heads are discarded under a
> live filesystem (which can lead to all sorts of issues like crashes in case
> of ext4). Patch 1 drops some stale buffer invalidation code, patch 2
> temporarily gets exclusive access to the block device for the duration of
> buffer cache handling to avoid interfering with other exclusive bdev user.
> The patch fixes the problems for me and pass xfstests for ext4.
> 
> Changes since v1:
> * Check for exclusive access to the bdev instead of for the presence of
>   superblock

Jens, now that Christoph has reviewed the patches (thanks Christoph!), can
you pick up the patches to your tree please? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
