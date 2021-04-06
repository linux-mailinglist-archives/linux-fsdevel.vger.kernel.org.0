Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26EF3555C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbhDFNyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbhDFNyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:54:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2411C06174A;
        Tue,  6 Apr 2021 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=OdOYGP1HF5HqPyolt1H7wEKXtP
        R2MgeHt2QqAUlLWDOw+ZN10SYIJE85hzGwiZYrQ7zSNsKAwxaBBo2hQpJKPvKGf24HoTkIIBk3lsw
        S5MJTjLC0gXqxlX6twMDrbMtWJUwaIo0ZxPGgG8Gf8OudbAUQgxEuHggFVlbbJwZdDMHkY9vh5GsC
        9mAXTcCk7ZlowfKT7Xx+6V7nUr6A753WC6ELeaJ2BJe1ejnFC3Fss9trUoKI2J2T4kHqiQqfsc6Y9
        zUel0xoXT4IioY3R9I0dkdR43JYc3sArnmLOrMVSTIY1fJXq0mKwCXWXPZOfEC+JoKnMK3NC2sYld
        9c6WKpJw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTm8t-00CtLE-E7; Tue, 06 Apr 2021 13:53:24 +0000
Date:   Tue, 6 Apr 2021 14:53:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 18/27] mm/filemap: Add lock_folio_killable
Message-ID: <20210406135319.GQ3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
