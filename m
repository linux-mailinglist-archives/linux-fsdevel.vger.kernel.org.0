Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28932625B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBZMLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 07:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBZMLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:11:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A61C06174A;
        Fri, 26 Feb 2021 04:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GoPhaTBzxDxDjimRwk9eU6RU03Pf2eUvh8y04g2Kknc=; b=Bknwcnr4tLLVBaQXp2lILZrLUk
        UDBrl4PxNZTggDzXjZeOMfsh9YNWwOn7jMizsRsiwWYjKYseEEtcfPJ21vW5EqCdonExNtpGFWTki
        qUeDUmh1LdflaKmHoUIJhzJfcZIxq8/eUMB2kUkbV62LGBGtvjRc0LpmGjGwAN4SgZEAz+6LFwJge
        XxI89rki8RYYlWDaN9TeYA1xjThJSKg0mUqkpMjK5iwmObLW0371KXBrHC386qUouVo7hMizZtiPb
        mkHTT3uxPT7VPePn8sD5/D1GTHJ3dZ4zjLKJQh0VFPEswmOCji6kFhJhejGj/gHOLvOok1sAh+w4c
        YcNbH/Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFbx5-00BxuP-RD; Fri, 26 Feb 2021 12:10:36 +0000
Date:   Fri, 26 Feb 2021 12:10:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Use WARN(1,...)
Message-ID: <20210226121035.GA2723601@casper.infradead.org>
References: <20210226094949.49372-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226094949.49372-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 09:49:49AM +0000, Xu Wang wrote:
> Use WARN(1,...) rather than printk followed by WARN_ON(1).

This description doesn't match the patch.

> -	WARN(1, KERN_ERR "BUG: Dentry %p{i=%lx,n=%pd} "
> +	WARN(1, "BUG: Dentry %p{i=%lx,n=%pd} "

