Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0D536AF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbiE1FsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiE1FsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:48:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F556007E
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ufukiDdR22JyUmphCSlUdSf0Lt+6ceGwp/hwMz0aIU=; b=JPLH8bJiKMAdaFk8xdHOF/20IC
        gKegp8gOAJZTcfIROjynnoPhGhHWJxef+5VGOXoiE1fLItnciTceDQ2WIcTvlPrAacxeEsTLJut0z
        QGoTm4vTyPtYtW8KrTuALRQe+ix5txclr1oU7V498rTLmYi0nyBDZCYG1Dw94OUskzOxeOI2mCj79
        z2yosAqlmZaySlokTZqjc0QTnwyJ6jOG2amNFicZNP1fOB9LXIeqlwWLsxqyKLF9dXn+Sk4oQKMju
        DkStrrYOwTpHH7MZt4SnU40pl8qtvlCufjnuucmynQr/9vwlpEEBUtfelf5KAyrae8Ybl3gJq7m7T
        wOrltcvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupJG-001VKG-Gx; Sat, 28 May 2022 05:48:22 +0000
Date:   Fri, 27 May 2022 22:48:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/24] gfs: Check PageUptodate instead of PageError
Message-ID: <YpG3pkbsiCD4HIJO@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:16PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the correct flag to test to know if the read completed
> successfully.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
