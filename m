Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF63E1ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 19:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbhHER6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 13:58:03 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:59958 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhHER6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:58:02 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 13:58:02 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mBhYA-001pwx-6C; Thu, 05 Aug 2021 19:52:58 +0200
Date:   Thu, 5 Aug 2021 19:52:58 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Howells <dhowells@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Canvassing for network filesystem write size vs page size
Message-ID: <YQwlehFilahEZg2T@angband.pl>
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
 <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
 <1219713.1628181333@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1219713.1628181333@warthog.procyon.org.uk>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 05:35:33PM +0100, David Howells wrote:
>  - a complete folio currently is limited to PMD_SIZE or order 8, but could
>    theoretically go up to about 2GiB before various integer fields have to be
>    modified (not to mention the memory allocator).

No support for riscv 512GB pages? :p


-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ The ill-thought conversion to time64_t will make us suffer from
⢿⡄⠘⠷⠚⠋⠀ the Y292B problem.  So let's move the Epoch by 435451400064000000
⠈⠳⣄⠀⠀⠀⠀ and make it unsigned -- that'll almost double the range.
