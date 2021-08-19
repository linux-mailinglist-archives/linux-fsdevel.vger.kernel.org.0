Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120DE3F151D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhHSIYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhHSIYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:24:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46829C061575;
        Thu, 19 Aug 2021 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=O/9AmCHEhTz3mJ3YpncuUEt6iO
        kel653nzgWmdKxIvSSrCDfzar+eekblcqnPWTzAqliQkouejC4fJqDmdCrlhgi3fyabZfoP1sQ06e
        LEIUtsZ8tqasFIlJRFnIhDAKzDwQm6IGLtxyArCv5fWL4rJwNrbarDTjin+jbYygUxI9ggC+JxajT
        g+Fyd6gfFxHzvT9BFQ0k/lyhllNb+OgK8EmgcpdfmAyln74CAY8cHYzdbMORGVSHNe9i36ZnPBOPv
        N4lQOgAG8xKiaHKASpTBS/hf1TcAZ20h5KMoYv+ctKP62mq8yNUQRDLzELiz7De3numt48njVPeD/
        2GLzyHNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGdKB-004oaT-8c; Thu, 19 Aug 2021 08:23:13 +0000
Date:   Thu, 19 Aug 2021 09:22:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, riteshh@linux.ibm.com,
        tytso@mit.edu, gavin.dg@linux.alibaba.com,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: add swapfile maxpages regression test
Message-ID: <YR4U30PIGlBNv7P1@infradead.org>
References: <db99c25a8e2a662046e498fd13e5f0c35364164a.1629286473.git.xuyu@linux.alibaba.com>
 <20210819014326.GC12597@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819014326.GC12597@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
