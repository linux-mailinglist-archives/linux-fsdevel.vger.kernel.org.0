Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9B309268
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 07:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhA3GEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 01:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhA3GD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 01:03:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9AC06174A;
        Fri, 29 Jan 2021 22:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ulTijpS/LBioTo1ylP63hfNPHictEmvbFArlgqbeXJ4=; b=Q9MbYBzNEQZYWZvGwWOsx22FSO
        74ZfFFf55AQJeccITM31kpIlwKmqk+Fi8PqbcdgJq2RagZh5MFfS9QuEX1VkV4pM9u/mOwsWQRv12
        gRFPAwWeKlAhxnlsvw5Oc3mv6uXEvBGjx5bozyZpLzmZGw1gszCnIADoBMQr+w+NWHdxZ9vX+P7Ll
        QOMu5DSYUkrBJntwqJlUiVOkV6lCD3oo/NXqxC5e8z4XcvjdGlucb/4chrHY59tA4RcwduDv9QVAE
        TbryHhGqJ9vIxgG7SKg9fnqc3FF9iCrnhT2ZJUhhPjPmmLA37CUYxPZY/d9ow5McNMpe0STttFhkq
        2KeNw8Ng==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l5jLD-00AlNA-98; Sat, 30 Jan 2021 06:02:39 +0000
Date:   Sat, 30 Jan 2021 06:02:39 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/2 v2] nfsd: skip some unnecessary stats in the v4 case
Message-ID: <20210130060239.GB2564543@infradead.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
 <20210129192629.GC8033@fieldses.org>
 <20210129192701.GD8033@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129192701.GD8033@fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:27:01PM -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> In the typical case of v4 and an i_version-supporting filesystem, we can
> skip a stat which is only required to fake up a change attribute from
> ctime.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
