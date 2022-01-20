Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158384949D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359353AbiATIrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiATIrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:47:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84095C061574;
        Thu, 20 Jan 2022 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7GM0HQf9tPss24x1/mYICgALcB2ZyBdjeGTVOCICW9E=; b=eL9BOsWNbgECzttqklZYLdsSej
        v6CLpdwxnbZTGfeAsDpcDIJA0F9xwMJcOsdBch5qvVDMdgpYU0V7A3xTI60TXrnsJ2XbOSs54uBCA
        BwW/N13hfhrnbf6BYY/ZKy+5joy0zxM64YW89SeJjiu4Qswv42/RhTGli0tb18hGZ3XnOkKx/MLaQ
        JsuQSgBe/GG+pPRC1KuHXaqIlzc7FaDRxb+zXyDOpOL6SiEQ1pxR4jd2TNk6aFhnqcGpdXOcZ9aIz
        t/+qNmK1OkOpMrIzKa5RSba26vzKY0JzRWV4U5M0AzpgeL1BuDyH0zttuu2oF5DDe/FIZ/oIScpWX
        iM9DU0qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAT62-009tcm-2s; Thu, 20 Jan 2022 08:47:06 +0000
Date:   Thu, 20 Jan 2022 00:47:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 05/10] fsdax: fix function description
Message-ID: <YekhisDyJUmF/cQI@infradead.org>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-6-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:34:34PM +0800, Shiyang Ruan wrote:
> The function name has been changed, so the description should be updated
> too.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Dan, can you send this to Linux for 5.17 so that we can get it out of
the way?
