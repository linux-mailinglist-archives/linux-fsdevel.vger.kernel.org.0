Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63F3D11A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhGUOLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhGUOLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:11:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358CC061575;
        Wed, 21 Jul 2021 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AKhTwBZRXuGyK0eHt0zsDJMOjVofgpnBIIWEazs7doI=; b=egiPLTjakG8jcgwUqAP7E3PEAa
        CVYhSGAarUxwP3XjPbEHvaB3QfbP66PeiHIyi0IUdquVR+rZcGXpYLNmXX+YRWyc7+NAOJOQ1ru1g
        cwLHq3YAEbnlcygzQ+TUuukACRA0ajirTF09amSs3alMVWmT1VawrduKoJyb0FttR9X/otktMQ+BU
        IyrKGa7C0gtof2ZZuwwy+mZuZ9Z8bsMkPPpysQzqt3bnCPp2oR4GCBaD07AjEnQz62+fYYr62lfbG
        cNfbK2iah0tgoiZrSorKKIjVWMb1nausf8L06VQOD6EX06zJJrYrB4KJx/Q1DJsQdhUKQ4H0rlzpC
        7dNYi4rA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6DZ5-009Inm-09; Wed, 21 Jul 2021 14:51:20 +0000
Date:   Wed, 21 Jul 2021 15:51:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Message-ID: <YPg0Ylbmk4qIZ/63@casper.infradead.org>
References: <20210721135926.602840-1-nborisov@suse.com>
 <YPgwATAQBfU2eeOk@infradead.org>
 <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
 <YPgyQsG7PFLL8yE3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgyQsG7PFLL8yE3@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 03:42:10PM +0100, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 05:35:42PM +0300, Nikolay Borisov wrote:
> > 
> > 
> > On 21.07.21 ??. 17:32, Christoph Hellwig wrote:
> > > This seems to have lost the copyright notices from glibc.
> > > 
> > 
> > I copied over only the code, what else needs to be brought up:
> > 
> >  Copyright (C) 1991-2021 Free Software Foundation, Inc.
> >    This file is part of the GNU C Library.
> >    Contributed by Torbjorn Granlund (tege@sics.se).
> > 
> > The rest is the generic GPL license txt ?
> 
> Last time I checked glibc is under LGPL.

This particular file is under LGPL-2.1, so we can distribute it under
GPL 2.
