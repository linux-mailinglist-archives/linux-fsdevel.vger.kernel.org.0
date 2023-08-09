Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F0775481
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHIHzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIHzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B41736;
        Wed,  9 Aug 2023 00:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D41C6301C;
        Wed,  9 Aug 2023 07:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68ECC433C8;
        Wed,  9 Aug 2023 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691567720;
        bh=0+0+5RYWZQq4xxQCKgGM0US6Ugvd2dyjwVoA5wrJW9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZN22mju2skgy/wgAtRHQJdlm4siIO8NMVa68yMTF7zXF7jdFMT/uF7QR6a6YSUcQ
         N0J95P8yshmpYa3f0bzhUFZT/x+GYwTZGPc+nWyG+ulvrzBveCFg0Wv1YdslQkv34h
         KgcWDSMdZqphHiYdiNUhQVOTYkszXLexSACXwR8/3pvzo+K+WnpexAW1ZOf5ih8dGs
         YVaSLWyKqLZmOu0ZN5CKKhyff0C7I+fCTc7C3Xz07imcsUI3Sr5PJEwpynw40m8QRS
         TjVlyf/nffTGIAwET4CgaG2aab/8++pzVW49ySCEG8nQu2fK98hDPLewi57eq6cbsg
         usP/dtwfD0aQg==
Date:   Wed, 9 Aug 2023 09:55:15 +0200
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
Subject: Re: [PATCH 13/13] ntfs3: free the sbi in ->kill_sb
Message-ID: <20230809-serienweise-backpulver-5ca2915ea3cf@brauner>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-14-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:16:00AM -0700, Christoph Hellwig wrote:
> As a rule of thumb everything allocated to the fs_context and moved into
> the super_block should be freed by ->kill_sb so that the teardown
> handling doesn't need to be duplicated between the fill_super error
> path and put_super.  Implement an ntfs3-specific kill_sb method to do
> that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
