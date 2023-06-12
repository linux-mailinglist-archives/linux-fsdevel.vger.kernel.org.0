Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4972B811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjFLG3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFLG3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:29:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5610F7;
        Sun, 11 Jun 2023 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OnuAK6mreoGm4FNJHs9uI+JEJspPLsCF39WNhOsF+CY=; b=2ZRoLCGKEHf1bi3m7EPZUYSUen
        +YNx5Wd4YSVDCiX9vQ8NHSnqV+eBeXfYtM6/Z+jIyvbGmGp4W0BZAvUBtWXVZBzKxuphLNDVqoTcg
        kt8cEKXnU76JStQjY1Hy6Zto1BNu39MgKIILkjHptOa3McMlejlG1A4p85l88YF3199aoxoPk4wBJ
        n7/MFkUUqQ+yD5hmDV5/J22cEH0OHKx5kHMelzhdhWxnbufWw+/Si0X4JV4pH03eYPH/l2ATf/KGl
        sr4zjPCxUF0uvzc+wY/zbJXqPIl2NDGJPfjt7TuxBUwMjQ4mwAVovlLcEdTPh68LrNVRBhQawKC6l
        cnktLj3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8axR-002kpy-0g;
        Mon, 12 Jun 2023 06:23:17 +0000
Date:   Sun, 11 Jun 2023 23:23:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and
 others
Message-ID: <ZIa51URaIVjjG35D@infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <12b297f38307ed980fe505d03111db3fd887f5f0.1686395560.git.ritesh.list@gmail.com>
 <ZIa5fOD6Kaz2cLUp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIa5fOD6Kaz2cLUp@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 11:21:48PM -0700, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Actually, coming back to this:

-to_iomap_page(struct folio *folio)
+static inline struct iomap_folio_state *iomap_get_ifs

I find the to_* naming much more descriptive for derving the
private data.  get tends to imply grabbing a refcount.
