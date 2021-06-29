Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71A03B72F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhF2NLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhF2NLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485C7C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+l1C73jR7x+wDr88mhrVJCLsQff2oAHfgh27HOG8hWA=; b=rUhvIHlDe9jFoong0Xr9s8ok0H
        jJrUV/1Yb6diR1kDT4ElTEZgu/mKBiLwT8yyVaA0zIqYTvUHi17YOIo++kC7xtp+kueObq8TKireB
        NNAQrMXtXAeUZCfbSCK/SOVeF7pjgGVEdxdj+qPC/J9+NEJSaQFKi9knvdo4u8EywP0f70p9uNzuj
        KTMLm0Ef1JfWDCsC0qMzjHp68VTrdCAc66jkhDD0qpte+Iyli8CmBwYwzIiU16EY98LgOLIqvMdCQ
        GnAPCnJwYHWU+ueul2bee55wmBSKNxyR5xLzUQRPq/DlEiQqvx0bOvqbEPk0Twrq9vRN1aGL5iUKk
        tuQRomTw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyDTB-0048Jo-9N; Tue, 29 Jun 2021 13:08:19 +0000
Date:   Tue, 29 Jun 2021 14:08:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     hch@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: Break build if io_inline_bio is not last in
 iomap_ioend
Message-ID: <YNsbNctGHDW1DA3A@infradead.org>
References: <20210629072051.2875413-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629072051.2875413-1-nborisov@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:20:51AM +0300, Nikolay Borisov wrote:
> Comments are good but unfortunately they can't effectively enforce
> certain invariants, to that effect let's break the build in case
> io_inline_bio is, for whatever reason, not the last member of
> iomap_ioend.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
