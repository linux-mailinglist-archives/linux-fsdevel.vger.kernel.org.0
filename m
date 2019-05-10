Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE75419CEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfEJLuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 07:50:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727210AbfEJLtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 07:49:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ABmBjE065121
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 07:49:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sd76km9np-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 07:49:53 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 10 May 2019 12:49:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 May 2019 12:49:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4ABnihp46530636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:49:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FD974C04A;
        Fri, 10 May 2019 11:49:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DBE34C040;
        Fri, 10 May 2019 11:49:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.242])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 May 2019 11:49:42 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
Date:   Fri, 10 May 2019 07:49:31 -0400
In-Reply-To: <bf0d02fc-d6ce-ef1d-bb7d-7ca14432c6fd@huawei.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
         <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
         <bf0d02fc-d6ce-ef1d-bb7d-7ca14432c6fd@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051011-4275-0000-0000-0000033363FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051011-4276-0000-0000-00003842DA35
Message-Id: <1557488971.10635.102.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100084
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-05-10 at 08:56 +0200, Roberto Sassu wrote:
> On 5/9/2019 8:34 PM, Rob Landley wrote:
> > On 5/9/19 6:24 AM, Roberto Sassu wrote:

> >> The difference with another proposal
> >> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> >> included in an image without changing the image format, as opposed to
> >> defining a new one. As seen from the discussion, if a new format has to be
> >> defined, it should fix the issues of the existing format, which requires
> >> more time.
> > 
> > So you've explicitly chosen _not_ to address Y2038 while you're there.
> 
> Can you be more specific?

Right, this patch set avoids incrementing the CPIO magic number and
the resulting changes required (eg. increasing the timestamp field
size), by including a file with the security xattrs in the CPIO.  In
either case, including the security xattrs in the initramfs header or
as a separate file, the initramfs, itself, needs to be signed.

Mimi

