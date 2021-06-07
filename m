Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3523239E5EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 19:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGR4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 13:56:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59302 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFGR4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:56:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lqJRx-00HNGl-5O; Mon, 07 Jun 2021 11:54:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lqJRv-00ApD3-VN; Mon, 07 Jun 2021 11:54:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
        <162306071065.69474.8064509709844383785.stgit@web.messagingengine.com>
Date:   Mon, 07 Jun 2021 12:53:37 -0500
In-Reply-To: <162306071065.69474.8064509709844383785.stgit@web.messagingengine.com>
        (Ian Kent's message of "Mon, 07 Jun 2021 18:11:50 +0800")
Message-ID: <87a6o1k1cu.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lqJRv-00ApD3-VN;;;mid=<87a6o1k1cu.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qfqyxi2IVBqfcwTRg5iTykwxrZ/hJkEw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ian Kent <raven@themaw.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 524 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.6%), parse: 0.94 (0.2%),
         extract_message_metadata: 13 (2.5%), get_uri_detail_list: 2.4 (0.4%),
        tests_pri_-1000: 5 (1.0%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 85 (16.3%), check_bayes:
        84 (16.0%), b_tokenize: 11 (2.0%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 59 (11.2%), b_finish: 0.76
        (0.1%), tests_pri_0: 395 (75.3%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.32 (0.1%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 2/6] kernfs: add a revision to identify directory node changes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> writes:

> Add a revision counter to kernfs directory nodes so it can be used
> to detect if a directory node has changed.
>
> There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> on all architectures and as far as I know that assumption holds.
>
> So adding a revision counter to the struct kernfs_elem_dir variant of
> the kernfs_node type union won't increase the size of the kernfs_node
> struct. This is because struct kernfs_elem_dir is at least
> sizeof(pointer) smaller than the largest union variant. It's tempting
> to make the revision counter a u64 but that would increase the size of
> kernfs_node on archs where sizeof(pointer) is smaller than the revision
> counter.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c             |    8 ++++++++
>  fs/kernfs/kernfs-internal.h |   24 ++++++++++++++++++++++++
>  include/linux/kernfs.h      |    5 +++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 33166ec90a112..b88432c48851f 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
>  	/* successfully added, account subdir number */
>  	if (kernfs_type(kn) == KERNFS_DIR)
>  		kn->parent->dir.subdirs++;
> +	kernfs_inc_rev(kn->parent);
>  
>  	return 0;
>  }
> @@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
>  
>  	if (kernfs_type(kn) == KERNFS_DIR)
>  		kn->parent->dir.subdirs--;
> +	kernfs_inc_rev(kn->parent);
>  
>  	rb_erase(&kn->rb, &kn->parent->dir.children);
>  	RB_CLEAR_NODE(&kn->rb);
> @@ -1105,6 +1107,12 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  
>  	/* instantiate and hash dentry */
>  	ret = d_splice_alias(inode, dentry);
> +	if (!IS_ERR(ret)) {
> +		if (unlikely(ret))
> +			kernfs_set_rev(parent, ret);
> +		else
> +			kernfs_set_rev(parent, dentry);

Do we care about d_time on non-NULL dentries?

For d_splice_alias to return a different dentry implies
that the dentry was non-NULL.

I am wondering if having a guarantee that d_time never changes could
help simplify the implementation.  For never changing it would see to
make sense to call kernfs_set_rev before d_splice_alias on dentry, and
simply not worry about it after d_splice_alias.

> +	}
>   out_unlock:
>  	mutex_unlock(&kernfs_mutex);
>  	return ret;
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index ccc3b44f6306f..1536002584fc4 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -81,6 +81,30 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
>  	return d_inode(dentry)->i_private;
>  }
>  
> +static inline void kernfs_set_rev(struct kernfs_node *kn,
> +				  struct dentry *dentry)
> +{
> +	if (kernfs_type(kn) == KERNFS_DIR)
> +		dentry->d_time = kn->dir.rev;
> +}
> +
> +static inline void kernfs_inc_rev(struct kernfs_node *kn)
> +{
> +	if (kernfs_type(kn) == KERNFS_DIR)
> +		kn->dir.rev++;
> +}
> +
> +static inline bool kernfs_dir_changed(struct kernfs_node *kn,
> +				      struct dentry *dentry)
> +{
> +	if (kernfs_type(kn) == KERNFS_DIR) {
> +		/* Not really a time bit it does what's needed */
> +		if (time_after(kn->dir.rev, dentry->d_time))
> +			return true;

Why not simply make this:
		if (kn->dir.rev != dentry->d_time)
	        	return true;

I don't see what is gained by not counting as changed something in the
wrong half of the values.

> +	}
> +	return false;
> +}
> +
>  extern const struct super_operations kernfs_sops;
>  extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
>  
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 9e8ca8743c268..7947acb1163d7 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -98,6 +98,11 @@ struct kernfs_elem_dir {
>  	 * better directly in kernfs_node but is here to save space.
>  	 */
>  	struct kernfs_root	*root;
> +	/*
> +	 * Monotonic revision counter, used to identify if a directory
> +	 * node has changed during revalidation.
> +	 */
> +	unsigned long rev;
>  };
>  
>  struct kernfs_elem_symlink {

Eric
