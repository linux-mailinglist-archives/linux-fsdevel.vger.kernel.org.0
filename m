Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9076F190
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHCSMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHCSMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC773ABB;
        Thu,  3 Aug 2023 11:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E1361E56;
        Thu,  3 Aug 2023 18:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1541C433C8;
        Thu,  3 Aug 2023 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086323;
        bh=FvE8CcpTg/rwFyIjkGKpbi4sVFpEPrWRcbOUHH0og0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW7WFuTLRAPoN8tiK+U2RXIY2N8l9VIKhr4v5EuwvrjQjf3HdRQf7xbN68UZZ46zH
         SO1MA9DuRBFsu/t101HYGMhge4PpqCvyyFdCSiM6yxB5L2rIj/XJaXXMMh9Zh/Cuu+
         co+kKz1UN7oez5C8+giAJgZwdFug00bKSW2NUiG/NmUDxnk6vUU0SV5iwwzbS7c9PV
         ENMI160o/kjEUAuSQu7B0b9aiWQQ359FaQygUVE6PTlsN667YIfLe7I1yKSIAq18O6
         t1BukcVZsqtEKb564oyOfYihvq+7U4lXIKeLsRGPjRhjk5Iylovvs66qrt9tj6OKwC
         WUm7iF7kPoIZQ==
Date:   Thu, 3 Aug 2023 20:11:56 +0200
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
Subject: Re: [PATCH 06/12] fs: use the super_block as holder when mounting
 file systems
Message-ID: <20230803-zornig-drucken-7e2a53465a15@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-7-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:25PM +0200, Christoph Hellwig wrote:
> The file system type is not a very useful holder as it doesn't allow us
> to go back to the actual file system instance.  Pass the super_block instead
> which is useful when passed back to the file system driver.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
