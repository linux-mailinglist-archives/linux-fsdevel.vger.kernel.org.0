Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD839A922
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFCR2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 13:28:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44328 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhFCR2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:28:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lor79-000mX8-2C; Thu, 03 Jun 2021 11:26:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lor76-001AUG-Q2; Thu, 03 Jun 2021 11:26:38 -0600
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
        <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
Date:   Thu, 03 Jun 2021 12:26:30 -0500
In-Reply-To: <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
        (Ian Kent's message of "Fri, 28 May 2021 14:34:05 +0800")
Message-ID: <87czt2q2pl.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lor76-001AUG-Q2;;;mid=<87czt2q2pl.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18V/U3vc+8ginDH12+uNQJ0nulcXisbRXE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ian Kent <raven@themaw.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1613 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 9 (0.5%), parse: 1.26 (0.1%),
         extract_message_metadata: 14 (0.9%), get_uri_detail_list: 2.2 (0.1%),
        tests_pri_-1000: 13 (0.8%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 185 (11.5%), check_bayes:
        183 (11.4%), b_tokenize: 10 (0.6%), b_tok_get_all: 8 (0.5%),
        b_comp_prob: 2.7 (0.2%), b_tok_touch_all: 159 (9.9%), b_finish: 0.83
        (0.1%), tests_pri_0: 1372 (85.1%), check_dkim_signature: 0.70 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 0.92 (0.1%), tests_pri_10:
        3.2 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> writes:

> If there are many lookups for non-existent paths these negative lookups
> can lead to a lot of overhead during path walks.
>
> The VFS allows dentries to be created as negative and hashed, and caches
> them so they can be used to reduce the fairly high overhead alloc/free
> cycle that occurs during these lookups.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 4c69e2af82dac..5151c712f06f5 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
>  
> -	/* Always perform fresh lookup for negatives */
> -	if (d_really_is_negative(dentry))
> -		goto out_bad_unlocked;
> +	mutex_lock(&kernfs_mutex);
>  
>  	kn = kernfs_dentry_node(dentry);
> -	mutex_lock(&kernfs_mutex);

Why bring kernfs_dentry_node inside the mutex?

The inode lock of the parent should protect negative to positive
transitions not the kernfs_mutex.  So moving the code inside
the mutex looks unnecessary and confusing.

What NFS does is to check to see if the parent has been modified
since the negative dentry was created, can't kernfs do the same
and remove the need for taking the lock until the lookup that
makes the dentry positive?

Doing the lookup twice seems strange.

Perhaps this should happen as two changes.  One change to enable
negative dentries and a second change to optimize d_revalidate
of negative dentries.  That way the issues could be clearly separated
and looked at separately.

> +
> +	/* Negative hashed dentry? */
> +	if (!kn) {
> +		struct kernfs_node *parent;
> +
> +		/* If the kernfs node can be found this is a stale negative
> +		 * hashed dentry so it must be discarded and the lookup redone.
> +		 */
> +		parent = kernfs_dentry_node(dentry->d_parent);
> +		if (parent) {
> +			const void *ns = NULL;
> +
> +			if (kernfs_ns_enabled(parent))
> +				ns = kernfs_info(dentry->d_sb)->ns;
> +			kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
> +			if (kn)
> +				goto out_bad;
> +		}
> +
> +		/* The kernfs node doesn't exist, leave the dentry negative
> +		 * and return success.
> +		 */
> +		goto out;
> +	}
>  
>  	/* The kernfs node has been deactivated */
>  	if (!kernfs_active_read(kn))
> @@ -1060,12 +1081,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>  	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
>  	    kernfs_info(dentry->d_sb)->ns != kn->ns)
>  		goto out_bad;
> -
> +out:
>  	mutex_unlock(&kernfs_mutex);
>  	return 1;
>  out_bad:
>  	mutex_unlock(&kernfs_mutex);
> -out_bad_unlocked:
>  	return 0;
>  }
>  
> @@ -1080,33 +1100,24 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  	struct dentry *ret;
>  	struct kernfs_node *parent = dir->i_private;
>  	struct kernfs_node *kn;
> -	struct inode *inode;
> +	struct inode *inode = NULL;
>  	const void *ns = NULL;
>  
>  	mutex_lock(&kernfs_mutex);
> -
>  	if (kernfs_ns_enabled(parent))
>  		ns = kernfs_info(dir->i_sb)->ns;
>  
>  	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
> -
> -	/* no such entry */
> -	if (!kn || !kernfs_active(kn)) {
> -		ret = NULL;
> -		goto out_unlock;
> -	}
> -
>  	/* attach dentry and inode */
> -	inode = kernfs_get_inode(dir->i_sb, kn);
> -	if (!inode) {
> -		ret = ERR_PTR(-ENOMEM);
> -		goto out_unlock;
> +	if (kn && kernfs_active(kn)) {
> +		inode = kernfs_get_inode(dir->i_sb, kn);
> +		if (!inode)
> +			inode = ERR_PTR(-ENOMEM);
>  	}
> -
> -	/* instantiate and hash dentry */
> +	/* instantiate and hash (possibly negative) dentry */
>  	ret = d_splice_alias(inode, dentry);
> - out_unlock:
>  	mutex_unlock(&kernfs_mutex);
> +
>  	return ret;
>  }
>  
