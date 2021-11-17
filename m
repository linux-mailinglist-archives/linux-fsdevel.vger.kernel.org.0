Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7734546FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhKQNQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 08:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhKQNQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:16:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A37C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ylpZ9Lw61g+uleOVyqJA3dFrLpOTun3ZRS+3g5WDVlg=; b=fZpkKkDdg0nRn54bcJyExBelwZ
        H0dVQnO1SYdwuM6IZ5UBd9GifihUtr3tKdbkq7dDM3FSNC8N8/2H21RQKrO1wUyOfWZCYFyxKMr/w
        1SCrjLShiNp4SW0HXwWd34J4g6tO2i2na5brYskBcW/a9EOnBM/R8Wialec9cg13DHPT/E+d0wqa/
        AJJLWHdFHVgGarCFGwzNN0Tcbk4jaoBvnRorAGlMIcunsl+SwJHYqOYbIShV4pzHgfoGCey9EsEIR
        +TPngsCA1QUlBCN4rGG/aZmTquCfLwezj7KGa0fa/IjwH4Auvzl2AoeL43shy7frh9Dk6FwfT8a4V
        lnDF1DuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnKkM-007cdN-E2; Wed, 17 Nov 2021 13:13:06 +0000
Date:   Wed, 17 Nov 2021 13:13:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     rohitsd1409 <rohitsd1409@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] inode_dio_begin comment fixed.
Message-ID: <YZT/4nVVjylycZBs@casper.infradead.org>
References: <20211117111326.GA4306@overlay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117111326.GA4306@overlay>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 04:43:26PM +0530, rohitsd1409 wrote:
> +++ b/include/linux/fs.h
> @@ -3282,8 +3282,7 @@ void inode_dio_wait(struct inode *inode);
>   * inode_dio_begin - signal start of a direct I/O requests
>   * @inode: inode the direct I/O happens on
>   *
> - * This is called once we've finished processing a direct I/O request,
> - * and is used to wake up callers waiting for direct I/O to be quiesced.
> + * This is called once we've started processing a direct I/O request.
>   */

 * This is called before we start processing a direct I/O request so
 * that inode_dio_wait() will wait for this to finish.
