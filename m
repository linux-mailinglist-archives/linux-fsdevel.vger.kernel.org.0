Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21D567A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 00:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiGEWXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiGEWXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DFF13FB6;
        Tue,  5 Jul 2022 15:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E0461D27;
        Tue,  5 Jul 2022 22:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7BEC341C7;
        Tue,  5 Jul 2022 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657059826;
        bh=NyH/wUMlKCpXP0ybWK58C7Bl3SZcKN7gu8I2sNEmJP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxENKH6q1X65U6SdYLGR1dD9KHKC2amz+KRixKjpJlxvcEm32TBxV3ERu2nPn3q56
         ncMWVerhZruHMY1auWm5B7/ZX1yf7B5nlc+5MLGhMQMMs8RTs4AE231rqnTSgiEf90
         GP91N0JbWjsJdaFkLRZMLz02byoXAjE3oM4CpmMiPsSzYulOLlWZAt7flA/jeu/7Mq
         K/7xvRiENbITR75Tp5Ct7Y1NbtDhfEE/F9hs6Emd6/F/etQySUVcXve4Wt3pn7X3UC
         HZqYWceNjEasjJPKZD+NUCu9XsYQp4VO8G3//VTkOvsIBLw2pqW6/1DeFFLNmMU1/q
         WULPVGfmN0+kA==
Date:   Tue, 5 Jul 2022 15:23:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [man-pages PATCH RESEND] statx.2: correctly document STATX_ALL
Message-ID: <YsS58QJf4jQ4r3QM@magnolia>
References: <20220705183614.16786-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705183614.16786-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 11:36:14AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since kernel commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
> STATX_ALL is deprecated.  It doesn't include STATX_MNT_ID, and it won't
> include any future flags.  Update the man page accordingly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

As the last idiot to trip over this,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  man2/statx.2 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index a8620be6f..561e64f7b 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -244,8 +244,9 @@ STATX_SIZE	Want stx_size
>  STATX_BLOCKS	Want stx_blocks
>  STATX_BASIC_STATS	[All of the above]
>  STATX_BTIME	Want stx_btime
> +STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> +         	This is deprecated and should not be used.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> -STATX_ALL	[All currently available fields]
>  .TE
>  .in
>  .PP
> 
> base-commit: 88646725187456fad6f17552e96c50c93bd361dc
> -- 
> 2.37.0
> 
