Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD3328A03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbhCASJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 13:09:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239176AbhCASHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:07:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121I5EXG066483;
        Mon, 1 Mar 2021 13:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QRfwyov4tdGnAwz8cU/ex+kzIeddUMeBq24T0KutDYA=;
 b=SKs8M5bDVZqVGMpp+Adqq1gShCr3DlMbLablmetxMymKLcKYF6k66j0fQr3yCRzHHe8/
 aU8wDhR8A7OtTxHhsuLbUxiikOG9p+CIpPiw+SLfY8pOubqrRNk7BattW4uDLxr38ij6
 pIsI9+1EjiK7Wf3ohnPEUHFPkRxk+WlY+gRQZvJMEubvJMyLMVtNLn0wGvBNhbuC8SRZ
 Qb70Dmmg/qXsZGbTwvHMQLEsFlMqEtWGWT5IqVedJwSgX6aibTxJeE2n68fuGZV9wdIh
 Bg+p+YQYJuIgRsefj3xVO0dSMJr1TPaWPu2dzRN9XT+cPCYmeMDlDrTlLklTs9ppbP+3 Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3713w7tvch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 13:06:39 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 121I6caG077482;
        Mon, 1 Mar 2021 13:06:38 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3713w7tvbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 13:06:38 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121I36lI015679;
        Mon, 1 Mar 2021 18:06:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 370atn0m4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 18:06:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121I6X2L38797700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 18:06:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7461AE057;
        Mon,  1 Mar 2021 18:06:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 363B0AE04D;
        Mon,  1 Mar 2021 18:06:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.103.165])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 18:06:32 +0000 (GMT)
Message-ID: <58c23338f15ea13278f275832ac35eeff875daad.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/11] evm: Load EVM key in ima_load_x509() to avoid
 appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Date:   Mon, 01 Mar 2021 13:06:31 -0500
In-Reply-To: <20201111092302.1589-3-roberto.sassu@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
         <20201111092302.1589-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_12:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010146
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Wed, 2020-11-11 at 10:22 +0100, Roberto Sassu wrote:
> Public keys do not need to be appraised by IMA as the restriction on the
> IMA/EVM keyrings ensures that a key can be loaded only if it is signed with
> a key in the primary or secondary keyring.
> 
> However, when evm_load_x509() is called, appraisal is already enabled and
> a valid IMA signature must be added to the EVM key to pass verification.
> 
> Since the restriction is applied on both IMA and EVM keyrings, it is safe
> to disable appraisal also when the EVM key is loaded. This patch calls
> evm_load_x509() inside ima_load_x509() if CONFIG_IMA_LOAD_X509 is defined.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/iint.c         | 2 ++
>  security/integrity/ima/ima_init.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 1d20003243c3..7d08c31c612f 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -200,7 +200,9 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  void __init integrity_load_keys(void)
>  {
>  	ima_load_x509();
> +#ifndef CONFIG_IMA_LOAD_X509
>  	evm_load_x509();
> +#endif

Please replace the ifdef with the IS_ENABLED() equivalent.

thanks,

Mimi

