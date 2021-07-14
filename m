Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CD3C7B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 04:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhGNCNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 22:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237428AbhGNCNx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:13:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04B6161260;
        Wed, 14 Jul 2021 02:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626228662;
        bh=vSDndrHeLw7XaPTTxvIHN02H9QKd84y0MXkTgllu+BE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AtTz0juCBR1u3QZ2mh/HHMslRjQ2ETaNGLVS3z9cXItuWz3YlsWzuMG8yzbdJapB1
         uXqv3SU8E4P2TRtyJtADOqoQHu51/OgXl/lX4W3rr/BGg7uP1Mop1qIVWy0yPe60uj
         MwpHtMDpUYeIY4pxJT6YCs3ryijI+e3uA3sKZ/Bo=
Date:   Tue, 13 Jul 2021 19:11:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Request for folios
Message-Id: <20210713191101.b38013786e36286e78c9648c@linux-foundation.org>
In-Reply-To: <3398985.1626104609@warthog.procyon.org.uk>
References: <3398985.1626104609@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Jul 2021 16:43:29 +0100 David Howells <dhowells@redhat.com> wrote:

> Hi Andrew,
> 
> Is it possible to get Willy's folios patchset - or at least the core of it -
> staged for the next merge window?  I'm working on improvements to the local
> filesystem caching code and the network filesystem support library and that
> involves a lot of dealing with pages - all of which will need to be converted
> to the folios stuff.  This has the potential to conflict with the changes
> Willy's patches make to filesystems.  Further, the folios patchset offers some
> facilities that make my changes a bit easier - and some changes that make
> things a bit more challenging (e.g. page size becoming variable).

It's about that time.  However there's a discussion at present which
might result in significant renamings, so I'll wait until that has
panned out.

> Also, is it possible to get the folios patchset in a stable public git branch
> that I can base my patches upon?

I guess Willy's tree, but I doubt if the folio patches will be reliably
stable for some time (a few weeks?)

