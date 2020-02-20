Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85516614E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgBTPq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:46:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgBTPq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MIppzgKk98lmK5PhJKrp7GozR9kPFtlmL48ezorCc2Q=; b=DTIPW2wRymIl8Y1SL0vTTAXhAG
        10hulHiMjv5NYS4LI9tGOaNCrq4nd+C+RwR4aIN8ihR9+aKpx+HZIkoGOHfEnFNMl+INDxyFQoY1G
        wK0oNdlDakpJIXlH/Rdyi22id259VnTAx5qpjDsXCFgk0c0Ba6PGbYp5ws76T/yfme48FejWp11tc
        8yWg/4xpZUoZE457jQLbTfn8JIsSyn2s/OpknlYOJ/LtthzT+Hx2+0/nydFNhhkiFTiDCEWzANbN0
        Rz/BfuH4fYG7aEMpINJKvlDs6q3KxUGykyuRHiYjes3Axb2zc8Jv3qa2R8QeX/MrPq40G9Uzfl2uK
        7tqs90Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4o2U-0005BT-1l; Thu, 20 Feb 2020 15:46:58 +0000
Date:   Thu, 20 Feb 2020 07:46:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200220154658.GA19577@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220134849.GV24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> btrfs: Convert from readpages to readahead
>   
> Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> to optimise fetching a batch of pages at once.

Shouldn't this readahead_page_batch heper go into a separate patch so
that it clearly stands out?
