Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B972E0AB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgLVNbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 08:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgLVNbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:31:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89821C0613D6;
        Tue, 22 Dec 2020 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=42fzafLRxdLNbzacrFdM4qrpWHImldmnOrdNk/6ZVck=; b=iePoeRjEV0kcCjWEwPHuCUm1iq
        DsnCh6wlOMy9pj7bxofpZcd6sMzCSd2I/GgHLbXe4+d47bGf8PoYmhaWHX4JAljs7Pmp11Q61zZry
        uNBn6b2e9O7Ol30xD2+f25f/OKKo2EejBCMSi4aXnQWCWGJcyN7m5KeZkWhfJKK8x6qocjLrF9eK1
        HuGXF8R0AhSu2kId/AcyD/guIzYRawRmiUACVaunqnykwQLtLbuUJiBWDZwM1zc3OyBhtUOWuhfLW
        utOSM4ESay1lTFxwSK16xqDEiDyUT1DDFnMXTzCKwbMnLypMRHujdLLBoRjOiVAFdvst9fpmxG+0d
        rCC+BbMA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krhkb-0001K5-MZ; Tue, 22 Dec 2020 13:30:53 +0000
Date:   Tue, 22 Dec 2020 13:30:53 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] block: move definition of blk_qc_t to types.h
Message-ID: <20201222133053.GA2935@infradead.org>
References: <20201222031154.62150-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222031154.62150-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -typedef unsigned int blk_qc_t;
>  #define BLK_QC_T_NONE		-1U
>  #define BLK_QC_T_SHIFT		16
>  #define BLK_QC_T_INTERNAL	(1U << 31)

I think we need a comment here explaining these are the values for
blk_qc_t at least.
