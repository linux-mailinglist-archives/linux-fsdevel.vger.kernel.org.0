Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB277881F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 09:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHKHYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 03:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjHKHYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B21AA;
        Fri, 11 Aug 2023 00:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A6E66BBE;
        Fri, 11 Aug 2023 07:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37178C433C8;
        Fri, 11 Aug 2023 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691738689;
        bh=gn2WfJEZHOWAV3qHLFB1JfBTT0fLyhd0K6l80/kfy3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjRQqe610JNypA9abG8cVu+d/5OVCxyYLkOJDNVwq4SCyCpQtm9gBkPbruSkO4Smx
         jL+41qMS2dZSV3LhHowNx5iao8vX3ezpobAjclhOgQ3fJUvh8wWLudkw53INkdLhvV
         /3rY91pCJngQlx+938vTHdz7GYUqkzIqk5Wi6wghczOHLhalUQfqJFGwwIgs/BV/UB
         /Lh19m3SkW9Z0tRdwphI/rPPtoTgUB2X62itNGwENKMez0Syq7h4jCtqfweoiWdNAY
         0mZAPHVEFFtjRRNpaUiihyJjYRaBU/UzGW+He5o2Ae11qEDq+2UeTXTapj2ElnSKxU
         BXIFYLumFrMVg==
Date:   Fri, 11 Aug 2023 09:24:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 01/13] xfs: reformat the xfs_fs_free prototype
Message-ID: <20230811-leeren-garnelen-6153c9e68cff@brauner>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-2-hch@lst.de>
 <20230810-unmerklich-grandios-281ae311e396@brauner>
 <20230810155116.GC28000@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810155116.GC28000@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:51:16PM +0200, Christoph Hellwig wrote:
> I think the btrfs hunk (below) in "fs: use the super_block as holder when
> mounting file systems" needs to be dropped, as we dropped the prep patch

Ah yes, thanks!

> that allows to use the sb as a holder for now.  I'll add it to my resend
> of the btrfs conversion.

Dropped.
