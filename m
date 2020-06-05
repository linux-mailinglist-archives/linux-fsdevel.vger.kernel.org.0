Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B931EF698
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgFELmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFELmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:42:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40677C08C5C2;
        Fri,  5 Jun 2020 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GvsW7zdrUIqmvXgAJrllNLf1O1seE5aFbC1JusbrvcI=; b=rYJr3ZgM4OLQq4cmCbWihqvWX1
        cNYPHtzQjittlKB9+HDAOi7uZ1YQJZBxxuxGyXCYYEB1odBNw58jCW5h3rZ6Hx2eJh/wHADb8gGUz
        4+1dzkdivSIJ0OZzNcFr5DYmt0iDJZlqLUDl87yzDBB60YC+cD0TnQ1G1M2+W6DQOS5HwJ+90wNFa
        eY+yHqVlmy5yrIzsk8hEOUQNtMT5Xe9PLeGh4Mb9MxYf9cR6cVSxsHM5swrBQlIsp5EuMQqyeRmeg
        NAuYYbDAklhTiprOyPo724hi+oUXjMhej9qLr7pLM4OAl0iCa6bHLGFdo0gHCOtJMZTj/bcoBES3f
        QgHNSQGw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhAjg-0003Rg-Rq; Fri, 05 Jun 2020 11:42:08 +0000
Date:   Fri, 5 Jun 2020 04:42:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: block: Fix use-after-free in blkdev_get()
Message-ID: <20200605114208.GC19604@bombadil.infradead.org>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111039.GL22511@kadam>
 <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 01:40:37PM +0200, Markus Elfring wrote:
> >> I am trying to contribute a bit of patch review as usual.
> >
> > We have asked you again and again to stop commenting on commit messages.
> 
> I am going to continue with constructive feedback at some places.
> 
> 
> > New kernel developers have emailed me privately to say that your review
> > comments confused and discouraged them.
> 
> Did these contributors not dare to ask me directly about mentioned details?
> 
> Some developers found parts of my reviews helpful, didn't they?

Overall you are a net negative to kernel development.  Please change
how you contribute.
