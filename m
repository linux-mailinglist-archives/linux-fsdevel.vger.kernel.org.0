Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC21157EBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 16:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgBJP0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 10:26:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727363AbgBJP0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:26:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AFJGIe038663
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 10:26:21 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9p33n4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 10:26:21 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 10 Feb 2020 15:26:19 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 15:26:16 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AFQFgV31064454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 15:26:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD41952052;
        Mon, 10 Feb 2020 15:26:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.79])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 828CD52059;
        Mon, 10 Feb 2020 15:26:14 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 10:26:13 -0500
In-Reply-To: <CAE=NcrYhz7zrhxZoVDSvfs+Cd-vNX30gGXU9Xu4K7ft-1ozN2g@mail.gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <CAE=NcrYhz7zrhxZoVDSvfs+Cd-vNX30gGXU9Xu4K7ft-1ozN2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021015-0016-0000-0000-000002E585A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021015-0017-0000-0000-0000334877FB
Message-Id: <1581348373.5585.798.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_05:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=973 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-10 at 10:04 +0200, Janne Karhunen wrote:
> On Thu, Feb 6, 2020 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > The implications of exporting and removing records from the IMA-
> > measurement list needs to be considered carefully.  Verifying a TPM
> > quote will become dependent on knowing where the measurements are
> > stored.  The existing measurement list is stored in kernel memory and,
> > barring a kernel memory attack, is protected from modification.
> >  Before upstreaming this or a similar patch, there needs to be a
> > discussion as to how the measurement list will be protected once is it
> > exported to userspace.
> >
> > This patch now attempts to address two very different scenarios.  The
> > first scenario is where userspace is requesting exporting and removing
> > of the measurement list records.  The other scenario is the kernel
> > exporting and removing of the measurement list records.  Conflating
> > these two different use cases might not be the right solution, as we
> > originally thought.
> >
> > The kernel already exports the IMA measurement list to userspace via a
> > securityfs file.  From a userspace perspective, missing is the ability
> > of removing N number of records.  In this scenario, userspace would be
> > responsible for safely storing the measurements (e.g. blockchain).
> >  The kernel would only be responsible for limiting permission, perhaps
> > based on a capability, before removing records from the measurement
> > list.
> 
> This is a good point. I will adapt the patch to this.
> 
> 
> > In the kernel usecase, somehow the kernel would need to safely export
> > the measurement list, or some portion of the measurement list, to a
> > file and then delete that portion.  What protects the exported records
> > stored in a file from modification?
> 
> Are we looking at protecting this file from a root exploit and the
> potential DOS it might cause? In the original patch the file was root
> writable only. As far as further limitations go, the easiest would
> probably be to use the file immutable bit. If the kernel opens the
> file and sets the immutable bit, it is the only entity that can ever
> write to it - not even another root task could directly write to it.
> The kernel could, as long as it keeps the file open.

The problem being addressed is freeing kernel memory instead of
letting the measurement list grow unbounded.  One solution is to
remove measurement list records, as you did, but that changes the
existing userspace expectations of returning the entire measurement
list.  In the userspace scenario, removing measurement list records is
the requirement.  For the kernel scenario, I don't think it is a
requirement.

> 
> > Instead of exporting the measurement records, one option as suggested
> > by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
> > file for backing store.  The existing securityfs measurement lists
> > would then read from this private copy of the anonymous file.
> >
> > I've Cc'ed fsdevel for additional comments/suggestions.
> 
> I didn't quickly see what the actual problem is that the vfs_tmpfile
> solves in this context, will check.

The existing IMA measurement list is by design, as coined by George
Wilson, a "deliberate memory leak".  Fixing the "Deliberate IMA event
log memory leak" should be the problem description.  Amir's suggestion
of using a vfs_tmpfile seems like a reasonable solution.

Mimi

