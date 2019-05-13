Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8C1BF62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfEMWJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 18:09:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbfEMWJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 18:09:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DM7DeJ144092
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 18:09:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sfh3k82ac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 18:09:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 13 May 2019 23:09:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 23:09:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4DM9Np452166906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:09:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A1A4C046;
        Mon, 13 May 2019 22:09:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F045D4C044;
        Mon, 13 May 2019 22:09:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.120])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 22:09:21 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arvind Sankar <niveditas98@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org
Date:   Mon, 13 May 2019 18:09:11 -0400
In-Reply-To: <20190513184744.GA12386@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
         <20190512194322.GA71658@rani.riverdale.lan>
         <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
         <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
         <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
         <20190513172007.GA69717@rani.riverdale.lan>
         <20190513175250.GC69717@rani.riverdale.lan>
         <1557772584.4969.62.camel@linux.ibm.com>
         <20190513184744.GA12386@rani.riverdale.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051322-0008-0000-0000-000002E646B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051322-0009-0000-0000-00002252DD3F
Message-Id: <1557785351.4969.94.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-05-13 at 14:47 -0400, Arvind Sankar wrote:
> On Mon, May 13, 2019 at 02:36:24PM -0400, Mimi Zohar wrote:
> > 
> > > > How does this work today then? Is it actually the case that initramfs
> > > > just cannot be used on an IMA-enabled system, or it can but it leaves
> > > > the initramfs unverified and we're trying to fix that? I had assumed the
> > > > latter.
> > > Oooh, it's done not by starting IMA appraisal later, but by loading a
> > > default policy to ignore initramfs?
> > 
> > Right, when rootfs is a tmpfs filesystem, it supports xattrs, allowing
> > for finer grained policies to be defined.  This patch set would allow
> > a builtin IMA appraise policy to be defined which includes tmpfs.

Clarification: finer grain IMA policy rules are normally defined in
terms of LSM labels.  The LSMs need to enabled, before writing IMA
policy rules in terms of the LSM labels.

> > 
> Ok, but wouldn't my idea still work? Leave the default compiled-in
> policy set to not appraise initramfs. The embedded /init sets all the
> xattrs, changes the policy to appraise tmpfs, and then exec's the real
> init? Then everything except the embedded /init and the file with the
> xattrs will be appraised, and the embedded /init was verified as part of
> the kernel image signature. The only additional kernel change needed
> then is to add a config option to the kernel to disallow overwriting the
> embedded initramfs (or at least the embedded /init).

Yes and no.  The current IMA design allows a builtin policy to be
specified on the boot command line ("ima_policy="), so that it exists
from boot, and allows it to be replaced once with a custom policy.
 After that, assuming that CONFIG_IMA_WRITE_POLICY is configured,
additional rules may be appended.  As your embedded /init solution
already replaces the builtin policy, the IMA policy couldn't currently
be replaced a second time with a custom policy based on LSM labels.

Mimi

