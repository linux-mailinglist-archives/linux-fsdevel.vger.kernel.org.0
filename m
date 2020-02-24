Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2616B294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgBXVdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:33:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgBXVdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=CiTwqnEvciiAQat+oldK633lmg
        zUawSauYqMaewNeZNVkeqnPK9Dhr87RX5DCkkld/HO7vh1OMCcSSpI6qklmXTtXeOk9AKTwRC3+kA
        6pf3Pjk2PiFQ9J8Q+q9u93/j1yk2LCsyKVrXcjrWVTOSiNY8S+dka/Tg3TIfYq6mXxUUiYmadp/Qz
        jrgn7KhcrwzLQshsGaCz1A8KpgR3cTw0cWajD7kDWH+IbtI99BCaafCuCvpMRoPJuUYxgKYyXgeLc
        OIJmBvwaPjoGKLZqi0ywPLQaNkBXn7O0W6ogtLU4CqYsPBWE1o/YSi0+8TFNlNMRRoH7t7l6VNSZ5
        luB/mO1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LMO-0004Ap-Do; Mon, 24 Feb 2020 21:33:52 +0000
Date:   Mon, 24 Feb 2020 13:33:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v7 02/24] mm: Return void from various readahead functions
Message-ID: <20200224213352.GB13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
