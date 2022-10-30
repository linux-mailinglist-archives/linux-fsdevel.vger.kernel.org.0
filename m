Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53D612917
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 09:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ3I14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3I1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:27:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B5120;
        Sun, 30 Oct 2022 01:27:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EBC868AA6; Sun, 30 Oct 2022 09:27:50 +0100 (CET)
Date:   Sun, 30 Oct 2022 09:27:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, djwong@kernel.org, bvanassche@acm.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] iomap: directly use logical block size
Message-ID: <20221030082749.GA4949@lst.de>
References: <20221026165133.2563946-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026165133.2563946-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:51:33AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Don't transform the logical block size to a bit shift only to shift it
> back to the original block size. Just use the size.

This looks reasonable.  But given that the blksz variable is only used
once, why not open code the bdev_logical_block_size in the conditional?
