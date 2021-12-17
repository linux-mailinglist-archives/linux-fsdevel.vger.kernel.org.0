Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43844792D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 18:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhLQRaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 12:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhLQRaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:30:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B94C061574;
        Fri, 17 Dec 2021 09:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KRu2HyiXNFc5f6NY7Du/EqXFqBi1PV+Q/H4L0UyoFMw=; b=dJKfbe2mNgm1auXnIFhwQbLkfr
        r7raIByXdMChXYuIHwd6f9qY9Wh0Gv8XvWynXl35CJwsdSLJjNV5guFjcWj2DmDLU7Az6SJTdpatA
        /+TxpMRQ4roORe84tqM+gjj/TEqh95ynDHtpMg48Q6wpkLOM/y4j74mrp1Ydg5uMtaXdM49eF3TZ6
        bLl8tPaGWGzNZX+7hBcF8lBNKCmRwAY+EXRJ0Zrme/KtP5VIWRL/s5U5lqno/HFVOuCj1RvpcicUJ
        v/rjDsXQh04t6GQCl1ozYSAirVI7W9qW+tuAlfJLgT4k/1HMSm9fzVChMeNbg+yUTrkXBp5zgAXaA
        Eq+jRbqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myH3P-00GvBx-4u; Fri, 17 Dec 2021 17:29:59 +0000
Date:   Fri, 17 Dec 2021 17:29:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ceph: Uninline the data on a file opened for
 writing
Message-ID: <YbzJFytPgSbuh1bx@casper.infradead.org>
References: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
 <Yby4sKDALDXHAbdT@casper.infradead.org>
 <e2fcdecb9288dc112d0051e917da5bb48bf72388.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fcdecb9288dc112d0051e917da5bb48bf72388.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:18:04PM -0500, Jeff Layton wrote:
> This feature is being deprecated in ceph altogether, so more
> aggressively uninlining of files is fine. The kernel cephfs client never
> supported writes to it anyway so this feature was really only used by a
> few brave souls.
> 
> We're hoping to have it formally removed by the time the Ceph Quincy
> release ships (~April-May timeframe). Unfortunately, we need to keep
> support for it around for a bit longer since some still-supported ceph
> releases don't have this deprecated.

OK, I shan't bother pointing out the awful bugs and races in the current
uninlining code then ...
