Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A940CBD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhIORoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:44:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36589 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229479AbhIORoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:44:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18FHgO2e004544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 13:42:25 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 360D215C3424; Wed, 15 Sep 2021 13:42:24 -0400 (EDT)
Date:   Wed, 15 Sep 2021 13:42:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, ksummit@lists.linux.dev
Subject: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers Summit
 topic?
Message-ID: <YUIwgGzBqX6ZiGgk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Back when we could fit all or most of the Maintainers plus interested
developers in a single room, the question of how to make forward
progress on something like Folios.  These days, all of the interested
parties wouldn't fit in a single room, which is why Maintainers summit
focuses only on development process issues.

However, this means that when we need to make a call about what needs
to happen before Folios can be merged, we don't seem to have a good
way to make that happen.  And being a file system developer who is
eagerly looking forward to what Folios will enable, I'm a bit biased
in terms of wanting to see how we can break the logjam and move
forward.

So.... I have a proposal.  We could potentially schedule a Wither
Folios LPC BOF during one of the time slots on Friday when the
Maintainers Summit is taking place, and we arrange to have all of the
Maintainers switch over to the LPC BOF room.  If enough of the various
stakeholders for Folios are going to be attending LPC or Maintainer's
Summit, and folks (especially Linus, who ultiamtely needs to make the
final decision), this is something we could do.

Would this be helpful?  (Or Linus could pull either the folio or
pageset branch, and make this proposal obsolete, which would be great.  :-)

	    	      	       		 - Ted
