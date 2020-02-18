Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B14162989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRPhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 10:37:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23850 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgBRPhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:37:10 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IFNtdk153134
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 10:37:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cbap378-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 10:37:08 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Feb 2020 15:37:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 15:36:58 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IFavcP41549922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 15:36:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B335A4062;
        Tue, 18 Feb 2020 15:36:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E470A4054;
        Tue, 18 Feb 2020 15:36:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.154.230])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 15:36:56 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     david.safford@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 18 Feb 2020 10:36:55 -0500
In-Reply-To: <CAE=NcrYwBZVT+xTn384K3fit6UFUES62zsibL=7A5C8_nYaq8A@mail.gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
         <1581366258.5585.891.camel@linux.ibm.com>
         <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
         <1581462616.5125.69.camel@linux.ibm.com>
         <6b787049b965c8056d0e27360e2eaa8fa2f38b35.camel@gmail.com>
         <1581555796.8515.130.camel@linux.ibm.com>
         <CAE=NcrYwBZVT+xTn384K3fit6UFUES62zsibL=7A5C8_nYaq8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021815-0012-0000-0000-00000388022C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021815-0013-0000-0000-000021C492E9
Message-Id: <1582040215.5067.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-13 at 08:41 +0200, Janne Karhunen wrote:
> On Thu, Feb 13, 2020 at 3:03 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > > This is a pretty important new feature.
> > > A lot of people can't use IMA because of the memory issue.
> > > Also, I really think we need to let administrators choose the tradeoffs
> > > of keeping the list in memory, on a local file, or only on the
> > > attestation server, as best fits their use cases.
> >
> > Dave, I understand that some use cases require the ability of
> > truncating the measurement list.  We're discussing how to truncate the
> > measurement list.  For example, in addition to the existing securityfs
> > binary_runtime_measurements file, we could define a new securityfs
> > file indicating the number of records to delete.
> 
> I don't have strong opinions either way, just let me know how to adapt
> the patch and we will get it done asap. I'd prefer a solution where
> the kernel can initiate the flush, but if not then not.

If the measurement list isn't stored in kernel memory, then we would
have the best of both worlds.  The measurement list staying intact for
attestation, with userspace's ability to truncate the measurement list
as desired.  Barring any implementation details, I see this as a win-
win solution.

Mimi

