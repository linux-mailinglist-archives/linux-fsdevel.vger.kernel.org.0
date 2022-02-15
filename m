Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410844B6448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiBOHZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:25:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiBOHZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:25:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65597F1EBD
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y1ta4A2pA3xRjz4+7DYg0bKTf6OOfSccy05vggXhPLk=; b=bnqG51VFpHj0J8j/HkvQIXOS3u
        vYp2owcYTeqkqGR8UV4NSxe6y5vOAsCwjo3XJPQbZrfGMNrF7BmDz0GdHxpnOSeryufQihNhbt+/Z
        W8j3p4aSzJm71sajEBG+/jJR+L3/eUROyrs+YtG9x7jO1+YEGHxW+vTsXrn414dS9bEfBTH7mtQLN
        k+hKgSMBMNu25dPdqKjStMfyJT3DRHn5ANfaHtXeRPra60J5iOcfQRWAm4DNW6/l8kKG1j9VyffKw
        UtVEe00aLeMU8dKB83qjVH7YO7GR6VROi5LjC0uLX8rwULZygk9G3TlFskS2TaRULuBWQvoOxjiTy
        p4jo3qVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsDb-001AoF-2b; Tue, 15 Feb 2022 07:25:47 +0000
Date:   Mon, 14 Feb 2022 23:25:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/10] mm: Turn deactivate_file_page() into
 deactivate_file_folio()
Message-ID: <YgtVezm7HX8i5JIQ@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-9-willy@infradead.org>
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

On Mon, Feb 14, 2022 at 08:00:15PM +0000, Matthew Wilcox (Oracle) wrote:
> This function has one caller which already has a reference to the
> page, so we don't need to use get_page_unless_zero().  Also move the
> prototype to mm/internal.h.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
