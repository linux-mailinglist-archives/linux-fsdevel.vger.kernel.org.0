Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF73D5CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhGZO1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhGZO1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:27:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2351C061760;
        Mon, 26 Jul 2021 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BubiKB9vB45J69umFp5in89rgduVxIwyz1cpJGxQFfY=; b=sOAC1zypeUA7rs8q0Zw+qXhU5q
        toYffRKhMe4o+N3uzGP7XKidnZnHdprBmR5GYoZC4KqwGWDLwdzLgBqWWsex3XzVCz9J/LXL6Hk+g
        7f7YOQx2/x4C7U45SOZXJ9zNXOJHo4Zgq3Yb1PjadyiE3aUINlZFqmNvQXIeMGtww/Iom++C2G5lJ
        Wf5Daib5UT5W/UfyiwpvAzHlXPwz20UuQye+MIRIcZo7yyEAP28itHHpnVKOd/jMKwtdsO4gxBs7j
        yDZ6g2hb83wVt9iDIbzJEtRXhB9x/Iqnc//TTRI/bnxFV0XHwjV1d0yU0ZQObcn+3U22e2rxfnv6k
        bVXKT5IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m82Br-00E4Pi-Rc; Mon, 26 Jul 2021 15:07:02 +0000
Date:   Mon, 26 Jul 2021 16:06:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <YP7Ph55kV0M8M1gW@casper.infradead.org>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Please make the Subject: 'iomap: Support file tail packing' as there
are clearly a number of ways to make the inline data support more
flexible ;-)

Other than that:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
