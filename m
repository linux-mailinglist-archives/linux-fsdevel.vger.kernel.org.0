Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4378870A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjHYMVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbjHYMVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A02707;
        Fri, 25 Aug 2023 05:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D70679F7;
        Fri, 25 Aug 2023 12:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED1BC433C7;
        Fri, 25 Aug 2023 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965965;
        bh=ZaK0iBVh48tG1uSvdbG2IxFPtvcjs/3Xp2ddmE0lzw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQ/PXinS1ES76QEYhNqOy+IGcYNdu7C9rW8mGAxg9nOSuVM1ijr1/zyRNApNnHlhL
         uwYoeEcgsQ4lEwBcMEu1BSKDT15n6Caq+ufrjkemaEPe5a8/Vgdh9nks6BirUNiMLz
         sCZhgIzvgSFtE3K0SNKId0DzYyAyCQy6wGTLwdDwJH7+zR7KAJf8D5kZ9Tyfktq2K+
         yCoUXwsnJ6EnCtawasLisqvlWmnpYzGje1keIx7qa2Aqab35m+7kQ4J4+HN/DuGcJV
         6eeX9f/3TS82l6ixvurjUzX84lncFlspyXgNESqSWUPt+p3HgwkUQntY2iUDAKRyJ/
         OEDzkKvFFJQZA==
Date:   Fri, 25 Aug 2023 14:19:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 18/29] mm/swap: Convert to use bdev_open_by_dev()
Message-ID: <20230825-handpuppen-entnommen-7db8838bc52c@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-18-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-18-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:29PM +0200, Jan Kara wrote:
> Convert swapping code to use bdev_open_by_dev() and pass the handle
> around.
> 
> CC: linux-mm@kvack.org
> CC: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
