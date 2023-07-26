Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC07636C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGZMvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjGZMvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:51:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C31FF3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 05:51:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29A236732A; Wed, 26 Jul 2023 14:51:07 +0200 (CEST)
Date:   Wed, 26 Jul 2023 14:51:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230726125106.GA14306@lst.de>
References: <20230724175145.201318-1-hch@lst.de> <20230725-tagebuch-gerede-a28f8fd8084a@brauner> <20230725-einnahmen-warnschilder-17779aec0a97@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-einnahmen-warnschilder-17779aec0a97@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 06:32:05PM +0200, Christian Brauner wrote:
> I've removed the references to bind mounts from the commit message.
> I mentioned in [1] and [2] that this problem is really related to
> superblocks at it's core. It's just that technically a bind-mount would
> be created in the following scenario where two processes race to create
> a superblock:

I wanted to keep some of Jan's original logic.  In the end a bind mount
is just one of many reuses of a super block so I think your updated
log is fine.

Btw, it might make sense to place this on a separate branch, and Jan's
block work will have to pull it in, and it might be good to not
require the entire vfs misc tree to be pult in.

