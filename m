Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5078DAC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjH3ShH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245309AbjH3PI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:08:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338181A3;
        Wed, 30 Aug 2023 08:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A02F9B81F49;
        Wed, 30 Aug 2023 14:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40563C433C7;
        Wed, 30 Aug 2023 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693407556;
        bh=9U6q6lhJIcLmeUyf96hP3NIEvNRrTjKhSlvtoOaH5rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/pST/lDO29bcroqNWarLiYypoQNHAPAKzrignl0OHztaQHgQLA39N9aY1FJJLuNd
         Cmo/ILALBpVdNH+H9TAxnvQkNy+0LDFAq0bX95935sV/ZuBqN4tyS6IsUYBEkvl+6x
         JMRodq6Vqiu4OezHiZo/57n6UKllFjmY5EX42QgmV7eulkqQigQoWg7nCV6f+TghhP
         BloSOIBQYZKGi/MIF2l1dXm+z3REZ2L5OGSUhQISa4EZQr17vLzored82oJaLdi1oY
         eEyRSpcuoOFq4ttDrQj7v1KRjTzl25Q0iDudxueSs4GWqNV8CLYCjTvw5i6Vg1w6lv
         UrL21djQZDGlA==
Date:   Wed, 30 Aug 2023 07:59:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH fstests v4 2/3] generic/578: add a check to ensure that
 fiemap is supported
Message-ID: <20230830145915.GC28202@frogsfrogsfrogs>
References: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
 <20230830-fixes-v4-2-88d7b8572aa3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-fixes-v4-2-88d7b8572aa3@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:58:51AM -0400, Jeff Layton wrote:
> This test requires FIEMAP support.
> 
> Suggested-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/578 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/578 b/tests/generic/578
> index b024f6ff90b4..e8bb97f7b96c 100755
> --- a/tests/generic/578
> +++ b/tests/generic/578
> @@ -24,6 +24,7 @@ _cleanup()
>  _supported_fs generic
>  _require_test_program "mmap-write-concurrent"
>  _require_command "$FILEFRAG_PROG" filefrag
> +_require_xfs_io_command "fiemap"
>  _require_test_reflink
>  _require_cp_reflink
>  
> 
> -- 
> 2.41.0
> 
