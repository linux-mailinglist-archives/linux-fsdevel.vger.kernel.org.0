Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80F8114615
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfLERho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:37:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gV5bNkEwBW3OMSAGQGkznh3MP6+M3SnlgiG4sr6SzbU=; b=tqBl522OzgsBdx0pQUVwFHHv/
        11Ak81mZQsTdymKLKQfps4PtDanKgVfilOcEThHGUhqYe9LmkSyLir+3wjqZRqr7sCTvemqml1Mxa
        p8LZV6JxZ+xNQ8LCkd80dad84HZvr3mJHg6C37j1UO12xk5yTICdhQzg2K11rxRGm/Tk+hDQsCto+
        FqNgWoXWEYJDLsN6+aIMRgTEad3oXdyzPArZ5k6qkEVxA82xWpYYsbcZB7BzgkDaNJp8D1uD3WYoV
        4VdMMqSBBw+EZSFPBqOk6N1EVa7e5EmbsCJv+gvrmHk1cMNiiik/31IibiGUFw75Rw7kCMzZ8oaAj
        6wLqBSG2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icv4R-0008Rv-UO; Thu, 05 Dec 2019 17:37:43 +0000
Date:   Thu, 5 Dec 2019 09:37:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205173743.GB32341@infradead.org>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
 <20191205171959.GA8586@infradead.org>
 <20191205173242.GB19670@Johanness-MacBook-Pro.local>
 <20191205173346.GA26969@infradead.org>
 <20191205173648.GC19670@Johanness-MacBook-Pro.local>
 <20191205173728.GA32341@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205173728.GA32341@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:37:28AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 05, 2019 at 06:36:48PM +0100, Johannes Thumshirn wrote:
> > To hide the implementation details and not provoke someone yelling layering
> > violation?
> 
> The only layering is ->direct_IO, and this is a step to get rid of that
> junk..

s/layering/layering violation/
