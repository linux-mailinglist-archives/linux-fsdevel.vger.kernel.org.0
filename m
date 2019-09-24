Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2057FBC7CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 14:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504908AbfIXMXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 08:23:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504875AbfIXMXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MaF/Zn7nRAaxZ3nnq0Sx6bZl4ydSwH98geY5XMZU4qg=; b=XYkDssxA+HB3Cpi4POOGunZ99
        TBTejN7B/LicvZAPyiN6pyrnRMWcqRyfWiTYtW9zHseqpRBh8+crA+CgA0BneSGXucMSX8jLzz4MK
        crOIZY7mFAr67ydqMsPYcxBjHN9YvUZ2WPlN0Mw3CN9Ku+1rTWzeEfh3sm0kEa+jxXsorajRS/eAn
        4/R7W72KlfZpchgQA0mSfNyeopw7ZCDUKvwB+qTQxA38COF/Aw6tfMpEfIkjUkLfHg16POuh83HK3
        ucW7EQGITorcGyCilD/PRRID0gWBDktjwzDj8ZZfDJraCfW5cVxgE+LOZ+fHoujSnoAFsovXh2dmn
        mk7g4ktKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCjqY-0003uT-Pt; Tue, 24 Sep 2019 12:23:10 +0000
Date:   Tue, 24 Sep 2019 05:23:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: direct-io: Fixed a Documentation build warn
Message-ID: <20190924122310.GF1855@bombadil.infradead.org>
References: <20190924121920.GA4593@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924121920.GA4593@madhuparna-HP-Notebook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:49:25PM +0530, Madhuparna Bhowmik wrote:
> Adds the description about
> offset within the code.

Why?

> @@ -255,6 +254,7 @@ void dio_warn_stale_pagecache(struct file *filp)
>   */
>  static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
>  {
> +	/* offset: the byte offset in the file of the completed operation */
>  	loff_t offset = dio->iocb->ki_pos;
>  	ssize_t transferred = 0;
>  	int err;

This is not normal practice within the Linux kernel.  I suggest reading
section 8 of Documentation/process/coding-style.rst 

