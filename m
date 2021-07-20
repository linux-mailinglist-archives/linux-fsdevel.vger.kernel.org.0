Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D073CF53D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhGTGmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhGTGmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:42:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1558C061762;
        Tue, 20 Jul 2021 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WWnoTr+kmBZSzb1NAcQtBt0fCIQCkrqs75DYEVV33yk=; b=eQSQWrVKPYww59Lll5aKdROvip
        XjruLgRsS7Dx8Ee+jelpq6wnZNu6/jdoJH+r/QdL5gDIk2Un6knR9TZ7h4PAHYiyjyNcsWDe52ldN
        VS3KAfpNX3n4tYk4WtKFxtLyRSsO2+MdrEkrDhwfxOymXZvPpMvPS7qDrAGSHhT7z41d2llRIBtxd
        hWVhLV6K95pn8v+I0gROHObXoHWQ+BexqnRLZ35UejT+zl7jWxKJNCb3OlAUxyCFyCNf12t+z0+4P
        HxnPl0XjB85b/nr4TttReGE6m0IBzENRmaL66fUHxpy9OMzgr5TrC3o7RHCBeZWVV10ctFqCfFUfM
        RyHdPygw==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5k4X-007rmC-44; Tue, 20 Jul 2021 07:21:55 +0000
Date:   Tue, 20 Jul 2021 09:21:44 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 17/17] iomap: Convert iomap_migrate_page to use folios
Message-ID: <YPZ5iPDZReMoMm8F@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:40:01PM +0100, Matthew Wilcox (Oracle) wrote:
> The arguments are still pages for now, but we can use folios internally
> and cut out a lot of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
