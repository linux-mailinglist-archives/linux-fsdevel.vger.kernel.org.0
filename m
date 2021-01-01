Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF32E8536
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jan 2021 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhAARgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jan 2021 12:36:51 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53634 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbhAARgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jan 2021 12:36:51 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kvOLQ-00EiGv-LC; Fri, 01 Jan 2021 10:36:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kvOLP-0009RW-Il; Fri, 01 Jan 2021 10:36:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
        <20201207163255.564116-2-mszeredi@redhat.com>
Date:   Fri, 01 Jan 2021 11:35:16 -0600
In-Reply-To: <20201207163255.564116-2-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Mon, 7 Dec 2020 17:32:46 +0100")
Message-ID: <87czyoimqz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kvOLP-0009RW-Il;;;mid=<87czyoimqz.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18iUeLdjvyBTCthc4PVnPTvYUkmUHyVYDw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 539 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.8%), parse: 1.76
        (0.3%), extract_message_metadata: 8 (1.5%), get_uri_detail_list: 4.5
        (0.8%), tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.84 (0.3%),
        tests_pri_-900: 1.50 (0.3%), tests_pri_-90: 105 (19.4%), check_bayes:
        102 (19.0%), b_tokenize: 14 (2.6%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 3.3 (0.6%), b_tok_touch_all: 73 (13.6%), b_finish: 1.17
        (0.2%), tests_pri_0: 374 (69.5%), check_dkim_signature: 0.88 (0.2%),
        check_dkim_adsp: 3.1 (0.6%), poll_dns_idle: 0.90 (0.2%), tests_pri_10:
        3.9 (0.7%), tests_pri_500: 11 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> cap_convert_nscap() does permission checking as well as conversion of the
> xattr value conditionally based on fs's user-ns.
>
> This is needed by overlayfs and probably other layered fs (ecryptfs) and is
> what vfs_foo() is supposed to do anyway.

Well crap.

I just noticed this and it turns out this change is wrong.

The problem is that it reads the rootid from the v3 fscap, using
current_user_ns() and then writes it using the sb->s_user_ns.

So any time the stacked filesystems sb->s_user_ns do not match or
current_user_ns does not match sb->s_user_ns this could be a problem.

In a stacked filesystem a second pass through vfs_setxattr will result
in the rootid being translated a second time (with potentially the wrong
namespaces).  I think because of the security checks a we won't write
something we shouldn't be able to write to the filesystem.  Still we
will be writing the wrong v3 fscap which can go quite badly.

This doesn't look terribly difficult to fix.

Probably convert this into a fs independent form using uids in
init_user_ns at input and have cap_convert_nscap convert the v3 fscap
into the filesystem dependent form.  With some way for stackable
filesystems to just skip converting it from the filesystem independent
format.

Uids in xattrs that are expected to go directly to disk, but aren't
always suitable for going directly to disk are tricky.

Eric

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/xattr.c                 | 17 +++++++++++------
>  include/linux/capability.h |  2 +-
>  security/commoncap.c       |  3 +--
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index cd7a563e8bcd..fd57153b1f61 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -276,8 +276,16 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
>  {
>  	struct inode *inode = dentry->d_inode;
>  	struct inode *delegated_inode = NULL;
> +	const void  *orig_value = value;
>  	int error;
>  
> +	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
> +		error = cap_convert_nscap(dentry, &value, size);
> +		if (error < 0)
> +			return error;
> +		size = error;
> +	}
> +
>  retry_deleg:
>  	inode_lock(inode);
>  	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
> @@ -289,6 +297,9 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
>  		if (!error)
>  			goto retry_deleg;
>  	}
> +	if (value != orig_value)
> +		kfree(value);
> +
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(vfs_setxattr);
> @@ -537,12 +548,6 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
>  		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
>  		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
>  			posix_acl_fix_xattr_from_user(kvalue, size);
> -		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
> -			error = cap_convert_nscap(d, &kvalue, size);
> -			if (error < 0)
> -				goto out;
> -			size = error;
> -		}
>  	}
>  
>  	error = vfs_setxattr(d, kname, kvalue, size, flags);
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 1e7fe311cabe..b2f698915c0f 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -270,6 +270,6 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  /* audit system wants to get cap info from files as well */
>  extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
>  
> -extern int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size);
> +extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
>  
>  #endif /* !_LINUX_CAPABILITY_H */
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 59bf3c1674c8..bacc1111d871 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -473,7 +473,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
>   *
>   * If all is ok, we return the new size, on error return < 0.
>   */
> -int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
> +int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
>  {
>  	struct vfs_ns_cap_data *nscap;
>  	uid_t nsrootid;
> @@ -516,7 +516,6 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
>  	nscap->magic_etc = cpu_to_le32(nsmagic);
>  	memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
>  
> -	kvfree(*ivalue);
>  	*ivalue = nscap;
>  	return newsize;
>  }
