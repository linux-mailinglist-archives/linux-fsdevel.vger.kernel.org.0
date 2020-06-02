Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BE1EB5B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 08:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgFBGNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 02:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBGNJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:13:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38F5206A2;
        Tue,  2 Jun 2020 06:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591078388;
        bh=rRykBBWnGs96WxsrQLDxmACWOa/UFVBVpsVgwWsmVXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Hjjl6n79wTkMOGwUGwEfwwZ3SrDwiog0vc+onIjwGGuMKSzKjJvPZlMTPoeBSV3T
         s00gQNv4yH6M7lX9kvpeFeAHUFFI/guixhK0D6JH5aXOm+zA8naHv9mb1MQJ2Wi8AE
         gcQr/P3/ruI6VfcDbwA53bx45o8NZmrvKj7Cj1H8=
Date:   Tue, 2 Jun 2020 08:13:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tao pilgrim <pilgrimtao@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        sth@linux.ibm.com, viro@zeniv.linux.org.uk, clm@fb.com,
        jaegeuk@kernel.org, hch@infradead.org,
        Mark Fasheh <mark@fasheh.com>, dhowells@redhat.com,
        balbi@kernel.org, damien.lemoal@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>, hoeppner@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-usb@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Message-ID: <20200602061305.GA2258861@kroah.com>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
 <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
 <20200601084426.GB1667318@kroah.com>
 <20200602055152.GA11620@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602055152.GA11620@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 02, 2020 at 07:51:52AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 01, 2020 at 10:44:26AM +0200, Greg KH wrote:
> > But does this code path actually show up anywhere that is actually
> > measurable as mattering?
> > 
> > If so, please show that benchmark results.
> 
> I think the requests are starting to be a bit unreasonable.  Tao is
> replacing a reimplementation of a standard function with that standard
> function / compiler builtin.  We don't put such a high burden on that.

That's fine, but to say it is "faster" usually means we want to see it
actually going faster somehow :)

> And once the proper existing fields are used where possible as shown
> in my reply just replacing the rest seems totally obvious - quite
> contrary I think keeping a reimplementation would need a high bar.

Your patch makes sense, I was not objecting to that.

thanks,

greg k-h
