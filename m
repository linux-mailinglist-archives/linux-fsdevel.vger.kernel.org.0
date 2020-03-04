Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0884179151
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 14:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgCDN2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 08:28:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgCDN2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vcyjl/gf9IB6qjHUL3x/zChqzGCsLcScrsxnmpIoAjU=; b=eq5l3g1Tod0dAnZbI4RkPb4doi
        2dFO7PzAPS1zgq9oQM512m58g5Gc2wzNrgvVGouydIulxHhfHCPTP3zUFL6XpoGTDCbdd36NVH3mH
        7Au7SnFiEDp1OBbDewb9Da2OEX33OFf0jew/JLvAhHYMNSyHun0llahx5201paync0Ls7pO2YAXgy
        bypnEAWWHugKhvGwdCWlHORtqxR4QQZkvlv1D7BtmwpnkEt8XTX2h0C8Q9E0dCKF441nkdH2Y+t2B
        Fxlw32Ip+xO6WguWKS0rTc2zIQLeUCB5QgkVwRTSrkGqv+tXon0u05MLNvPL8nFly6QP827eBzFqu
        Nb8cv/DQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9U4K-0006L0-P1; Wed, 04 Mar 2020 13:28:12 +0000
Date:   Wed, 4 Mar 2020 05:28:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200304132812.GE29971@bombadil.infradead.org>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
 <20200302003926.GM23230@ZenIV.linux.org.uk>
 <87o8tdgfu8.fsf@x220.int.ebiederm.org>
 <20200304002434.GO23230@ZenIV.linux.org.uk>
 <87wo80g0bo.fsf@x220.int.ebiederm.org>
 <20200304065547.GP23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304065547.GP23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 06:55:47AM +0000, Al Viro wrote:
> On Tue, Mar 03, 2020 at 11:23:39PM -0600, Eric W. Biederman wrote:
> > Do the xfs-tests cover that sort of thing?
> > The emphasis is stress testing the filesystem not the VFS but there is a
> > lot of overlap between the two.
> 
> I do run xfstests.  But "runs in KVM without visible slowdowns" != "won't
> cause them on 48-core bare metal".  And this area (especially when it
> comes to RCU mode) can be, er, interesting in that respect.
> 
> FWIW, I'm putting together some litmus tests for pathwalk semantics -
> one of the things I'd like to discuss at LSF; quite a few codepaths
> are simply not touched by anything in xfstests.

Might be more appropriate for LTP than xfstests?  will-it-scale might be
the right place for performance benchmarks.

