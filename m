Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA658EDA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfHOOED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 10:04:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbfHOOED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FgGZiYXjX5p6iXeIo9sIPhrcGThmyFQ9KdVBSYt6xy4=; b=t+CAzhjHmlbWiEABajJnEJ9Xw
        ewduxXdizGkzLNO2QGuZ4NEejL81zqQflcITrJFxxCx/CEqDqEjX8xq9LSVcd87H78Sgv+SCjE/wA
        hGgYGs/ivclk3xfyTHAa9wDyqehoV3pxfX2XLnJqDHqbP11y+jxNqZdlAVxuMluoVXzbPvJLDq3yu
        QqENAoxcIgBrZWQSGsqW4uy/z7/NNwp60s6VsBBSKmwYc1XG8Q5qbxqFkINYoGaCA7fzFeTDZrAFp
        mgd2ZwQv7VsHPlxBSN8j0hp2ffLRA6ZU+WQnV1OVuTvqZ6uPf8xK6rSuF5Mv/aP7H36iZGO7Jlee5
        9dUqfe5tA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyGM7-0002vt-TH; Thu, 15 Aug 2019 14:03:55 +0000
Date:   Thu, 15 Aug 2019 07:03:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Message-ID: <20190815140355.GA11012@infradead.org>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area>
 <20190815071314.GA6960@infradead.org>
 <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
 <20190815080211.GA17055@infradead.org>
 <20190815102649.GA10821@infradead.org>
 <20190815121511.GR6129@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815121511.GR6129@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:15:12PM +1000, Dave Chinner wrote:
> > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table
> 
> Lots to like in that handful of patches. :)
> 
> It can easily go before or after Arnd's patch, and the merge
> conflict either way would be minor, so I'm not really fussed either
> way this gets sorted out...

The other thing we could do is to just pick the two important ones:

http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table-5.3

and throw that into Arnds series, or even 5.3, and then defer the
table thing until later.
