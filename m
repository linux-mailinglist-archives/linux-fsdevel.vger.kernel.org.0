Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E322FC6E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 02:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbhATBhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 20:37:02 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:36010 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbhATBgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:36:48 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l22Pf-000s1Q-M7; Tue, 19 Jan 2021 18:35:59 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l22Pe-00Aw4B-Ln; Tue, 19 Jan 2021 18:35:59 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
        <20210119162204.2081137-3-mszeredi@redhat.com>
Date:   Tue, 19 Jan 2021 19:34:49 -0600
In-Reply-To: <20210119162204.2081137-3-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Tue, 19 Jan 2021 17:22:04 +0100")
Message-ID: <8735yw8k7a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l22Pe-00Aw4B-Ln;;;mid=<8735yw8k7a.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ENBj119UF+ufFlQellSdzGmdBO3hQ/RE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 487 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.2%), parse: 1.54
        (0.3%), extract_message_metadata: 15 (3.2%), get_uri_detail_list: 3.0
        (0.6%), tests_pri_-1000: 14 (2.8%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 78 (16.1%), check_bayes:
        77 (15.8%), b_tokenize: 10 (2.0%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 52 (10.8%), b_finish: 0.90
        (0.2%), tests_pri_0: 342 (70.3%), check_dkim_signature: 0.66 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.61 (0.1%), tests_pri_10:
        3.2 (0.7%), tests_pri_500: 14 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> If a capability is stored on disk in v2 format cap_inode_getsecurity() will
> currently return in v2 format unconditionally.
>
> This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
> and so the same conversions performed on it.
>
> If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
> that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
> user namespace in case of v2) cannot be mapped in the current user
> namespace.

This looks like a good cleanup.

I do wonder how well this works with stacking.  In particular
ovl_xattr_set appears to call vfs_getxattr without overriding the creds.
What the purpose of that is I haven't quite figured out.  It looks like
it is just a probe to see if an xattr is present so maybe it is ok.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
>  1 file changed, 43 insertions(+), 24 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index bacc1111d871..c9d99f8f4c82 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -371,10 +371,11 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  {
>  	int size, ret;
>  	kuid_t kroot;
> +	__le32 nsmagic, magic;
>  	uid_t root, mappedroot;
>  	char *tmpbuf = NULL;
>  	struct vfs_cap_data *cap;
> -	struct vfs_ns_cap_data *nscap;
> +	struct vfs_ns_cap_data *nscap = NULL;
>  	struct dentry *dentry;
>  	struct user_namespace *fs_ns;
>  
> @@ -396,46 +397,61 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  	fs_ns = inode->i_sb->s_user_ns;
>  	cap = (struct vfs_cap_data *) tmpbuf;
>  	if (is_v2header((size_t) ret, cap)) {
> -		/* If this is sizeof(vfs_cap_data) then we're ok with the
> -		 * on-disk value, so return that.  */
> -		if (alloc)
> -			*buffer = tmpbuf;
> -		else
> -			kfree(tmpbuf);
> -		return ret;
> -	} else if (!is_v3header((size_t) ret, cap)) {
> -		kfree(tmpbuf);
> -		return -EINVAL;
> +		root = 0;
> +	} else if (is_v3header((size_t) ret, cap)) {
> +		nscap = (struct vfs_ns_cap_data *) tmpbuf;
> +		root = le32_to_cpu(nscap->rootid);
> +	} else {
> +		size = -EINVAL;
> +		goto out_free;
>  	}
>  
> -	nscap = (struct vfs_ns_cap_data *) tmpbuf;
> -	root = le32_to_cpu(nscap->rootid);
>  	kroot = make_kuid(fs_ns, root);
>  
>  	/* If the root kuid maps to a valid uid in current ns, then return
>  	 * this as a nscap. */
>  	mappedroot = from_kuid(current_user_ns(), kroot);
>  	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
> +		size = sizeof(struct vfs_ns_cap_data);
>  		if (alloc) {
> -			*buffer = tmpbuf;
> +			if (!nscap) {
> +				/* v2 -> v3 conversion */
> +				nscap = kzalloc(size, GFP_ATOMIC);
> +				if (!nscap) {
> +					size = -ENOMEM;
> +					goto out_free;
> +				}
> +				nsmagic = VFS_CAP_REVISION_3;
> +				magic = le32_to_cpu(cap->magic_etc);
> +				if (magic & VFS_CAP_FLAGS_EFFECTIVE)
> +					nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
> +				memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
> +				nscap->magic_etc = cpu_to_le32(nsmagic);
> +			} else {
> +				/* use allocated v3 buffer */
> +				tmpbuf = NULL;
> +			}
>  			nscap->rootid = cpu_to_le32(mappedroot);
> -		} else
> -			kfree(tmpbuf);
> -		return size;
> +			*buffer = nscap;
> +		}
> +		goto out_free;
>  	}
>  
>  	if (!rootid_owns_currentns(kroot)) {
> -		kfree(tmpbuf);
> -		return -EOPNOTSUPP;
> +		size = -EOVERFLOW;
> +		goto out_free;
>  	}
>  
>  	/* This comes from a parent namespace.  Return as a v2 capability */
>  	size = sizeof(struct vfs_cap_data);
>  	if (alloc) {
> -		*buffer = kmalloc(size, GFP_ATOMIC);
> -		if (*buffer) {
> -			struct vfs_cap_data *cap = *buffer;
> -			__le32 nsmagic, magic;
> +		if (nscap) {
> +			/* v3 -> v2 conversion */
> +			cap = kzalloc(size, GFP_ATOMIC);
> +			if (!cap) {
> +				size = -ENOMEM;
> +				goto out_free;
> +			}
>  			magic = VFS_CAP_REVISION_2;
>  			nsmagic = le32_to_cpu(nscap->magic_etc);
>  			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
> @@ -443,9 +459,12 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
>  			cap->magic_etc = cpu_to_le32(magic);
>  		} else {
> -			size = -ENOMEM;
> +			/* use unconverted v2 */
> +			tmpbuf = NULL;
>  		}
> +		*buffer = cap;
>  	}
> +out_free:
>  	kfree(tmpbuf);
>  	return size;
>  }
