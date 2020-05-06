Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998831C7A73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 21:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgEFTpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 15:45:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729402AbgEFTpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 15:45:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046JebdV000769;
        Wed, 6 May 2020 15:45:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8t7a58p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 15:45:00 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046JeaWT000630;
        Wed, 6 May 2020 15:44:59 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8t7a57n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 15:44:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046JUXjf028572;
        Wed, 6 May 2020 19:44:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5sugr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 19:44:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 046Jisow524580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 19:44:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9D294203F;
        Wed,  6 May 2020 19:44:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BA9542045;
        Wed,  6 May 2020 19:44:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.80])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 19:44:53 +0000 (GMT)
Message-ID: <1588794293.4624.21.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, david.safford@gmail.com,
        viro@zeniv.linux.org.uk, jmorris@namei.org,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Wed, 06 May 2020 15:44:53 -0400
In-Reply-To: <20200429073935.11913-1-roberto.sassu@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-06_09:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc: John Johansen] 

On Wed, 2020-04-29 at 09:39 +0200, Roberto Sassu wrote:
> EVM is a module for the protection of the integrity of file metadata. It
> protects security-relevant extended attributes, and some file attributes
> such as the UID and the GID. It protects their integrity with an HMAC or
> with a signature.
> 
> What makes EVM different from other LSMs is that it makes a security
> decision depending on multiple pieces of information, which cannot be
> managed atomically by the system.
> 
> Example: cp -a file.orig file.dest
> 
> If security.selinux, security.ima and security.evm must be preserved, cp
> will invoke setxattr() for each xattr, and EVM performs a verification
> during each operation. The problem is that copying security.evm from
> file.orig to file.dest will likely break the following EVM verifications if
> some metadata still have to be copied. EVM has no visibility on the
> metadata of the source file, so it cannot determine when the copy can be
> considered complete.

I remember having a similar discussion in the past.  At the time,
there wasn't EVM portable and immutable signature support, just the
HMAC and original signature types.  Neither of these EVM xattrs types
should be copied.

Calling evm_verifyxattr() is not limited to IMA, but may be called by
other LSMs/subsystems as well.  At some point, there was some
discussion about AppArmor calling it directly.  Not sure if that is
still being discussed.

Since copying the EVM HMAC or original signature isn't applicable, I
would prefer exploring an EVM portable and immutable signature only
solution.

Mimi
