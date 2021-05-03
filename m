Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3DB3716AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhECOff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 10:35:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhECOff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 10:35:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143EWjNW059364;
        Mon, 3 May 2021 10:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7mL8FDzBMAjmCV7DfbSNIWf6w40iFdmjkhfdERaeVRA=;
 b=I4z/vS3tvDbY0LRAuQmLszQ2Y7i1PiaNFqBLWrfhLtGBU6Uag45UXwYFEQrAngjykFjh
 NBr3YI4xeM/QKz0lRWg+atNjsXQRxbJ0OWs3CyYQsdfmUUHaQCAu9ZradWAY9Xkfrnmb
 VX+cGJidtHKeG+Qd8ldTIZdtGFDkFHBYPRB/JW2n92qiKURKtmOCqdHuHoZHMbJV/31u
 ID9Dgvhixyk9ErkExkVxmXt1BWUn9aHZKAWoIoG9RpTQjaFGJcX5qOZJFpeV3x2Vkvfc
 ApkcIxEGm8rIaMedI3InBhFm1d2XRmFiuzKHnT0zZHAsrD2AM8coX73ye5B4MfFPxYH1 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ajye84f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 10:34:38 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143EXEoj061102;
        Mon, 3 May 2021 10:34:38 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ajye84e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 10:34:38 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143ESkAV003650;
        Mon, 3 May 2021 14:34:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 388xm88dv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 14:34:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143EY85F34406786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 14:34:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C144C046;
        Mon,  3 May 2021 14:34:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487C64C044;
        Mon,  3 May 2021 14:34:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 14:34:31 +0000 (GMT)
Message-ID: <a2ca7317b672c63a40743268b641dd73661c3329.camel@linux.ibm.com>
Subject: Re: [PATCH v5 06/12] evm: Ignore
 INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS if conditions are safe
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 03 May 2021 10:34:30 -0400
In-Reply-To: <33cad84d2f894ed5a05a3bd6854f73a0@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-7-roberto.sassu@huawei.com>
         <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
         <c12f18094cc0479faa3f0f152b4964de@huawei.com>
         <33cad84d2f894ed5a05a3bd6854f73a0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8rfCqxeB6htgEsunVVGBiRIymhHRStfR
X-Proofpoint-GUID: nivbUT025dw3pmsh5X499IA29R0zvE0Q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030101
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-03 at 14:15 +0000, Roberto Sassu wrote:

> > > >  	if (evm_status != INTEGRITY_PASS)
> > > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > d_backing_inode(dentry),
> > > >  				    dentry->d_name.name,
> > > "appraise_metadata",
> > > > @@ -515,7 +535,8 @@ int evm_inode_setattr(struct dentry *dentry,
> > struct
> > > iattr *attr)
> > > >  		return 0;
> > > >  	evm_status = evm_verify_current_integrity(dentry);
> > > >  	if ((evm_status == INTEGRITY_PASS) ||
> > > > -	    (evm_status == INTEGRITY_NOXATTRS))
> > > > +	    (evm_status == INTEGRITY_NOXATTRS) ||
> > > > +	    (evm_ignore_error_safe(evm_status)))
> > >
> > > It would also remove the INTEGRITY_NOXATTRS test duplication here.
> > 
> > Ok.
> 
> Actually, it does not seem a duplication. Currently, INTEGRITY_NOXATTRS
> is ignored also when the HMAC key is loaded.

The existing INTEGRITY_NOXATTRS exemption is more general and includes
the new case of when EVM HMAC is disabled.  The additional exemption is
only needed for INTEGRITY_NOLABEL, when EVM HMAC is disabled.

Mimi

