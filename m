Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1016E42415B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbhJFPbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:31:02 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52744 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhJFPbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:31:01 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY8kX-00AWIy-GM; Wed, 06 Oct 2021 15:22:29 +0000
Date:   Wed, 6 Oct 2021 15:22:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:58:14PM +0100, Matthew Wilcox wrote:
> David expressed some unease about the lack of typesafety in patches
> 1 & 2 of the page->slab conversion [1], and I'll admit to not being
> particularly a fan of passing around an unsigned long.  That crystallised
> in a discussion with Kent [2] about how to lock a page when you don't know
> its type (solution: every memory descriptor type starts with a
> pgflags_t)

Why bother making it a struct?  What's wrong with __bitwise and letting
sparse catch conversions?
