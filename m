Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BDF4E4C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiCWGQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiCWGQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:16:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81C15A17B;
        Tue, 22 Mar 2022 23:15:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A1A068AFE; Wed, 23 Mar 2022 07:15:07 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:15:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 39/40] btrfs: pass private data end end_io handler to
 btrfs_repair_one_sector
Message-ID: <20220323061506.GK24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-40-hch@lst.de> <7d24309f-6851-da18-efab-36eb4b65e130@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d24309f-6851-da18-efab-36eb4b65e130@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:28:31AM +0800, Qu Wenruo wrote:
> Not a big fan of extra parameters for a function which already had enough...
>
> And I always have a question on repair (aka read from extra copy).
>
> Can't we just make the repair part to be synchronous?

I'll defer that to people who know the btrfs code better.  This basically
means we will block for a long time in the end_io workqueue, which could
have adverse consequences.

It would howerver simply a lot of things in a very nice way.
