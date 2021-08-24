Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEB3F69D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhHXT1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:27:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35279 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234788AbhHXT1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:27:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17OJQY5P004559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 15:26:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8AB8215C3DBB; Tue, 24 Aug 2021 15:26:34 -0400 (EDT)
Date:   Tue, 24 Aug 2021 15:26:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSVH6k5plj9lrTFe@mit.edu>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:29:53AM -0700, Linus Torvalds wrote:
> 
> Something like just "struct pages" would be less clunky, would still
> get the message across, but gets a bit too visually similar.

How about "struct mempages"?

> Naming is hard.

Indeed...

					- Ted
