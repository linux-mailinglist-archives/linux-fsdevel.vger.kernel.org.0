Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A550576F16C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjHCSGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjHCSGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FAC4EE1;
        Thu,  3 Aug 2023 11:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5543261E3E;
        Thu,  3 Aug 2023 18:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC28DC433C7;
        Thu,  3 Aug 2023 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691085874;
        bh=eCLuzrspl2iA9AJzB2yLuYbX5hhAX4e4sNYlXnEkxWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dl7ePWst+Fn/zB+vTBNyZ407Av71NETccv5s5eg1ogo6vQAFVqCGX2QEDriBXA9la
         h2aslHTXX2U2bsrocTVsZ1nmjo4B6UBq2h91Gx2vahiPi4QQ78UmzOI8LXbNUflrDL
         FAPNfKTTR1fZ0j6/+PdOIbgJ66CpgAdLA76gvCOEtrpv7EtMMR+ReL9GxeLci5PfKd
         P9uXqdRuUap6ECaZ1XEHmFvLYlyxeOd/uUKnWx2wJpCmXSIjDwP0TsCg/27xnBkTRk
         R9xAA/eehNcaM8eGXyancfI9Oj6aRKq8jTXGn9A39bXCqYJ7/awLi7s6Iyj1xU7PWz
         dl2fOfiODVuqQ==
Date:   Thu, 3 Aug 2023 20:04:28 +0200
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
Subject: Re: [PATCH 01/12] fs: export setup_bdev_super
Message-ID: <20230803-decken-lernen-3939eb320283@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-2-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:20PM +0200, Christoph Hellwig wrote:
> We'll want to use setup_bdev_super instead of duplicating it in nilfs2.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
