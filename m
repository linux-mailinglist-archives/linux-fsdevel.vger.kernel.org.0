Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83786725966
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjFGJFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbjFGJEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6F211B;
        Wed,  7 Jun 2023 02:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A58361D44;
        Wed,  7 Jun 2023 09:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCCDC433D2;
        Wed,  7 Jun 2023 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686128597;
        bh=q7AdZhSDALKQcnwiboxtavjTYhFCYH416kEbuBo82ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmFv4NUDSWWO12W7cnryBDYV8PpqTiV6m9IiQfaN+Gy1TfavMxnrDvH/1VFaqu0VY
         pNdbYyRHzF2xHsOOKI87miWMENWlYg9+fsdmVVKTz7wYCo6GM1+2x+3dTWnt7WYDdZ
         Mcjyuj+xp5weCEAYKk11qk0vTGQUIzOnBLlKJpx07Q5ZRsx7ASXqBbtAW0ZLkT7Ew4
         zBKVTwzdquqRp3RuennzrpOsYTw2sC0VjBfUPhiyrzzFVaAdPGx6+N+quMH0El0KVh
         SXVIETbMrhU8sh4IsaqUJwCWqqtEaM+3Y6KO5/S9XwefBpx2SMbZ5aVq7LqHVJcaJB
         5ShZ62p5oKScw==
Date:   Wed, 7 Jun 2023 11:03:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 26/31] block: move a few internal definitions out of
 blkdev.h
Message-ID: <20230607-kernkompetenz-halbleiter-b8874bc39061@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-27-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:45AM +0200, Christoph Hellwig wrote:
> All these helpers are only used in core block code, so move them out of
> the public header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
