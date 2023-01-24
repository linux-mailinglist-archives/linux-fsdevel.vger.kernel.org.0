Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B756867993F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjAXN1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjAXN1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:27:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2110DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aXYACGLSPYoouoDuyqZmYhX1Fx
        u1QzSVfzGRzZZ3f9IPmFM1RLayI6vd43p9/B+Fcpx4Zv8F6d6JdjbvIWBiEBDksQKciLY7glEMdrq
        SMPIYC66C7aSPCphmlOn2Haa7skPpsnsefaPNe8nRb3AM/FjC5bYMlWejQAbzEXb2Uc2YbLzY8XsE
        p1mztS3q/K/KeKo3ikYTkZ96q5Z1T9E8zPdhBiXpIou6bmKOkdbQe7PHuCSmsl7HI65TTtSDOn9mi
        XW3JWRn3LrHn/zQJc1CQ2eKWz72CUZ0YoHBfT5PhyenYr6D4rCsn/q7o+E/ljd7gc1ANjMOqUvbWY
        Mn20QKfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJKS-003ylk-G4; Tue, 24 Jan 2023 13:27:12 +0000
Date:   Tue, 24 Jan 2023 05:27:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/10] udf: Convert all file types to use udf_write_end()
Message-ID: <Y8/csLysZG74ySQ3@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-5-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
