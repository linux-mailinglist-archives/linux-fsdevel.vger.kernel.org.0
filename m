Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7501D47E04F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbhLWIWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347084AbhLWIWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243FFC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weE2bf4DlZGNBx3j1AGSlkJTAZ2lBm3dfDjBENOM0wk=; b=l9hSCWNtz/OE/TlHkejdr3qmcB
        XutiKA29KZFf53szMIUkfupz/c09Rl6u24Kh9k2Vb3no+O30rzq1c1l5KIAKyk2YFNKMuXkVWOL1q
        drDo/b4pwYg0BffhfNWBvnvj04mbzcQBIeLqqCtLZARd/c2BABqv5hT5cxb+JrRzt53nGhLyr1QG1
        KfPX4lw2xvFSAxLYY6kVsOPl2UKCfW1RnncUd/7oTzXy9k5G8BDH7MEXuN8rbWjpSXNpRxqAXf/cn
        Ri0gQGiD/1ibCxw9WhQK/tS3gFfQURBcB87ZZnk+MZWIYya52FzkyvU5MO9qChNVntm1Dwj487jg9
        gnT8Uh7Q==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMa-00CCnW-28; Thu, 23 Dec 2021 08:22:12 +0000
Date:   Thu, 23 Dec 2021 09:22:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 40/48] filemap: Convert filemap_get_read_batch() to use a
 folio_batch
Message-ID: <YcQxsJESQcfgzjBQ@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-41-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-41-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:48AM +0000, Matthew Wilcox (Oracle) wrote:
> This change ripples all the way through the filemap_read() call chain and
> removes a lot of messing about converting folios to pages and back again.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
