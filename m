Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394AF44590F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhKDR5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhKDR4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:56:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CEC06120B;
        Thu,  4 Nov 2021 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wTE0pUvAy2SS7XIPVFk47lEu8RHkWpmW/KaM1nPJ460=; b=nGx1gBZldH+s/qsgyKfbHwWNXg
        50DXz1YBwxTRvfUi5UmXEXSn8BUfgTNmeRoWmDK8iDaM+WpTWFNoFaSw+DaNvaFxT/Z+ZLVknHAgB
        xLTdxY/HFyieIJMqUAnK87tF4q5wToZ3bcY0V1WFDP4OBh7Y7h0gWg7KV+9aFdRordrJEy2/eFkxw
        IEw2RuJoAfDQkR9Oo1ErkY+3W5qCWhus//8Iwz38nvOKHHA7Btxe2tdmGMnAhuuWcAGXjlOgyU+MW
        vKJZV4viv4Nu8SXXFYvqLi3pqSjlbu7oP+uk9hDhAfDtOpx3Z2O9TAVvExTXpryu8BP2jojaSzONA
        OEthPTHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migvz-009j2r-Mv; Thu, 04 Nov 2021 17:53:55 +0000
Date:   Thu, 4 Nov 2021 10:53:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] dax: introduce dax_clear_poison to dax pwrite
 operation
Message-ID: <YYQeM+1f7JgDY/QP@infradead.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <20210914233132.3680546-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914233132.3680546-3-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:31:30PM -0600, Jane Chu wrote:
> +		if ((map_len == -EIO) && (iov_iter_rw(iter) == WRITE)) {

No need for the inner braces.

> +			if (dax_clear_poison(dax_dev, pgoff, PHYS_PFN(size)) == 0)

Overly long line.

Otherwise looks good, but it might need a rebase to the iomap_iter
changes.

