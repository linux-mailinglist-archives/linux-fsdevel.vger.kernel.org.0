Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4093D66AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZRn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 13:43:58 -0400
Received: from verein.lst.de ([213.95.11.211]:47068 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhGZRn5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:43:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AC4F67373; Mon, 26 Jul 2021 20:24:23 +0200 (CEST)
Date:   Mon, 26 Jul 2021 20:24:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <20210726182422.GA25131@lst.de>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com> <20210726145858.GA14066@lst.de> <20210726181925.GE8572@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726181925.GE8572@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:19:25AM -0700, Darrick J. Wong wrote:
> On Mon, Jul 26, 2021 at 04:58:58PM +0200, Christoph Hellwig wrote:
> > Looks good to me:
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Uh, did you mean RVB here?

Yes:

Reviewed-by: Christoph Hellwig <hch@lst.de>
