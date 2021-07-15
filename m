Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7C3C98C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhGOGbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 02:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOGbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:31:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E4C06175F;
        Wed, 14 Jul 2021 23:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TVMJ2meUh3uUYUqamo05eQ3yyG2zQeAnvXeWxbYdcAo=; b=IxvYsMgIWgwvolsj/LDjuMN+aq
        ur6AtHcY+ic5554MZR+9IFeO6bIeYzKVBcJs4b3KHKljyZsMjnwWcim//x0K7Jn5n7537ZG3eTFOK
        0YDp8ydhXzQnoAoSTpM1IboO74Fr59Xizy8yqP2YVx5kmnYtCjjcEcvGK14x9HOwi4KWCeCKGngRy
        ezF2tdNUN49+W4Dg/jvJJpyV/ymGfbQ4EX+6XFVQoyeGD/BlFFtNXRZklGRzFFh/SZYpEhQwbzoUb
        tPFhTtr1T6y2wPiAoKTKF1vVsuC/ZB1fPlN8+5Up4Av8WD58s8e+fKMZ9I0SyegmITNYPSZ/zGRe5
        DDQ8TbLA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3uqM-0033cG-KK; Thu, 15 Jul 2021 06:27:47 +0000
Date:   Thu, 15 Jul 2021 07:27:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] fs: kill sync_inode
Message-ID: <YO/VVsa5Q2ylKuHA@infradead.org>
References: <cover.1626288241.git.josef@toxicpanda.com>
 <8c4c75ad09fb61114ee955829860ce8fd5e170ee.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4c75ad09fb61114ee955829860ce8fd5e170ee.1626288241.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 02:47:25PM -0400, Josef Bacik wrote:
> Now that all users of sync_inode() have been deleted, remove
> sync_inode().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
