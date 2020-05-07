Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1846F1C94B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEGPRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 11:17:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29956 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgEGPRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 11:17:41 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047F4hU7112011;
        Thu, 7 May 2020 11:17:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8n4cfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 11:17:26 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047F5Khg113846;
        Thu, 7 May 2020 11:17:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8n4cb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 11:17:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047FAaca015722;
        Thu, 7 May 2020 15:17:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5uk0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 15:17:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047FHAFT33292412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 15:17:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 854BFAE053;
        Thu,  7 May 2020 15:17:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41963AE05A;
        Thu,  7 May 2020 15:17:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.201])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 15:17:09 +0000 (GMT)
Message-ID: <1588864628.5685.78.camel@linux.ibm.com>
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
Date:   Thu, 07 May 2020 11:17:08 -0400
In-Reply-To: <ab879f9e66874736a40e9c566cadc272@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-05-07 at 07:53 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Wednesday, May 6, 2020 11:10 PM
> > To: Roberto Sassu <roberto.sassu@huawei.com>; david.safford@gmail.com;
> > viro@zeniv.linux.org.uk; jmorris@namei.org; John Johansen
> > <john.johansen@canonical.com>
> > Cc: linux-fsdevel@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> > security-module@vger.kernel.org; linux-kernel@vger.kernel.org; Silviu
> > Vlasceanu <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure

Roberto, please fix your mailer or at least manually remove this sort
of info from the email.

> > 
> > On Wed, 2020-05-06 at 15:44 -0400, Mimi Zohar wrote:
> > > Since copying the EVM HMAC or original signature isn't applicable, I
> > > would prefer exploring an EVM portable and immutable signature only
> > > solution.
> > 
> > To prevent copying the EVM xattr, we added "security.evm" to
> > /etc/xattr.conf.  To support copying just the EVM portable and
> > immutable signatures will require a different solution.
> 
> This patch set removes the need for ignoring security.evm. It can be always
> copied, even if it is an HMAC. EVM will update it only when verification in
> the pre hook is successful. Combined with the ability of protecting a subset
> of files without introducing an EVM policy, these advantages seem to
> outweigh the effort necessary to make the switch.

As the EVM file HMAC and original signature contain inode specific
information (eg. i_version, i_generation), these xattrs cannot ever be
copied.  The proposed change is in order to support just the new EVM
signatures.

At least IMA file hashes should always be used in conjunction with
EVM.  EVM xattrs should always require a security.ima xattr to bind
the file metadata to the file data.  The IMA and EVM policies really
need to be in sync.

Mimi
