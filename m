Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6445E3B31E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhFXO73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 10:59:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57181 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230170AbhFXO73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:59:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OEuuZV016283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:56:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 07A5615C3CD7; Thu, 24 Jun 2021 10:56:56 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:56:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [RFC PATCH v4 8/8] fs: remove bdev_try_to_free_page callback
Message-ID: <YNSdN1psRyoUnpZe@mit.edu>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <20210610112440.3438139-9-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610112440.3438139-9-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:24:40PM +0800, Zhang Yi wrote:
> After remove the unique user of sop->bdev_try_to_free_page() callback,
> we could remove the callback and the corresponding blkdev_releasepage()
> at all.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
