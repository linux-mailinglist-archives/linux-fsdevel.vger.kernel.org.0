Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39DA3B31DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhFXO7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 10:59:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57137 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230170AbhFXO7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:59:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OEuhRg016173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:56:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD08515C3CD7; Thu, 24 Jun 2021 10:56:43 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:56:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [RFC PATCH v4 7/8] ext4: remove bdev_try_to_free_page() callback
Message-ID: <YNSdK3puRdqwFFKm@mit.edu>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <20210610112440.3438139-8-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610112440.3438139-8-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:24:39PM +0800, Zhang Yi wrote:
> After we introduce a jbd2 shrinker to release checkpointed buffer's
> journal head, we could free buffer without bdev_try_to_free_page()
> under memory pressure. So this patch remove the whole
> bdev_try_to_free_page() callback directly. It also remove many
> use-after-free issues relate to it together.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
