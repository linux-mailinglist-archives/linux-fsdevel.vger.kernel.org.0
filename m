Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99310350FC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhDAHGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhDAHGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A2DC0613E6;
        Thu,  1 Apr 2021 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=88lYvDpnwPfKj3QVw708sk877g/3cogDT4ZN4+SDo6U=; b=Y0AEWLS1Ti/qnF59mInxsA2tYL
        x1RS1lRNZ07pQFwqNSp+efQQQyb8GFL/kJy6qvsGK/qAQfWCxfz1I4dsYWLMqJFdjcKJfawPXg4ey
        1FA/T4516LzuGnOceiuMKI6mH9uGKcwZmiW4qTqUEhV9IQGo2acQ5jhHmJgiqUdTb49RKwuq3dbAp
        LJsvJ06vv3GLx1gZDgj/JGflwEYft7zWmW+A4zqFv9fSpZ6hcDGiJrE79iC1E8QBXcbYtGbwiXHcG
        JvdpJT1slbYtyiEG1HturyLiazPX87N235lVb5H3cqFtUqFgIRAnrFxN9mXHRtBRCmQQZGhoeQbEi
        KNgLvDKw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRrOb-005kyu-Je; Thu, 01 Apr 2021 07:05:41 +0000
Date:   Thu, 1 Apr 2021 08:05:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210401070537.GB1363493@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
>  - Mirror members of struct page (for pagecache / anon) into struct folio,
>    so (eg) you can use folio->mapping instead of folio->page.mapping

Eww, why?
