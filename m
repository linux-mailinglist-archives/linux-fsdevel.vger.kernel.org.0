Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3A251689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgHYKUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgHYKUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:20:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8736FC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sZPoy1XX/XaYTKoz7+gdFK0juoS+usgfYV78xsYMYKY=; b=HAzAaIgMNYT3pYLTegNZ9DVIMu
        krgwHWLCmArSWOr7S1gikLmqg/ZOaQyBOhs7ipOHeR+jkvIcunogu4jR49Vu4Iribs7mp4d5aFjPc
        dNEWBKah9SQTVj5mKKkStNz0SQ8OvknsriTxBnBfgMg0mMBpalmCqqBi8+wxwdHv23LO/0dJYNtB9
        5QMyPFnJssE49VjEkeq4dKbzhbp3iEP1/d5Zz030mG1z3R5a8DoCGbYuhtPvTRIc6hudNa8ihsn9s
        5KMElgrKM1vI6ZQJNDN3sFW90KeAPDXbFZkGmD7uNbn+tRlWBHi/oqqANiLjGhCkrES+LAKlgL8Q4
        /I1DgIQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAW4G-00047d-65; Tue, 25 Aug 2020 10:20:40 +0000
Date:   Tue, 25 Aug 2020 11:20:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
Message-ID: <20200825102040.GA15394@infradead.org>
References: <20200505183608.10280-1-yshuiv7@gmail.com>
 <20200505193049.GC5694@magnolia>
 <CAGqt0zzA5NRx+vrcwyekW=Z18BL5CGTuZEBvpRO3vK5rHCBs=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGqt0zzA5NRx+vrcwyekW=Z18BL5CGTuZEBvpRO3vK5rHCBs=A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:26:14AM +0100, Yuxuan Shui wrote:
> Hi,
> 
> Do we actually want to fix this bug or not? There are a number of
> people actually seeing this bug.

bmap should not succeed for unwritten extents.

> If you think this is not the right fix, what do you think we should
> do? If the correct fix is to make ext4 use iomap_swapfile_activate,
> maybe we should CC the ext4 people too?

Yes, ext4 should use iomap_swapfile_activate.
