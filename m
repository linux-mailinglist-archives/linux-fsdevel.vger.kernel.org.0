Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA93A9100
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFPFNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhFPFNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:13:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA9C061574;
        Tue, 15 Jun 2021 22:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CY93Q8HkdUaFWEd0CM+L3x5mizqDiuZJg8BZfH45oYY=; b=Za6f2SM7Vq7AHXHxN4C8gmjYlo
        aOIx4ybFJJskaDdxax79/0MYzY21NgV5WE3JHAFi7x+Um3sjhX6a/FN2IYTbAsZRDz0Pc7mD/cvcg
        im72QL2U72ZNmYStScgb+HO/PW2wnMYrQ6Jtj03yO8dzv9t3az9dpX9HHi+1llCQPdl8nJE3Ybqmi
        ud8rS3uJbLn8xv+gzURzk+7iD7rtQcrIiYyWAFDQMaZy+Q1Bcjz3bgeS98J0ze/wFJuDPtCl9eK1/
        2BMYBE8KHqB1eqs+0fUfSvGj1ZYCCyEGvvxVg0WpfsXe5Hz5ay/Obewm4n8dLHBgfxgJ0KJrcRNvr
        W+u9i8qg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltNon-007cWm-6e; Wed, 16 Jun 2021 05:10:28 +0000
Date:   Wed, 16 Jun 2021 06:10:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chen Li <chenli@uniontech.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ramfs: skip mknod if inode already exists.
Message-ID: <YMmHwTZaahtmjK2z@infradead.org>
References: <874kdyh65j.wl-chenli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kdyh65j.wl-chenli@uniontech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:53:12AM +0800, Chen Li wrote:
> 
> It's possible we try to mknod a dentry, which have
> already bound to an inode, just skip it.

How do you think this could happen?
