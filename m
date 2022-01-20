Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54CA4949EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359383AbiATIr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359413AbiATIrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:47:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279FFC061756;
        Thu, 20 Jan 2022 00:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fNusMrWQ+iaAxCx5W24yZJ93BWZfAuFDm6S8/KGzbK0=; b=D39kfHS+T/0kWsqL02joFtiv09
        ubeTypbD4543NiZpFkfezmtBZWQPlrZpYwm/nLxZD9YK8pWH41dX2UJdscRc7NmMJvro+lxKIaBId
        K7jnSerZ73JAr+mJgGNAbVwjVHOW9sFo2xVDGlluJ5YFRPbCzMgZWrwNKA1PwHpa3SU0W6DbeyEZM
        8Jhb0XYD0mJ+HB19llClYpTW+tEqw/tkvKNOsFZfQsn8N3aCVrg/s/BVVvN1k/LtRGQa2vqe92Uv8
        WYO1RKbzkm+czYu/+x0/YVypor1v53PG6zh7AENpjveWc5STtRuijyEz/bq9rbZuNmyIZsgE89SL4
        P4DvTPTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAT6S-009tud-Lg; Thu, 20 Jan 2022 08:47:32 +0000
Date:   Thu, 20 Jan 2022 00:47:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 07/10] mm: move pgoff_address() to vma_pgoff_address()
Message-ID: <YekhpF0VS+OA4Yud@infradead.org>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-8-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:34:36PM +0800, Shiyang Ruan wrote:
> Since it is not a DAX-specific function, move it into mm and rename it
> to be a generic helper.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
