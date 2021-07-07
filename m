Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD913BE421
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhGGIO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 04:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhGGIO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625645508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IxHHhOiV8+sZ6LpLjgjNcv26IJ9eZSvwO6Xt1AmHis=;
        b=gyIrlS/KWGqZ/LxB2BEhi7DQ7Y/+pXT3CDeLeJ2Y5TclNSHwDHrfPiP+E9FFXvoxn6eHuh
        msls2dYqAHKxdCzH7vnwlKZQjKW5kjm4p0BJSHKoM5shyvvKh2E6LNpUePTCPbeUE0JIHI
        Sk3E6T9dub3lrjSSdeBIjUbQI26Sv60=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-tLtprZqcM5-bJdyiMs3rFA-1; Wed, 07 Jul 2021 04:11:47 -0400
X-MC-Unique: tLtprZqcM5-bJdyiMs3rFA-1
Received: by mail-pl1-f199.google.com with SMTP id v7-20020a1709028d87b029012945cac72fso588571plo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 01:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7IxHHhOiV8+sZ6LpLjgjNcv26IJ9eZSvwO6Xt1AmHis=;
        b=MUBO/rvlwxDPO70emMEsOw3YL2oBu9oW0J4Be0tRDC4T2yx1S05TQVI1rNR0Ouh8L8
         c1uHOjscAb2RPcFbazNI9clIv/jXlLs7K58p6vHQ9JS1xZwJHt32UT9Wd62beYUwhJxJ
         /4iz25Hrvle5zQBhn168czN3Aj71z/hmsJWDOqyeywMY6+W2S5UDQNOlCv3cXT3YKIiV
         YkPcc1JV2ojYGrf3WLvwvD/Kadu2IaoeikeelbP3zF/UADO806F1hpgWpKW66Usuir9L
         eJYW0yh/aDwUd70Japvx67lREEI/1KO9QDoNhuTbkSk+d8egtqk+8/eVaSGRcfg9SKIE
         y+OQ==
X-Gm-Message-State: AOAM531Yn1K8s6u5psYniutDCn452Bcvep65ZaV4CoxF8Q0UDK6S+o1l
        wi1cG0Zd0P8hGid8RLeDViVHJiYIKHe5pMJ88GDlrjIBLil6+yrJgooAzRYzMdH29XUB+pw3BZR
        XdrelR8DLUWfOmoasCigxrmJJfA==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr25474364pja.175.1625645506059;
        Wed, 07 Jul 2021 01:11:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMNU4SB0teOHT6v93uRcHhLg04FB4deO8vIy0u0Uh1kyBSJ87unh7MGpThF7r/GIoLDW/Mqg==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr25474351pja.175.1625645505799;
        Wed, 07 Jul 2021 01:11:45 -0700 (PDT)
