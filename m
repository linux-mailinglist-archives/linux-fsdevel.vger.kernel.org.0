Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894D1792D70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbjIESg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbjIESg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:36:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18610E75;
        Tue,  5 Sep 2023 11:36:34 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385HNE7N013330;
        Tue, 5 Sep 2023 17:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ld64bg6DoVAaSajRnJTTPI+85fKEcgBbLZT2tpmMA48=;
 b=WFmReFAZZ/8MhTigkZcdSCE4mi40DYSGe2/RPiU5ebFRIkAqhAWHhcIYQR+t+Cdig2N/
 YshF3jUiybnbPZwDnK1Ceqb7VCA1gwCqJllMpBixEzHft/2Xrpx5wM7nPbRBsED+U09G
 ar44FTn7bbz3ERFPCe4+t5TpXMCL0uGvlUEO60spod6nj/HTxmatpgXWMEKdBPUwbk6+
 nLcn4r+diUWvZm9vP/rDPLGXxyY5vLsdpdDjcSOIg33RWimgwTlJnEfsK0ZUyA7+nl7S
 PoeObCuhC8A4TcE1N+ODYCd7L5NYyT0JRnoF4weJIoOFkWIENh1xeBHadOCv9te3aBgj vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx8pg0pbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:40:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385HQ8HO023071;
        Tue, 5 Sep 2023 17:40:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx8pg0pa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:40:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385HDaXl006622;
        Tue, 5 Sep 2023 17:40:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkcej5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:40:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385HeZx326804598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 17:40:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92FDF58056;
        Tue,  5 Sep 2023 17:40:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17CD75803F;
        Tue,  5 Sep 2023 17:40:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 17:40:34 +0000 (GMT)
Message-ID: <380f9312-97f9-7ccf-1854-dc15135a76cc@linux.ibm.com>
Date:   Tue, 5 Sep 2023 13:40:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/25] security: Introduce inode_post_setattr hook
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
 <20230904133415.1799503-13-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oGx3S1xEnHqv5zFYdKRH45Z2702CyqST
X-Proofpoint-GUID: jVfQhPQUkfioEGflO-yolUrB0Sb5lBmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050152
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
> the inode_post_setattr hook.
>
> It is useful for EVM to recalculate the HMAC on modified file attributes
> and other file metadata, after it verified the HMAC of current file
> metadata with the inode_setattr hook.
>
> LSMs should use the new hook instead of inode_setattr, when they need to
> know that the operation was done successfully (not known in inode_setattr).
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/attr.c                     |  1 +
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  7 +++++++
>   security/security.c           | 16 ++++++++++++++++
>   4 files changed, 26 insertions(+)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 431f667726c7..3c309eb456c6 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -486,6 +486,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>   
>   	if (!error) {
>   		fsnotify_change(dentry, ia_valid);
> +		security_inode_post_setattr(idmap, dentry, ia_valid);
>   		ima_inode_post_setattr(idmap, dentry, ia_valid);
>   		evm_inode_post_setattr(idmap, dentry, ia_valid);
>   	}
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index fdf075a6b1bb..995d30336cfa 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -136,6 +136,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
>   LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
>   LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
>   	 struct iattr *attr)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, int ia_valid)
>   LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>   LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dcb3604ffab8..820899db5276 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -355,6 +355,8 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
>   int security_inode_permission(struct inode *inode, int mask);
>   int security_inode_setattr(struct mnt_idmap *idmap,
>   			   struct dentry *dentry, struct iattr *attr);
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid);
>   int security_inode_getattr(const struct path *path);
>   int security_inode_setxattr(struct mnt_idmap *idmap,
>   			    struct dentry *dentry, const char *name,
> @@ -856,6 +858,11 @@ static inline int security_inode_setattr(struct mnt_idmap *idmap,
>   	return 0;
>   }
>   
> +static inline void
> +security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			    int ia_valid)
> +{ }

Existing security_sem_free() and others are also formatted like it, so 
it should be ok.


> +
>   static inline int security_inode_getattr(const struct path *path)
>   {
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index 2b24d01cf181..764a6f28b3b9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2124,6 +2124,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>   }
>   EXPORT_SYMBOL_GPL(security_inode_setattr);
>   
> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr operation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>   /**
>    * security_inode_getattr() - Check if getting file attributes is allowed
>    * @path: file

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


