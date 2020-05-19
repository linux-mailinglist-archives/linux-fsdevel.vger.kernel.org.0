Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232FA1D9B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgESPgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgESPgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 11:36:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61133C08C5C0;
        Tue, 19 May 2020 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hlXeYEx61e2dpv4e5nUYpsc8cj1KDFe3uADuD6pRwsk=; b=alhwMGYnLcWkesAdX0d+S9orsd
        1KKvGGLQoDUeQZvvKFjyvGImEd2ZFCTYLnrygsRqjRoP4rj8Ei2ZH6OTOP36Jt21IgY+yHycdswLb
        7itYT9KNiAhN4/QJp8h/5Me1OTX1pDtlbCH2dSt11Q3/hzxfIZwxv0YgECZmEuXSUuRLXpIvTC5Oj
        aUFFLn5JCzFiTRewt3qvFuAEwQPSTU/5cKwtQEfYNwiqUcB/kt0ZBhUr0WyXfj6upJlALVRDlqRxm
        u1MBoSx0aOydQZ1QLtmDkcJA1/o+eqjKAyueQJ4+gPYFEFD/gnzIZD0f3lEN5d5PRVJ/ijYMM4gvZ
        krNjA0dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb4I5-0000Yg-DM; Tue, 19 May 2020 15:36:25 +0000
Date:   Tue, 19 May 2020 08:36:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200519153625.GB21875@infradead.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516031956.2605-8-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 03:19:56AM +0000, Luis Chamberlain wrote:
> Be pedantic on removal as well and hold the mutex.
> This should prevent uses of addition while we exit.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
