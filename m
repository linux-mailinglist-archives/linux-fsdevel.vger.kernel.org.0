Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF57E371008
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 02:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhECANr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 20:13:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232628AbhECANq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 20:13:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143036nL006348;
        Sun, 2 May 2021 20:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MlEKYRUqqVUIAqoK6EJhjPI6yszVv6kSy3yggPaZMng=;
 b=aO8I7seNjCoVD9cQ2LZah8AP4ZE2rj8lBzlg1GPwkpzQuOyvRd1QzbWQqtaSqd14tHtq
 yUoB8JO89BLr6Bg4aL+bHTsyCOSz9uZeSeJrf2kLhhRhO2r31wtf4PCKpSEcd3OmlUUN
 zpEWVkV3om4RQo/lxqnZqaI5B/vd4qNmJ2y2X7fVGMRJOQROIffZP0DJrn25+PRhhWzP
 WoKdhuEzoSxO9t+b+k/Gb11wFlclbsfRmZ3c5ANA3kkmrn3xNpkR7stEQuSoT4MzwOj9
 36l+G0LFzipzM3uwXGmy0rjn2Vyv3zvLVZpWJheNo4mlzELugeWhQxwTWJsLiFke0d08 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38a5bkh096-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 20:12:49 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14303KXo009929;
        Sun, 2 May 2021 20:12:49 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38a5bkh08n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 20:12:49 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1430CkM1031720;
        Mon, 3 May 2021 00:12:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 388xm8g8c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 00:12:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1430CiAA37356024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 00:12:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E382A405B;
        Mon,  3 May 2021 00:12:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD629A4054;
        Mon,  3 May 2021 00:12:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.39.226])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 00:12:42 +0000 (GMT)
Message-ID: <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
Subject: Re: [PATCH v5 06/12] evm: Ignore
 INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS if conditions are safe
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 02 May 2021 20:12:41 -0400
In-Reply-To: <20210407105252.30721-7-roberto.sassu@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SRH9-xLb8PeB-WTYDgJE37X7kGXCIGZM
X-Proofpoint-GUID: s6WIgB_nV3uYkBTK8drPNP4-J4-cCBKx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-02_15:2021-04-30,2021-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105020194
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> When a file is being created, LSMs can set the initial label with the
> inode_init_security hook. If no HMAC key is loaded, the new file will have
> LSM xattrs but not the HMAC. It is also possible that the file remains
> without protected xattrs after creation if no active LSM provided it.
> 
> Unfortunately, EVM will deny any further metadata operation on new files,
> as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error, or
> INTEGRITY_NOXATTRS if no protected xattrs exist. This would limit the
> usability of EVM when only a public key is loaded, as commands such as cp
> or tar with the option to preserve xattrs won't work.
> 
> This patch ignores these errors when they won't be an issue, if no HMAC key
> is loaded and cannot be loaded in the future (which can be enforced by
> setting the EVM_SETUP_COMPLETE initialization flag).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 998818283fda..6556e8c22da9 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -90,6 +90,24 @@ static bool evm_key_loaded(void)
>  	return (bool)(evm_initialized & EVM_KEY_MASK);
>  }
>  
> +/*
> + * Ignoring INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS is safe if no HMAC key
> + * is loaded and the EVM_SETUP_COMPLETE initialization flag is set.
> + */
> +static bool evm_ignore_error_safe(enum integrity_status evm_status)
> +{
> +	if (evm_initialized & EVM_INIT_HMAC)
> +		return false;
> +
> +	if (!(evm_initialized & EVM_SETUP_COMPLETE))
> +		return false;
> +
> +	if (evm_status != INTEGRITY_NOLABEL && evm_status != INTEGRITY_NOXATTRS)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int evm_find_protected_xattrs(struct dentry *dentry)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> @@ -354,6 +372,8 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  				    -EPERM, 0);
>  	}
>  out:
> +	if (evm_ignore_error_safe(evm_status))
> +		return 0;

I agree with the concept, but the function name doesn't provide enough
context.  Perhaps defining a function more along the lines of
"evm_hmac_disabled()" would be more appropriate and at the same time
self documenting.

>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  				    dentry->d_name.name, "appraise_metadata",
> @@ -515,7 +535,8 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  		return 0;
>  	evm_status = evm_verify_current_integrity(dentry);
>  	if ((evm_status == INTEGRITY_PASS) ||
> -	    (evm_status == INTEGRITY_NOXATTRS))
> +	    (evm_status == INTEGRITY_NOXATTRS) ||
> +	    (evm_ignore_error_safe(evm_status)))

It would also remove the INTEGRITY_NOXATTRS test duplication here.

thanks,

Mimi

>  		return 0;
>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  			    dentry->d_name.name, "appraise_metadata",

