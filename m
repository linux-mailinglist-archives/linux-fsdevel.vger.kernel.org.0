Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B35C173BB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgB1PkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:40:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgB1PkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RLl4lTWEQ1GAiGFB/dhL9F5BLvw5PQx9CA3ElGeVs+w=; b=Q1MbV49LowiIjlZpl3pNUVex/6
        PYMFB6kNE6s0M2yxnhWgQGvqCIe/DlhIOaRLyRdURzf1Wn9ZvewzHhgdjT/tTHbnfX5+HyKMKdxi8
        IAwZPdqdVKoQFa+GOs3+zAa99/Z05xaPUZbij2dZIvjv+xW6oDHpR+8w3Jx30mojVKFHz36BcJJxQ
        68phLWX6JxxZqC9nm5LoVlVlnfpPqkbHfGjnQN/KtTRnJEhMArnYpn9dzI1EzifcLvwmTvplhu+xM
        yneLzr2C54T4EFC8UH0bqR8tFQzr2tRs7AMgJnSkRAhVUkkleL0Bsus5cB9fslrLObZAtkPCqBBJR
        itBk+T3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7hjz-00040e-5g; Fri, 28 Feb 2020 15:39:51 +0000
Date:   Fri, 28 Feb 2020 07:39:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Andreas Dilger <adilger@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200228153951.GH29971@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
 <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
 <20200228033412.GD29971@bombadil.infradead.org>
 <e8730c5e-6610-f25a-f1cc-9d4ffffe0eb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8730c5e-6610-f25a-f1cc-9d4ffffe0eb5@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:32:02AM -0500, Waiman Long wrote:
> On 2/27/20 10:34 PM, Matthew Wilcox wrote:
> > The canonical argument in favour of negative dentries is to improve
> > application startup time as every application searches the library path
                                                               ^^^^^^^
> > for the same libraries.  Only they don't do that any more:
                 ^^^^^^^^^
>
> It is the shell that does the path search, not the command itself.

