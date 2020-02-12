Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE615A255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgBLHoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:44:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgBLHoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dC4TB1VlR9EO8KvuKNUfivAt39h3I9RbzHocDbdo1eE=; b=ljpcZ0mZWn9haoXeZzxL+XbO3m
        i1PIeQrlpkvRF9LpCMQwchG/K7FPS40wnMQeeyxcD1yemAPy1eNpNPiPhIxcnXIj+vt39tEMQDAK2
        UMY0CGHbOEiqwpEsj5mIHtkWKNWw4d1wzNxkL8PNARK0ys+G/PiJxsqpIwHqD1ZdXzKGLwoJ6AuuE
        oj07OvjtPku8JmHQy2w6ESS4L+seIcDWZwZKKk5Fkt1tBaQ/DB+/wQb8xf8nsRTt4c6mBwWPg4+15
        YqlBIb6Y5fYqPeMNI7O9Wqao3F6zWlE9TyhIOg1erEOZmqcKOVLo9cTmedLihv0/ZzIxptuSRXEbk
        RYhEgj6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mhZ-0000Nl-Pk; Wed, 12 Feb 2020 07:44:53 +0000
Date:   Tue, 11 Feb 2020 23:44:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] fs: Introduce i_blocks_per_page
Message-ID: <20200212074453.GH7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good modulo some nitpicks below:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> + * Context: Any context.

Does this add any value for a trivial helper like this?

> + * Return: The number of filesystem blocks covered by this page.
> + */
> +static inline
> +unsigned int i_blocks_per_page(struct inode *inode, struct page *page)

static inline unisnged int
i_blocks_per_page(struct inode *inode, struct page *page)
