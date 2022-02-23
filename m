Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA434C0CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiBWG61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBWG6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:58:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D42A49C82
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ufHFQeXxYQGk4lDyi83wzKVg9+
        xdzaz49m2qHqrHKpHV/SiUHc7pnzan92uzqfJmwsh65K090JrsFR9UsrSV1wbTI+0nzr6xVdadKhS
        6LtT87fBmvMJyQbxj/yj5kXwB4a3VLd98SktyJD6npFzv0iCwMV9ka630Mr1xKR5pAf8k7Kj4Eh9W
        XC2BSYS5WpbllQvyks+fnPlyEPDwVXHjFHvQb6G+q82/1gYKpUfbkYcaXze2mdlltHazQcN2NXnUz
        PJ7x7Gs0H3NAmGDOqzTI5ntoppr7FUqqrIg1d7W0phk3ImhUmHzvGFcSIf4nhnczMcv4wXUKsOQyM
        Ff2JPCYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlb4-00D3SP-Ph; Wed, 23 Feb 2022 06:57:58 +0000
Date:   Tue, 22 Feb 2022 22:57:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/22] fs: Remove aop_flags parameter from
 netfs_write_begin()
Message-ID: <YhXa9usmouUT9A6o@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-16-willy@infradead.org>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
