Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F551257B6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHaOkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgHaOki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:40:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB6C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ecPIVKZPGvGK7Z99O1rOhMk/Zq7Bp/08RcPNGmkNUV0=; b=d7ioD5FxIjtL38bpXus7hzv0My
        lry3tAeHKNtI6BS3FnwHgI+AQfYSXH+8YyIN1bgcGtK9mPpruANatVuBMDpFOYx+cWDRlTcvy2wwF
        ASnsS0+01MbDZSXV3pMkl3dudWwnKs6FTDrle23sovgm+RlWbHAIHWBTFvxgcXJOU2ACPmE6QqRxT
        pNAh/Qzjztuv6cwonJJ2MjWlcHNfJL4hHdTkOsICKEQhY0bhdCa2FtjkQUZ/KNqpLOGTF08gagQQp
        7gaOtkvuSSYudWe3HDCCx5cenK5xauleWfMQ/kii5iJjWuKIBqPA8kBRDjPY5+YOF4dTc+vGcwBgZ
        nMK83eQw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCkyx-0004uo-LQ; Mon, 31 Aug 2020 14:40:27 +0000
Date:   Mon, 31 Aug 2020 15:40:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200831144027.GE14765@casper.infradead.org>
References: <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <20200829191751.GT14765@casper.infradead.org>
 <20200829194042.GT1236603@ZenIV.linux.org.uk>
 <20200829201245.GU14765@casper.infradead.org>
 <20200831142312.GB4267@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831142312.GB4267@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:23:12AM -0400, Theodore Y. Ts'o wrote:
> On Sat, Aug 29, 2020 at 09:12:45PM +0100, Matthew Wilcox wrote:
> > > 	3) what happens to it if that underlying file is unlinked?
> > 
> > Unlinking a file necessarily unlinks all the streams.  So the file
> > remains in existance until all fds on it are closed, including all
> > the streams.
> 
> That's a bad idea, because if the fds are closed silently, then they

What?  I think you completely misread me.  I never said anything about
closing file descriptors.  I'm proprosing standard unix semantics;
having a file descriptor open keeps a file in existance, even after
it's unlinked.

