Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC7792EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbjIETTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbjIETTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:19:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1519C;
        Tue,  5 Sep 2023 12:18:33 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385J8c6P008633;
        Tue, 5 Sep 2023 19:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tweIh2DYtuCy17Peu9ze/DKTxA/LGtUrlwZnouIHK/8=;
 b=TwFsNdCSF0HzukEy3byh35Dtxdr0dY1iH1mBMChea8OfHdabWyzYWStc3YGynDBHwNF0
 YnA6MlQQMZ7hHPuNlW2h8AcxhEwwWFtG/mXwyjFe8IB/TSHKob9lssF6qLIlRjo6/j7D
 e0eRvsNjN6dbuzlgMTDr0y6XNvt0ltI9xos+gUop7LjD9lxf8YHvg/+ghp29lYpv3ISM
 uZ/75Zj3Q0F2Zqc4ZyKTJQhXMQllNty9p7kDIhQiM6cg97hY6DJI9LUsal9fnnP1cDV/
 zz53iu9DTDgMSsWZmbkwWNVyvcOR/9nK1hdFSAgpcgmp34xecRVthMi8t74/oEyqtTBL fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxa0w18et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:17:22 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385J92s9013794;
        Tue, 5 Sep 2023 19:17:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxa0w188t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:17:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385HQJPU012275;
        Tue, 5 Sep 2023 19:17:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjvuuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:17:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385JHB4H5571210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 19:17:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D3C45803F;
        Tue,  5 Sep 2023 19:17:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26AAA58056;
        Tue,  5 Sep 2023 19:17:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 19:17:10 +0000 (GMT)
Message-ID: <908acfec-1b76-8d4c-1c24-34f9977a1af6@linux.ibm.com>
Date:   Tue, 5 Sep 2023 15:17:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 21/25] ima: Move to LSM infrastructure
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
 <20230904134049.1802006-2-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904134049.1802006-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B5t5MKV2mEV0_ZHGoaq8T6hGbWXt_QpD
X-Proofpoint-GUID: 0YJ9yWOmE_hfR8HYzGDOfXOwPyNBPIjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050166
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/4/23 09:40, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Remove hardcoded IMA function calls (not for appraisal) from the LSM
> infrastructure, the VFS, NFS and the key subsystem.
>
> Make those functions as static (except for ima_file_check() which is
> exported, and ima_post_key_create_or_update(), which is not in ima_main.c),
> and register them as implementation of the respective hooks in the new
> function init_ima_lsm().
>
> Call init_ima_lsm() from integrity_lsm_init() (renamed from
> integrity_iintcache_init()), to make sure that the integrity subsystem is
> ready at the time IMA hooks are registered. The same will be done for EVM,
> by calling init_evm_lsm() just after init_ima_lsm().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> index 6e4d060ff378..58591b5cbdb4 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -16,26 +16,7 @@ struct linux_binprm;
>   
>   #ifdef CONFIG_IMA
>   extern enum hash_algo ima_get_current_hash_algo(void);
> -extern int ima_bprm_check(struct linux_binprm *bprm);
>   extern int ima_file_check(struct file *file, int mask);

 From what I saw ima_file_check doesn't need to be public anymore, either.

    Stefan


