Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAD1A562
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 00:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfEJWjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 18:39:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbfEJWjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 18:39:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AMahO7021980
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 18:39:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sdeqqfe1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 18:39:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 10 May 2019 23:39:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 May 2019 23:38:58 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4AMcvKk47251620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 22:38:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7DA052076;
        Fri, 10 May 2019 22:38:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E99D752077;
        Fri, 10 May 2019 22:38:54 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Rob Landley <rob@landley.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
Date:   Fri, 10 May 2019 18:38:44 -0400
In-Reply-To: <3a9d717e-0e12-9d62-a3cf-afb7a5dbf166@landley.net>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
         <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
         <bf0d02fc-d6ce-ef1d-bb7d-7ca14432c6fd@huawei.com>
         <1557488971.10635.102.camel@linux.ibm.com>
         <3a9d717e-0e12-9d62-a3cf-afb7a5dbf166@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051022-0008-0000-0000-000002E570DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051022-0009-0000-0000-00002251FEE0
Message-Id: <1557527924.10635.157.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-10_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=902 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-05-10 at 15:46 -0500, Rob Landley wrote:
> On 5/10/19 6:49 AM, Mimi Zohar wrote:
> > On Fri, 2019-05-10 at 08:56 +0200, Roberto Sassu wrote:
> >> On 5/9/2019 8:34 PM, Rob Landley wrote:
> >>> On 5/9/19 6:24 AM, Roberto Sassu wrote:
> > 
> >>>> The difference with another proposal
> >>>> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> >>>> included in an image without changing the image format, as opposed to
> >>>> defining a new one. As seen from the discussion, if a new format has to be
> >>>> defined, it should fix the issues of the existing format, which requires
> >>>> more time.
> >>>
> >>> So you've explicitly chosen _not_ to address Y2038 while you're there.
> >>
> >> Can you be more specific?
> > 
> > Right, this patch set avoids incrementing the CPIO magic number and
> > the resulting changes required (eg. increasing the timestamp field
> > size), by including a file with the security xattrs in the CPIO.  In
> > either case, including the security xattrs in the initramfs header or
> > as a separate file, the initramfs, itself, needs to be signed.
> 
> The /init binary in the initramfs runs as root and launches all other processes
> on the system. Presumably it can write any xattrs it wants to, and doesn't need
> any extra permissions granted to it to do so. But as soon as you start putting
> xattrs on _other_ files within the initramfs that are _not_ necessarily running
> as PID 1, _that's_ when the need to sign the initramfs comes in?
> 
> Presumably the signing occurs on the gzipped file. How does that affect the cpio
> parsing _after_ it's decompressed? Why would that be part of _this_ patch?

The signing and verification of the initramfs is a separate issue, not
part of this patch set.  The only reason for mentioning it here was to
say that both methods of including the security xattrs require the
initramfs be signed.  Just as the kernel image needs to be signed and
verified, the initramfs should be too.

Mimi


