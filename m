Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52824E5C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 08:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHVGBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 02:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVGBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:01:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE02C061573;
        Fri, 21 Aug 2020 23:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4sW5NkGTIdZnLEpGZfOYW+uwnHM3SBAF6ctXgNKOsBM=; b=FMgzhJe6qwurPFWFxaW9fv8Ayg
        pBipEcF9XSC9CCiDdI6btVjfI+CHQWE9Y8W7rqB5crMEiPOqAp5Yoa95AdDa721tzZJ2exGAJkz2W
        k8IRmFv//HP2CdqAYPWXbKigGKszBhiV+I1jIrhmULi8r3qLUtc169ixmjGjnd99WqwqydBOrgU0Q
        UDVscmzUMfGr5ukS4z8eUupEV6XjSIzJkZ/E58R4S7jy8Zte9YCTs8lYVPlmkbcHFvjHbB1FSEqHS
        EsMcEPdJajhPSmy9sXk3Ya9nl04dyLBzH0PGkFfuJCMAmZHUt85mN1C5d+RAeRFow7dVKV7wOMMAZ
        F0UHpqlQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9MaW-0004kO-AZ; Sat, 22 Aug 2020 06:01:12 +0000
Date:   Sat, 22 Aug 2020 07:01:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 3/3] iomap: Support arbitrarily many blocks per page
Message-ID: <20200822060112.GC17129@infradead.org>
References: <20200821124424.GQ17456@casper.infradead.org>
 <20200821124606.10165-1-willy@infradead.org>
 <20200821124606.10165-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821124606.10165-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 01:46:06PM +0100, Matthew Wilcox (Oracle) wrote:
> Size the uptodate array dynamically and add a few debugging assertions.

Needs a rebase to not require i_blocks_per_page, and a somewhat more
details changelog that requires why we change this.  Otherwise this
looks good and should probably go in before the per-block uptodate
tracking.
