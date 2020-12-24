Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770672E2897
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgLXSfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 13:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLXSfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 13:35:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C8C061573;
        Thu, 24 Dec 2020 10:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6bjQ6DB7Sij29teUT41eZ+TIB55tlCK4EW2eiJN+C5U=; b=Ymeef74JQydcz/TIxx1C9t9sSP
        oEghNPqF1Wvgas1sTmr5egkg9JUNglWkW5b0M5BxO9RXOpqWRHFxZ5rIKPJDpwh/fVU6Gf6BJ8jx+
        x8sJgUsqOTa6pViHzlD8CnVd6qS9Nj1pBH7fre7kIAQ2Tdql0mAh6qT60JyBjGZ0AfNd/txCaJB78
        PSPLmxrwMWxjlVMdgOWChz2wOEi7n1LuTZiBUZuWc/7HNKY7/RRjvNMxtsmajdM3qd4HX2ngcAY+n
        e5KAcGB5nasuSFvTtIfCxFUc6lSjDM7YhaTnkZyp24lxNZdQ1bbABBT7NlgB3K9/nfJgFpVCO7ID6
        zlHgezkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksVS2-0007xj-7B; Thu, 24 Dec 2020 18:35:02 +0000
Date:   Thu, 24 Dec 2020 18:35:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: delete repeated words in comments
Message-ID: <20201224183502.GU874@casper.infradead.org>
References: <20201224052810.25315-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224052810.25315-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 09:28:10PM -0800, Randy Dunlap wrote:
> Delete duplicate words in fs/*.c.
> The doubled words that are being dropped are:
>   that, be, the, in, and, for
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
