Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A143E37150F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhECMIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 08:08:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229866AbhECMIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 08:08:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143C4Kko122984;
        Mon, 3 May 2021 08:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=67Bb/a/rk0rGoLvbb54LTekVRlGTstOAnAiKjDvwdK4=;
 b=caXBLvw/7nAu67ZSKQk8AOv7hdU505FCKvSxtwWozt2Si1HowWtvN/MDEtnl1QaOqmVL
 I/sTtDqCESxXZQf+xq9r0PjmxGVHF9Bn6Z0PTKodtRNFj2VKDxxRReZa1auuHS+NGkpQ
 WatncmbKRgcJ3KbFGRUpnrgrXBvJwcTy1glJURygSDJpUE1NRiSkd8QwaUBEnA184Xzf
 JyTW/1sVBRNzANNRbgqETzXGVTl1Hrt7OSBFoWGv7G+bBHrSq6cPpSEYqSn76fayp/j9
 jddPh995uf9jG7RJbiqZaUKFFN1ysVxSstx+jciu9DjXQ6LC8qCFyanOZgxCNLU4C3/S Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38agju8hhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 08:07:46 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143C4lE4124403;
        Mon, 3 May 2021 08:07:46 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38agju8hgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 08:07:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143C46op000613;
        Mon, 3 May 2021 12:07:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 388xm88crt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 12:07:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143C7gCR28049756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 12:07:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 058EBA460F;
        Mon,  3 May 2021 12:07:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBE45A4611;
        Mon,  3 May 2021 12:07:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 12:07:39 +0000 (GMT)
Message-ID: <3bcb6e633f91d096cd0821a658c01cdb2f745cf6.camel@linux.ibm.com>
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
Date:   Mon, 03 May 2021 08:07:38 -0400
In-Reply-To: <c12f18094cc0479faa3f0f152b4964de@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-7-roberto.sassu@huawei.com>
         <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
         <c12f18094cc0479faa3f0f152b4964de@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: peZrPvDM-tXm3jXr8zp1A0Qnp8E-VIrT
X-Proofpoint-ORIG-GUID: jF42g-kS2lyBpv4J5skHCnXQL6afTgkN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_07:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030084
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-03 at 07:55 +0000, Roberto Sassu wrote:
> 
> > > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c

> > > @@ -354,6 +372,8 @@ static int evm_protect_xattr(struct dentry *dentry,
> > const char *xattr_name,
> > >  				    -EPERM, 0);
> > >  	}
> > >  out:
> > > +	if (evm_ignore_error_safe(evm_status))
> > > +		return 0;
> > 
> > I agree with the concept, but the function name doesn't provide enough
> > context.  Perhaps defining a function more along the lines of
> > "evm_hmac_disabled()" would be more appropriate and at the same time
> > self documenting.
> 
> Since the function checks if the passed error can be ignored,
> would evm_ignore_error_hmac_disabled() also be ok?

The purpose of evm_protect_xattr() is to prevent allowing an invalid
security.evm xattr from being re-calculated and updated, making it
valid.   Refer to the first line of the function description.  That
hasn't changed.

One of the reasons for defining a new function is to avoid code
duplication, but it should not come at the expense of clear and easily
understood code.   In this case, the reason for "ignoring" certain
return codes needs to be highlighted, not hidden.  
(is_)evm_hmac_disabled() makes this very clear.

Please update the function description to include the reason why making
an exception is safe.

thanks,

Mimi

> > >  	if (evm_status != INTEGRITY_PASS)
> > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > d_backing_inode(dentry),
> > >  				    dentry->d_name.name,
> > "appraise_metadata",

