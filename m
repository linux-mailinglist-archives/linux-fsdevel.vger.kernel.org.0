Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171081D0F52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgEMKHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbgEMKHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:07:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7112CC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fN1EnHGWA4UlJEscV/scLIoLJvsXQCDXyBN2NQ9jNno=; b=cPbHACTN/NoaT2Rxnzm/z362zx
        rO9UN+CT4XI4e61RFoO0jyzVTjT32nz1ToA8B/o2ji3Xn5bUAyE1Bq3MrBC77qCk6Y2cnZDPhZtJD
        oLGSNHgLkM8X+5a+yQInhksLh1yxCA08gBubmTvETEnJYDIRWUZlUXOgh73OO5Dl3PNTERqrrpiX2
        dpFqtH1YlwAXwcwxn/SZyXWWIB0NAaazqnrZ3APnsj6MBqDZqi0JaeLQZv+oKMq9rlhj6iFNdM0Iy
        Kor2RbE5CEQtpsNCTAfsbifxupbaJg5Kv8/qhFZNZscryDpxPOy+UQQz1ouSwTUUsQO+++OLss2Hb
        uiEmhznQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoI2-0005hG-Mz; Wed, 13 May 2020 10:07:02 +0000
Date:   Wed, 13 May 2020 03:07:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] vfs: don't parse "posixacl" option
Message-ID: <20200513100702.GI7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-12-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-12-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:14AM +0200, Miklos Szeredi wrote:
> Unlike the others, this is _not_ a standard option accepted by mount(8).
> 
> In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
> mount(2) interface is possibly a bug.
> 
> The only filesystem that apparently wants to handle the "posixacl" option
> is 9p, but it has special handling of that option besides setting
> SB_POSIXACL.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
