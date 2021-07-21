Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023533D06B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 04:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhGUBs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 21:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhGUBs4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:48:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74F9360FEA;
        Wed, 21 Jul 2021 02:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626834569;
        bh=jPqsRfixr7ThqKyCRmqlm134VfXl6jPYm4Dbko94Ygw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YYNWJvT6HScDEJdKQNLwDbeNjoAOa+HrsklilQ5iXXfGBHgvZfkUh4G/+ZJ9mtwKE
         9gQ2SJRZCbsg/oT1+U4F1bt8gKO6LjPXqDjFukeJmArXlyY/8U4KYhYXHGaZdBvNR2
         Zo8TgsvKzkHDhtkKnA7/Wtviwl2s6G642CKpOmE0=
Date:   Tue, 20 Jul 2021 19:29:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-Id: <20210720192927.98ee7809717b9cc28fa95bb6@linux-foundation.org>
In-Reply-To: <20210721122102.38c80140@canb.auug.org.au>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
        <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
        <20210720094033.46b34168@canb.auug.org.au>
        <YPY7MPs1zcBClw79@casper.infradead.org>
        <20210721122102.38c80140@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jul 2021 12:21:02 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Matthew,
> 
> On Tue, 20 Jul 2021 03:55:44 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I think conceptually, the folio for-next tree is part of mmotm for this
> > cycle.  I would have asked Andrew to carry these patches, but there are
> > people (eg Dave Howells) who want to develop against them.  And that's
> > hard to do with patches that are in mmotm.
> > 
> > So if Andrew bases mmotm on the folio tree for this cycle, does that
> > make sense?
> 
> Sure.  I will have a little pain the first day it appears, but it
> should be OK after that.  I am on leave starting Saturday, so if you
> could get me a tree without the mmotm patches for tomorrow that would
> be good.

Sure, let's go that way.  Linus wasn't terribly enthusiastic about the
folio patches and I can't claim to be overwhelmed by their value/churn
ratio (but many MM developers are OK with it all, and that
counts).  Doing it this way retains options...
