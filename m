Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39710358DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhDHTtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 15:49:06 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59851 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232023AbhDHTtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:49:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 61BF65C00F9;
        Thu,  8 Apr 2021 15:48:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Apr 2021 15:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fw9IHCLJHiRwr8mG8aPR5wNCw+y
        Sr2ECQd6P2WIYQTA=; b=NUjIuKakvgWBWb63I3f5BeSkW2jFtfJjHEwDl7Gn9Kv
        qZf0zp8LN02gDnCrEr2MFMUWj8VYzEUQlyVF24zV0P0BhA5N4lx2PBlLxdELp9NX
        h8dqFRZLBh0Qi0/nMaI3Bl6Y0P7jju4dohJtGZ9zoEU9hP1NL4XBQZ+hL2hfNvnP
        DpEaHnZPsp1A183gWRjA5+XsGoyY5dvDrHpXSokCGvr0fFncQyINaXUtkXeHdvFy
        /ZLV/iJ/E/pPuii6RGn+cUPYof/8a3NGzLe2jKljsg8G5zQ7SjUG2rN8jR5b4Td1
        YTWwjaeVea7uYO092nsTdupuCyGRyT8RDrHpUNX+PSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fw9IHC
        LJHiRwr8mG8aPR5wNCw+ySr2ECQd6P2WIYQTA=; b=K6vo3oY3mP345AdlOqgpvG
        MDIxj3WMxCM4GwBvGv09JZ7QreGswrNZMCCGhJyrh4U3JdctjJg4GCuBxl2XYmaA
        2aCMuxTZmuohGeCTrz9eh/N7wcd7I6JNTROU/6oQF7TYhbM13tYInXrJo6c6DxT8
        a/0bRdIZm+BY3XDfunvCguu0T88ha9ItyqZ0dwNS4Ia+toqTuSNBymatj4e+5SB2
        8Vlq5BOpTgC0npw7CDbMiCzj+e7W9sS+pYygWjryEiycWWlggUTmCMHXNSzPTHZh
        /d2+EnzAwpvxq5P7ggd1BAzglOi7CFmAm1WHg1LIpxVt5qjjQfHFr9e40YLl1OLQ
        ==
X-ME-Sender: <xms:JV5vYGU1ZWrzrTAUr2bMvroLreoIYiS0kscJJfqKYvT4UMPaNTKY0Q>
    <xme:JV5vYJk6W20mIIu97g4hMFceyu7Njv5cLYIY_7aFuFknd4idkP9VmNu-4VrPawuSu
    mbYPz9a6k6VcWc0wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejledgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepudevudelgedtjeehieekjeeiffevffevtedtheekudegvdef
    ffegfeehjefhuddvnecuffhomhgrihhnpehigidrihhonecukfhppeduieefrdduudegrd
    dufedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:JV5vYPZ2c6eURSAz3TGFymWFEhGHhOyK1LmgZtxCOkmR0CqR6MkhUw>
    <xmx:JV5vYMO48uArW9L2NrCOACSZah3wFJhUgcu5vxmWhbWsBvF5JMWCXQ>
    <xmx:JV5vYMYSXfQUCVKB32Pg0BrxECXQrr-hhiHrj2Dj4X5XP_YnTVmYtg>
    <xmx:Jl5vYMz3k3eAkRrNExz_9VbjJwZaNSmYvEmG8zAHrWNRvGbiVbI2Hw>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8FD711080057;
        Thu,  8 Apr 2021 15:48:51 -0400 (EDT)
Date:   Thu, 8 Apr 2021 12:48:49 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408194849.wmueo74qcxghhf2d@dlxu-fedora-R90QNFJV>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
 <20210408061401.GI2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408061401.GI2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 07:14:01AM +0100, Matthew Wilcox wrote:
