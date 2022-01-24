Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66E497991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 08:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbiAXHhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 02:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiAXHhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:37:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF5C06173B;
        Sun, 23 Jan 2022 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mao8rTEmKkOjo8x2Hq6UPTus4x5HRQqleMU3/f2v4+8=; b=qiBZvvlnUtQQViXRuVHdJLEMSn
        LuQ8hWvmiZgXfqsC2sEzmF6F/M+KQVWbWsM6OeHkqN2hAC0K3f9pwMeLzSDXLugK2u45lX4LpCpIU
        3ROynwEKKjABNmroBa6YEkliJ2VEdtUi4QJS25QfrKLg8mMC+Si9d6Zwx1DBZoAIFyp6/n6xgege5
        0gLvXaCaa99dSE/FNpRFhobv4zHMObTVBj3OBct0EExWPzYmyIsToiBIb0VSFW5Wn+PxppQs5QLNW
        +3XLvax0B5gM97OxIAydjae+D9VkwunjkEG/uZx8AsTcJEImQcDOrFzTV1mlqw2MALuo77JEW6pta
        FwWPVy6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBtuD-002VGp-9U; Mon, 24 Jan 2022 07:36:49 +0000
Date:   Sun, 23 Jan 2022 23:36:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm: page_vma_mapped: support checking if a pfn is
 mapped into a vma
Message-ID: <Ye5XEeMYt8c7/iMV@infradead.org>
References: <20220121075515.79311-1-songmuchun@bytedance.com>
 <20220121075515.79311-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121075515.79311-3-songmuchun@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:55:13PM +0800, Muchun Song wrote:
> +	if (pvmw->pte && ((pvmw->flags & PVMW_PFN_WALK) || !PageHuge(pvmw->page)))

Please avoid the overly long line here and in a few other places.

> +/*
> + * Then at what user virtual address will none of the page be found in vma?

Doesn't parse, what is this trying to say?
