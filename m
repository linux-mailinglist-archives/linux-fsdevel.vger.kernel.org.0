Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F83B1720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFWJr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:47:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C81C061574;
        Wed, 23 Jun 2021 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GP93UPkC0hitfxxYgCn7L4t08K/y+OYO9CnmPnYe08Y=; b=MhsBbYroqBJd2MoDpQGLPRoKEZ
        vJiwFt2VPW7m0BMFpjrgKDSmDUCN8kJMPVEHK6nOR1GmDiOimvhFdVVUH49FaJK6dXlH986l6egSp
        0/2A2czQ4bTCZlMON1ohIUKz4REPRL2L+FvddLerAyDWPtYwTz4fYWB12ZoRWd7GwLDrJiQYv+JOt
        jbBHQ6PlIyi1UCdMSUwPzE4DPLuQB5se590lRcEh89R9aNRxml6iK0s2VSi1J4eu2130ubjEziOFw
        Zsvj8lEr8TC+Em7GJ3a9dh5kjbIro5RGTrcqnhodRiX8fm6e3hWCGH2n+60dHDkyljws0hWTp54nu
        ZBEBxm3g==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzQh-00FHHv-7U; Wed, 23 Jun 2021 09:44:33 +0000
Date:   Wed, 23 Jun 2021 11:44:18 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 32/46] mm/writeback: Add folio_account_redirty()
Message-ID: <YNMCcjbdTe2Ff5vM@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-33-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:37PM +0100, Matthew Wilcox (Oracle) wrote:
> Account the number of pages in the folio that we're redirtying.
> Turn account_page_dirty() into a wrapper around it.  Also turn
> the comment on folio_account_redirty() into kernel-doc and
> edit it slightly so it makes sense to its potential callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
