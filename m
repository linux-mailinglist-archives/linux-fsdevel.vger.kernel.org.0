Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A43E4F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhHIWes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHIWer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:34:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4A6C0613D3;
        Mon,  9 Aug 2021 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KTtc/cvMulc1INMc4c7GIJVcioXgpCwan62UGzeNg8c=; b=twaqeqLpMxeAacqIw1RkFNHjDm
        u55azO4PdS9+2SjvVIrX3P4pICyXE3DOK0AAkWRi2NvD07EJljVIWFtKQUzfgLFR552eBCBTfXjRb
        b/SJ6DDwpzXO8+kQ3WCB6AulAVN/iIJCyIY1tFA6xW611CLm5yXLr5OdXYhUd7iTwfMUp2TrR0WgH
        er6HoX2cvJ57ANc9QUHkc3WsPRVsoSsGI/mOBExuz72ev2TyCKTKflORqzkUE3CONDkHIxpYeEKmo
        j/1hRbVBXpOfns1k19RRzQCwqS3PZgtbVE5sXB0BmaxIKIA9hFBNRNJ09EGT6xNC8VClLm40ePWJX
        hWE8dYww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDDpH-00BUGA-F9; Mon, 09 Aug 2021 22:33:13 +0000
Date:   Mon, 9 Aug 2021 23:32:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs fixes for 5.14-rc6
Message-ID: <YRGtF69Z8kjsaSkb@casper.infradead.org>
References: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com>
 <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
 <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 02:26:55PM -0700, Linus Torvalds wrote:
> On Mon, Aug 9, 2021 at 2:25 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I've pulled this,
> 
> Actually, I take that back.
> 
> None of those things have been in linux-next either, and considering
> my worries about it, I want to see more actual testing of this.

Not only that, the changes to fs/namespace.c and mm/util.c haven't been
posted to linux-mm or linux-fsdevel, as far as I can tell.
