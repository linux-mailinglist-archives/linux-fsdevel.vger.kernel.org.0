Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8C37100C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhECAOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 20:14:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232628AbhECAOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 20:14:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14304Ld1127179;
        Sun, 2 May 2021 20:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=j5tVgerw/HaiqFeD0mqp4eWW0oDhvr1CskwJFs3/cJw=;
 b=lbLaVkHlbAoyG/Y0kyr9XTbUfq4GutV10IG+oufdHA/fyTxy7DolgitcQu3HPWyHoEYQ
 UdKTLkA3nU9HMEum6oXWRzxk22AKSew/40zqv8wkQq3BbqN8Frui+RweTxwfr4US9F05
 FK//6EXL8lpDrPNQPDEh0BQkC1OM/B2krfoE2WsG0urT6b5ZM+Lz42+Zn/V7s5sE1W8n
 5C9TfRfiBTOhKRJOOjkvH+RWJjzbZSbEXqZvGhXHO90hif92vNfJ2ROMcfcf2ab564bs
 IRErMVkVgjm+HQHJzLekidIznOhfCKbraOgka5azxakZWht8JseSOSzi5paw+xlulods vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38a5u8gfx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 20:13:07 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14307XFG138539;
        Sun, 2 May 2021 20:13:07 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38a5u8gfws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 20:13:07 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1430D5vn008378;
        Mon, 3 May 2021 00:13:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 388xm8revh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 00:13:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1430D2i859638046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 00:13:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDEB24C044;
        Mon,  3 May 2021 00:13:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC56C4C040;
        Mon,  3 May 2021 00:13:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.39.226])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 00:13:00 +0000 (GMT)
Message-ID: <75e8a4f70dfbbfa4cf5b923ab0ac92768e1e2de5.camel@linux.ibm.com>
Subject: Re: [PATCH v5 07/12] evm: Allow xattr/attr operations for portable
 signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 02 May 2021 20:12:49 -0400
In-Reply-To: <20210407105252.30721-8-roberto.sassu@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-8-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2XmW_2P6ztGe5cpTyKfMsWF1PN6i0z-S
X-Proofpoint-GUID: xUVLXz571dJrcr-ZhF-iMSszeiz76_ok
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-02_15:2021-04-30,2021-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105020194
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2271939c5c31..2ea0f2f65ab6 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> 
> @@ -238,9 +241,12 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  		break;
>  	}
>  
> -	if (rc)
> -		evm_status = (rc == -ENODATA) ?
> -				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
> +	if (rc) {
> +		evm_status = INTEGRITY_NOXATTRS;
> +		if (rc != -ENODATA)
> +			evm_status = evm_immutable ?
> +				     INTEGRITY_FAIL_IMMUTABLE : INTEGRITY_FAIL;

The original code made an exception for the -ENODATA case.   Using a
ternary operator made sense in that case.   Inverting the test makes
the code less readable.  Please use the standard "if" statement
instead.

thanks,

Mimi

