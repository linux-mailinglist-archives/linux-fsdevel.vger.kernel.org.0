Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98B47DFA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbhLWHjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLWHjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:39:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091DC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6HYxK8PlftP87ahi0NFaICEuS1ofxT8DuXhIt97aRPQ=; b=JB8I9gVbJG39RuuGk21k+tZkU1
        NAcr91yllNpMqVCxJ++vFatNmk5+ec5i6ddfUfcTpIi+R+6gJqzeJQsxqcfjBLisDvl2FF9bhJ19x
        f+GVlEV79oPvXKCjS8kulN4EM6ugQ8Vp4SBNnpXNmnt9hoggQqxz5pSkUiz+rSCNtJlOlajO8bhK2
        vY/PRTbTAr0FHt9Wwbl3fwUeFoQFOaDtRR+u1l85mzVoSzg9ZnOTG/khCHq+dVd1TPJ+yaSbzJrVS
        wgv13Etkjm4fFWkFwDO68LP10x51nXFJa1PiHx42cZTHvn3exDbYikM/dyf7pImR7bAGfOBt6LpU3
        wUb8r71w==;
Received: from 089144214178.atnat0023.highway.a1.net ([89.144.214.178] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IhF-00Byxh-MT; Thu, 23 Dec 2021 07:39:31 +0000
Date:   Thu, 23 Dec 2021 08:39:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 34/48] shmem: Convert part of shmem_undo_range() to use a
 folio
Message-ID: <YcQnqfz/OqUpTPI3@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-35-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-35-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:42AM +0000, Matthew Wilcox (Oracle) wrote:
> find_lock_entries() never returns tail pages.  We cannot use page_folio()
> here as the pagevec may also contain swap entries, so simply cast.

Ugg.  At least this seems to be temporary, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
