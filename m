Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24AB289B9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbgJIWHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 18:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389952AbgJIWHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:07:11 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A4D22282;
        Fri,  9 Oct 2020 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602281230;
        bh=Un/RxkERVA9WPUuhU+dMOyVzuPXQ9SlpACyjyieCdEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSNtgww2ymiQq7HwSox/kl729euzUmg7DyslWyZrrprSPDKGdINFSMVPMth9huQbu
         TN71buJZTFHi0GUYsv4ZVbsp0vz7VNNSYbztrluGZZ8cv8l8lIw5LtDZD3p8eseo+1
         vb1pT/nPegmnDw6j+Csh0r2dqYlg6qqtDVBnCA/k=
Date:   Fri, 9 Oct 2020 15:07:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Clean up kernel_read/kernel_write
Message-ID: <20201009220709.GB1122@sol.localdomain>
References: <20201003025534.21045-1-willy@infradead.org>
 <20201003034756.GK3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003034756.GK3421308@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 03, 2020 at 04:47:56AM +0100, Al Viro wrote:
> On Sat, Oct 03, 2020 at 03:55:21AM +0100, Matthew Wilcox (Oracle) wrote:
> > Linus asked that NULL pos be allowed to kernel_write() / kernel_read().
> > This set of patches (against Al's for-next tree) does that in the first
> > two patches, and then converts many of the users of kernel_write() /
> > kernel_read() to use a NULL pointer.  I test-compiled as many as I could.
> 
> OK, applied, will push if it survives local beating.

Applied to where?

- Eric
