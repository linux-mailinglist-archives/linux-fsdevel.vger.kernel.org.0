Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4B355563
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbhDFNkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbhDFNkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:40:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DAFC06174A;
        Tue,  6 Apr 2021 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+7/Yy8FyGH5pK5mRz0l5jSVYfRzX9mnUy8rv/og0Li0=; b=vxnrURPk4ZMdXwdWGpKk5XuPbF
        l3xFtxxPz2vTtazTcxXpf7AYJ3llp958/TUesie5bfi48mmp5RTgwD9YF8SnpubF/ONM3aKM/1ZBX
        qcSK5qr8yTxPzxySQI8lCgz55JDu821gmVEyzENzFhvrOurypJclIu5grnwFOVl4ASaikuotYYWqA
        ZDV+3WBApfl6evy6wR4r9GWnfwPDFUHeUfY5geb4L0ZQn/PynH2UFbyBO8sMxrcSS52q6tGHBo9RN
        kjkK+2nR5Ez036FznOaZhNCiZASDlc+s14u9r5twSgtAjJL6nM4ZCc0jXmegS8LdMPYqbSt+ljNMw
        fyX8iwMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlvD-00CsBg-F2; Tue, 06 Apr 2021 13:39:14 +0000
Date:   Tue, 6 Apr 2021 14:39:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 10/27] mm/filemap: Add folio_index, folio_file_page
 and folio_contains
Message-ID: <20210406133911.GI3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Except for the implementation details using the unions field (I'm not
going to mention these going forward), this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
