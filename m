Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B26ACE32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCFTgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCFTf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:35:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A270439;
        Mon,  6 Mar 2023 11:35:58 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326ItVwc032349;
        Mon, 6 Mar 2023 19:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=y+Z1ma1MGws0W6zD6MGLuFhhDh4S6Lu9ng79sc+aU4g=;
 b=fTV1tQ+90rz2JRT9K8Y8RxFeQcVk0DBAnKbkQ61lC/GP6dew9/rOVe+n+QQeawQPFIxV
 uwldZ4q9vn5BBMgFnobEe5oINx42BI/TPVzX865gYHmPg93zd0/ZUnAls3QJlszELnKX
 xWc0o+TjGALAxX5cxR3yUg+tEdq/0Kd38lc50YYjpHzi0qlwOkgAPycX8QuMdBqUreO7
 dINPBi6A04C2UhV6RoBXuXV6vJBZiHm/+PcvbD9w6gdbp6WSwvonA8ITtTPlFX+Vjlhm
 y8Wly5W3UyyFdqct/L+KMal3AQ/F8nv5KfsES6DkihnEIZFQFMxIyy92JRc6ZNzVHD0r 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wswgh1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 19:35:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326JQTkH027564;
        Mon, 6 Mar 2023 19:35:41 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wswgh1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 19:35:41 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326JIaNH023888;
        Mon, 6 Mar 2023 19:35:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p4187anub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 19:35:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326JZd8q37421512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 19:35:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99B2A58056;
        Mon,  6 Mar 2023 19:35:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D64F58062;
        Mon,  6 Mar 2023 19:35:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 19:35:38 +0000 (GMT)
Message-ID: <1be26c09-15ab-bda8-5e44-7571cca7576d@linux.ibm.com>
Date:   Mon, 6 Mar 2023 14:35:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 19/28] security: Introduce inode_post_create_tmpfile hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-20-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303181842.1087717-20-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WVHYJeMnZ6qIVnqc4AHmDTyRuCltDoBo
X-Proofpoint-GUID: TRpX03ukmbXQTAUPWiQPZGl5ATPGFfuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_12,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/3/23 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_create_tmpfile hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/namei.c                    |  1 +
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  8 ++++++++
>   security/security.c           | 18 ++++++++++++++++++
>   4 files changed, 29 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f2747521d3..8c4fdfd81d4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3624,6 +3624,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>   		inode->i_state |= I_LINKABLE;
>   		spin_unlock(&inode->i_lock);
>   	}
> +	security_inode_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
>   	ima_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
>   	return 0;
>   }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 32c801a3ea2..5dc2a7c3d9a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -120,6 +120,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>   	 const struct qstr *name, const struct inode *context_inode)
>   LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>   	 umode_t mode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
> +	 struct inode *dir, struct dentry *dentry, umode_t mode)
>   LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
>   	 struct dentry *new_dentry)
>   LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fb6e9d434c6..b3e201404dc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -337,6 +337,9 @@ int security_inode_init_security_anon(struct inode *inode,
>   				      const struct qstr *name,
>   				      const struct inode *context_inode);
>   int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *dir,
> +					struct dentry *dentry, umode_t mode);
>   int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>   			 struct dentry *new_dentry);
>   int security_inode_unlink(struct inode *dir, struct dentry *dentry);
> @@ -787,6 +790,11 @@ static inline int security_inode_create(struct inode *dir,
>   	return 0;
>   }
>   
> +static inline void
> +security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> +				   struct dentry *dentry, umode_t mode)
> +{ }
> +
>   static inline int security_inode_link(struct dentry *old_dentry,
>   				       struct inode *dir,
>   				       struct dentry *new_dentry)
> diff --git a/security/security.c b/security/security.c
> index f5f367e2064..8883082b686 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1971,6 +1971,24 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
>   }
>   EXPORT_SYMBOL_GPL(security_inode_create);
>   
> +/**
> + * security_inode_post_create_tmpfile() - Update inode sec after tmpfile created

'sec'? -> Update inode security field after creation of tmpfile



> + * @idmap: idmap of the mount
> + * @dir: the inode of the base directory
> + * @dentry: the dentry of the new tmpfile
> + * @mode: the mode of the new tmpfile
> + *
> + * Update inode security field after a tmpfile has been created.

With the nit above:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> + */
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *dir,
> +					struct dentry *dentry, umode_t mode)
> +{
> +	if (unlikely(IS_PRIVATE(dir)))
> +		return;
> +	call_void_hook(inode_post_create_tmpfile, idmap, dir, dentry, mode);
> +}
> +
>   /**
>    * security_inode_link() - Check if creating a hard link is allowed
>    * @old_dentry: existing file
