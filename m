Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99257358EA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 22:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhDHUo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 16:44:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54487 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDHUo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:44:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CBA175C00AC;
        Thu,  8 Apr 2021 16:44:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Apr 2021 16:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qd99tIwkyY/yAuS+FY1nRWCDzMJ
        lvE3kBmaqzDP5T8I=; b=d5RbFQyskd2jDEewPuVtIYXhbjKJ0C3OJApXeMJmzQ5
        QGU1zt28aKnfc2TKMx4BeCxELRQ6XFdHyN7aztL9bl+977LdnZ0YjRQep++GFj32
        vvJl0VC2caDQ/SnpdOfbS1Ua4E3mJAw6nFFsXtuB77ePRBMRsNlMVb+AAVElAD4b
        dTTyWJNw27ZMuPrOl50w6omLbRepdkP40KdXU9x2/9FQF4KYtCGZHytpm/TM3HCr
        MrnC4cmftk1rwJMfllap1/FtDCugbbEY8vh9xcPJsDhqJw7XTuzlh7veA33W+uY0
        DL1mqpUKY6oNp+S2JTw/AUnVeIWgFn9c5W6cfEMg0hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qd99tI
        wkyY/yAuS+FY1nRWCDzMJlvE3kBmaqzDP5T8I=; b=SDh4cvheVbh2qDob+ss9qD
        +FD9wwn4xZsrkMHujv7PmqPYsEeMTwnDJ+vINSAVHbu4jHq2r39NuiyTiiIBatZs
        Ndud9QH6jCxsN6qKbrLHaQEfh5p0mUNgcij3+IM2xi7IZt5p9jkKZJk8gIsqYxkI
        Tae/IIvDRsouOAOzO9/FVfdqvxrPJlNkYkIctwGZPoc3ZoL+fZMV/lvwkwPdqOnb
        C6UP4UQRILccy4TOuJO3AKjbyoOUIuWZCNPgwKOoBRBe5/WwKFbc8RVa3F7W8wQx
        hrQ/b+6ccZ84wrkaJQSAa5LcPRCjtVruv8wrqflGoI//D1eiHO7wYi+HT8Nr75bQ
        ==
X-ME-Sender: <xms:H2tvYK7hDuVvRYZQa8BpuLFO8hkoPJdan5ew_HwPaYXoW5Sam7pWeg>
    <xme:H2tvYD3s9T6lffHebe8KOw4uLxn7ka8cq3UToaYK4F1MqX0u1Fv3rQuNNpf4-9DHy
    hR22zs37r96BIplmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeduieefrdduudegrddufedvrddunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:H2tvYGVZVRDHsdcyZ4XwA88XmJMpJm3bbMua5fjnHUVtlP2MM4Iuhg>
    <xmx:H2tvYO66bmMCSoV44an8XyaPyRcVU3xPpW9djcQuGP6Y9YrQNlAe5g>
    <xmx:H2tvYNJ0fpje33fosaQ2Tm6G_BD4Si9BtHFUgdzRSJpSAj_Kq4eG3w>
    <xmx:H2tvYO_E4TXJTWpm6IPWiAkv1uLGnHEvlMpIyZPflRbvItFwhR4o2w>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5B3F1080066;
        Thu,  8 Apr 2021 16:44:12 -0400 (EDT)
Date:   Thu, 8 Apr 2021 13:44:10 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408204410.wszz3rjmqbg4ps3q@dlxu-fedora-R90QNFJV>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
 <20210408081935.b3xollrzl6lejbyf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408081935.b3xollrzl6lejbyf@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:19:35AM +0200, Christian Brauner wrote:
> On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:
> > This commit introduces the bpf page cache iterator. This iterator allows
> > users to run a bpf prog against each page in the "page cache".
> > Internally, the "page cache" is extremely tied to VFS superblock + inode
> > combo. Because of this, iter_pagecache will only examine pages in the
> > caller's mount namespace.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  kernel/bpf/Makefile         |   2 +-
> >  kernel/bpf/pagecache_iter.c | 293 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 294 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/bpf/pagecache_iter.c

<...>

> > 
> > +static int init_seq_pagecache(void *priv_data, struct bpf_iter_aux_info *aux)
> > +{
> > +	struct bpf_iter_seq_pagecache_info *info = priv_data;
> > +	struct radix_tree_iter iter;
> > +	struct super_block *sb;
> > +	struct mount *mnt;
> > +	void **slot;
> > +	int err;
> > +
> > +	info->ns = current->nsproxy->mnt_ns;
> > +	get_mnt_ns(info->ns);
> > +	INIT_RADIX_TREE(&info->superblocks, GFP_KERNEL);
> > +
> > +	spin_lock(&info->ns->ns_lock);
> > +	list_for_each_entry(mnt, &info->ns->list, mnt_list) {
> 
> Not just are there helpers for taking ns_lock
> static inline void lock_ns_list(struct mnt_namespace *ns)
> static inline void unlock_ns_list(struct mnt_namespace *ns)
> they are private to fs/namespace.c because it's the only place that
> should ever walk this list.

Thanks for the hints. Would it be acceptable to add some helpers to
fs/namespace.c to allow walking the list?

IIUC the only way to find a list of mounts is by looking at the mount
namespace. And walking each mount and looking at each `struct
super_node`'s inode's `struct address_space` seemed like the cleanest
way to walkthe page cache.

> This seems buggy: why is it ok here to only take ns_lock and not also
> namespace_sem like mnt_already_visible() and __is_local_mountpoint()
> or the relevant proc iterators? I might be missing something.

Thanks for the hints. I'll take a closer look at the locking. Most
probably I didn't get it right.

I should have also mentioned in the cover letter that I'm fairly sure I
messed up the locking somewhere.

> 
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
> 
> It also isn't nice that you mess with sb->s_active directly.
> 
> Imho, this is poking around in a lot of fs/ specific stuff that other
> parts of the kernel should not care about or have access to.

Re above: do you think it'd be appropriate to add more helpers to fs/ ?

<...>

Thanks,
Daniel
