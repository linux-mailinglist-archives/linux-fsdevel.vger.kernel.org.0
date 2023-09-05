Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4C792F38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbjIETrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjIETrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:47:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C076283;
        Tue,  5 Sep 2023 12:47:00 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385IcTX4025333;
        Tue, 5 Sep 2023 19:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RbGG0JMEkT1YvxWzhDbzrzewytMoYeXhTP6+OTsHwnk=;
 b=jt5bnX516m4U+z7VNYDdHh6fBuV1NUVKjW8rVnmH68RqoyEdP0k2+G/71u13EEIrbhqV
 fo6FqXBQPQ5MYG6bQ6LfG22YTIE25yMRp2iRzh0mTT8isHjJArB3wraKvbU8lSthBKNT
 9WaW/VIhsjF5kz+ArnODtlQ79a72thmOUtDkNG2H3tlE/dhOgQ1OypYCMEwHd+J8WanN
 I0iAtC8kQkLkV8waeKQrwwYrkLLcJs4YDifHGnwmQCdCQioQ1WCPYvGTkKQ15LrKRmNz
 9x8ETpeEkXOLFAGOV9nSsnbwcnMyziDgoZFITVAMjeH21Dd9oea9Fzq/okjuMY+bkz95 Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9ef1r0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:01:54 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385IcmdD027855;
        Tue, 5 Sep 2023 19:01:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9ef1qy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:01:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385IAvRq011169;
        Tue, 5 Sep 2023 19:01:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31mksx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:01:52 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385J1pLp63242618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 19:01:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE535806C;
        Tue,  5 Sep 2023 19:01:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D4D258061;
        Tue,  5 Sep 2023 19:01:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 19:01:48 +0000 (GMT)
Message-ID: <f202cf50-1284-9df6-6930-10dfa7a8c3b4@linux.ibm.com>
Date:   Tue, 5 Sep 2023 15:01:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 19/25] security: Introduce inode_post_remove_acl hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
 <20230904133415.1799503-20-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-20-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pDxbPR99nTpnXAXTx-OssX3jXWVMDnzs
X-Proofpoint-GUID: 9r68kwj-_BlQBEtF9MZvSedkoZHJ36X1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050161
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/4/23 09:34, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
>
> It is useful for EVM to recalculate the HMAC on the remaining POSIX ACLs
> and other file metadata, after it verified the HMAC of current file
> metadata with the inode_remove_acl hook.
>
> LSMs should use the new hook instead of inode_remove_acl, when they need to
> know that the operation was done successfully (not known in
> inode_remove_acl). The new hook cannot return an error and cannot cause the
> operation to be reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/posix_acl.c                |  1 +
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  8 ++++++++
>   security/security.c           | 17 +++++++++++++++++
>   4 files changed, 28 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 3b7dbea5c3ff..2a2a2750b3e9 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1246,6 +1246,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>   		error = -EIO;
>   	if (!error) {
>   		fsnotify_xattr(dentry);
> +		security_inode_post_remove_acl(idmap, dentry, acl_name);
>   		evm_inode_post_remove_acl(idmap, dentry, acl_name);
>   	}
>   
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bba1fbd97207..eedc26790a07 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -163,6 +163,8 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name)
>   LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, const char *acl_name)
>   LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
>   LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
>   	 struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 556d019ebe5c..e543ae80309b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -373,6 +373,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
>   			   struct dentry *dentry, const char *acl_name);
>   int security_inode_remove_acl(struct mnt_idmap *idmap,
>   			      struct dentry *dentry, const char *acl_name);
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry,
> +				    const char *acl_name);
>   void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>   				  const void *value, size_t size, int flags);
>   int security_inode_getxattr(struct dentry *dentry, const char *name);
> @@ -915,6 +918,11 @@ static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
>   	return 0;
>   }
>   
> +static inline void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +						  struct dentry *dentry,
> +						  const char *acl_name)
> +{ }
> +
>   static inline void security_inode_post_setxattr(struct dentry *dentry,
>   		const char *name, const void *value, size_t size, int flags)
>   { }
> diff --git a/security/security.c b/security/security.c
> index aabace9e24d9..554f4925323d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2323,6 +2323,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>   	return evm_inode_remove_acl(idmap, dentry, acl_name);
>   }
>   
> +/**
> + * security_inode_post_remove_acl() - Update inode sec after remove_acl op
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security field after successful remove_acl operation on @dentry
> + * in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry, const char *acl_name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>   /**
>    * security_inode_post_setxattr() - Update the inode after a setxattr operation
>    * @dentry: file

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


