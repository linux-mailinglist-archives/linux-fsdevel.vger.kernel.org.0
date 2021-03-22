Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD034501D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhCVTm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhCVTmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:42:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05434C061574;
        Mon, 22 Mar 2021 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a+s43F3dBXNbso9NPwsCMVQdm9PWJMB9D0uiyUFUfTM=; b=pLdjFDiH/whGlVLwqeQ/HEzf5W
        AENF9SXNQmhq6Xz5TMPLGu//ryRv24iA/gKFuwXXU+HuEThL0BP2lqt2EVxjFU8mYOVGXVmET6m1s
        HvF3wTT0kbojHxEktZtcV/ToN9krn9Udt8eysCQ//do1Re7PDdu6uGO5pUHUgx/Xmzl4mBk9uBTro
        +y1samCBFOh4XUbqfywQGIyPz7H9bRvsT90gjyLZRWTdeK00OWspMpeLTlqj4ctQKzGTHMYogdS5f
        W2qDvOHSGSAV51724svy9mB+MKCnllOPOpKT4gjghOWhwbKwDVDKMdCcHhhOWrEO21outVjZxjpVS
        diVkiCCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQQV-008z4C-Vw; Mon, 22 Mar 2021 19:41:40 +0000
Date:   Mon, 22 Mar 2021 19:41:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 03/27] afs: Use wait_on_page_writeback_killable
Message-ID: <20210322194123.GV1719932@casper.infradead.org>
References: <20210320054104.1300774-4-willy@infradead.org>
 <20210320054104.1300774-1-willy@infradead.org>
 <1878264.1616405246@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1878264.1616405246@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:27:26AM +0000, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > Open-coding this function meant it missed out on the recent bugfix
> > for waiters being woken by a delayed wake event from a previous
> > instantiation of the page.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-and-tested-by: David Howells <dhowells@redhat.com>
> 
> Should this be pushed upstream now as well if it's missing out on a bugfix?

I would be delighted for you to take these first three patches through
your tree and push them for, say, -rc5.
