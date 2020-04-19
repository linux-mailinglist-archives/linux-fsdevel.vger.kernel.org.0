Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E2F1AF97D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDSK4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 06:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgDSK4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:56:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E4C061A0C;
        Sun, 19 Apr 2020 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=87JQq/8fy/ba6TI5H7xOE4LoomBBm7ajqmEAFHP33Z8=; b=klZsaJBdjtnccxPkMYcYmx36Jg
        2gxnROzkfj2g39w+iLyTtkAfTd+l79DKHZ+TUrLOPYgGk1uTdHZeb0bOwFCZZfOhp/rI5+T5CNIr0
        QNTkudE1/FvokTmh10qQY7QabuyClkMR4fxn/yekdS8oyDk0qaBqzeM5ZT8NMPdS4+IRD3lsDZhDJ
        JDk5DcwYCG/+WtwEAk4MOezsrd8TOlP5MluJicOHCz41Ct/PoTyIJ99gRxkUPiyIlqfF76H95hmZN
        Y5XJaYufNd6eFtyalfDUmnGmeUxNqDiEVAO2A9a4i8s2bFHajB4yfYw1y/zdbyO0rOrwRqbOwWIjY
        BgvVcSZw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQ7cn-0006SZ-JM; Sun, 19 Apr 2020 10:56:33 +0000
Date:   Sun, 19 Apr 2020 03:56:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Phillip Lougher <phillip@squashfs.org.uk>,
        squashfs-devel@lists.sourceforge.net,
        Philippe Liard <pliard@google.com>
Subject: Re: mmotm 2020-04-17-20-35 uploaded (squashfs)
Message-ID: <20200419105633.GX5820@bombadil.infradead.org>
References: <20200418033629.oozqt8YrL%akpm@linux-foundation.org>
 <319997c2-5fc8-f889-2ea3-d913308a7c1f@infradead.org>
 <20200418124728.51632dbebc8b5dbc864cc34f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200418124728.51632dbebc8b5dbc864cc34f@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 12:47:28PM -0700, Andrew Morton wrote:
> On Sat, 18 Apr 2020 08:56:31 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 4/17/20 8:36 PM, akpm@linux-foundation.org wrote:
> > > The mm-of-the-moment snapshot 2020-04-17-20-35 has been uploaded to
> > > 
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > > 
> > > mmotm-readme.txt says
> > > 
> > > README for mm-of-the-moment:
> > > 
> > > http://www.ozlabs.org/~akpm/mmotm/
> > > 
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > more than once a week.
> > > 
> > > You will need quilt to apply these patches to the latest Linus release (5.x
> > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > http://ozlabs.org/~akpm/mmotm/series
> > > 
> > > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > > followed by the base kernel version against which this patch series is to
> > > be applied.
> > 
> > on x86_64:
> > 
> >   CC      fs/squashfs/decompressor_multi_percpu.o
> > ../fs/squashfs/decompressor_multi_percpu.c:75:5: error: conflicting types for ‘squashfs_decompress’
> >  int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
> >      ^~~~~~~~~~~~~~~~~~~
> 
> Thanks.  Seems that file was missed.
> 
> Also, this code jumps through horrifying hoops in order to initialize
> locals at their definition site.  But the code looks so much better if
> we Just Don't Do That!

I think the code would look even better if things just Had The Right Type!

struct squashfs_sb_info {
...
-       struct squashfs_stream                  *stream;
+	union {
+		struct squashfs_stream		*stream;
+		struct squashfs_stream __percpu	*percpu_stream;
+	};

int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
		int offset, int length, struct squashfs_page_actor *output)
{
	struct squashfs_stream *stream = get_cpu_ptr(msblk->percpu_stream);
	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
			offset, length, output);
	...

As an aside, that calling convention could do with putting some of the
arguments into a struct so the CPU spends less time shuffling arguments
from one register to another.
