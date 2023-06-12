Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC57A72B80F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjFLG2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjFLG2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:28:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D11995;
        Sun, 11 Jun 2023 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lysXVnW3VNj2fBVe5u6WOM7WQG
        h1ZfWylCFS4rYQ3T36dsol0jMjLgotzcCc5qWgSmAKKKZwm9Bt+MAWmjUidSOSieZlK/j2UHAFSTD
        e4+eIcG6iB/tcRbeBat3rsTuJ2RWZr2/hQzHjhLzHFr9tZiw16SUp7j4/UXH5Qscric8a1iYmYrGF
        DKsIX7FFy+4OJTyDBTsUeQf/WkAP/wpG9u/e0vX5fjAiWqY0sG/e5kVQrMZZp52p16dn5jlA+J/4d
        pgwqyKvBykVciDl4CW/T+MKBwAevTX8zBMxBrLPKLyT4CBL8+jUlAkgbRStRjlYUbVaOYlr3dPYgm
        H0mnAysw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8aw0-002kiL-23;
        Mon, 12 Jun 2023 06:21:48 +0000
Date:   Sun, 11 Jun 2023 23:21:48 -0700
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
Message-ID: <ZIa5fOD6Kaz2cLUp@infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <12b297f38307ed980fe505d03111db3fd887f5f0.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b297f38307ed980fe505d03111db3fd887f5f0.1686395560.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
