Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D438F372B48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEDNrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 09:47:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230478AbhEDNrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 09:47:07 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144DiPCN007508;
        Tue, 4 May 2021 09:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=USYFsrusWFxT3Qxhq4iFumDkqaNvL/dcdiSFURy7vwk=;
 b=HJpGo/AYQyTWjvaxeFr0ue7JEMRWBXqgTP9GZsBDEM+KQ8yP6NO4LpdgitvEtpFet4yZ
 T4WVIcIsqZX5Ybq+r4e5pAQR2ZdC8np1klqpZqs+Wc+xu1e54VlVaRkGzMRqx/Qm4Tku
 Hjh0KUI0Epd6cijXX6ZNMhcKfqNORZ8Ax5WtbM22BUD7QcY0oSBuu4n3GwMrPfUrXrop
 tZeQIth/Ea6PCAeF7HLHlvHqhic091YHt8nyJIld+Qxqe6AbU/XFM+KSKU0YnHnrbQwj
 h5PGZfbx2xB9H1ak9J1Ffrac/G7B7DqpB6lzynW6iBY4vFY7e0oqyR5B3hrxKMy5ggK2 pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b7dn81ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:46:07 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144DiIt5007378;
        Tue, 4 May 2021 09:46:07 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b7dn81dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:46:06 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144DitvQ023463;
        Tue, 4 May 2021 13:46:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 388xm8gpew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 13:46:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144Dk1kk31457602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 13:46:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C68652051;
        Tue,  4 May 2021 13:46:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.38.211])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A2C1252050;
        Tue,  4 May 2021 13:45:59 +0000 (GMT)
Message-ID: <02426b1486616544230d0804de21cd9e78a0a00e.camel@linux.ibm.com>
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
Date:   Tue, 04 May 2021 09:45:58 -0400
In-Reply-To: <1869963c94574fd1b026b304acdd308e@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-7-roberto.sassu@huawei.com>
         <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
         <c12f18094cc0479faa3f0f152b4964de@huawei.com>
         <33cad84d2f894ed5a05a3bd6854f73a0@huawei.com>
         <a2ca7317b672c63a40743268b641dd73661c3329.camel@linux.ibm.com>
         <1869963c94574fd1b026b304acdd308e@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: we5ICwBpig5bvP9a2bZCG3O26IgnNOk8
X-Proofpoint-ORIG-GUID: q0uot74SQAkCwksYxzBNaRI42DYE6IYi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_07:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040101
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-05-04 at 13:16 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, May 3, 2021 4:35 PM
> > On Mon, 2021-05-03 at 14:15 +0000, Roberto Sassu wrote:
> > 
> > > > > >  	if (evm_status != INTEGRITY_PASS)
> > > > > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > > > d_backing_inode(dentry),
> > > > > >  				    dentry->d_name.name,
> > > > > "appraise_metadata",
> > > > > > @@ -515,7 +535,8 @@ int evm_inode_setattr(struct dentry *dentry,
> > > > struct
> > > > > iattr *attr)
> > > > > >  		return 0;
> > > > > >  	evm_status = evm_verify_current_integrity(dentry);
> > > > > >  	if ((evm_status == INTEGRITY_PASS) ||
> > > > > > -	    (evm_status == INTEGRITY_NOXATTRS))
> > > > > > +	    (evm_status == INTEGRITY_NOXATTRS) ||
> > > > > > +	    (evm_ignore_error_safe(evm_status)))
> > > > >
> > > > > It would also remove the INTEGRITY_NOXATTRS test duplication here.
> > > >
> > > > Ok.
> > >
> > > Actually, it does not seem a duplication. Currently, INTEGRITY_NOXATTRS
> > > is ignored also when the HMAC key is loaded.
> > 
> > The existing INTEGRITY_NOXATTRS exemption is more general and includes
> > the new case of when EVM HMAC is disabled.  The additional exemption is
> > only needed for INTEGRITY_NOLABEL, when EVM HMAC is disabled.
> 
> Unfortunately, evm_ignore_error_safe() is called by both evm_protect_xattr()
> and evm_inode_setattr(). The former requires an exemption also for
> INTEGRITY_NOXATTRS.
> 
> I would keep the function as it is. In the worst case, when the status is
> INTEGRITY_NOXATTRS in evm_inode_setattr(), the function will not
> be called.

Right, which is another reason for replacing evm_ignore_eror_safe()
with (is_)evm_hmac_disabled() and inlining the error tests.

thanks,

Mimi

