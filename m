Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32140F697
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbhIQLPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 07:15:36 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:46192 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243123AbhIQLPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631877253;
        bh=kOSJlytOKArtchcqsw0mkjWJteCtj8u7OX0jv2Vu1lU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ANH3VOqgwioVEKItkM+3IR7tNfwOi4OyeVJE+KryLKowID2uuEMtpCrB5Bv40xofo
         XUZJsvKB3tfQ/9eMUGZB9xBYTd7rwAm2J6xl26qVcGUKQCtGl6dDMOr6XzYedr720I
         0wOGpenriHMIOAlLuLID1mkEYl8Djp2xdRoMQoLU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A7CC3128046C;
        Fri, 17 Sep 2021 04:14:13 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WxlMDOf_mUhM; Fri, 17 Sep 2021 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631877253;
        bh=kOSJlytOKArtchcqsw0mkjWJteCtj8u7OX0jv2Vu1lU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ANH3VOqgwioVEKItkM+3IR7tNfwOi4OyeVJE+KryLKowID2uuEMtpCrB5Bv40xofo
         XUZJsvKB3tfQ/9eMUGZB9xBYTd7rwAm2J6xl26qVcGUKQCtGl6dDMOr6XzYedr720I
         0wOGpenriHMIOAlLuLID1mkEYl8Djp2xdRoMQoLU=
Received: from jarvis.lan (c-67-166-170-96.hsd1.va.comcast.net [67.166.170.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4EDF11280420;
        Fri, 17 Sep 2021 04:14:12 -0700 (PDT)
Message-ID: <f8561816ab06cedf86138a4ad64e7ff7b33e2c07.camel@HansenPartnership.com>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Chris Mason <clm@fb.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Date:   Fri, 17 Sep 2021 07:14:11 -0400
In-Reply-To: <20210916210046.ourwrk6uqeisi555@meerkat.local>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
         <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
         <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
         <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
         <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
         <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
         <261D65D8-7273-4884-BD01-2BF8331F4034@fb.com>
         <20210916210046.ourwrk6uqeisi555@meerkat.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-09-16 at 17:00 -0400, Konstantin Ryabitsev wrote:
> On Thu, Sep 16, 2021 at 08:38:13PM +0000, Chris Mason wrote:
> > Agree here.  Mailing lists make it really hard to figure out when
> > these conflicts are resolved, which is why I love using google docs
> > for that part.
> 
> I would caution that Google docs aren't universally accessible. China
> blocks access to many Google resources, and now Russia purportedly
> does the same. Perhaps a similar effect can be reached with a git
> repository with limited commit access? At least then commits can be
> attested to individual authors.

In days of old, when knights were bold and cloud silos weren't
invented, we had an ancient magic handed down by the old gods who spoke
non type safe languages.  They called it wiki and etherpad ... could we
make use of such tools today without committing heresy against our
cloud overlords?

James