> On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:
> > +struct bpf_iter_seq_pagecache_info {
> > +	struct mnt_namespace *ns;
> > +	struct radix_tree_root superblocks;
> 
> Why are you adding a new radix tree?  Use an XArray instead.

Ah right, sorry. Will do.

> > +static struct page *goto_next_page(struct bpf_iter_seq_pagecache_info *info)
> > +{
> > +	struct page *page, *ret = NULL;
> > +	unsigned long idx;
> > +
> > +	rcu_read_lock();
> > +retry:
> > +	BUG_ON(!info->cur_inode);
> > +	ret = NULL;
> > +	xa_for_each_start(&info->cur_inode->i_data.i_pages, idx, page,
> > +			  info->cur_page_idx) {
> > +		if (!page_cache_get_speculative(page))
> > +			continue;
> 
> Why do you feel the need to poke around in i_pages directly?  Is there
> something wrong with find_get_entries()?

No reason other than I didn't know about the latter. Thanks for the
hint. find_get_entries() seems to return a pagevec of entries which
would complicate the iteration (a 4th layer of things to iterate over).

But I did find find_get_pages_range() which I think can be used to find
1 page at a time. I'll look into it further.

> > +static int __pagecache_seq_show(struct seq_file *seq, struct page *page,
> > +				bool in_stop)
> > +{
> > +	struct bpf_iter_meta meta;
> > +	struct bpf_iter__pagecache ctx;
> > +	struct bpf_prog *prog;
> > +
> > +	meta.seq = seq;
> > +	prog = bpf_iter_get_info(&meta, in_stop);
> > +	if (!prog)
> > +		return 0;
> > +
> > +	meta.seq = seq;
> > +	ctx.meta = &meta;
> > +	ctx.page = page;
> > +	return bpf_iter_run_prog(prog, &ctx);
> 
> I'm not really keen on the idea of random BPF programs being able to poke
> at pages in the page cache like this.  From your initial description,
> it sounded like all you needed was a list of which pages are present.

Could you elaborate on what "list of which pages are present" implies?
The overall goal with this patch is to detect duplicate content in the
page cache. So anything that helps achieve that goal I would (in theory)
be OK with.

My understanding is the user would need to hash the contents
of each page in the page cache. And BPF provides the flexibility such
that this work could be reused for currently unanticipated use cases.

Furthermore, bpf programs could already look at all the pages in the
page cache by hooking into tracepoint:filemap:mm_filemap_add_to_page_cache,
albeit at a much slower rate. I figure the downside of adding this
page cache iterator is we're explicitly condoning the behavior.

> > +	INIT_RADIX_TREE(&info->superblocks, GFP_KERNEL);
> > +
> > +	spin_lock(&info->ns->ns_lock);
> > +	list_for_each_entry(mnt, &info->ns->list, mnt_list) {
> > +		sb = mnt->mnt.mnt_sb;
> > +
> > +		/* The same mount may be mounted in multiple places */
> > +		if (radix_tree_lookup(&info->superblocks, (unsigned long)sb))
> > +			continue;
> > +
> > +		err = radix_tree_insert(&info->superblocks,
> > +				        (unsigned long)sb, (void *)1);
> > +		if (err)
> > +			goto out;
> > +	}
> > +
> > +	radix_tree_for_each_slot(slot, &info->superblocks, &iter, 0) {
> > +		sb = (struct super_block *)iter.index;
> > +		atomic_inc(&sb->s_active);
> > +	}
> 
> Uh.  What on earth made you think this was a good way to use the radix
> tree?  And, no, the XArray doesn't change that.

The idea behind the radix tree was to deduplicate the mounts by
superblock. Because a single filesystem may be mounted in different
locations. I didn't find a set data structure I could reuse so I
figured radix tree / xarray would work too.

Happy to take any better ideas too.

> If you don't understand why this is so bad, call xa_dump() on it after
> constructing it.  I'll wait.

I did a dump and got the following results: http://ix.io/2VpY .

I receieved a hint that you may be referring to how the xarray/radix
tree would be as large as the largest pointer. To my uneducated eye it
doesn't look like that's the case in this dump. Could you please
clarify?

<...>

Thanks,
Daniel
