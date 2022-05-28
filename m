Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44053536AF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbiE1Fsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiE1Fsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:48:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D46007E
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m9G9ns3eIgke6eu6rSAOFG08x7K5dzQuAObWwk8pl3w=; b=K+2bYkKKlY663QheOkVuKpCIU+
        ZTMeqL2jKnROhWVrU9ZTaVuLFpSpAHb53eP+5fjW9VYSh3MAZe4o0kMN5BdZj3HzbRPl7L63P4n3U
        PdGiA6JYNKG/k6IFAjDhrBtn0WH63lMHNG659FF82FplyUtzCdIFzpkUeiyTneGX7Z7XrvJ80ei87
        ZcSitBEjZNvYHSIYLpC3oG9FAaHqnQ0pKJAUfDwmRK8Ga8dc/0ye9vrz7YSTHIMUMgC+qCOU0VDAC
        iMOwxi2PZNLu2rk1SPPKVE9gd9i/eLnFuZDLPvrV0rlM85pomz/ovT7H/24r0e3B+mT9Vnywtcaal
        SXmJdcOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupJT-001VLt-A8; Sat, 28 May 2022 05:48:35 +0000
Date:   Fri, 27 May 2022 22:48:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/24] hfs: Remove check for PageError
Message-ID: <YpG3s4ZSSN9ONcUW@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:17PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() encounters an error, it returns an errno, not a
> page with PageError set, so this is dead code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
