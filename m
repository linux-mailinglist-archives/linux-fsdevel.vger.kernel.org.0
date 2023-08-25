Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8618788778
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbjHYMcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbjHYMbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4126AF;
        Fri, 25 Aug 2023 05:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B0B67B95;
        Fri, 25 Aug 2023 12:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8004C433C9;
        Fri, 25 Aug 2023 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966625;
        bh=YllMQsUv14IXcAV5eXi5Bkkkb4eHZRqaRVsvNBAoLlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGsV9oyBhqmEqmboUScP7GRsXXfMR9TqANIi5mr5dUFcT65MSCDGKtuxy2CS54cH1
         cqRJ29ZmcwRtuClxZx1FFk2vGFa8ZmPDLwkwpzl8Dp9LixE/E3bzwfi2a7jw4f7SO6
         Jhhg9hNJ+pf+Aln4mJxUMvAkp7V7PVNmieW+z0J91Hbjv6CStPv2g74s+XzJGxwGW2
         GUOeS2AzXpgWXl7CYpZxWDdTtkYCRnaMhGP1KxD3oEhJ9cRdo+pYnkZ4XBJG1Q4XxV
         bnjbLCNqqmsfHvBB6WDXzmEmdtXpYV2Zfl1XnqC4Rqx1plNlqUjOUFEq4sGYqWftex
         slovSrrs/SCCg==
Date:   Fri, 25 Aug 2023 14:30:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 23/29] f2fs: Convert to bdev_open_by_dev/path()
Message-ID: <20230825-kaschieren-gespreizt-7d246803ae8f@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-23-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-23-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:34PM +0200, Jan Kara wrote:
> Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.
> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
