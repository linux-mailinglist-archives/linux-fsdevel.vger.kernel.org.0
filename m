Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D64746B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhLNPmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 10:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhLNPmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:42:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847CC061574;
        Tue, 14 Dec 2021 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wjypj8Z4Rg2+/h76mxjfwvjNCwkDu0E5brw7BKK/Hgg=; b=tEcA6K5ehWXLXPQsfXCwOObarL
        o9UpZ+PNLeaJUmIx3vlOncBNz490UxrZQ/NmCOjVKIwb5lN4VhmSGPZAwepg/YiyAY4AnACoFxINY
        t8IdsbIknSUucM0SSZD6aszBSZXaJdL4CfYFmAssolfBUEYR+3X723Yu3Fh7clCmsBmi+H04ObrwW
        pyt1MBkpdXUfw8bIez2ZYlkMN6/S1uQsngkzIAYHWskZbmvM8UYMP3MbJ1/arbc7RmVJrqK75epfW
        9LKWCKpFSx2a5XzjKbbj9paf/ciMmgU0TKzYdT4tObMCSI9uwU4uwIB6eskGmkkaWDzH4U8Bh2z9a
        wLYnR0bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx9wU-00EjQ3-QS; Tue, 14 Dec 2021 15:42:14 +0000
Date:   Tue, 14 Dec 2021 07:42:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v8 5/9] fsdax: Introduce dax_lock_mapping_entry()
Message-ID: <Ybi7VmfigwLpUrgO@infradead.org>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
 <20211202084856.1285285-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202084856.1285285-6-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:48:52PM +0800, Shiyang Ruan wrote:
> The current dax_lock_page() locks dax entry by obtaining mapping and
> index in page.  To support 1-to-N RMAP in NVDIMM, we need a new function
> to lock a specific dax entry corresponding to this file's mapping,index.
> And BTW, output the page corresponding to the specific dax entry for
> caller use.

s/BTW, //g

>  /*
> - * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
> + * dax_lock_page - Lock the DAX entry corresponding to a page
>   * @page: The page whose entry we want to lock
>   *
>   * Context: Process context.

This should probably got into a separate trivial fix.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
