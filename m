Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3AC1B37BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDVGog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgDVGof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:44:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC103C03C1A6;
        Tue, 21 Apr 2020 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R3Wcm6CbR/G6SLD4XVnk7GpiQZBdrcFoabboLjiCXlQ=; b=NQJRNZk+/BeYMRqupYqT78Xm3c
        lUHnX1+AoijrHjRNNPRMqd69eOFSctktIO/ZIi232xkEOjE7IKKc3qy/cDK6GKxexH6xqtHuGC8Wj
        Qf+1BoxBR5jrLE8abr6u4QZ7Tg8SXsjoyID0NawIg+a995SvhAeciWRQh7MGc1knkwEd4L2SrwP7w
        dSUNSgSynR4vKot2UhL11knNyxFmtrA9PZspvbvAJGO6WClEg9BOm57RRiE3fxqo3gqiP2FWBvPwg
        G9uWfO08I77P5IXANZE9CvFR676D7PN9EZvqEem9VMFMZfNOwwnoIPzF3IiwXBWcWu/HtQMjcBuWy
        qQSzRiQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR97X-0004Z0-Bx; Wed, 22 Apr 2020 06:44:31 +0000
Date:   Tue, 21 Apr 2020 23:44:31 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
Message-ID: <20200422064431.GG20318@infradead.org>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-2-johannes.thumshirn@wdc.com>
 <de79e1ab-0407-205e-3272-532f0484b49f@acm.org>
 <SN4PR0401MB3598B2774CD52FAB68C726249BD40@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598B2774CD52FAB68C726249BD40@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:46:21AM +0000, Johannes Thumshirn wrote:
> On 18/04/2020 18:02, Bart Van Assche wrote:
> > How about adding __must_check to scsi_setup_fs_cmnd()?
> 
> I'm actually not sure if __must_check helps us anything given that with 
> this patch applied:

It doesn't.  __must_check on static functions with a single caller does
not make any sense.
