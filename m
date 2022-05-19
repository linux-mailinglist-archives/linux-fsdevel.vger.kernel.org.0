Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94A52CD65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiESHnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiESHnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:43:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626873135B;
        Thu, 19 May 2022 00:43:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F44768AFE; Thu, 19 May 2022 09:43:15 +0200 (CEST)
Date:   Thu, 19 May 2022 09:43:14 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Message-ID: <20220519074314.GI22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <YoWAnDR/XOwegQNZ@gmail.com> <YoWUnTxag7TsCBwa@kbusch-mbp.dhcp.thefacebook.com> <f42c74b9-67fa-50fc-d97e-2a7f153f10e4@nvidia.com> <YoWlQxEjvlmACNRV@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWlQxEjvlmACNRV@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 07:02:43PM -0700, Eric Biggers wrote:
> If you're thinking about about BLKDISCARD and BLKZEROOUT, those are block device
> ioctls, so statx() doesn't seem like a great fit for them.  There is already a
> place to expose block device properties to userspace (/sys/block/$dev/).  Direct
> I/O is different because direct I/O is not just a feature of block devices but
> also of regular files, and it is affected by filesystem-level constraints.

Agreed.
