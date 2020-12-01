Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F52CADD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgLAUxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:53:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729183AbgLAUxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:53:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1KXBwA055455;
        Tue, 1 Dec 2020 15:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=APMTXe6+p68TNGCweQqMwpTcWSnBIulipluxdg/4dMI=;
 b=ro3anzC85I+sf6+LeJKjYBW0cIvmTnbV5cVAipOfkFZiwezT1/r3eHOI2A7/mkT9zQZ1
 z2KKZ4/8sbdVwa1tuaiEffwbmrqiOoLY3Xy3VlI00kdslZN7qYv6rNjoh8VblCDsPkK0
 xdO9mlLsr8c05t2de1cqjxLYaGJnnF1zuF1FbS9za6PSuHazrmBauQzce95hL/chtAFM
 qx7DqtyPGFHnpnm33NNTUdzWqVR6Ie4ey+gLCzpiZ/3hBlPvFZEqxcG8neigMQ01W7Op
 CP/P5pYWz63ztSMhlv1FzZQYmsvGGdvhf4kq2XtFXjLmD9tDu8SNVdw6JoylvcuKqVvy YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjnxnxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 15:52:53 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1KYHkE062548;
        Tue, 1 Dec 2020 15:52:52 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjnxnx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 15:52:52 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1KmZMI007327;
        Tue, 1 Dec 2020 20:52:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpda8y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 20:52:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1Kqm2E63832448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 20:52:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 133454C040;
        Tue,  1 Dec 2020 20:52:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 434514C044;
        Tue,  1 Dec 2020 20:52:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.13])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 20:52:46 +0000 (GMT)
Message-ID: <feb537b46b78054239397396ea1fdabc1a3c44e2.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/11] evm: Improve usability of portable signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Date:   Tue, 01 Dec 2020 15:52:45 -0500
In-Reply-To: <20201111092302.1589-1-roberto.sassu@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_09:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=910
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Wed, 2020-11-11 at 10:22 +0100, Roberto Sassu wrote:
> EVM portable signatures are particularly suitable for the protection of
> metadata of immutable files where metadata is signed by a software vendor.
> They can be used for example in conjunction with an IMA policy that
> appraises only executed and memory mapped files.

The existing "appraise_tcb" builtin policy verify all root owned files.
Defining a new builtin policy to verify only executed and memory
mmapped files would make a nice addition and would probably simplify
testing.

> 
> However, some usability issues are still unsolved, especially when EVM is
> used without loading an HMAC key. This patch set attempts to fix the open
> issues.

We need regression tests for each of these changes.

To prevent affecting the running system, the appraise policy rules
could be limited to a loopback mounted filesystem. 

> 
> Patch 1 allows EVM to be used without loading an HMAC key. Patch 2 avoids
> appraisal verification of public keys (they are already verified by the key
> subsystem).

Loading the EVM key(s) occurs early, either the builtin x509 EVM key or
during the initramfs, makes testing difficult.  Based on
security/evm/evm, different tests could be defined for when only x509
keys, only HMAC key, or both EVM key types are loaded.

> 
> Patches 3-5 allow metadata verification to be turned off when no HMAC key
> is loaded and to use this mode in a safe way (by ensuring that IMA
> revalidates metadata when there is a change).
> 
> Patches 6-8 make portable signatures more usable if metadata verification
> is not turned off, by ignoring the INTEGRITY_NOLABEL error when no HMAC key
> is loaded, by accepting any metadata modification until signature
> verification succeeds (useful when xattrs/attrs are copied sequentially
> from a source) and by allowing operations that don't change metadata.
> 
> Patch 9 makes it possible to use portable signatures when the IMA policy
> requires file signatures and patch 10 shows portable signatures in the
> measurement list when the ima-sig template is selected.

ima-evm-utils needs to be updated to support EVM portable & immutable
signatures.

> 
> Lastly, patch 11 avoids undesired removal of security.ima when a file is
> not selected by the IMA policy.

thanks,

Mimi

