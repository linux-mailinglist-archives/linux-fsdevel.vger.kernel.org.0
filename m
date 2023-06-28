Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972F7417A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjF1R5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjF1R4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4426B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF5D613F8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 17:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E7C433C8;
        Wed, 28 Jun 2023 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974978;
        bh=Yj4/Ntnt2oZgdLyzEMSvzPyiC54bDdrZZCr/Pg03UWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1txkoxGdHj2gp1afgHzN+3DeOP/OyDT5VlyWPECi+fQ886Jbw+Zn9vS0FMnTndDg
         LFDs1jJu0Qp1Ppz65KY2HzYyRCHtkydXpF9gzPpc2/0jUj/VsdrO9L86YY8CQS7rJ/
         86bnT+KN8IOPvLv2tu2JJbWNkGGTtiGxZ4qCz9Szndde3LQcXY/wHgp+jKagrb9e+S
         Fo5UVQZ6OBOzR5KRYp0Rr7e0OOwCyRF/f+2ra+Hyn9y+7ZiqEbMMul31gaENqUZF2T
         jxP6CXBYGdqVAriz8J+fdAQecwhv6TaHN9E9SVJFOStW8e0AOVch0rJPIWxB2AaJ/6
         VyoCi4TokML/A==
Date:   Wed, 28 Jun 2023 10:56:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] drop me from MAINTAINERS for iomap
Message-ID: <20230628175618.GI11467@frogsfrogsfrogs>
References: <20230620052933.711180-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620052933.711180-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:29:33AM +0200, Christoph Hellwig wrote:
> As Darrick prefers to micro-manage this without looking at my input
> for code I wrote and then complain about getting burned out by that
> I might as well drop myself from the maintainers file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f794002a192e24..9c4a5572ae3382 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10813,7 +10813,6 @@ S:	Maintained
>  F:	drivers/net/ethernet/sgi/ioc3-eth.c
>  
>  IOMAP FILESYSTEM LIBRARY
> -M:	Christoph Hellwig <hch@infradead.org>
>  M:	Darrick J. Wong <djwong@kernel.org>
>  L:	linux-xfs@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
> -- 
> 2.39.2
> 
