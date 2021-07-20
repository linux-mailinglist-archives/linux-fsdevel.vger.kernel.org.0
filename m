Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F223CF52A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhGTGfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhGTGfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:35:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D9C061574;
        Tue, 20 Jul 2021 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JEfZeM7jWTdqkGOwm75oTN+mIvv+BDd9ZtRWA7fAfw=; b=GIWCL83ng7O/GpBekG+qOKxApC
        vrvxhb1gtP+le2Fp3fvzjFkQ4LKBWxoE4z7Q6MYytcj4ZqX2yXZ/RmsdAdcClRMydXdCxI8w5emPo
        cXGE7n7mVun1z6uT2t5f6CZ6CBVUlyR+uoi/3FQeHsU+Zh5E9aCro8tYwaSr37kGpw0zBFW8yrqRa
        ryNyvgso4SguKjwI+PkiDwkHMUzqyDJy+MR1GqkKFSs1WIDntETE1cX2tsUi9S4Mr+0wqlIRoe7Q8
        d9OQD7wbkR52IREfFZ7CwbPHRFeuNOFiUS8hsIinMs1wsdJdbz12QukztLR1vw2ilPk7amduUQjP/
        0sXobfpw==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jyY-007rRp-6y; Tue, 20 Jul 2021 07:15:47 +0000
Date:   Tue, 20 Jul 2021 09:15:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 13/17] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YPZ4FTK88GrVGtZN@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:57PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions still only work in PAGE_SIZE chunks, but there are
> fewer conversions from head to tail pages as a result of this patch.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
