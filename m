Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700C77548C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjHIH5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIH5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAB1736;
        Wed,  9 Aug 2023 00:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BE062E80;
        Wed,  9 Aug 2023 07:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66230C433C8;
        Wed,  9 Aug 2023 07:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691567834;
        bh=v0xYfmG6wm9eg/WvvT9EQwYCv5EnapFNIDQZX7uEmsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atzbLuizD9CF2qTmbSqgkQ6N1iAapMzRg0pGKYLDxK1JFOy5RMGGk2QqiJN/CPVT+
         IgXJWUItCz9lKaLxohz3lMVf0ba/+xPcELcTCG9Xdjhpf7D7g6JQnHu1zCA6L/EkoT
         1xsAf7cq3k01UZJXy4w6mWwVBtvP5Vef3tJwkm5TOJuOT0Z8+NPZj6kczyOJ/V+IM2
         7RoMpjntorgOVwaX4SL0dMJ29sNMMKk+fcLVdFVv45Y4fnR5VcmPbPYji8+yWz1hoA
         j2O+f5JqIGHfBZB0uQCBu172D/q5twktJ6f0y2qnQDPc3TLRtU/A+UAEEDXGLIpF40
         K7J3/PFN0XxVw==
Date:   Wed, 9 Aug 2023 09:57:08 +0200
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
Subject: Re: [PATCH 12/13] ntfs3: don't call sync_blockdev in ntfs_put_super
Message-ID: <20230809-schob-putzen-c667de925b90@brauner>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-13-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:59AM -0700, Christoph Hellwig wrote:
> kill_block_super will call sync_blockdev just a tad later already.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
