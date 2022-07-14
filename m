Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8265742F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 06:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiGNE20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiGNE1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:27:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D632872A;
        Wed, 13 Jul 2022 21:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qV7WvqM3l1Qusr3KhngZJMatPE6l9LI2CEqxLIbX1mE=; b=0+42dBNeAU34+ipbmLsz0Iqxzp
        DOVgVeZxxlVrnld13iDfJGSaN6eL5gqla21qRpsvyFuUNwlapclu+iAbpULh6veeSGa6PpcENRuyS
        wuDEpqYINzkAoYwTs2QhK9w1QZcley2aFiK0A6UyRyqjRzajxQpo7jYRhkij6g95l6svub9CRs+0U
        W/L/JJAvrbsT8qpOuqh0TGfdJMDD7YUkNV3ciL4EP7HJ/Mj9Ar49BSqVR1fQHFxE+BdgwgloKfAPI
        0PUhKeE3YVc/KqRtU8PLwqVmL3ycZR7yNOHLcDx0ZJkCTpQjNoppcSDwI56N02wZixNtbzKe/QK4t
        0d714kZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBqOd-00AbGq-D6; Thu, 14 Jul 2022 04:24:15 +0000
Date:   Wed, 13 Jul 2022 21:24:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs/ntfs3: Refactoring and improving logic in run_pack
Message-ID: <Ys+abx3Au0p9pXmR@infradead.org>
References: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
 <YsZkQAsKC6qxY8gi@infradead.org>
 <c8b65567-6a4d-2e61-b2a0-3a757ae9b36c@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b65567-6a4d-2e61-b2a0-3a757ae9b36c@paragon-software.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:41:58PM +0300, Konstantin Komarov wrote:
> I will look into converting the I/O path to iomap.
> Thank you for reminding about it.

If you have any questions or need help feel free to contact me.
