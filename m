Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A14292A01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgJSPFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgJSPFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:05:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6562EC0613CE;
        Mon, 19 Oct 2020 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bFSiuYqB4gwYvv/iZyzJmlqTMgfw3DQ04mxWA+a4zz8=; b=gjNRMhzR4NWeuUkCP2OuEJTVHP
        fewl680n7c4HRDiiRMpp52VauoWDCZK80TaMfhH3kq6fMTh6SsN1XFNJXGJkvTBWhxdlXr5xEktjK
        pvpY5JNh8agErSuEeuptPQ6S/S621map4Ma8WPf4k6G+gQQ0pBHMwP1NgqhwAcbzm7rA29VmKYqpv
        lj0LhIontRqUDXzxL1gizjcITxaXKxOp5UtTGGLzpN5fBQmI8GoffXSqbwZFkKFqLl5UMztbYWyxJ
        Yxt08S9WnVFD1LxhZoPusN0CGuHRfkNnGo8P2zaQpV7OuJ76O58TxpNR9OJNeKtxb2p3FCKyg1ldZ
        jFPgpmdg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUWjB-00080A-Is; Mon, 19 Oct 2020 15:05:38 +0000
Date:   Mon, 19 Oct 2020 16:05:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, Takashi Iwai <tiwai@suse.de>,
        dwysocha@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Drop superfluous readpages aops NULL check
Message-ID: <20201019150537.GS20115@casper.infradead.org>
References: <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 03:56:54PM +0100, David Howells wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> After the recent actions to convert readpages aops to readahead, the
> NULL checks of readpages aops in cachefiles_read_or_alloc_page() may
> hit falsely.  More badly, it's an ASSERT() call, and this panics.
> 
> Drop the superfluous NULL checks for fixing this regression.
> 
> [DH: Note that cachefiles never actually used readpages, so this check was
>  never actually necessary]
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208883
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1175245
> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
