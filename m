Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B47679941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjAXN1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjAXN13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:27:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE8110DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3qpiKlhGQ+xppThQB3BCQICVfW96knQ7Ac28iZ2itoA=; b=FxznLjEPL2raSYeB9HEiMWfeFB
        DRE4zhjrbDWrmh46KCtGuNaKduBZ97N3LYMz+ANyfiFupnDel1pQHRsN3+LhHjvtw+dq3kjrqKKun
        OhtWvEoy0R3tdmcocl8YOWfACfaVBDUoLs2wWKzWbTnuT6PEOlFgvv3P/qKhkA/n3HpuA2BRB4Wcx
        4mFpnxf8GNiSVuIj0T6Af3oOpl/CAa3Btw/18HO7JGzVHKNG8/zOewC9uMc+02K8QKLjQVvq7ZZNf
        X0bBns2HMgVWpxP05xxYaRyxRppXeDebhBbyL/e4obCdlWwXA4VsryHFNOMsJ1tY5QD/V9t4555Q2
        7OUx0K9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJKi-003yq4-Q9; Tue, 24 Jan 2023 13:27:28 +0000
Date:   Tue, 24 Jan 2023 05:27:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/10] udf: Add handling of in-ICB files to udf_bmap()
Message-ID: <Y8/cwLcVLYz+ykpa@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-6-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:06:17PM +0100, Jan Kara wrote:
> Add detection of in-ICB files to udf_bmap() and return error in that
> case. This will allow us o use single address_space_operations in UDF.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
