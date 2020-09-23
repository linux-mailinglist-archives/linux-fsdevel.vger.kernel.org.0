Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34792274FA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 05:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIWDpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 23:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWDpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 23:45:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12DAC061755;
        Tue, 22 Sep 2020 20:45:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKviT-004Gtp-DG; Wed, 23 Sep 2020 03:45:13 +0000
Date:   Wed, 23 Sep 2020 04:45:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] fs,nfs: lift compat nfs4 mount data handling into
 the nfs code
Message-ID: <20200923034513.GF3421308@ZenIV.linux.org.uk>
References: <20200917082236.2518236-1-hch@lst.de>
 <20200917082236.2518236-3-hch@lst.de>
 <20200917171604.GW3421308@ZenIV.linux.org.uk>
 <20200917171826.GA8198@lst.de>
 <20200921064813.GB18559@lst.de>
 <CAFX2Jfks7QTS5crWa43mp4TQ3LoquvRxjuEeCpsZr1aees00eA@mail.gmail.com>
 <20200921181123.GA1776@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921181123.GA1776@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 08:11:23PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 21, 2020 at 12:05:52PM -0400, Anna Schumaker wrote:
> > This is for the binary mount stuff? That was already legacy code when
> > I first started, and mount uses text options now. My preference is for
> > keeping it as close to the original code as possible.
> 
> Ok.  Al, are you fine with the series as-is then?

I can live with that.  I'm not fond of in_compat_syscall() proliferation,
but in this case it's reasonably sane...

OK, applied.
