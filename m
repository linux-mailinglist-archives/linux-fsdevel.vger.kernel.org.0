Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6465F5DAB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 03:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfGCBYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 21:24:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56265 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfGCBYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:24:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DE3F921FC5;
        Tue,  2 Jul 2019 21:24:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 02 Jul 2019 21:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        pVI22is6JO53wiZeKX9orH1tH3EcKd0M9Qk5pUYGmz0=; b=QItggmVaCyufNw3o
        /95vT5695PevmXfDp/PHA5E7MaN9KfbMw3ZneCWWL7t0iFS7QOtEoPVlnm2vSlyw
        C0JUc5byfsYPlgb9FRdODsk2VPWx3FgNtplNDDs/aQDO/KwTMsZQTU0prKgIYzD9
        xUjtbGaXHE0VWv+BaaSlb5xbOz5COW3WQpSLOY1ZUNjvrn7w76TTXU/aEuGsU5mb
        Z9u2vMQOVfr2CbXS8lMBesxvBmBlZA0ruD0Do62BkwIJMraGd/yfXMs8KLJoWclf
        iUlpNf2DLVa53z7+63c2WAjtaUDJvWJ2sXqXhWwV24EzJrQTLnTbF/MlSB9tXpR7
        0jHyNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pVI22is6JO53wiZeKX9orH1tH3EcKd0M9Qk5pUYGm
        z0=; b=ZhFxubvHT1vsXcvj/Zr9QHUi7dK9Zch+ARwj4eFkkl8VOFPiLtvBAsIqF
        i1skt4q2l4HIUEG7HfYsDvuKeZx50YqathHBNAphVCaUAFrvRNDQnMJicERlOetQ
        /+FwykjEUSmzXGuuZQ9AuqOC1PnkRUoMAwYP/EvZjXl3x0FVl++0bQ3A6PaKMAI/
        S2JrPidStsfE+EVWeWGkD41crT4QSgbemXLskxpJuFJqYLb9rJ/ZjrAeieFLaIuA
        28ys2SkQEV4wq7lIEPeLyObRiJNc+hayqCARi7W2b7YtxNOPtj+FEzPZ1T4YLImT
        x/hvnWxH2oQqv1oGz6gAuKrtUrHow==
X-ME-Sender: <xms:zQMcXUULUfoNl5XkFNDfbduOQBYCTJcrzySdOCeV3p1II8AQ_EgP0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrvdelgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    dujeegrdeiudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:zQMcXX0C9MJeHilckyGlfFrIzLAd4OnaB85JUH04KZBwzguVQ_Mh5g>
    <xmx:zQMcXbNRvAePR97KooMz9xXGakAiTUS0IDWeEasKbtySoyiknIKY4w>
    <xmx:zQMcXa1ya4R0aj5Eq-FdHtKutkQtIaLiurSXNqELyiIR9nGfqnuvCg>
    <xmx:zQMcXd6yrEzjUC27C7TZgZUtRKCUHX2qkZK4tYEYT0FVO48PENaQyA>
Received: from pluto.themaw.net (unknown [118.208.174.61])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE231380083;
        Tue,  2 Jul 2019 21:24:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 85D991C014E;
        Wed,  3 Jul 2019 09:24:25 +0800 (AWST)
Message-ID: <2daf229272884deaf139be510f5842f0689c18a6.camel@themaw.net>
Subject: Re: [PATCH 4/6] vfs: Allow mount information to be queried by
 fsinfo() [ver #15]
From:   Ian Kent <raven@themaw.net>
To:     christian@brauner.io, David Howells <dhowells@redhat.com>,
        viro@zeniv.linux.org.uk
Cc:     mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Jul 2019 09:24:25 +0800
In-Reply-To: <8c70abf248d5ac07f334730af70d64235185b109.camel@themaw.net>
References: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
         <156173685496.14728.9606180227161368035.stgit@warthog.procyon.org.uk>
         <8c70abf248d5ac07f334730af70d64235185b109.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-07-03 at 09:09 +0800, Ian Kent wrote:
> Hi Christian,
> 
> About the propagation attributes you mentioned ...

Umm ... how did you work out if a mount is unbindable from proc
mountinfo?

I didn't notice anything that could be used for that when I was
looking at this.

> 
> On Fri, 2019-06-28 at 16:47 +0100, David Howells wrote:
> 
> snip ...
> 
> > +
> > +#ifdef CONFIG_FSINFO
> > +int fsinfo_generic_mount_info(struct path *path, struct fsinfo_kparams
> > *params)
> > +{
> > +	struct fsinfo_mount_info *p = params->buffer;
> > +	struct super_block *sb;
> > +	struct mount *m;
> > +	struct path root;
> > +	unsigned int flags;
> > +
> > +	if (!path->mnt)
> > +		return -ENODATA;
> > +
> > +	m = real_mount(path->mnt);
> > +	sb = m->mnt.mnt_sb;
> > +
> > +	p->f_sb_id		= sb->s_unique_id;
> > +	p->mnt_id		= m->mnt_id;
> > +	p->parent_id		= m->mnt_parent->mnt_id;
> > +	p->change_counter	= atomic_read(&m->mnt_change_counter);
> > +
> > +	get_fs_root(current->fs, &root);
> > +	if (path->mnt == root.mnt) {
> > +		p->parent_id = p->mnt_id;
> > +	} else {
> > +		rcu_read_lock();
> > +		if (!are_paths_connected(&root, path))
> > +			p->parent_id = p->mnt_id;
> > +		rcu_read_unlock();
> > +	}
> > +	if (IS_MNT_SHARED(m))
> > +		p->group_id = m->mnt_group_id;
> > +	if (IS_MNT_SLAVE(m)) {
> > +		int master = m->mnt_master->mnt_group_id;
> > +		int dom = get_dominating_id(m, &root);
> > +		p->master_id = master;
> > +		if (dom && dom != master)
> > +			p->from_id = dom;
> 
> This provides information about mount propagation (well mostly).
> 
> My understanding of this was that:
> "If a mount is propagation private (or slave) the group_id will
> be zero otherwise it's propagation shared and it's group id will
> be non-zero.
> 
> If a mount is propagation slave and propagation peers exist then
> the mount field mnt_master will be non-NULL. Then mnt_master
> (slave's master) can be used to set master_id. If the group id
> of the propagation source is not that of the master then set
> the from_id group as well."
> 
> This parallels the way in which these values are reported in
> the proc pseudo file system.
> 
> Perhaps adding flags as well as setting the fields would be
> useful too, since interpreting the meaning of the structure
> fields isn't obvious, ;)
> 
> David, Al, thoughts?
> 
> Ian

