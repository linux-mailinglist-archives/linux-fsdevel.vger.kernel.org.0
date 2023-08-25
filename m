Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E8788754
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbjHYM3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244881AbjHYM3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B024212C;
        Fri, 25 Aug 2023 05:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8611161E25;
        Fri, 25 Aug 2023 12:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7141C433CB;
        Fri, 25 Aug 2023 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966467;
        bh=X1sEmR7Wgo9iEx4Nm5FGEwpQOX2GMPaKb2K7hO0NWmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7Zyoejkzwbp96OecrluACIPS19q3kRmBAIAhMXW9X6N3gDcuzK6W06bnJV8X00W+
         QQ2W0j+IHgi/b1O77QFPRD+Ho5mMoO+d/qLdM/tjCxsVEKAYnsSYDun3s0Hl7GlRaT
         4Fp1xxh1rwlfzvw1sYMR67VlStTY0jb4pIfAfLqWpo2bxKCs1Vxo9cBUSLQ0p6Z7BF
         EVYZrab9lBcUKigXaRDTDDw8XHAO0PtZW71bg0dmdRnj6622bz2LRZWLKbL7GGusXm
         rG8dAVbMdX7UbX4Jo9+Sogv6S+7eiP59Av2Y6LgP8mlVijqREN9oIqOtpZjb6h6ar5
         X/d0w/NZgZ9rg==
Date:   Fri, 25 Aug 2023 14:27:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 21/29] erofs: Convert to use bdev_open_by_path()
Message-ID: <20230825-tosend-geldforderungen-6b4c43bcdcfe@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-21-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-21-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:32PM +0200, Jan Kara wrote:
> Convert erofs to use bdev_open_by_path() and pass the handle around.
> 
> CC: Gao Xiang <xiang@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-erofs@lists.ozlabs.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
