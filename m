Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7044A96E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbhKIIoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbhKIIoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:44:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A494C061764;
        Tue,  9 Nov 2021 00:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vEF/qGAy2myUspKQRcnTogkbwaDGtmggvQ2Clke6pHI=; b=JMN/y3XtBAhFexjSK/DHf9e+ry
        d7TR+xHRGNBmMFgm/WIaTQ1myfiQyNyjSD2xIH+DAM0iSg7184shj6qitXfNFPQ/8DT+UQaGkJAmt
        lbtwrU6jZvIapUM7rcVCnQfLpsvmsxb+Cty6/KXEmSlD9cBBqiT/azo9Pd5RVlDCzoG9WxYSowIxZ
        JtBAV5/urgQhQ+7e+7e92d8kvS5O9qLJkUuCvC/18apgqwOQA/BO8er0yC42szgCB4D9mPJ8G2rsQ
        KAb2cTsXjtLhCVdghYuM+yO0QzYqVEw0QNreUPrHxmi+osShME8u2dnxvoqw4duSawpBR314qL+vF
        waJkadWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMgy-0013jc-06; Tue, 09 Nov 2021 08:41:20 +0000
Date:   Tue, 9 Nov 2021 00:41:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 04/28] fs: Rename AS_THP_SUPPORT and
 mapping_thp_support
Message-ID: <YYo0L60o7ThqGzlX@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:27AM +0000, Matthew Wilcox (Oracle) wrote:
> These are now indicators of multi-page folio support, not THP support.

Given that we don't use the large foltio term anywhere else this really
needs to grow a comment explaining what the flag means.
