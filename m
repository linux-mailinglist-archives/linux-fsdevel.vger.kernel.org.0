Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4F2FB150
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhASGXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 01:23:48 -0500
Received: from verein.lst.de ([213.95.11.211]:50685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbhASGNk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:13:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D30B6736F; Tue, 19 Jan 2021 07:12:54 +0100 (CET)
Date:   Tue, 19 Jan 2021 07:12:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        'Jens Axboe ' <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] block: Add bio_limit
Message-ID: <20210119061253.GA21250@lst.de>
References: <20210114194706.1905866-1-willy@infradead.org> <20210118181338.GA11002@lst.de> <20210118181712.GC2260413@casper.infradead.org> <20210118183113.GA11473@lst.de> <20210118192048.GF2260413@casper.infradead.org> <BL0PR04MB6514A4BFE2EA5AE59795E586E7A40@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514A4BFE2EA5AE59795E586E7A40@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:52:10PM +0000, Damien Le Moal wrote:
> What about calling it bio_max_bvecs() or bio_max_segs() ? Together with renaming
> BIO_MAX_PAGES to BIO_MAX_SEGS or BIO_MAX_BVECS, things would be clear on what
> this is referring to. Since these days one bvec is one seg, but segment is more
> struct request layer while bvec is more BIO layer, I would lean toward using
> bvec for naming this one, but either way would be fine I think.

That's probably the least bad of the options for now.
