Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164594CDE25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiCDUCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiCDUB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:01:56 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC66188865;
        Fri,  4 Mar 2022 11:53:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F229068AFE; Fri,  4 Mar 2022 20:36:00 +0100 (CET)
Date:   Fri, 4 Mar 2022 20:36:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature
 hint
Message-ID: <20220304193600.GA15474@lst.de>
References: <20220304175556.407719-1-hch@lst.de> <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:34:39AM -0800, Keith Busch wrote:
> On Fri, Mar 04, 2022 at 06:55:55PM +0100, Christoph Hellwig wrote:
> > -	ctrl->nssa = le16_to_cpu(s.nssa);
> > -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
> > -		dev_info(ctrl->device, "too few streams (%u) available\n",
> > -					ctrl->nssa);
> > -		goto out_disable_stream;
> > -	}
> 
> Just fyi, looks like the patch was built against an older version of the
> driver, so it doesn't apply cleanly to nvme-5.18 at the above part.
> 
> Also please consider folding the following in this patch since it removes all
> nr_streams use:

This was against Jens' for-5.18/block tree.  I'm a bit lost what tree
to best send it against as there will always be some conflicts.
