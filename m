Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD172BA514
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgKTIuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:50:01 -0500
Received: from verein.lst.de ([213.95.11.211]:41964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgKTIuB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:50:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A171367373; Fri, 20 Nov 2020 09:49:56 +0100 (CET)
Date:   Fri, 20 Nov 2020 09:49:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/20] init: refactor name_to_dev_t
Message-ID: <20201120084956.GA21715@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-8-hch@lst.de> <20201118143747.GL1981@quack2.suse.cz> <20201119075225.GA15815@lst.de> <20201119082505.GS1981@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119082505.GS1981@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:25:05AM +0100, Jan Kara wrote:
> OK, understood. Still it would seem more logical to leave blk_lookup_devt()
> declaration inside #ifdef CONFIG_BLOCK and just delete the !CONFIG_BLOCK
> definition (to make it clear we ever expect only users compiled when
> CONFIG_BLOCK is defined). But whatever... Feel free to add:

Not having the ifdef would allow using IS_ENABLED() around it.  Which
is what I did in one of the earlier variants before settlings on this one.
