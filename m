Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B988162B84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBRRHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:07:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBRRHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j2WGs4C1vLnL8fc/aOtqeG9qe3lmQcu+zgjxzRT1RuI=; b=o7sf60WWlvof4jYu7ttN+64LOc
        B+2H+zPtYs9lptGsjPwxiQoOkSAgMncfULRPJ0VtVJxFfgt21bu3pShHZfSg8YI4YEjzviRHj0Yx/
        V6J6E7hwYzztsnUsxyh9x9gfuflCIvFFnGJMLFnaFNKowbbUs2s4LyE6k4xP4XM9IBrVqI0+B09Iw
        U2Kg9seWWADNhL6ODYe/u/N7R6D1GVZgOWXZ2I37zVC3+Utc2z/N13gMs3nUe1VccOjuDTs+HsRUU
        mPD41sLA2JutnlUO/Sc6jaN4E0ci/WxL8mdm4uIHv9xovvhu6o1v5Q/EJ7cZS07cKOSF7E2y726ok
        IKgd5L5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j46LX-00083T-4i; Tue, 18 Feb 2020 17:07:43 +0000
Date:   Tue, 18 Feb 2020 09:07:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v4 1/7] pmem: Add functions for
 reading/writing page to/from pmem
Message-ID: <20200218170743.GA30766@infradead.org>
References: <20200217181653.4706-1-vgoyal@redhat.com>
 <20200217181653.4706-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217181653.4706-2-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:16:47PM -0500, Vivek Goyal wrote:
> This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
> pmem_do_write() will be used by pmem zero_page_range() as well. Hence
> sharing the same code.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
