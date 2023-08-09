Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0438775488
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjHIH4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIH4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCC1736;
        Wed,  9 Aug 2023 00:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A226300B;
        Wed,  9 Aug 2023 07:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D08C433C7;
        Wed,  9 Aug 2023 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691567797;
        bh=WQY/j1wRlLAF1gay3G00GCSxD4stoAKq0BiMQO5p9rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPCXNYecxQuiNJQEnEQp8yZaYu6iJySRdexI4jSuar+507/Y46g2iiu+kLfQa45mK
         T4GS+HU3tCfK0GuK5wsMw7nlsRzIgFgNOvH7tOwAFh/mRziRkxp/YgOUNN5hmE75qH
         qV5YEAnEboRMAqKP9/HNp84UdqdOaB/k/G/0O87YC4QRd5EC1eDLsmVQ54ib6IqPzM
         QxmZ5BmRDceLYLky88vlnCKQEKJI7Qgwz/bXxxvRhMYUppadwcV6UCX+gvfme2xjP1
         m00ieueVSYJxe//aR9ihwdqEA95gko1caNgKGEd3OZ6CiLHREO/XSlmfcPYKLMRqua
         W+Hj8yMKH6OVg==
Date:   Wed, 9 Aug 2023 09:56:31 +0200
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
Subject: Re: [PATCH 11/13] ntfs3: rename put_ntfs ntfs3_free_sbi
Message-ID: <20230809-ausziehen-melken-be7ae49e204f@brauner>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-12-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:58AM -0700, Christoph Hellwig wrote:
> put_ntfs is a rather unconventional name for a function that frees the
> sbi and associated resources.  Give it a more descriptive name and drop
> the duplicate name in the top of the function comment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
