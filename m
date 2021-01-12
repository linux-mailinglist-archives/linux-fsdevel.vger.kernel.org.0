Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD22F2431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbhALAZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:40 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:51792 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404255AbhALAQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:16:03 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kz7LD-0038Qw-IH; Mon, 11 Jan 2021 17:15:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kz7LB-000PtX-S5; Mon, 11 Jan 2021 17:15:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
        <20201207163255.564116-2-mszeredi@redhat.com>
        <87czyoimqz.fsf@x220.int.ebiederm.org>
        <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
Date:   Mon, 11 Jan 2021 18:14:17 -0600
In-Reply-To: <20210111134916.GC1236412@miu.piliscsaba.redhat.com> (Miklos
        Szeredi's message of "Mon, 11 Jan 2021 14:49:16 +0100")
Message-ID: <874kjnm2p2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kz7LB-000PtX-S5;;;mid=<874kjnm2p2.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uX1+9Ozqq4QWJMfvhjm5y5e+FWhnoXWk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1140 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.4%), b_tie_ro: 3.0 (0.3%), parse: 1.96
        (0.2%), extract_message_metadata: 15 (1.3%), get_uri_detail_list: 7
        (0.6%), tests_pri_-1000: 3.7 (0.3%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 106 (9.3%), check_bayes:
        104 (9.1%), b_tokenize: 19 (1.7%), b_tok_get_all: 15 (1.3%),
        b_comp_prob: 3.3 (0.3%), b_tok_touch_all: 64 (5.6%), b_finish: 0.77
        (0.1%), tests_pri_0: 750 (65.8%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 240 (21.0%), tests_pri_10:
        1.63 (0.1%), tests_pri_500: 251 (22.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Fri, Jan 01, 2021 at 11:35:16AM -0600, Eric W. Biederman wrote:
>> Miklos Szeredi <mszeredi@redhat.com> writes:
>> 
>> > cap_convert_nscap() does permission checking as well as conversion of the
>> > xattr value conditionally based on fs's user-ns.
>> >
>> > This is needed by overlayfs and probably other layered fs (ecryptfs) and is
>> > what vfs_foo() is supposed to do anyway.
>> 
>> Well crap.
>> 
>> I just noticed this and it turns out this change is wrong.
>> 
>> The problem is that it reads the rootid from the v3 fscap, using
>> current_user_ns() and then writes it using the sb->s_user_ns.
>> 
>> So any time the stacked filesystems sb->s_user_ns do not match or
>> current_user_ns does not match sb->s_user_ns this could be a problem.
>> 
>> In a stacked filesystem a second pass through vfs_setxattr will result
>> in the rootid being translated a second time (with potentially the wrong
>> namespaces).  I think because of the security checks a we won't write
>> something we shouldn't be able to write to the filesystem.  Still we
>> will be writing the wrong v3 fscap which can go quite badly.
>> 
>> This doesn't look terribly difficult to fix.
>> 
>> Probably convert this into a fs independent form using uids in
>> init_user_ns at input and have cap_convert_nscap convert the v3 fscap
>> into the filesystem dependent form.  With some way for stackable
>> filesystems to just skip converting it from the filesystem independent
>> format.
>> 
>> Uids in xattrs that are expected to go directly to disk, but aren't
>> always suitable for going directly to disk are tricky.
>
> I've been looking at this for a couple of days and can't say I clearly
> understand everything yet.
>
> For one: a v2 fscap is supposed to be equivalent to a v3 fscap with a rootid of
> zero, right?

Yes.  This assumes that everything is translated into the uids of the
target filesystem.

> If so, why does cap_inode_getsecurity() treat them differently (v2 fscap
> succeeding unconditionally while v3 one being either converted to v2, rejected
> or left as v3 depending on current_user_ns())?

As I understand it v2 fscaps have always succeeded unconditionally.  The
only case I can see for a v2 fscap might not succeed when read is if the
filesystem is outside of the initial user namespace.


> Anyway, here's a patch that I think fixes getxattr() layering for
> security.capability.  Does basically what you suggested.  Slight change of
> semantics vs. v1 caps, not sure if that is still needed, getxattr()/setxattr()
> hasn't worked for these since the introduction of v3 in 4.14.
> Untested.

Taking a look.  The goal of change how these operate is to make it so
that layered filesystems can just pass through the data if they don't
want to change anything (even with the user namespaces of the
filesystems in question are different).

Feedback on the code below:
- cap_get should be in inode_operations like get_acl and set_acl.

- cap_get should return a cpu_vfs_cap_data.

  Which means that only make_kuid is needed when reading the cap from
  disk.

  Which means that except for the rootid_owns_currentns check (which
  needs to happen elsewhere) default_cap_get should be today's
  get_vfs_cap_from_disk.

- With the introduction of cap_get I believe commoncap should stop
  implementing the security_inode_getsecurity hook, and rather have
  getxattr observe is the file capability xatter and call the new
  vfs_cap_get then translate to a v2 or v3 cap as appropriate when
  returning the cap to userspace.

I think that would put the code on a solid comprehensible foundation.

Eric


> I still need to wrap my head around the permission requirements for the
> setxattr() case...
>
> Thanks,
> Miklos
>
> ---
>  fs/overlayfs/super.c       |   15 +++
>  include/linux/capability.h |    2 
>  include/linux/fs.h         |    1 
>  security/commoncap.c       |  210 ++++++++++++++++++++++++---------------------
>  4 files changed, 132 insertions(+), 96 deletions(-)
>
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -395,6 +395,20 @@ static int ovl_remount(struct super_bloc
>  	return ret;
>  }
>  
> +static int ovl_cap_get(struct dentry *dentry,
> +		       struct vfs_ns_cap_data *nscap)
> +{
> +	int res;
> +	const struct cred *old_cred;
> +	struct dentry *realdentry = ovl_dentry_real(dentry);
> +
> +	old_cred = ovl_override_creds(dentry->d_sb);
> +	res = vfs_cap_get(realdentry, nscap);
> +	revert_creds(old_cred);
> +
> +	return res;
> +}
> +
>  static const struct super_operations ovl_super_operations = {
>  	.alloc_inode	= ovl_alloc_inode,
>  	.free_inode	= ovl_free_inode,
> @@ -405,6 +419,7 @@ static const struct super_operations ovl
>  	.statfs		= ovl_statfs,
>  	.show_options	= ovl_show_options,
>  	.remount_fs	= ovl_remount,
> +	.cap_get	= ovl_cap_get,
>  };
>  
>  enum {
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -272,4 +272,6 @@ extern int get_vfs_caps_from_disk(const
>  
>  extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
>  
> +int vfs_cap_get(struct dentry *dentry, struct vfs_ns_cap_data *nscap);
> +
>  #endif /* !_LINUX_CAPABILITY_H */
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1963,6 +1963,7 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	int (*cap_get)(struct dentry *dentry, struct vfs_ns_cap_data *nscap);
>  };
>  
>  /*
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -341,6 +341,13 @@ static __u32 sansflags(__u32 m)
>  	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
>  }
>  
> +static bool is_v1header(size_t size, const struct vfs_cap_data *cap)
> +{
> +	if (size != XATTR_CAPS_SZ_1)
> +		return false;
> +	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_1;
> +}
> +
>  static bool is_v2header(size_t size, const struct vfs_cap_data *cap)
>  {
>  	if (size != XATTR_CAPS_SZ_2)
> @@ -355,6 +362,72 @@ static bool is_v3header(size_t size, con
>  	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_3;
>  }
>  
> +static bool validheader(size_t size, const struct vfs_cap_data *cap)
> +{
> +	return is_v1header(size, cap) || is_v2header(size, cap) || is_v3header(size, cap);
> +}
> +
> +static void cap_to_v3(const struct vfs_cap_data *cap,
> +			 struct vfs_ns_cap_data *nscap)
> +{
> +	u32 magic, nsmagic;
> +
> +	nsmagic = VFS_CAP_REVISION_3;
> +	magic = le32_to_cpu(cap->magic_etc);
> +	if (magic & VFS_CAP_FLAGS_EFFECTIVE)
> +		nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
> +	nscap->magic_etc = cpu_to_le32(nsmagic);
> +	nscap->rootid = cpu_to_le32(0);
> +}
> +
> +static int default_cap_get(struct dentry *dentry, struct vfs_ns_cap_data *nscap)
> +{
> +	int err;
> +	ssize_t size;
> +	kuid_t kroot;
> +	uid_t root, mappedroot;
> +	char *tmpbuf = NULL;
> +	struct vfs_cap_data *cap;
> +	struct user_namespace *fs_ns = dentry->d_sb->s_user_ns;
> +
> +	size = vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS, &tmpbuf,
> +				  sizeof(struct vfs_ns_cap_data), GFP_NOFS);
> +	if (size < 0)
> +		return size;
> +
> +	cap = (struct vfs_cap_data *) tmpbuf;
> +	err = -EINVAL;
> +	if (!validheader(size, cap))
> +		goto out;
> +
> +	memset(nscap, 0, sizeof(*nscap));
> +	memcpy(nscap, tmpbuf, size);
> +	if (!is_v3header(size, cap))
> +		cap_to_v3(cap, nscap);
> +
> +	/* Convert rootid from fs user namespace to init user namespace */
> +	root = le32_to_cpu(nscap->rootid);
> +	kroot = make_kuid(fs_ns, root);
> +	mappedroot = from_kuid(&init_user_ns, kroot);
> +	nscap->rootid = cpu_to_le32(mappedroot);
> +
> +	err = 0;
> +out:
> +	kfree(tmpbuf);
> +	return err;
> +}
> +
> +int vfs_cap_get(struct dentry *dentry, struct vfs_ns_cap_data *nscap)
> +{
> +	struct super_block *sb = dentry->d_sb;
> +
> +	if (sb->s_op->cap_get)
> +		return sb->s_op->cap_get(dentry, nscap);
> +	else
> +		return default_cap_get(dentry, nscap);
> +}
> +EXPORT_SYMBOL(vfs_cap_get);
> +
>  /*
>   * getsecurity: We are called for security.* before any attempt to read the
>   * xattr from the inode itself.
> @@ -369,14 +442,15 @@ static bool is_v3header(size_t size, con
>  int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  			  bool alloc)
>  {
> -	int size, ret;
> +	int ret;
> +	ssize_t size;
>  	kuid_t kroot;
> +	__le32 nsmagic, magic;
>  	uid_t root, mappedroot;
> -	char *tmpbuf = NULL;
> +	void *tmpbuf = NULL;
>  	struct vfs_cap_data *cap;
> -	struct vfs_ns_cap_data *nscap;
> +	struct vfs_ns_cap_data nscap;
>  	struct dentry *dentry;
> -	struct user_namespace *fs_ns;
>  
>  	if (strcmp(name, "capability") != 0)
>  		return -EOPNOTSUPP;
> @@ -385,67 +459,50 @@ int cap_inode_getsecurity(struct inode *
>  	if (!dentry)
>  		return -EINVAL;
>  
> -	size = sizeof(struct vfs_ns_cap_data);
> -	ret = (int) vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS,
> -				 &tmpbuf, size, GFP_NOFS);
> +	ret = vfs_cap_get(dentry, &nscap);
>  	dput(dentry);
>  
>  	if (ret < 0)
>  		return ret;
>  
> -	fs_ns = inode->i_sb->s_user_ns;
> -	cap = (struct vfs_cap_data *) tmpbuf;
> -	if (is_v2header((size_t) ret, cap)) {
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
> -	}
> +	tmpbuf = kmalloc(sizeof(struct vfs_ns_cap_data), GFP_NOFS);
> +	if (!tmpbuf)
> +		return -ENOMEM;
>  
> -	nscap = (struct vfs_ns_cap_data *) tmpbuf;
> -	root = le32_to_cpu(nscap->rootid);
> -	kroot = make_kuid(fs_ns, root);
> +	root = le32_to_cpu(nscap.rootid);
> +	kroot = make_kuid(&init_user_ns, root);
>  
>  	/* If the root kuid maps to a valid uid in current ns, then return
>  	 * this as a nscap. */
>  	mappedroot = from_kuid(current_user_ns(), kroot);
>  	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
> +		size = sizeof(struct vfs_cap_data);
>  		if (alloc) {
>  			*buffer = tmpbuf;
> -			nscap->rootid = cpu_to_le32(mappedroot);
> -		} else
> -			kfree(tmpbuf);
> -		return size;
> +			tmpbuf = NULL;
> +			nscap.rootid = cpu_to_le32(mappedroot);
> +			memcpy(*buffer, &nscap, size);
> +		}
> +		goto out;
>  	}
>  
> -	if (!rootid_owns_currentns(kroot)) {
> -		kfree(tmpbuf);
> -		return -EOPNOTSUPP;
> -	}
> +	size = -EOPNOTSUPP;
> +	if (!rootid_owns_currentns(kroot))
> +		goto out;
>  
>  	/* This comes from a parent namespace.  Return as a v2 capability */
>  	size = sizeof(struct vfs_cap_data);
>  	if (alloc) {
> -		*buffer = kmalloc(size, GFP_ATOMIC);
> -		if (*buffer) {
> -			struct vfs_cap_data *cap = *buffer;
> -			__le32 nsmagic, magic;
> -			magic = VFS_CAP_REVISION_2;
> -			nsmagic = le32_to_cpu(nscap->magic_etc);
> -			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
> -				magic |= VFS_CAP_FLAGS_EFFECTIVE;
> -			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
> -			cap->magic_etc = cpu_to_le32(magic);
> -		} else {
> -			size = -ENOMEM;
> -		}
> +		cap = *buffer = tmpbuf;
> +		tmpbuf = NULL;
> +		magic = VFS_CAP_REVISION_2;
> +		nsmagic = le32_to_cpu(nscap.magic_etc);
> +		if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
> +			magic |= VFS_CAP_FLAGS_EFFECTIVE;
> +		memcpy(&cap->data, &nscap.data, sizeof(__le32) * 2 * VFS_CAP_U32);
> +		cap->magic_etc = cpu_to_le32(magic);
>  	}
> +out:
>  	kfree(tmpbuf);
>  	return size;
>  }
> @@ -462,11 +519,6 @@ static kuid_t rootid_from_xattr(const vo
>  	return make_kuid(task_ns, rootid);
>  }
>  
> -static bool validheader(size_t size, const struct vfs_cap_data *cap)
> -{
> -	return is_v2header(size, cap) || is_v3header(size, cap);
> -}
> -
>  /*
>   * User requested a write of security.capability.  If needed, update the
>   * xattr to change from v2 to v3, or to fixup the v3 rootid.
> @@ -570,74 +622,40 @@ static inline int bprm_caps_from_vfs_cap
>  int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> -	__u32 magic_etc;
> -	unsigned tocopy, i;
> -	int size;
> -	struct vfs_ns_cap_data data, *nscaps = &data;
> -	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
> -	kuid_t rootkuid;
> -	struct user_namespace *fs_ns;
> +	unsigned int i;
> +	int ret;
> +	struct vfs_ns_cap_data nscaps;
>  
>  	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
>  
>  	if (!inode)
>  		return -ENODATA;
>  
> -	fs_ns = inode->i_sb->s_user_ns;
> -	size = __vfs_getxattr((struct dentry *)dentry, inode,
> -			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> -	if (size == -ENODATA || size == -EOPNOTSUPP)
> +	ret = vfs_cap_get((struct dentry *) dentry, &nscaps);
> +	if (ret == -ENODATA || ret == -EOPNOTSUPP)
>  		/* no data, that's ok */
>  		return -ENODATA;
>  
> -	if (size < 0)
> -		return size;
> -
> -	if (size < sizeof(magic_etc))
> -		return -EINVAL;
> -
> -	cpu_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
> +	if (ret < 0)
> +		return ret;
>  
> -	rootkuid = make_kuid(fs_ns, 0);
> -	switch (magic_etc & VFS_CAP_REVISION_MASK) {
> -	case VFS_CAP_REVISION_1:
> -		if (size != XATTR_CAPS_SZ_1)
> -			return -EINVAL;
> -		tocopy = VFS_CAP_U32_1;
> -		break;
> -	case VFS_CAP_REVISION_2:
> -		if (size != XATTR_CAPS_SZ_2)
> -			return -EINVAL;
> -		tocopy = VFS_CAP_U32_2;
> -		break;
> -	case VFS_CAP_REVISION_3:
> -		if (size != XATTR_CAPS_SZ_3)
> -			return -EINVAL;
> -		tocopy = VFS_CAP_U32_3;
> -		rootkuid = make_kuid(fs_ns, le32_to_cpu(nscaps->rootid));
> -		break;
> +	cpu_caps->magic_etc = le32_to_cpu(nscaps.magic_etc);
> +	cpu_caps->rootid = make_kuid(&init_user_ns, le32_to_cpu(nscaps.rootid));
>  
> -	default:
> -		return -EINVAL;
> -	}
>  	/* Limit the caps to the mounter of the filesystem
>  	 * or the more limited uid specified in the xattr.
>  	 */
> -	if (!rootid_owns_currentns(rootkuid))
> +	if (!rootid_owns_currentns(cpu_caps->rootid))
>  		return -ENODATA;
>  
>  	CAP_FOR_EACH_U32(i) {
> -		if (i >= tocopy)
> -			break;
> -		cpu_caps->permitted.cap[i] = le32_to_cpu(caps->data[i].permitted);
> -		cpu_caps->inheritable.cap[i] = le32_to_cpu(caps->data[i].inheritable);
> +		cpu_caps->permitted.cap[i] = le32_to_cpu(nscaps.data[i].permitted);
> +		cpu_caps->inheritable.cap[i] = le32_to_cpu(nscaps.data[i].inheritable);
>  	}
>  
>  	cpu_caps->permitted.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
>  	cpu_caps->inheritable.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
>  
> -	cpu_caps->rootid = rootkuid;
> -
>  	return 0;
>  }
>  
