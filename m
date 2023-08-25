Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF107887B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbjHYMmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244270AbjHYMmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F081BE;
        Fri, 25 Aug 2023 05:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2756666928;
        Fri, 25 Aug 2023 12:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F97C433C9;
        Fri, 25 Aug 2023 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692967326;
        bh=wohoeLc54G470PAxrgSeBMklXj47pDJYky5esTzz8ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WklpX/LhQ/j/mGp80J4Idd4t4KZtBcF0240AdRlxAF+0O56oLch8U693qjturmdU5
         JUJ7bjpKTkBKIb8JoRmoQTd7e8neb6EogHbn6RKPxqM5KfBBDRlo7+xTDk4B2XlGpz
         GBW7F1JlJdmuU+qGLYQeqiurw/8VcAR/i+1aGyIDifLHXdaUkB87wPBo0+NiHCt55t
         gzqk0oOADE36RQj08sd7eXaD6fDyraPghjG/uu62KIDjshT9xwDPQ53QGYoIi8O5ew
         Rfw5C7p2D2WQQpGRyZoxwCNcukfNmHNoUa2F8/15natuNKwF40eSBMQ25S7LBS3w0X
         NHdaxLarBBZsw==
Date:   Fri, 25 Aug 2023 14:42:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 29/29] block: Remove blkdev_get_by_*() functions
Message-ID: <20230825-stiehlt-hallt-30fcac4e1f4f@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-29-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-29-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:40PM +0200, Jan Kara wrote:
> blkdev_get_by_*() and blkdev_put() functions are now unused. Remove
> them.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
