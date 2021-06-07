Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04E339E6A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 20:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFGS3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 14:29:46 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34210 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhFGS3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:29:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lqJya-00GKWZ-4h; Mon, 07 Jun 2021 12:27:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lqJyK-009rTo-DI; Mon, 07 Jun 2021 12:27:51 -0600
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
        <162306072498.69474.16160057168984328507.stgit@web.messagingengine.com>
Date:   Mon, 07 Jun 2021 13:27:29 -0500
In-Reply-To: <162306072498.69474.16160057168984328507.stgit@web.messagingengine.com>
        (Ian Kent's message of "Mon, 07 Jun 2021 18:12:05 +0800")
Message-ID: <87lf7lil7y.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lqJyK-009rTo-DI;;;mid=<87lf7lil7y.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+BKBqvpHqVOC8NchFOFOsF2zTFLLCvskI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ian Kent <raven@themaw.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15036 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (0.1%), b_tie_ro: 9 (0.1%), parse: 0.94 (0.0%),
         extract_message_metadata: 12 (0.1%), get_uri_detail_list: 1.44 (0.0%),
         tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 1.38 (0.0%),
        tests_pri_-900: 1.03 (0.0%), tests_pri_-90: 121 (0.8%), check_bayes:
        120 (0.8%), b_tokenize: 8 (0.1%), b_tok_get_all: 7 (0.0%),
        b_comp_prob: 2.4 (0.0%), b_tok_touch_all: 95 (0.6%), b_finish: 0.92
        (0.0%), tests_pri_0: 6319 (42.0%), check_dkim_signature: 0.87 (0.0%),
        check_dkim_adsp: 6008 (40.0%), poll_dns_idle: 14555 (96.8%),
        tests_pri_10: 2.1 (0.0%), tests_pri_500: 8561 (56.9%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v5 3/6] kernfs: use VFS negative dentry caching
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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
> Use the kernfs node parent revision to identify if a change has been
> made to the containing directory so that the negative dentry can be
> discarded and the lookup redone.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |   53 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index b88432c48851f..5ae95e8d1aea1 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1039,13 +1039,32 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
>  
> -	/* Always perform fresh lookup for negatives */
> -	if (d_really_is_negative(dentry))
> -		goto out_bad_unlocked;
> -
>  	kn = kernfs_dentry_node(dentry);
>  	mutex_lock(&kernfs_mutex);
>  
> +	/* Negative hashed dentry? */
> +	if (!kn) {
> +		struct dentry *d_parent = dget_parent(dentry);
> +		struct kernfs_node *parent;
> +
> +		/* If the kernfs parent node has changed discard and
> +		 * proceed to ->lookup.
> +		 */
> +		parent = kernfs_dentry_node(d_parent);
> +		if (parent) {
> +			if (kernfs_dir_changed(parent, dentry)) {
> +				dput(d_parent);
> +				goto out_bad;
> +			}
> +		}
> +		dput(d_parent);
> +
> +		/* The kernfs node doesn't exist, leave the dentry
> +		 * negative and return success.
> +		 */
> +		goto out;
> +	}

What part of this new negative hashed dentry check needs the
kernfs_mutex?

I guess it is the reading of kn->dir.rev.

Since all you are doing is comparing if two fields are equal it
really should not matter.  Maybe somewhere there needs to be a
sprinkling of primitives like READ_ONCE.

It just seems like such a waste to put all of that under kernfs_mutex
on the off chance kn->dir.rev will change while it is being read.

Eric
