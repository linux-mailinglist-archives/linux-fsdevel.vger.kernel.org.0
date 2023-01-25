Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEDE67B91C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjAYSRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjAYSRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:17:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755A599B4;
        Wed, 25 Jan 2023 10:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80508615AC;
        Wed, 25 Jan 2023 18:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B152AC433D2;
        Wed, 25 Jan 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674670639;
        bh=D55JdfXbvbY8wplLtWnkYlIQGaS+XFRNKe74YyALuDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dD7lihIwNL3uKynMEKCYfHqJZHXn1l7nCLsRQ1dMl3ZDc+Ni4vVl5jHDHMfFx9iYd
         foCfUCr2ZCiFb5DS/ld9LjD2biMsxTY6hWxeEO6DD/jdeBmvmg52XZBvVrRTtEpAID
         /cvMstSaXOiLGP8ifCXFj8ymj6ynzPXEPOQf+S0GfqL6JAyUgtPWCgHFcvx4V4Foe/
         aYuAp+YcAlLkH0ChuUOx4hz0IVqTmA4BnC7n5TqtFXAVmmv+BqcXHijkzprNhvwW6Z
         xWOVTEa93iKc59CSwwyLiXFkROlNFyYpINWRiR0Y10WCVeA7y5ZSwv89fc92NE0iDi
         37RsoFZIBOdHw==
Date:   Wed, 25 Jan 2023 10:17:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: move sb_init_dio_done_wq out of direct-io.c
Message-ID: <Y9FyLu3gcWBKUgoe@sol.localdomain>
References: <20230125065839.191256-1-hch@lst.de>
 <20230125065839.191256-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125065839.191256-2-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:58:38AM +0100, Christoph Hellwig wrote:
> sb_init_dio_done_wq is also used by the iomap code, so move it to
> super.c in preparation for building direct-io.c conditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/direct-io.c | 24 ------------------------
>  fs/internal.h  |  4 +---
>  fs/super.c     | 24 ++++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 27 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
