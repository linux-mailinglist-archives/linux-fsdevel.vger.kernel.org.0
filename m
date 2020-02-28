Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A317300E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 05:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgB1ExC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 23:53:02 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41605 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgB1ExC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:53:02 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9186E5E3E;
        Thu, 27 Feb 2020 23:53:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 23:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        QaGDiOWBjcbn4rDNlKqOONKkTcLMMhgcigudu4fkTbM=; b=GZOcs8xDttkrjAVH
        NW9UlrkQHXPo/yp+iwzXrgXI2kwoirhgmPKFo2IiP93xmQIntQbvsTBtJfRWbUk6
        hS2XBceoGb1Lf0EWHXoc1SALBi0oDKpu46k4ZWx5hWeXuEAt3KonSJHOFgHPwX6U
        t9qHrh42MNfipoF/IjTo9N4zoHql4Nz11N2kcyFih9JkEOJuuuVrPdzffd8JwDyb
        mow3W9mqXvX57e/4DbRq3j7gnKySA92lowvBWNGa8lAeWvDgb1UJQEn+3o7DiOd9
        n7MOlLGe0q1ZIqnKowyLEe6RDoe1iRqED+P4jXHGiAM6PTxYPHY7XHulnBsu6Tpy
        mTMlWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=QaGDiOWBjcbn4rDNlKqOONKkTcLMMhgcigudu4fkT
        bM=; b=qbgmEM9mb8vbUI3ZVYzTO8aH27yRXZWIPIyOebMpXlXWzQDXqEwEIIiRI
        3HuNvlmmLpNhM2h8ab/H4PvyxdIRPojyG40qxhJVmxruoQ8eUXvbr73nFSzFJ/ZS
        3E3cVQ7e33DvkJkyIDKoQAhx60sTmw2S53kHQ+6Uh0p5To9c8FxU3GkrPUi3L0fc
        98+segKQUKNehg+9skkC53roy7m4vN46zx6baUGxXSAkvio4vKp58l2iYpbe3QZs
        iLb++WKJX5Ffb8aQqYjLvIa0DtD/w61BQTL3p0PoOIwYbZ/3QYngqMzcNqYr57yC
        n69weE2/LZUy6ZS5jMv57C//FG3gw==
X-ME-Sender: <xms:rZxYXm9ggD5oS5z_Ndh6eLsqOkWgKNfSno9Y1Mol3ukkJz0E1gxWsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:rZxYXuMgmNOqBG1ZOYM6qjSwgHzbLQLAuViLq0qqjCNBCUTqEW9Qog>
    <xmx:rZxYXiEJOnr6HAOZUpNyy8aQZz8Q9PHBsx3RZaLzVSjWeDTFaEqdyg>
    <xmx:rZxYXsiSBodZN5FXl-QYKfwWUpoyfgTRzvqUcRNXi5bA2ncVAiLR1w>
    <xmx:rZxYXiOe1qWGFvcAnxqH4bkmJyZOD5G4ykKl0SEz90qyJ-l0Zj7KdA>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED8323060D1A;
        Thu, 27 Feb 2020 23:52:55 -0500 (EST)
Message-ID: <2b03788f9d71d9d972cbe908e0f0fb0e37672719.camel@themaw.net>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
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
Date:   Fri, 28 Feb 2020 12:52:52 +0800
In-Reply-To: <20200228042208.GI23230@ZenIV.linux.org.uk>
References: <20200226161404.14136-1-longman@redhat.com>
         <20200226162954.GC24185@bombadil.infradead.org>
         <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
         <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
         <20200228033412.GD29971@bombadil.infradead.org>
         <20200228042208.GI23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-28 at 04:22 +0000, Al Viro wrote:
> On Thu, Feb 27, 2020 at 07:34:12PM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 27, 2020 at 05:55:43PM +0800, Ian Kent wrote:
> > > Not all file systems even produce negative hashed dentries.
> > > 
> > > The most beneficial use of them is to improve performance of
> > > rapid
> > > fire lookups for non-existent names. Longer lived negative hashed
> > > dentries don't give much benefit at all unless they suddenly have
> > > lots of hits and that would cost a single allocation on the first
> > > lookup if the dentry ttl expired and the dentry discarded.
> > > 
> > > A ttl (say jiffies) set at appropriate times could be a better
> > > choice all round, no sysctl values at all.
> > 
> > The canonical argument in favour of negative dentries is to improve
> > application startup time as every application searches the library
> > path
> > for the same libraries.  Only they don't do that any more:
> 
> 	Tell that to scripts that keep looking through $PATH for
> binaries each time they are run.  Tell that to cc(1) looking through
> include path, etc.
> 
> 	Ian, autofs is deeply pathological in that respect; that's OK,
> since it has very unusual needs, but please don't use it as a model
> for anything else - its needs *are* unusual.

Ok, but my thoughts aren't based on autofs behaviours.

But it sounds like you don't believe this is a sensible suggestion
and you would know best so ...

Ian

