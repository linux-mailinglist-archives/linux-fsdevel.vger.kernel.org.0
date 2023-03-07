Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9366AEE52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCGSLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 13:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCGSKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:10:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE35DECD;
        Tue,  7 Mar 2023 10:05:40 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327HGv5u002333;
        Tue, 7 Mar 2023 18:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hoz4RkVCJGwvQNNgSt4WLK6sHH0UVal/pigvAKVzo24=;
 b=KmYsR+wgzGHSKd2v0EhZiBj2MtYYjTed21FDk7VT0FDzn++Pa9LUhrxtOEdxY1tP0GZn
 VCO1Pk7iNQb8lGXM/S9XQPemTobWQnBQj7eT7rsay6FepXWh4Vk2WHPUWmiWf3X26ynZ
 xpKLFriFrXs4D92nYjxy3GxMkhkqhHPc0vCg4KiBUo0ZneDWg2BskimpR5tEBFVlRJNp
 wYFOMgYkiaVk7X23H12gTFeYEu5DwpqaxTHc6dbfJXw6dVhwAczgX0yMrDagPpdZdOyt
 fSDCSzMNYNS3VWM9c6Y1/VrYkJm+ZPLzWaqGz+/s2UEAxhn8pGxzUTYZf/f+1/lYJ/dc hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p67wfmdtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:05:03 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327HqNgi004706;
        Tue, 7 Mar 2023 18:05:02 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p67wfmdsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:05:02 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327H9dUc015329;
        Tue, 7 Mar 2023 18:05:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p4199sp2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:05:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327I4xJr32309734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:05:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE1DD5805A;
        Tue,  7 Mar 2023 18:04:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 600B15803F;
        Tue,  7 Mar 2023 18:04:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 18:04:55 +0000 (GMT)
Message-ID: <4b158d7e-a96d-58ae-cc34-0ad6abc1cea9@linux.ibm.com>
Date:   Tue, 7 Mar 2023 13:04:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 23/28] security: Introduce LSM_ORDER_LAST
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
 <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z2sA_jePHs3pgRRx2w8x57GTfaIXwbl5
X-Proofpoint-ORIG-GUID: giscmAA8yJRKHabeezSzr5z2e0B3EN--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_12,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/3/23 13:25, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> the last, e.g. the 'integrity' LSM, without changing the kernel command
> line or configuration.
> 
> As for LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled and put
> at the end of the LSM list in no particular order.
> 

I think you should describe the reason for the change for LSM_ORDER_MUTABLE as well.


> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/lsm_hooks.h |  1 +
>   security/security.c       | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 21a8ce23108..05c4b831d99 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -93,6 +93,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>   enum lsm_order {
>   	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
>   	LSM_ORDER_MUTABLE = 0,
> +	LSM_ORDER_LAST = 1,
>   };
>   
>   struct lsm_info {
> diff --git a/security/security.c b/security/security.c
> index 322090a50cd..24f52ba3218 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		bool found = false;
>   
>   		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (lsm->order == LSM_ORDER_MUTABLE &&
> -			    strcmp(lsm->name, name) == 0) {
> -				append_ordered_lsm(lsm, origin);
> +			if (strcmp(lsm->name, name) == 0) {
> +				if (lsm->order == LSM_ORDER_MUTABLE)
> +					append_ordered_lsm(lsm, origin);
>   				found = true;
>   			}
>   		}
> @@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   		}
>   	}
>   
> +	/* LSM_ORDER_LAST is always last. */
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (lsm->order == LSM_ORDER_LAST)
> +			append_ordered_lsm(lsm, "   last");
> +	}
> +
>   	/* Disable all LSMs not in the ordered list. */
>   	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>   		if (exists_ordered_lsm(lsm))
