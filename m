Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39E39A3AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFCOwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 10:52:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59368 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:52:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1loogd-000T5b-6m; Thu, 03 Jun 2021 08:51:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1loogc-000VSc-41; Thu, 03 Jun 2021 08:51:06 -0600
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
        <162218363530.34379.16741129191900256265.stgit@web.messagingengine.com>
Date:   Thu, 03 Jun 2021 09:50:34 -0500
In-Reply-To: <162218363530.34379.16741129191900256265.stgit@web.messagingengine.com>
        (Ian Kent's message of "Fri, 28 May 2021 14:33:55 +0800")
Message-ID: <87im2vq9xh.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1loogc-000VSc-41;;;mid=<87im2vq9xh.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/bKCwWNjTqbcYtNY+PUXv6nJdZuHoj4m4=
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
X-Spam-Timing: total 543 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.71
        (0.3%), extract_message_metadata: 21 (3.8%), get_uri_detail_list: 3.6
        (0.7%), tests_pri_-1000: 7 (1.3%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 71 (13.1%), check_bayes:
        70 (12.8%), b_tokenize: 11 (2.1%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 44 (8.2%), b_finish: 1.00
        (0.2%), tests_pri_0: 403 (74.2%), check_dkim_signature: 0.90 (0.2%),
        check_dkim_adsp: 3.5 (0.6%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 18 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REPOST PATCH v4 1/5] kernfs: move revalidate to be near lookup
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> writes:

> While the dentry operation kernfs_dop_revalidate() is grouped with
> dentry type functions it also has a strong affinity to the inode
> operation ->lookup().
>
> In order to take advantage of the VFS negative dentry caching that
> can be used to reduce path lookup overhead on non-existent paths it
> will need to call kernfs_find_ns(). So, to avoid a forward declaration,
> move it to be near kernfs_iop_lookup().
>
> There's no functional change from this patch.

Does this patch compile independently?

During the code movement  kernfs_active is replaced
by kernfs_active_read which does not exist yet.

Eric

> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |   86 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 7e0e62deab53c..4c69e2af82dac 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -548,49 +548,6 @@ void kernfs_put(struct kernfs_node *kn)
>  }
>  EXPORT_SYMBOL_GPL(kernfs_put);
>  
> -static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
> -{
> -	struct kernfs_node *kn;
> -
> -	if (flags & LOOKUP_RCU)
> -		return -ECHILD;
> -
> -	/* Always perform fresh lookup for negatives */
> -	if (d_really_is_negative(dentry))
> -		goto out_bad_unlocked;
> -
> -	kn = kernfs_dentry_node(dentry);
> -	mutex_lock(&kernfs_mutex);
> -
> -	/* The kernfs node has been deactivated */
> -	if (!kernfs_active(kn))
> -		goto out_bad;
> -
> -	/* The kernfs node has been moved? */
> -	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
> -		goto out_bad;
> -
> -	/* The kernfs node has been renamed */
> -	if (strcmp(dentry->d_name.name, kn->name) != 0)
> -		goto out_bad;
> -
> -	/* The kernfs node has been moved to a different namespace */
> -	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
> -	    kernfs_info(dentry->d_sb)->ns != kn->ns)
> -		goto out_bad;
> -
> -	mutex_unlock(&kernfs_mutex);
> -	return 1;
> -out_bad:
> -	mutex_unlock(&kernfs_mutex);
> -out_bad_unlocked:
> -	return 0;
> -}
> -
> -const struct dentry_operations kernfs_dops = {
> -	.d_revalidate	= kernfs_dop_revalidate,
> -};
> -
>  /**
>   * kernfs_node_from_dentry - determine kernfs_node associated with a dentry
>   * @dentry: the dentry in question
> @@ -1073,6 +1030,49 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
>  	return ERR_PTR(rc);
>  }
>  
> +static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
> +{
> +	struct kernfs_node *kn;
> +
> +	if (flags & LOOKUP_RCU)
> +		return -ECHILD;
> +
> +	/* Always perform fresh lookup for negatives */
> +	if (d_really_is_negative(dentry))
> +		goto out_bad_unlocked;
> +
> +	kn = kernfs_dentry_node(dentry);
> +	mutex_lock(&kernfs_mutex);
> +
> +	/* The kernfs node has been deactivated */
> +	if (!kernfs_active_read(kn))
> +		goto out_bad;
> +
> +	/* The kernfs node has been moved? */
> +	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
> +		goto out_bad;
> +
> +	/* The kernfs node has been renamed */
> +	if (strcmp(dentry->d_name.name, kn->name) != 0)
> +		goto out_bad;
> +
> +	/* The kernfs node has been moved to a different namespace */
> +	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
> +	    kernfs_info(dentry->d_sb)->ns != kn->ns)
> +		goto out_bad;
> +
> +	mutex_unlock(&kernfs_mutex);
> +	return 1;
> +out_bad:
> +	mutex_unlock(&kernfs_mutex);
> +out_bad_unlocked:
> +	return 0;
> +}
> +
> +const struct dentry_operations kernfs_dops = {
> +	.d_revalidate	= kernfs_dop_revalidate,
> +};
> +
>  static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  					struct dentry *dentry,
>  					unsigned int flags)