Received: from [10.72.12.117] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r33sm22714853pgk.51.2021.07.07.01.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 01:11:45 -0700 (PDT)
Subject: Re: [RFC PATCH v7 08/24] ceph: add ability to set fscrypt_auth via
 setattr
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-9-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4bb32761-93b5-16fb-b8ab-36897d469a39@redhat.com>
Date:   Wed, 7 Jul 2021 16:11:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625135834.12934-9-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/25/21 9:58 PM, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/acl.c                |  4 ++--
>   fs/ceph/inode.c              | 30 ++++++++++++++++++++++++++++--
>   fs/ceph/mds_client.c         | 31 ++++++++++++++++++++++++++-----
>   fs/ceph/mds_client.h         |  3 +++
>   fs/ceph/super.h              |  7 ++++++-
>   include/linux/ceph/ceph_fs.h | 21 +++++++++++++--------
>   6 files changed, 78 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 529af59d9fd3..6e716f142022 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -136,7 +136,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>   		newattrs.ia_ctime = current_time(inode);
>   		newattrs.ia_mode = new_mode;
>   		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> -		ret = __ceph_setattr(inode, &newattrs);
> +		ret = __ceph_setattr(inode, &newattrs, NULL);
>   		if (ret)
>   			goto out_free;
>   	}
> @@ -147,7 +147,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>   			newattrs.ia_ctime = old_ctime;
>   			newattrs.ia_mode = old_mode;
>   			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> -			__ceph_setattr(inode, &newattrs);
> +			__ceph_setattr(inode, &newattrs, NULL);
>   		}
>   		goto out_free;
>   	}
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index b620281ea65b..7821ba04eef3 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2086,7 +2086,7 @@ static const struct inode_operations ceph_symlink_iops = {
>   	.listxattr = ceph_listxattr,
>   };
>   
> -int __ceph_setattr(struct inode *inode, struct iattr *attr)
> +int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
>   {
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   	unsigned int ia_valid = attr->ia_valid;
> @@ -2127,6 +2127,32 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>   
>   	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
>   
> +	if (cia && cia->fscrypt_auth) {
> +		u32 len = offsetof(struct ceph_fscrypt_auth, cfa_blob) +
> +			  le32_to_cpu(cia->fscrypt_auth->cfa_blob_len);
> +
> +		if (len > sizeof(*cia->fscrypt_auth))
> +			return -EINVAL;
> +

Possibly we can remove this check here since in the patch followed will 
make sure the 'cia' is valid.



> +		dout("setattr %llx:%llx fscrypt_auth len %u to %u)\n",
> +			ceph_vinop(inode), ci->fscrypt_auth_len, len);
> +
> +		/* It should never be re-set once set */
> +		WARN_ON_ONCE(ci->fscrypt_auth);
> +
> +		if (issued & CEPH_CAP_AUTH_EXCL) {
> +			dirtied |= CEPH_CAP_AUTH_EXCL;
> +			kfree(ci->fscrypt_auth);
> +			ci->fscrypt_auth = (u8 *)cia->fscrypt_auth;
> +			ci->fscrypt_auth_len = len;
> +		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0) {
> +			req->r_fscrypt_auth = cia->fscrypt_auth;
> +			mask |= CEPH_SETATTR_FSCRYPT_AUTH;
> +			release |= CEPH_CAP_AUTH_SHARED;
> +		}
> +		cia->fscrypt_auth = NULL;
> +	}
> +
>   	if (ia_valid & ATTR_UID) {
>   		dout("setattr %p uid %d -> %d\n", inode,
>   		     from_kuid(&init_user_ns, inode->i_uid),
> @@ -2324,7 +2350,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>   	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
>   		return -EDQUOT;
>   
> -	err = __ceph_setattr(inode, attr);
> +	err = __ceph_setattr(inode, attr, NULL);
>   
>   	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
>   		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 9c994effc51d..4aca8ce1c135 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2529,8 +2529,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
>   	return r;
>   }
>   
> -static void encode_timestamp_and_gids(void **p,
> -				      const struct ceph_mds_request *req)
> +static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *req)
>   {
>   	struct ceph_timespec ts;
>   	int i;
> @@ -2543,6 +2542,21 @@ static void encode_timestamp_and_gids(void **p,
>   	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
>   		ceph_encode_64(p, from_kgid(&init_user_ns,
>   					    req->r_cred->group_info->gid[i]));
> +
> +	/* v5: altname (TODO: skip for now) */
> +	ceph_encode_32(p, 0);
> +
> +	/* v6: fscrypt_auth and fscrypt_file */
> +	if (req->r_fscrypt_auth) {
> +		u32 authlen = le32_to_cpu(req->r_fscrypt_auth->cfa_blob_len);
> +
> +		authlen += offsetof(struct ceph_fscrypt_auth, cfa_blob);

For the authlen calculating, maybe we could add one helper ? I found 
there have some other places are also doing this.


> +		ceph_encode_32(p, authlen);
> +		ceph_encode_copy(p, req->r_fscrypt_auth, authlen);
> +	} else {
> +		ceph_encode_32(p, 0);
> +	}
> +	ceph_encode_32(p, 0); // fscrypt_file for now
>   }
>   
>   /*
> @@ -2591,6 +2605,13 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	len += pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
>   		sizeof(struct ceph_timespec);
>   	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
> +	len += sizeof(u32); // altname
> +	len += sizeof(u32); // fscrypt_auth
> +	if (req->r_fscrypt_auth) {
> +		len += offsetof(struct ceph_fscrypt_auth, cfa_blob);
> +		len += le32_to_cpu(req->r_fscrypt_auth->cfa_blob_len);
> +	}
> +	len += sizeof(u32); // fscrypt_file
>   
>   	/* calculate (max) length for cap releases */
>   	len += sizeof(struct ceph_mds_request_release) *
> @@ -2621,7 +2642,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	} else {
>   		struct ceph_mds_request_head *new_head = msg->front.iov_base;
>   
> -		msg->hdr.version = cpu_to_le16(4);
> +		msg->hdr.version = cpu_to_le16(6);
>   		new_head->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
>   		head = (struct ceph_mds_request_head_old *)&new_head->oldest_client_tid;
>   		p = msg->front.iov_base + sizeof(*new_head);
> @@ -2672,7 +2693,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   
>   	head->num_releases = cpu_to_le16(releases);
>   
> -	encode_timestamp_and_gids(&p, req);
> +	encode_mclientrequest_tail(&p, req);
>   
>   	if (WARN_ON_ONCE(p > end)) {
>   		ceph_msg_put(msg);
> @@ -2781,7 +2802,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
>   		rhead->num_releases = 0;
>   
>   		p = msg->front.iov_base + req->r_request_release_offset;
> -		encode_timestamp_and_gids(&p, req);
> +		encode_mclientrequest_tail(&p, req);
>   
>   		msg->front.iov_len = p - msg->front.iov_base;
>   		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0c3cc61fd038..800eed49c2fd 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -278,6 +278,9 @@ struct ceph_mds_request {
>   	struct mutex r_fill_mutex;
>   
>   	union ceph_mds_request_args r_args;
> +
> +	struct ceph_fscrypt_auth *r_fscrypt_auth;
> +
>   	int r_fmode;        /* file mode, if expecting cap */
>   	const struct cred *r_cred;
>   	int r_request_release_offset;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index e032737fe472..ad62cde30e0b 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1035,7 +1035,12 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
>   }
>   extern int ceph_permission(struct user_namespace *mnt_userns,
>   			   struct inode *inode, int mask);
> -extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
> +
> +struct ceph_iattr {
> +	struct ceph_fscrypt_auth	*fscrypt_auth;
> +};
> +
> +extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
>   extern int ceph_setattr(struct user_namespace *mnt_userns,
>   			struct dentry *dentry, struct iattr *attr);
>   extern int ceph_getattr(struct user_namespace *mnt_userns,
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index e41a811026f6..a45a82c7d432 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -355,14 +355,19 @@ enum {
>   
>   extern const char *ceph_mds_op_name(int op);
>   
> -
> -#define CEPH_SETATTR_MODE   1
> -#define CEPH_SETATTR_UID    2
> -#define CEPH_SETATTR_GID    4
> -#define CEPH_SETATTR_MTIME  8
> -#define CEPH_SETATTR_ATIME 16
> -#define CEPH_SETATTR_SIZE  32
> -#define CEPH_SETATTR_CTIME 64
> +#define CEPH_SETATTR_MODE              (1 << 0)
> +#define CEPH_SETATTR_UID               (1 << 1)
> +#define CEPH_SETATTR_GID               (1 << 2)
> +#define CEPH_SETATTR_MTIME             (1 << 3)
> +#define CEPH_SETATTR_ATIME             (1 << 4)
> +#define CEPH_SETATTR_SIZE              (1 << 5)
> +#define CEPH_SETATTR_CTIME             (1 << 6)
> +#define CEPH_SETATTR_MTIME_NOW         (1 << 7)
> +#define CEPH_SETATTR_ATIME_NOW         (1 << 8)
> +#define CEPH_SETATTR_BTIME             (1 << 9)
> +#define CEPH_SETATTR_KILL_SGUID        (1 << 10)
> +#define CEPH_SETATTR_FSCRYPT_AUTH      (1 << 11)
> +#define CEPH_SETATTR_FSCRYPT_FILE      (1 << 12)
>   
>   /*
>    * Ceph setxattr request flags.

