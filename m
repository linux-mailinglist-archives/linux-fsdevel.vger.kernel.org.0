Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0F1D18BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgEMPJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:09:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEMPJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:09:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DF3hsU157163;
        Wed, 13 May 2020 11:09:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 310g8u6gya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 11:09:08 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04DF46Of158145;
        Wed, 13 May 2020 11:09:08 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 310g8u6gww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 11:09:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DF4vsH009582;
        Wed, 13 May 2020 15:09:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3100uc0qyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 15:09:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04DF94Hi63242460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 15:09:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39F73A405C;
        Wed, 13 May 2020 15:09:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00683A4065;
        Wed, 13 May 2020 15:09:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.144.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 May 2020 15:09:02 +0000 (GMT)
Message-ID: <1589382542.5098.136.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Wed, 13 May 2020 11:09:02 -0400
In-Reply-To: <4fb6c8457ac44af3b464fab712a10a37@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
         <1588864628.5685.78.camel@linux.ibm.com>
         <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
         <1588884313.5685.110.camel@linux.ibm.com>
         <84e6acad739a415aa3e2457b5c37979f@huawei.com>
         <1588957684.5146.70.camel@linux.ibm.com>
         <414644a0be9e4af880452f4b5079aba1@huawei.com>
         <1589233010.5091.49.camel@linux.ibm.com>
         <09ee169cfd70492cb526bcb30f99d693@huawei.com>
         <1589293025.5098.53.camel@linux.ibm.com>
         <d3f4a53e386d4bb1b8c608ac8b6bec1f@huawei.com>
         <1589298622.5098.67.camel@linux.ibm.com>
         <fcdb168d27214b5e85c3b741f184cde9@huawei.com>
         <1589312281.5098.91.camel@linux.ibm.com>
         <4fb6c8457ac44af3b464fab712a10a37@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_06:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 cotscore=-2147483648 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 07:21 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Tuesday, May 12, 2020 9:38 PM
> > On Tue, 2020-05-12 at 16:31 +0000, Roberto Sassu wrote:
> > > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > 
> > > > > > Each time the EVM protected file metadata is updated, the EVM
> > HMAC
> > > > is
> > > > > > updated, assuming the existing EVM HMAC is valid.  Userspace
> > should
> > > > > > not have access to the HMAC key, so we only allow writing EVM
> > > > > > signatures.
> > > > > >
> > > > > > The only difference between writing the original EVM signature and
> > the
> > > > > > new portable and immutable signature is the security.ima xattr
> > > > > > requirement.  Since the new EVM signature does not include the
> > > > > > filesystem specific data, something else needs to bind the file
> > > > > > metadata to the file data.  Thus the IMA xattr requirement.
> > > > > >
> > > > > > Assuming that the new EVM signature is written last, as long as there
> > > > > > is an IMA xattr, there shouldn't be a problem writing the new EVM
> > > > > > signature.
> > > > >
> > > > >         /* first need to know the sig type */
> > > > >         rc = vfs_getxattr_alloc(dentry, XATTR_NAME_EVM, (char
> > > > **)&xattr_data, 0,
> > > > >                                 GFP_NOFS);
> > > > >         if (rc <= 0) {
> > > > >                 evm_status = INTEGRITY_FAIL;
> > > > >                 if (rc == -ENODATA) {
> > > > >                         rc = evm_find_protected_xattrs(dentry);
> > > > >                         if (rc > 0)
> > > > >                                 evm_status = INTEGRITY_NOLABEL;
> > > > >                         else if (rc == 0)
> > > > >                                 evm_status = INTEGRITY_NOXATTRS; /* new file */
> > > > >
> > > > > If EVM_ALLOW_METADATA_WRITES is cleared, only the first xattr
> > > > > can be written (status INTEGRITY_NOXATTRS is ok). After,
> > > > > evm_find_protected_xattrs() returns rc > 0, so the status is
> > > > > INTEGRITY_NOLABEL, which is not ignored by evm_protect_xattr().
> > > >
> > > > With EVM HMAC enabled, as a result of writing the first protected
> > > > xattr, an EVM HMAC should be calculated and written in
> > > > evm_inode_post_setxattr().
> > >
> > > To solve the ordering issue, wouldn't allowing setxattr() on a file
> > > with portable signature that does not yet pass verification be safe?
> > > evm_update_evmxattr() checks if the signature is portable and
> > > if yes, does not calculate the HMAC.
> > 
> > Before agreeing to allowing the protected xattrs to be written on a
> > file with a portable signature that does not yet pass verification are
> > safe, would we be introducing any new types of attacks?
> 
> Allowing xattr/attr update means that someone can do:
> 
> setxattr(path, "security.evm", ...);	with type=5
> 
> all subsequent setxattr()/setattr() succeed until the correct
> combination is set.
> 
> At that point, any xattr/attr operation fails, even if one tries to set
> an xattr with the same value. If we still deny the operation when the
> verification succeeds, we have to fix that.
> 
> It is common that the signature passes verification before user space
> tools finish to set xattrs/attrs. For example, if a file is created with
> mode 644 and this was the mode at the time of signing, any attempt
> by tar for example to set again the same mode fails.

We have a couple of options: always fail the write, differentiate the
reason for the failure, or check the value before failing the write.
 The easiest obviously would be to always fail the write once it is
valid.  Whatever you decide, please keep it simple.

> 
> If allowing a change of xattrs/attrs for portable signatures is safe or
> not, I would say yes. Portable signatures cannot be modified even
> if __vfs_setxattr_noperm() is called directly.
> 
> > For example, would we differentiate between portable signatures that
> > don't pass verification and ones that do?  If we don't differentiate,
> > could it be used for DoS?  Should it be limited to new files?
> 
> I would prefer to lock files when signatures pass the verification to
> avoid accidental changes.
> 
> Unless we find a better way to identify new file, without depending
> on the appraisal policy, I would allow the operation even for existing
> files.

The existing code verifies the EVM xattr before allowing the
xattr/attr change.  It sounds like for EVM_XATTR_PORTABLE_DIGSIG we
need to do exactly the reverse.

Mimi

