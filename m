Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9851C9C9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGUp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 16:45:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEGUpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 16:45:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047KXHcV055062;
        Thu, 7 May 2020 16:45:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s2g5q56q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 16:45:19 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047KXRih055831;
        Thu, 7 May 2020 16:45:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s2g5q566-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 16:45:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047KeALF017294;
        Thu, 7 May 2020 20:45:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5v2q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 20:45:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047KjEfJ5832932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 20:45:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7D8C11C04A;
        Thu,  7 May 2020 20:45:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD8E711C052;
        Thu,  7 May 2020 20:45:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.201])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 20:45:13 +0000 (GMT)
Message-ID: <1588884313.5685.110.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 07 May 2020 16:45:13 -0400
In-Reply-To: <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
         <1588864628.5685.78.camel@linux.ibm.com>
         <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_13:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-05-07 at 16:47 +0000, Roberto Sassu wrote:
> > > > On Wed, 2020-05-06 at 15:44 -0400, Mimi Zohar wrote:
> > > > > Since copying the EVM HMAC or original signature isn't applicable, I
> > > > > would prefer exploring an EVM portable and immutable signature only
> > > > > solution.
> > > >
> > > > To prevent copying the EVM xattr, we added "security.evm" to
> > > > /etc/xattr.conf.  To support copying just the EVM portable and
> > > > immutable signatures will require a different solution.
> > >
> > > This patch set removes the need for ignoring security.evm. It can be
> > always
> > > copied, even if it is an HMAC. EVM will update it only when verification in
> > > the pre hook is successful. Combined with the ability of protecting a
> > subset
> > > of files without introducing an EVM policy, these advantages seem to
> > > outweigh the effort necessary to make the switch.
> > 
> > As the EVM file HMAC and original signature contain inode specific
> > information (eg. i_version, i_generation), these xattrs cannot ever be
> > copied.  The proposed change is in order to support just the new EVM
> > signatures.
> 
> Right, I didn't consider it.
> 
> Would it make sense instead to introduce an alias like security.evm_immutable
> so that this xattr can be copied?

Being portable, not the attribute of being immutable, allows copying
the EVM xattr.  Your original problem - the order in which the xattrs
are copied - might still be an issue.  We need to look at "cp" closer
to understand what it is doing.  For example, are the xattrs written
while the target file is tagged as a new file?

There have been similar problems in the past.  For example, tar calls
mknodat to create the file, but doesn't write the file data.  The
solution there was to tag the file as a new file.

We need to understand the problem better, before deciding how to
resolve it.

> 
> > At least IMA file hashes should always be used in conjunction with
> > EVM.  EVM xattrs should always require a security.ima xattr to bind
> 
> I proposed to enforce this restriction some time ago:
> 
> https://patchwork.kernel.org/patch/10979351/
> 
> Is it ok to enforce it globally?

Doing this would then be dependent on upstreaming the initramfs xattr
patches first, wouldn't it?  :)

> 
> > the file metadata to the file data.  The IMA and EVM policies really
> > need to be in sync.
> 
> It would be nice, but at the moment EVM considers also files that are
> not selected by the IMA policy. An example of why this is a problem is
> the audit service that fails to start when it tries to adjust the permissions
> of the log files. Those files don't have security.evm because they are
> not appraised by IMA, but EVM denies the operation.

No, this is a timing issue as to whether or not the builtin policy or
a custom policy has been loaded.  A custom policy could exclude the
log files based on LSM labels, but they are included in the builtin
policy.

Mimi
