Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F15497DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiFMQfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbiFMQdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:33:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322581D80AB;
        Mon, 13 Jun 2022 07:22:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 722DD68AA6; Mon, 13 Jun 2022 16:22:50 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:22:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv6 07/11] block/bounce: count bytes instead of sectors
Message-ID: <20220613142250.GA3707@lst.de>
References: <20220610195830.3574005-1-kbusch@fb.com> <20220610195830.3574005-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610195830.3574005-8-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:58:26PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
