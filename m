Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231776F184
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjHCSLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjHCSKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D3C1704;
        Thu,  3 Aug 2023 11:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740A561E67;
        Thu,  3 Aug 2023 18:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888DDC433C9;
        Thu,  3 Aug 2023 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086237;
        bh=l09B4wLLhFie262qfmXA0CveYXOk2JvcJhfIRHAAK4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfiQ2gN2z2YzxyG/O3d7GtOXWQ2m6fL49xtZB4NWZWBeLVPdsc4kAabQ8itROH1It
         21T7P0djO9aOpJ5WwnCRkrrEtUHf3uKDbJ1mew383Lt/fdb86kisMz4kq2oDhmj+Cm
         qurmwE1LM1WqgSAR9efG5Fq8Jmbkdlj14b21Xuzk8HjcYIDPRI7lsMh0d3Vha5yCln
         hqeMFKrHRptRejegCyC4bSWm4MvvIMFg9H5P/Pc9QiSz1UCps/9lt5Vhh/F+Sfy4Tb
         Nq31kTyt7Nxxjms3i402ilz2UjoNv7r6S2nPEZ6K3nTsNAyvejcB145/0RXS80IINs
         Cqrwcv6sNoi5A==
Date:   Thu, 3 Aug 2023 20:10:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more
 robust
Message-ID: <20230803-zecken-oberhalb-e30c55d66648@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-6-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:24PM +0200, Christoph Hellwig wrote:
> Check for sb->s_type which is the right place to look at the file system
> type, not the holder, which is just an implementation detail in the VFS
> helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
