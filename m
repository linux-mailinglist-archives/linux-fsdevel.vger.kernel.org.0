Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36D4E4C9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiCWGPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCWGPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:15:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5615A17B;
        Tue, 22 Mar 2022 23:13:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 07EC268AFE; Wed, 23 Mar 2022 07:13:40 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:13:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 28/40] btrfs: do not allocate a btrfs_io_context in
 btrfs_map_bio
Message-ID: <20220323061339.GJ24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-29-hch@lst.de> <d9062a7d-c83c-06d7-50ac-272ffc0788f1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9062a7d-c83c-06d7-50ac-272ffc0788f1@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:14:06AM +0800, Qu Wenruo wrote:
> Really not a fan of enlarging btrfs_bio again and again.
>
> Especially for the btrfs_bio_stripe and btrfs_bio_stripe * part.
>
> Considering how many bytes we waste for SINGLE profile, now we need an
> extra pointer which we will never really use.

How do we waste memory?  We stop allocating the btrfs_io_context now
which can be quite big.
