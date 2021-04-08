Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7C358EB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhDHUtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 16:49:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37427 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbhDHUtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:49:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CEA125C011A;
        Thu,  8 Apr 2021 16:49:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Apr 2021 16:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=MQtSHPJqtnoPnzsLmLnzXyuX+LY
        DZOGWduO0MWZnQ4w=; b=V0/BROVaZviWOXWayii4M2rCj+aWENTi/HG+cw32BK6
        JwhVkZg2PDP75XW8rAo4GS1xZQZ2ILRd2l4ZimrvbLdGYbv7IBIqsn/+paoScYUG
        QwhDVizRXDtp0qp8MNmLjSmqdq8BgOwXeHbrM5ZARicn8lvD2Mr1pUkvlH1eI/p8
        WQLiLuzD66Crf5G/8F2h86YpLZ3KDJi7uZyldlvPb754gQozWoKp8a1ihrPC5qYS
        KpqpSoFUTxkxY5sPylqoIMRnordMt8jczn6Ci9kFJbwMOpMp+Blh+UzjvOlVCkZP
        vMERXaRuzac1ndSim1CPUVvwG1btvbTxGq4GXHR0g7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MQtSHP
        JqtnoPnzsLmLnzXyuX+LYDZOGWduO0MWZnQ4w=; b=BL1kxNiYfljceJuJ5rR2GA
        21qCSxk5t0DAhehulEWmXzDETz/h5OX//HNTnOdDXwsvTacRu49pWW53U6vLPyx+
        kdm15sbFdteNVvZnUzlp/YlauBg8pDZ2+WSfxQmFdOVK/0Ne/LOm1BY8zjw6kFIF
        XJF/+2vF0ZQLSeKW1T9a0VizAP/RmVqAJ7cXdx+RSOlKQnzNirp/1rNGIJgE9ZWR
        t77Ehod/E5YrDajk2Sxe+jvEJWnqZRAvXj8s6/N28UEyuEc246JuL6ELoyCMiRO+
        h7sxP2a/X2dJLPQdumIhEaIX6KfAcsWrQ8bbCziVGQ7aSOuYH08TdSvQ4XbUUxKA
        ==
X-ME-Sender: <xms:Y2xvYJRA8C-R_T2zMFhSdB-ii3EdQo_bbU9-UyexhSQew2JLnXC2cA>
    <xme:Y2xvYCyTtmvQEAmnEsyKPZhIl_L73u651BvpndHMwvxKUmYNGMMRzGdwrllMlOZMY
    4osvWdl-Wi8eQuOQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejledgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeduieefrdduudegrddufedvrddunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:Y2xvYO2J5rCQ6QmqQS_fKv_kxSIDpHKVSVcAed8aeP4bD7yXtKKq0g>
    <xmx:Y2xvYBAUc2M6Tg2Bizo_JMFUldfxGze3X63Bkts1o5aVintRH8-kLg>
    <xmx:Y2xvYCivCVfyDh0l05GYqefJjfYGOLxLEReAOm9Ct23Eoqvwqn4Edg>
    <xmx:Y2xvYNXy_nr7lHZRpZ8hObQOVGL_oIF324qBSoPgXUTt2I-_anLi4g>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0BD031080063;
        Thu,  8 Apr 2021 16:49:36 -0400 (EDT)
Date:   Thu, 8 Apr 2021 13:49:35 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408204935.4itnxm4ekdv7zlrw@dlxu-fedora-R90QNFJV>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
 <YG8zMV59hSzpCHSn@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG8zMV59hSzpCHSn@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:45:37PM +0000, Al Viro wrote:
> On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:
> 
> > +static void fini_seq_pagecache(void *priv_data)
> > +{
> > +	struct bpf_iter_seq_pagecache_info *info = priv_data;
> > +	struct radix_tree_iter iter;
> > +	struct super_block *sb;
> > +	void **slot;
> > +
> > +	radix_tree_for_each_slot(slot, &info->superblocks, &iter, 0) {
> > +		sb = (struct super_block *)iter.index;
> > +		atomic_dec(&sb->s_active);
> > +		radix_tree_delete(&info->superblocks, iter.index);
> > +	}
> 
> ... and if in the meanwhile all other contributors to ->s_active have
> gone away, that will result in...?

Ah right, sorry. Nobody will clean up the super_block.

> IOW, NAK.  The objects you are playing with have non-trivial lifecycle
> and poking into the guts of data structures without bothering to
> understand it is not a good idea.
> 
> Rule of the thumb: if your code ends up using fields that are otherwise
> handled by a small part of codebase, the odds are that you need to be
> bloody careful.  In particular, ->ns_lock has 3 users - all in
> fs/namespace.c.  ->list/->mnt_list: all users in fs/namespace.c and
> fs/pnode.c.  ->s_active: majority in fs/super.c, with several outliers
> in filesystems and safety of those is not trivial.
> 
> Any time you see that kind of pattern, you are risking to reprise
> a scene from The Modern Times - the one with Charlie taking a trip
> through the guts of machinery.

I'll take a closer look at the lifetime semantics.

Hopefully the overall goal of the patch is ok. Happy to iterate on the
implementation details until it's correct.

Thanks,
Daniel
