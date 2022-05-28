Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB869536B03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiE1GAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1GAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:00:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A9F04
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rsBwluTalEVbHJfHOGzLNIf+cV3Fyok2XI6tCmHheak=; b=yxP6XtN6wgPCNmVbAwWsjguXwa
        zq6eJQJ0TLgwdwcBRCBRDXeWcfn2sTgngKSV3gcaNRqodMSO6d5L8IzxoBeeE3ngZ+0uAkq0TuM/E
        O+uA1UICF9/DWAOg000I+YnclaN8gzTRyd+24BRhYtvaB4vD2G7Nu/YX/gSLyFL6mY+NYxheQfsjM
        5WV+DBOmvTP11eec+vONg0CY4btX6Z5qkrFbMp2uMFANKxtl5QwJIRXx9KLXugJMzpZ6JEd9p8pmG
        HpEvpG63jriDkUQn0rztDMdJBhIO8nq9SDSmun8LeBmxkoflaLcHWOkoVtaqbYstzyg6GiUKXAL7m
        AMBVE+oA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupVF-001WlF-Is; Sat, 28 May 2022 06:00:45 +0000
Date:   Fri, 27 May 2022 23:00:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 17/24] orangefs: Remove test for folio error
Message-ID: <YpG6jWRGWLBzWdYt@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:29PM +0100, Matthew Wilcox (Oracle) wrote:
> The page cache clears the error bit before calling ->read_folio(),
> so this condition could never have been true.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
