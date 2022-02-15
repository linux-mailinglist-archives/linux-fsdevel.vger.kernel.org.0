Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949A4B643B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiBOHXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:23:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiBOHXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:23:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29386F1EBD
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L21Q4gp14yMp2pSFkt3h+UrCCtWC4nwzagMMl8TDYKU=; b=tjGNW23ul22RIoxRbEpQoXgQzF
        pagSH8iX2MEWckKz6+8h60MLkIETR1YK2NT0oijQYr/WNcEDxx1M/DgQ7/1t91F15VRa5eu86h+sR
        hfwRpsi7wa/b1DrXSPFY9k4z0bGLDiz/uUht+Q/Y1tXoq3TpCJf/LzcmlB9mpUpyxTMBrp5cN1G8H
        7mudJHHieWsVrI2TxqocLgYb+6V5v2NS8fVNL2jI1czHurH7cildehv7Y6wzfheee5MnzGB8YAY0l
        TlIh5tlDxqNmHsI/3BehH5yLgtqJvOBqSHWyRcuVYywJWot0S/v/FPMmxzK/h4wZ+IdPrSq8OO60q
        1ubSTRyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsBZ-0019a8-OH; Tue, 15 Feb 2022 07:23:41 +0000
Date:   Mon, 14 Feb 2022 23:23:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm/truncate: Split invalidate_inode_page() into
 mapping_shrink_folio()
Message-ID: <YgtU/eSAV3vFpEkw@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-7-willy@infradead.org>
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

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
