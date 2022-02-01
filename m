Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084574A553E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 03:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiBACcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 21:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBACck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:32:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163BC061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 18:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EOcwj4pE2etyMzrc5R8K1TCXD4lfa0MHlDS5y2L2sog=; b=I4xKrkbTFaKixq62gWf15Jijz4
        Z6XFnOf/jS3rFEISsTNoPLu15Oc3Vustql5JRSJVs20fnLmjtMdZrw3T4799bZUREUfly/aQLic89
        +tnkJuuh5Rh16yphTCdk/Ky1uxagVcsCXamiVxfJWpl2bk83Ox+tfcVTBzK9Z0yZAlxoihqp2SOMX
        dcBqzfHP+IQ68g83JyrmdrxpfdtCQlzLvxv7c2QbTee1hCZit/wgwg1ag/ysqZ3w5AbufhohrFofA
        6IyCHU2lpZRGV32xLZZvn6/hndmLmixZ0PmDSaEeAL1RIq+rNkImsZtk3GuoN3tJ+Vb97R1WTxKFL
        TbG1cktA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEiyB-00BEC6-8B; Tue, 01 Feb 2022 02:32:35 +0000
Date:   Tue, 1 Feb 2022 02:32:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
Message-ID: <Yfibw2kWukCyfRIK@casper.infradead.org>
References: <2571706.1643663173@warthog.procyon.org.uk>
 <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:16:54AM +0000, Chuck Lever III wrote:
> 
> 
> > On Jan 31, 2022, at 4:06 PM, David Howells <dhowells@redhat.com> wrote:
> > 
> > I've been working on a library (in fs/netfs/) to provide network filesystem
> > support services, with help particularly from Jeff Layton.  The idea is to
> > move the common features of the VM interface, including request splitting,
> > operation retrying, local caching, content encryption, bounce buffering and
> > compression into one place so that various filesystems can share it.
> 
> IIUC this suite of functions is beneficial mainly to clients,
> is that correct? I'd like to be clear about that, this is not
> an objection to the topic.
> 
> I'm interested in discussing how folios might work for the
> NFS _server_, perhaps as a separate or adjunct conversation.

I'd be happy to have that discussion with you, possibly in advance of
LSFMM.  I have a fortnightly Zoom call (which I put up on Youtube),
and I'd be happy to have this as a topic one week if more people are
interested than just you & I.  If it's just you & me, then we can chat
any time ;-)
