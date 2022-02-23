Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C964C0CDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiBWG6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbiBWG5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:57:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B637ABF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Iboe30TG8c+H54YPoX4wasp0Bz+vQFsYExSlk8GWK1U=; b=zXnIig2HKss+7x3tOeUfydwIo0
        rPRDSLSDZmwfHd7tT0WvDuGJKRZXPEMVGGi9qYYNbTT70h2GFbwbNvyOpPo3+zOlNQz+k1q3c/8mW
        d2BQfjqlDQukTwkV0XZguS0qTQnTYJw9IyJ5QyuWqsxMaiY8yI4si41botgPwxCUS7G82kmJkBzdi
        0gpVxn84xzujRQNW2dk3QW4u+PWiwWTpKvphbcqI8EqWma14G9mJ+/9ExNS4oA4VIeZzbH5/AJ17Q
        BZBTW0pxkrB0x4qAPsT+9wYYzwiyZqYmTmffHNlCbM3ObvEDPTu34Zh0nBWHf2kehYYXfbXLrOc14
        zkVSEu7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlaZ-00D3Oe-0u; Wed, 23 Feb 2022 06:57:27 +0000
Date:   Tue, 22 Feb 2022 22:57:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/22] fs: Remove AOP_FLAG_NOFS
Message-ID: <YhXa1/2u4Zhr/3jd@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:11PM +0000, Matthew Wilcox (Oracle) wrote:
> With all users of this flag gone, we can stop testing whether it's set.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
