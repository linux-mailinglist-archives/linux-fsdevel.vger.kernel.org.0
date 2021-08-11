Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732E3E89B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 07:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhHKFW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 01:22:57 -0400
Received: from verein.lst.de ([213.95.11.211]:39129 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234325AbhHKFW4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:22:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C851668AFE; Wed, 11 Aug 2021 07:22:29 +0200 (CEST)
Date:   Wed, 11 Aug 2021 07:22:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: hide laptop_mode_wb_timer entirely behind the
 BDI API
Message-ID: <20210811052229.GA1696@lst.de>
References: <20210809141744.1203023-1-hch@lst.de> <20210809141744.1203023-2-hch@lst.de> <20210810215622.GA874076@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810215622.GA874076@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 02:56:22PM -0700, Guenter Roeck wrote:
> On Mon, Aug 09, 2021 at 04:17:40PM +0200, Christoph Hellwig wrote:
> > Don't leak the detaіls of the timer into the block layer, instead
> > initialize the timer in bdi_alloc and delete it in bdi_unregister.
> > Note that this means the timer is initialized (but not armed) for
> > non-block queues as well now.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Just in case this hasn't been reported yet.
> This patch results in a widespread build failure. Example:

Sorry.  This was reported before and a fix is already queued up here:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.15/block&id=99d26de2f6d79badc80f55b54bd90d4cb9d1ad90
