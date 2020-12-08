Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DDE2D2FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgLHQgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 11:36:37 -0500
Received: from verein.lst.de ([213.95.11.211]:46864 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgLHQgh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:36:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0C3B6736F; Tue,  8 Dec 2020 17:35:52 +0100 (CET)
Date:   Tue, 8 Dec 2020 17:35:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201208163552.GA15052@lst.de>
References: <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk> <20201115155355.GR3576660@ZenIV.linux.org.uk> <20201115214125.GA317@Ryzen-9-3900X.localdomain> <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain> <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain> <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127162902.GA11665@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 05:29:02PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 16, 2020 at 03:29:42AM +0000, Al Viro wrote:
> > > Still good.
> > > 
> > > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > Pushed into #fixes
> 
> Shouldn't this go to Linus before v5.10 is released?

ping?
