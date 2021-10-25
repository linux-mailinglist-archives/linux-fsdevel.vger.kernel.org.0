Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA281439EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhJYTE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:04:56 -0400
Received: from vps.thesusis.net ([34.202.238.73]:54428 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhJYTEz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:04:55 -0400
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 0C83861FD2; Mon, 25 Oct 2021 15:02:27 -0400 (EDT)
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net> <20211022084127.GA1026@quack2.suse.cz>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: Readahead for compressed data
Date:   Mon, 25 Oct 2021 14:59:45 -0400
In-reply-to: <20211022084127.GA1026@quack2.suse.cz>
Message-ID: <87fssprkql.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Jan Kara <jack@suse.cz> writes:

> Well, one of the problems with keeping compressed data is that for mmap(2)
> you have to have pages decompressed so that CPU can access them. So keeping
> compressed data in the page cache would add a bunch of complexity. That
> being said keeping compressed data cached somewhere else than in the page
> cache may certainly me worth it and then just filling page cache on demand
> from this data...

True... Did that multi generational LRU cache ever get merged?  I was
thinking you could use that to make sure that the kernel prefers to
reclaim the decompressed pages in favor of keeping the compressed ones
around.

