Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA78300A31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbhAVRmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbhAVRfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:35:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE42C0613D6;
        Fri, 22 Jan 2021 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l9i8rKUkaxxaSbdOTMh1MXlfSJ8IPG77KkrZX87QG4Y=; b=ZPGU8syopDK9BN/mIwxPbguSTx
        VWfySzipI6F8o0TLgjZ0ixs6TP97HDpxkve91IcuhuZlx0h4Gzjbi5bN6yOg6h8Z57YuauzUU0dqG
        Ux4LGw7iYljbqrilEjqTi80MexXwbQGaxO5uQouP7+b8U29ia7kRGxxRvJPWoERtqsT3uktEljNLv
        3ztucShtLBKIyNiSRigl2tEvGHs/Vbp4fHy4jZcumu2VRp5+C+DMd+HFNmugNlagXcD6Fn4PUMZtj
        JnDbumGIPOKF9moh5AesEjhfsWDvr4gglI4//osF65jqDDAMPgj70jALQISMVbqA7XEcO3zZVCSyL
        Byh8bzwg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l30KE-0011cF-CE; Fri, 22 Jan 2021 17:34:23 +0000
Date:   Fri, 22 Jan 2021 17:34:22 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/3] NFS change attribute patches
Message-ID: <20210122173422.GC241302@infradead.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611084297-27352-1-git-send-email-bfields@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I'm fine with 1 and 3, but I'd rather skip patch 2.
