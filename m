Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD963717A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhECPOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 11:14:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229717AbhECPOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:14:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143F48st116650;
        Mon, 3 May 2021 11:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eDaj1jhHxQmBJpYcYXGZmB0FUavn6iXflGZ8LWwhdYw=;
 b=H493hy7LW/Y5Pb7XwZCWR4m+ONi6RANVJH1DiJIs/Y1aE7K2pcvFzRIFEHglyPj/Gx+3
 biMVVDqyyyRBTGD230hoIdb1UIeFvoQC/f2J2wW8oxBu60h4R3E9At0+Nsg3bAlGoh4X
 qnFxKkD+tQy+gC/Ol5lnKzZ2uSUnfBx9a8822K+58M3yTOrue/ZmyhqT9okvmsTD5CIq
 MYxeol2Nq+QmFkKnAF4jg8yyzoXHZJ58PfADHf4lUj4gG6xt5oXxMgHB0OkOGSRLxxHT
 rEakgxLq8z4C5mE+jPTjUQYIR4hYOgDTOqKQBA8Q8Lf5Y5wkLKQe2g/O7FdJIlSvT2XX cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ahy4uavm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 11:13:33 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143F4hx2120473;
        Mon, 3 May 2021 11:13:32 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ahy4uaun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 11:13:32 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143FCr7Z000398;
        Mon, 3 May 2021 15:13:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 388x8hgs8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 15:13:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143FDSU527853092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 15:13:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 907695205F;
        Mon,  3 May 2021 15:13:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6067552052;
        Mon,  3 May 2021 15:13:26 +0000 (GMT)
Message-ID: <33ddeb6108699f47ba47d5f002403ffeca5f9531.camel@linux.ibm.com>
Subject: Re: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 03 May 2021 11:13:25 -0400
In-Reply-To: <06edfc9f779447b9b93f26628327d1e5@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
         <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
         <06edfc9f779447b9b93f26628327d1e5@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NX_CnYn1o6Hj1UvnM9Aqd-BiXjSLY9I2
X-Proofpoint-GUID: ysFaGwSzJmublxH3DOS1djooJuMuKeF-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030104
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-03 at 14:48 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, May 3, 2021 3:00 PM
> > On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> > 
> > > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c
> > > @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct
> > user_namespace *mnt_userns,
> > >  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> > >  		return 0;
> > >
> > > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > > +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> > > +			      xattr_value_len))
> > > +		return 0;
> > > +
> > 
> > If the purpose of evm_protect_xattr() is to prevent allowing an invalid
> > security.evm xattr from being re-calculated and updated, making it
> > valid, INTEGRITY_PASS_IMMUTABLE shouldn't need to be conditional.  Any
> > time there is an attr or xattr change, including setting it to the
> > existing value, the status flag should be reset.
> 
> The status is always reset if evm_protect_xattr() returns 0. This does not
> change.
> 
> Not making INTEGRITY_PASS_IMMUTABLE conditional would cause issues.
> Suppose that the status is INTEGRITY_FAIL. Writing the same xattr would
> cause evm_protect_xattr() to return 0 and the HMAC to be updated.

This example is mixing security.evm types.  Please clarify.

> > I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
> > prevent the file from being resigned.
> 
> INTEGRITY_FAIL_IMMUTABLE should be enough to continue the
> operation.

Agreed.

Mimi

