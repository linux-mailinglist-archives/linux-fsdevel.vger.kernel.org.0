Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348CB538B5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 08:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiEaGWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiEaGWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 02:22:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC244A3F;
        Mon, 30 May 2022 23:22:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8364968AFE; Tue, 31 May 2022 08:22:27 +0200 (CEST)
Date:   Tue, 31 May 2022 08:22:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 5/9] block: add a helper function for dio alignment
Message-ID: <20220531062227.GB21098@lst.de>
References: <20220526010613.4016118-1-kbusch@fb.com> <20220526010613.4016118-6-kbusch@fb.com> <fb8bd4ec-10bf-3a8a-dbb9-cdd4aeec7ebe@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8bd4ec-10bf-3a8a-dbb9-cdd4aeec7ebe@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 10:54:02AM +0900, Damien Le Moal wrote:
> Nit: The name of this helper really suggest a bool return, which would be a more
> flexible interface I think:
> 
> 	if (!blkdev_dio_aligned(bdev, pos, iter))
> 		return -EINVAL; <-- or whatever error code the caller wants.
> 
> And that will allow you to get rid of the ret variable in a least
> __blkdev_direct_IO_async.

I agree, a bool return looks more natural here.

Otherwise this looks good to me.
