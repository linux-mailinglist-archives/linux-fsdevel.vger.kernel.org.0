Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8302F3D669C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhGZRi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 13:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233473AbhGZRi5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:38:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93BC5604DB;
        Mon, 26 Jul 2021 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627323565;
        bh=9Y7V+0t54qESU/DDHx7nrwaFgxexW3sul/7/SX89afs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peAvI0Sj/Qkz8JzjIXEHgwgzb64oGjD7myvo5JvDG+XTEd8ZHX9L6BCJHsi4YOAi4
         BPL4KIYLienRJDvpIaS+LjFo7I+serdOHQk8M2cC3ACw6K6vNGLL0d/DwOkr5SIZS5
         96BqmA/EYb5/CLTUbmmUBK60kKKEPAA9KMXo1GtoUrwoFZmAt2vxRLccdUipleoFT7
         7CaDdo+Xq2n5XH8xdWxzDPXVosJAuy81Z/p26LYKNcmKy4gZRBrH8scIdRiqwDP1sD
         XH1K5TnNAooWpd553jllQSL4wLuxQsY347COKv9PJi2UEQc4zIWgOdm+s+qXfQIzSf
         l9mJUfhl0V5+w==
Date:   Mon, 26 Jul 2021 11:19:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <20210726181925.GE8572@magnolia>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
 <20210726145858.GA14066@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726145858.GA14066@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 04:58:58PM +0200, Christoph Hellwig wrote:
> Looks good to me:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Uh, did you mean RVB here?

--D
