Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734CE1CF6DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgELORa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 10:17:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729336AbgELORa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 10:17:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CEBH1m009256;
        Tue, 12 May 2020 10:17:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws5f45jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 10:17:12 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04CEBVxM010678;
        Tue, 12 May 2020 10:17:11 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws5f45gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 10:17:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04CEGHW2001007;
        Tue, 12 May 2020 14:17:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55en15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 14:17:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04CEH7du46203022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 14:17:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAF424C064;
        Tue, 12 May 2020 14:17:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC2FB4C046;
        Tue, 12 May 2020 14:17:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.144.67])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 May 2020 14:17:05 +0000 (GMT)
Message-ID: <1589293025.5098.53.camel@linux.ibm.com>
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
Date:   Tue, 12 May 2020 10:17:05 -0400
In-Reply-To: <09ee169cfd70492cb526bcb30f99d693@huawei.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_03:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-05-12 at 07:54 +0000, Roberto Sassu wrote:
> > > > Roberto, EVM is only triggered by IMA, unless you've modified the
> > > > kernel to do otherwise.
> > >
> > > EVM would deny xattr/attr operations even if IMA is disabled in the
> > > kernel configuration. For example, evm_setxattr() returns the value
> > > from evm_protect_xattr(). IMA is not involved there.
> > 
> > Commit ae1ba1676b88 ("EVM: Allow userland to permit modification of
> > EVM-protected metadata") introduced EVM_ALLOW_METADATA_WRITES
> > to allow writing the EVM portable and immutable file signatures.
> 
> According to Documentation/ABI/testing/evm:
> 
> Note that once a key has been loaded, it will no longer be
> possible to enable metadata modification.

Not any key, but the HMAC key.
 
2         Permit modification of EVM-protected metadata at
          runtime. Not supported if HMAC validation and
          creation is enabled.

Each time the EVM protected file metadata is updated, the EVM HMAC is
updated, assuming the existing EVM HMAC is valid.  Userspace should
not have access to the HMAC key, so we only allow writing EVM
signatures.

The only difference between writing the original EVM signature and the
new portable and immutable signature is the security.ima xattr
requirement.  Since the new EVM signature does not include the
filesystem specific data, something else needs to bind the file
metadata to the file data.  Thus the IMA xattr requirement.

Assuming that the new EVM signature is written last, as long as there
is an IMA xattr, there shouldn't be a problem writing the new EVM
signature.

Mimi
