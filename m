Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB64B6423
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiBOHSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:18:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiBOHSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:18:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A1CCC40
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=71TlT4KOCLMpSKaq9fbcqCt6pysHDM8w0LcEda24Rro=; b=FlNy1hNKsfBzx+jIVOYnKtYWnQ
        fTjBRvxtZfKl67yicTRQpSmojy3PkrHgUO8RShlzUDjlsAzQFfX5bi+3sUavTRJziKYMEpzJfjf//
        A03lILlDs2npCxwWshF98d4QCiKeOZj//hWuTPakuRkh5XRO+NfigMXlVoF5+xzGr0wxUdwY1gxCt
        X35fKfJbERIiH8H6SD60VRwod08ixAPGp73pRq4FhUiELp3Xh6pkTzr9WFPaxg+ose3ny4wSfC3n6
        YrNnoGhoPpPP+ZfIY8YcPZWt8lqzc33LNUUZG5TcBqqKfFw43XiJoXz0SkHbFriOMbY70IlalMXVu
        zESGPURA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJs6a-0016ul-Tm; Tue, 15 Feb 2022 07:18:32 +0000
Date:   Mon, 14 Feb 2022 23:18:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 03/10] mm/truncate: Convert invalidate_inode_page() to
 use a folio
Message-ID: <YgtTyJg3rkCBwpDM@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-4-willy@infradead.org>
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

On Mon, Feb 14, 2022 at 08:00:10PM +0000, Matthew Wilcox (Oracle) wrote:
> This saves a number of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
