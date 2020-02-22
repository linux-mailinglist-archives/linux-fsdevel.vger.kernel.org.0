Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D02168B70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 02:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBVBJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 20:09:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgBVBJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LTbHwE3lV5WpQLB0ParYWcM6AZYImdA7UZTzC3wnNNM=; b=HxlPeagSzuLkYzLyiVln93VTqs
        DQf8NkG8id/IIioBHSJQxg+7evdNclgsrQfEVae/L0LZ6sfBMKjmeqbPkksobYexii4tyONiw5EAZ
        sEaBLhd+8jfqTUccvHA1MgjSUKBJuuGyMNcCMkpdIBB1lbDL0OymyffvYjXtOCO6dFExQoozYbGcn
        oJu3YBehtzxbJZ+ZUq8Yj/qpbrYfoMw39UZf64ZxGDPIvFxbX+rZLmrWRlE1w8VENg+bcszs1dHag
        i01SPalc2Elw9mcsf7AR8otZiQptnBizcOAPG7xvVEhHuBMRLzowFDYtKtveM6VzI5G54hBH72if4
        UZahGLFQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5JIp-00024B-DB; Sat, 22 Feb 2020 01:09:55 +0000
Date:   Fri, 21 Feb 2020 17:09:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200222010955.GG24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
 <20200222010353.GI9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222010353.GI9506@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:03:53PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 19, 2020 at 01:01:01PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in iomap.  Convert XFS and ZoneFS to
> > use it.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Ok... so from what I saw in the mm patches, this series changes
> readahead to shove the locked pages into the page cache before calling
> the filesystem's ->readahead function.  Therefore, this (and the
> previous patch) are more or less just getting rid of all the iomap
> machinery to put pages in the cache and instead pulling them out of the
> mapping prior to submitting a read bio?

Correct.

> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks!
