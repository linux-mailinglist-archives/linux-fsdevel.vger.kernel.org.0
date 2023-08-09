Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717077541F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjHIH3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHIH33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:29:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64653358B;
        Wed,  9 Aug 2023 00:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04BF362FDF;
        Wed,  9 Aug 2023 07:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81A2C433C7;
        Wed,  9 Aug 2023 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691566098;
        bh=9QTZ0PtmxByaIyvlMoxXgLmgqcW9x0ANh8QtQ48L7PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5utP/plwwL5bDCafpCSeDReNmHjPgMzjdiFGApn3SX1nBi82MHw2HpABjFimRGR5
         UZlZ+n8bpOppKio+IhsZl14xFLnaEly0AYVQlUHpUNJVvmyWT0Jg1vWISq6Sy0HN88
         G9T4OpcPM4hyC30FGMT2PJAX+4vsdH632IKa4rqkQ6+4cCsLjyPPPsx68KUTACl4sz
         9UruJth12z0VW3Wq0OHS1tl8nzOWjCBEw19DPa1C/zPoKSPY+u5hYDgeDHWHNrt2/X
         db+LBPPMPH8QXGLKastumucL/Eb+e7PdoSR6+bpj9CNW9kdFl53ugiXaXIlVjoXmr5
         A9NRyZRc6Sm8Q==
Date:   Wed, 9 Aug 2023 09:28:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] xfs: remove a superflous s_fs_info NULL check in
 xfs_fs_put_super
Message-ID: <20230809-kickboxen-hohlraum-efb1991a7bc1@brauner>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-3-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:49AM -0700, Christoph Hellwig wrote:
> ->put_super is only called when sb->s_root is set, and thus when
> fill_super succeeds.  Thus drop the NULL check that can't happen in
> xfs_fs_put_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
