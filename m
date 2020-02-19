Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9056164779
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSOwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:52:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSOwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMegKaz1HfLpF2g7p7DlQ/EBiCvWUcUbr7nX80vF5Lc=; b=X0rDPJg7QU0PJJIjNaGAqpvYpn
        /6hHDMHrdwYkFf1WvaYRTaaFo3AeckX2+ZMOn/Nm+JcW/3hxiePAiir6lvCdGk/P9uGHhfEvpwucR
        bDgJplk4ZCNgyTGHvDtEAXPpGMvUHcNEbcpg/CZuZzZ8G0wxOm3ivsGEcGAf/pSiwD7Ps2HXhUwxB
        /EDsb5LGA3euGi7WrNg3xJ0jEsmipdOVSe+xRb9+nw2AsqZgT8EzK22Jb+prE9J0v1S+vNMRg8lPH
        dfLqR0GpfpnFRQ0KGllMdG0K8ZzeSgnbnF1b+ANwO8esQ2ZRQlWzlSH06wNuzINQh6c12fiPoXmuF
        OO0s+XQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4QiU-0007wz-2Y; Wed, 19 Feb 2020 14:52:46 +0000
Date:   Wed, 19 Feb 2020 06:52:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200219145246.GA29869@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
 <20200219144117.GP24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219144117.GP24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 06:41:17AM -0800, Matthew Wilcox wrote:
> #define readahead_for_each(rac, page)                                   \
>         while ((page = readahead_page(rac)))
> 
> No more readahead_next() to forget to add to filesystems which don't use
> the readahead_for_each() iterator.  Ahem.

And then kill readahead_for_each and open code the above to make it
even more obvious?
