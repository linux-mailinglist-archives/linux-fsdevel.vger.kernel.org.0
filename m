Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF520836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfEPNby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 09:31:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbfEPNby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 09:31:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GDR76O083500
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 09:31:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sh8hrs32x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 09:31:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 May 2019 14:31:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 14:31:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GDVjWR52035654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 13:31:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DBFFAE056;
        Thu, 16 May 2019 13:31:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63E07AE045;
        Thu, 16 May 2019 13:31:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.230])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 May 2019 13:31:43 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mehmet Kayaalp <mkayaalp@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Rob Landley <rob@landley.net>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 16 May 2019 09:31:32 -0400
In-Reply-To: <20190516052934.GA68777@rani.riverdale.lan>
References: <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
         <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
         <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
         <1557861511.3378.19.camel@HansenPartnership.com>
         <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
         <1557878052.2873.6.camel@HansenPartnership.com>
         <20190515005221.GB88615@rani.riverdale.lan>
         <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
         <20190515160834.GA81614@rani.riverdale.lan>
         <ce65240a-4df6-8ebc-8360-c01451e724f0@huawei.com>
         <20190516052934.GA68777@rani.riverdale.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051613-0020-0000-0000-0000033D5A54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051613-0021-0000-0000-000021902221
Message-Id: <1558013492.4581.97.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-05-16 at 01:29 -0400, Arvind Sankar wrote:

> I think that's a separate issue. If you want to allow people to be able
> to put files onto the system that will be IMA verified, they need to
> have some way to locally sign them whether it's inside an initramfs or
> on a real root filesystem.

Anyone building their own kernel can build their own key into the
kernel image.  Another option is to build the kernel with  
CONFIG_SYSTEM_EXTRA_CERTIFICATE enabled, allowing an additional
certificate to be inserted into the kernel image post build.  The
additional certificate will be loaded onto the builtin kernel keyring.
 Certificates signed with the private key can then be added to the IMA
keyring.  By modifying the kernel image, the kernel image obviously
needs to be resigned.  Additional patches "Certificate insertion
support for x86 bzImages" were posted, but have not been upstreamed.

This patch set adds the security xattrs needed by IMA.

Mimi


 













