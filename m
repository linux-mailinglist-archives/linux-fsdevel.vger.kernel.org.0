Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10B33B6E6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhF2G4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 02:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhF2G4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:56:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A734C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+sBH/ZKUpW8hJacCTbYS4rvX/vZutabs8Och9zyINCs=; b=D4Eg1GqOX3i1xgytHe4DrT/L36
        dpfVztxWhja2eV+JGuAvzj1Uif8mOHfdd6azu0B6goojdmcgOcTMvQJtDqzOy3nYbsqCizlJbQa4p
        1WjTyxFI0Z9XGTbC9TLx5ZuRkOpttKssunjaw4KMvhMSSYe9U7ye3cDCcLjTkD4LXJ9s6TWh7pR2Z
        ZtyKEyaERRTb8fQQ+vPNzLCgO5DlnyO+GfEFZUPFN0f3jW7kdFsVCMSCAvslHqLm3Zb+5oFHu33Vb
        59jd9eSK18mXZws5wVhQNQhuGtxoXZMRJvdB89AGu3uJqXPxuZf/+SP98ENg0I+uNF2OprGYMdvHU
        xJmVSi6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ly7bY-003q4s-RV; Tue, 29 Jun 2021 06:52:33 +0000
Date:   Tue, 29 Jun 2021 07:52:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     hch@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Break build if io_inline_bio is not last in
 iomap_ioend
Message-ID: <YNrDJNMDEEsyRqM/@infradead.org>
References: <20210629064149.2872202-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629064149.2872202-1-nborisov@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:41:49AM +0300, Nikolay Borisov wrote:
> +	BUILD_BUG_ON(offsetof(struct iomap_ioend, io_inline_bio) + sizeof(struct bio)
> +		     != sizeof(struct iomap_ioend));

Please fix the overly long line and the incorrect operator placement.
