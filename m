Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210B736BB71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhDZWHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhDZWHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:07:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495B3C061574;
        Mon, 26 Apr 2021 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XK5+f7Db0OM4+ZlUyp6+mZlgB+krJZKGD28BOsZ8jy4=; b=iGkeBKviOcJn1BJX6sUAaIh6QL
        fQpcT/BpHYHRoV0YGxpWdGN9zqG7o8rBYEe2r92nByzEweT8X8XmMfZ20N0DFJuBXn9ebrBvbqINt
        hdhEx/GyGvraHDNzT1XkhX/WvACkWqodOj1zBpARVj02YOQyzPLOVRWwb8O2+8UM9gHg9wqlQp0Cy
        Yr5REVFTJdyS6yLDoUFAU5EavEPsF9oZ0rCW6DSyqhMflhTuMFKSV+tbR9xQpkZYdFLy4Az+VL1o3
        zC5FYj+Peusr2GHl6f75IuZUKFhBP0sUuPN/94FrqDdXhPpjjGHhLhV2R0LDaTWtSt/kdnnif6A1B
        l8FyUBWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb9NK-0069d6-6I; Mon, 26 Apr 2021 22:06:45 +0000
Date:   Mon, 26 Apr 2021 23:06:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        v9fs-developer@lists.sourceforge.net, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Miscellaneous fixes
Message-ID: <20210426220642.GU235567@casper.infradead.org>
References: <20210426210939.GS235567@casper.infradead.org>
 <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <3726642.1619471184@warthog.procyon.org.uk>
 <3737237.1619472003@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3737237.1619472003@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:20:03PM +0100, David Howells wrote:
> Okay, how about the attached, then?

LGTM!  Thanks.
