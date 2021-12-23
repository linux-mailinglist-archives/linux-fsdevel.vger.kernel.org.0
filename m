Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631C547DF59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbhLWHJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbhLWHJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:09:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE9C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tC0POHrxhndGICe+OkXc7XTx0ONivY/HkF9udkgGZ0A=; b=P9aqfuB2l8yip38T1QtG6WAD31
        /QYeN030fDjixWxXuQjtEYPUPTWkZfrvPHbBIX9ZHRbKWZENNcK9g+Dl/kZVMszHr7BSKb5px4inI
        xWLiSUIK0SeGEJ4d/Irt2dZSEk54gzSsrUeI2DBrdp4FVNeNtEaXDksYpfFT8/sZ3bkprpPOrUTTD
        X3Chiu8OI5+n8XA0ykXT6N52wWAo1g6FA62lDk0qYfvz6KAhPjtxbuP41OtqimOmgkRFeVpTe/PAW
        plCoDgFKQLSbhJ52ick5qolsF8oNBWDFzsTmOcO8XORrSnQVR7JChfXRaQBo/wqjtSPbUoPPBIjMv
        wWXaZoZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IE3-00BxUJ-6V; Thu, 23 Dec 2021 07:09:19 +0000
Date:   Wed, 22 Dec 2021 23:09:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/48] filemap: Remove thp_contains()
Message-ID: <YcQgnwkJVboJWLm8@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:23AM +0000, Matthew Wilcox (Oracle) wrote:
> This function is now unused, so delete it.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
