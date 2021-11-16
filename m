Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CEB452A19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 06:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbhKPF7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 00:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbhKPF6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:58:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BC2C048F2E;
        Mon, 15 Nov 2021 21:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jFwMkhAr45Koa2OCwczyqw/z6CbwDbfK4wgcBODiv6I=; b=aKX8PwvsFOJW6GP0jcRaN66vOF
        Csg3E+pZhNxx7ljXSrmY99g2gV05mArmWxCM1GC3O6AF4tDBQCFw+UGHc8pDtkpqhVggRGeHoQjsl
        3d2ntb7AETAXk0khGqXeymDfilXxI4RGg6TbRdfUJ+cLe32FnhXZ8Xr/7QcRhPEDz2kAhFmgZn2Q3
        x+KVsO1rT+wbr6XtzsTlTVf3guGnjYLi+/zokSokNUNoPWYbs8aVp0zla1qRfV6fOmxPaclWyeH3x
        fg+OfGHqqnol2B755jDbPWzDPh7lI8pIBQX1AqWza1fYQ8aFUg/YKOmzbpepSj7Ys+s0hBvEyyyOQ
        gAAX1A2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmqvE-000IAC-7t; Tue, 16 Nov 2021 05:22:20 +0000
Date:   Mon, 15 Nov 2021 21:22:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     hch@infradead.org, kechengsong@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, wangfangpeng1@huawei.com
Subject: Re: [PATCH] fs: Fix truncate never updates m/ctime
Message-ID: <YZNADLcSbgKp5Znh@infradead.org>
References: <YZKfr5ZIvNBmKDQI@infradead.org>
 <1637035090-52547-1-git-send-email-zhongjubin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637035090-52547-1-git-send-email-zhongjubin@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:58:10AM +0800, Jubin Zhong wrote:
> I work on embedded devices so concern about jffs2/yaffs2/ubifs the most. 
> If there are any errors in my test program please let me know.

It seems like you need to fix jffs2 to implement the proper semantics
in its ->setattr.
