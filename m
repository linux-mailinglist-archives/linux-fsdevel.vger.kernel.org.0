Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988E13B1905
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFWLfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWLfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:35:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C0C061574;
        Wed, 23 Jun 2021 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L0C38eSgFWGzhANcVbIDOYcAtDlPN8BpX4oY7srFPgs=; b=hxrKor8gJ4ne0kKz37Zge9aYGj
        wvlNxv8GznVqnfWkhKbYUXvRZBb56eEf78aCEUIMAuCF1ts6FQimLaQ1tcLj0ik0tFlCRpMc/+5zR
        8DmPahMQTvDktrwxic7km2ZXeaE5lsO8rEPugXDtbznrSjbF38o4idJSdbWEYAhNLohKQ9/458G94
        8uuKf7ifZYob0jWPlT0I90pImxfsORuAYoYi648yzfff3XsYHpe5RMrosOlYwEiGT6Lay6QnpbHCB
        kmB1xkxSL2/A+gJ003eAl9bsuDZFjVvTF2JStpSN4AxKdkJBB+aYDGMaUQXT6NDANF4sY94YA1M/y
        tw0HehZw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw17Y-00FMrc-IR; Wed, 23 Jun 2021 11:32:53 +0000
Date:   Wed, 23 Jun 2021 13:32:39 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 44/46] mm/filemap: Convert mapping_get_entry to return
 a folio
Message-ID: <YNMb1+0PrD73yCXE@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-45-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-45-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:49PM +0100, Matthew Wilcox (Oracle) wrote:
> - * Return: The head page or shadow entry, %NULL if nothing is found.
> + * Return: The folio, swap or shadow entry, %NULL if nothing is found.

This (old and new) reads a little weird, given that it returns a
struct folio, even if that happens to be a magic entry.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
