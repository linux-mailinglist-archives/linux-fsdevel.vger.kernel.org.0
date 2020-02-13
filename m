Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB415B650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgBMBDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 20:03:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729190AbgBMBDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:03:25 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D0sW0W127107
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 20:03:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qys8ej6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 20:03:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 13 Feb 2020 01:03:22 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 01:03:18 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D12NYH34406798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 01:02:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E214011C04C;
        Thu, 13 Feb 2020 01:03:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2D2211C052;
        Thu, 13 Feb 2020 01:03:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.187])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 01:03:16 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     david.safford@gmail.com, Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 12 Feb 2020 20:03:16 -0500
In-Reply-To: <6b787049b965c8056d0e27360e2eaa8fa2f38b35.camel@gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
         <1581366258.5585.891.camel@linux.ibm.com>
         <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
         <1581462616.5125.69.camel@linux.ibm.com>
         <6b787049b965c8056d0e27360e2eaa8fa2f38b35.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021301-0008-0000-0000-0000035253B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021301-0009-0000-0000-00004A72FADB
Message-Id: <1581555796.8515.130.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_10:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=2 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130006
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-02-12 at 16:08 -0500, david.safford@gmail.com wrote:
> On Tue, 2020-02-11 at 18:10 -0500, Mimi Zohar wrote:
> > On Tue, 2020-02-11 at 11:10 -0500, david.safford@gmail.com wrote:
> 
> > > <snip>
> > > 
> > This new feature will require setting up some infrastructure for
> > storing the partial measurement list(s) in order to validate a TPM
> > quote.  Userspace already can save partial measurement list(s) without
> > any kernel changes.  The entire measurement list does not need to be
> > read each time.  lseek can read past the last record previously read.
> >  The only new aspect is truncating the in kernel measurement list in
> > order to free kernel memory.
> 
> This is a pretty important new feature.
> A lot of people can't use IMA because of the memory issue.
> Also, I really think we need to let administrators choose the tradeoffs
> of keeping the list in memory, on a local file, or only on the 
> attestation server, as best fits their use cases.

Dave, I understand that some use cases require the ability of
truncating the measurement list.  We're discussing how to truncate the
measurement list.  For example, in addition to the existing securityfs
binary_runtime_measurements file, we could define a new securityfs
file indicating the number of records to delete.

> > 
> > < snip> 
> > 
> > Until there is proof that the measurement list can be exported to a
> > file before kexec, instead of carrying the measurement list across
> > kexec, and a TPM quote can be validated after the kexec, there isn't a
> > compelling reason for the kernel needing to truncate the measurement
> > list.
> 
> If this approach doesn't work with all the kexec use cases, then it is 
> useless, and the ball is in my court to prove that it does. Fortunately
> I have to test that anyway for the coming TLV support.
> 
> Working on it...

Testing could be done independently of the TLV support.  To verify
that you aren't loosing any measurements, boot with a measurement
policy like "ima_policy=tcb" on the boot command line.

thanks,

Mimi

