Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5747DF41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbhLWHAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbhLWHAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:00:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19EC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cI2eNvkPdNCsZZUycWNgBhNphIpO0K2pcfM73hmVJAA=; b=sE7cxoouchhe9E7yZ9ppcbkA7m
        Har6oGYJLCkb0K2GW14alvFUP7u7uUuvvk2GTPTksUj6d2p1q/erdj9NQQ27zM+rRdnnG27wBhfPv
        vtLImBICsux1QNC+lNgYdka233uudk9mVVYNhaRzqcdb8afRsIiT6VV0iIjeZ7fpH4ngZSCS8UmJU
        yn46nMAGyznYKGWcCGJ5oypDjVv+SV96rdv7yN0KmbhaQkFEp6hOaJ6pRUyRXO/Xuib32XKYnBNc2
        IR4AxSuMJBabdbaJnH38ICGGQr51yQt6JZNWEwbgZRw9FulRoZaqjfEaBY0fypP9kKqb/c68wQYt9
        znVNrrhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I5g-00Bx5z-8Z; Thu, 23 Dec 2021 07:00:40 +0000
Date:   Wed, 22 Dec 2021 23:00:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/48] filemap: Add folio_put_wait_locked()
Message-ID: <YcQemGi3byMpaIo3@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -int put_and_wait_on_page_locked(struct page *page, int state);
> +int folio_put_wait_locked(struct folio *folio, int state);

This could actually move to mm/internal.h.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
