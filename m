Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B4A6D0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfICPjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:39:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICPjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X/cB+D23nb3lX4M1niPmjOpwMGJ9zXCGneGvPXK49yk=; b=PdKulyV7w7y/A8JCioTeyJUuR
        y3Xccyj9G6xJF2RbjybT/K0F29/PFbSQafRj+pndk+/yoedkvuH6HVhD+zzptW42f6J2cebfVmilo
        UNCn4jitxx8GqoLqUeXZOioygfsc1XMfHMWCzocd0q7Urfh/oVU50o4uyCZT5QpB4l+l7s85hrNsg
        uGKJ4n6sUvDKSao5Au9nJQ2YGcmxOPY0AWIul0QyWh9AR42l4GbY4gzFykHKXbftY6tvnlAqs+7p2
        C8UMMHkQWMBLyIS5XfOzykxhVUY1pjbdarKNnJY9X7cUBurB6BwqqGNengoL8WlmZQS9sUtZHwPNK
        s8MoEWvCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Au2-0000xR-JZ; Tue, 03 Sep 2019 15:39:30 +0000
Date:   Tue, 3 Sep 2019 08:39:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903153930.GA2791@infradead.org>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
 <20190903135354.GI1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903135354.GI1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:53:54PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 06:50:24AM -0700, Christoph Hellwig wrote:
> > On Tue, Sep 03, 2019 at 02:48:32PM +0100, Al Viro wrote:
> > > Not sure what would be the best way to do it...  I don't mind breaking
> > > the out-of-tree modules, whatever their license is; what I would rather
> > > avoid is _quiet_ breaking of such.
> > 
> > Any out of tree module running against an upstream kernel will need
> > a recompile for a new version anyway.  So I would not worry about it
> > at all.
> 
> There's much nastier situation than "new upstream kernel released,
> need to rebuild" - it's bisect in mainline trying to locate something...

I really don't get the point.  And it's not like we've card about
this anywhere else.  And jumping wildly around with the numeric values
for constants will lead to bugs like the one you added and fixed again
and again.
