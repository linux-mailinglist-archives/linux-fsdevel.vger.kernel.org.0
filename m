Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40A02820D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 05:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJCDsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 23:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCDr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:47:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A446C0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 20:47:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOYWa-00Ap1z-6d; Sat, 03 Oct 2020 03:47:56 +0000
Date:   Sat, 3 Oct 2020 04:47:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Clean up kernel_read/kernel_write
Message-ID: <20201003034756.GK3421308@ZenIV.linux.org.uk>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 03, 2020 at 03:55:21AM +0100, Matthew Wilcox (Oracle) wrote:
> Linus asked that NULL pos be allowed to kernel_write() / kernel_read().
> This set of patches (against Al's for-next tree) does that in the first
> two patches, and then converts many of the users of kernel_write() /
> kernel_read() to use a NULL pointer.  I test-compiled as many as I could.

OK, applied, will push if it survives local beating.
