Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6D536AF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiE1Frq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbiE1Frl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:47:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580CF13DD7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i1Lvs5BpBAXbau72zrMflW/NuAghVvwBlqUp2VoYfDg=; b=DuWqu8ADAlU20TOePAdGh7svOI
        jAF0A9x37nSvEGHDNQdgfU0Y8ykpR/OEeba6sXVFJ0YtS8gyfV1rOBsGMs+JRENTRg2ty37ArDN34
        wVN+CB3wFoIpzlKVgFwjc8huvtSRKuNaJZZnaQ1keR0JgA6zS95STnknKT5o6nJdDWCa7LSgTU6ax
        vIHFESy2HR1MZaNs9et/AXACwfqnlbNCvxgLN8qEu7Nr/+a58jnAwdXoQrxE8zGZnOUcqp+OTLCQa
        KrrcClXkWyFPg9MjJfULOa7BCG5BeRAyggEcF8ejG3tvM+nvPGdROFcq290KOsWFmtwoBiuHZD4R9
        bcxt+jsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupIZ-001VEj-W3; Sat, 28 May 2022 05:47:40 +0000
Date:   Fri, 27 May 2022 22:47:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/24] afs: Remove check of PageError
Message-ID: <YpG3e0nEcbApUGQk@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:14PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() encounters an error, it returns an errno, not a
> page with PageError set, so this is dead code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
