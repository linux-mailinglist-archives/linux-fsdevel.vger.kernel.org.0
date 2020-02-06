Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C914E1545D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFOOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:14:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbgBFOOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:14:01 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016EDdEe060501
        for <linux-fsdevel@vger.kernel.org>; Thu, 6 Feb 2020 09:14:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn5j8sw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 09:14:00 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Feb 2020 14:13:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Feb 2020 14:13:55 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 016EDsud61276348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 14:13:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FE614C040;
        Thu,  6 Feb 2020 14:13:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE1774C052;
        Thu,  6 Feb 2020 14:13:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 14:13:52 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 06 Feb 2020 09:13:52 -0500
In-Reply-To: <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020614-0020-0000-0000-000003A799A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020614-0021-0000-0000-000021FF691C
Message-Id: <1580998432.5585.411.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 suspectscore=2 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Janne,

On Fri, 2020-01-10 at 10:48 +0200, Janne Karhunen wrote:
> On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> >
> > Some systems can end up carrying lots of entries in the ima
> > measurement list. Since every entry is using a bit of kernel
> > memory, allow the sysadmin to export the measurement list to
> > the filesystem to free up some memory.
> 
> Hopefully this addressed comments from everyone. The flush event can
> now be triggered by the admin anytime and unique file names can be
> used for each flush (log.1, log.2, ...) etc, so getting to the correct
> item should be easy.
> 
> While it can now be argued that since this is an admin-driven event,
> kernel does not need to write the file. However, the intention is to
> bring out a second patch a bit later that adds a variable to define
> the max number of entries to be kept in the kernel memory and
> workqueue based automatic flushing. In those cases the kernel has to
> be able to write the file without any help from the admin..

The implications of exporting and removing records from the IMA-
measurement list needs to be considered carefully.  Verifying a TPM
quote will become dependent on knowing where the measurements are
stored.  The existing measurement list is stored in kernel memory and,
barring a kernel memory attack, is protected from modification.
 Before upstreaming this or a similar patch, there needs to be a
discussion as to how the measurement list will be protected once is it
exported to userspace.

This patch now attempts to address two very different scenarios.  The
first scenario is where userspace is requesting exporting and removing
of the measurement list records.  The other scenario is the kernel
exporting and removing of the measurement list records.  Conflating
these two different use cases might not be the right solution, as we
originally thought.

The kernel already exports the IMA measurement list to userspace via a
securityfs file.  From a userspace perspective, missing is the ability
of removing N number of records.  In this scenario, userspace would be
responsible for safely storing the measurements (e.g. blockchain).
 The kernel would only be responsible for limiting permission, perhaps
based on a capability, before removing records from the measurement
list. 

In the kernel usecase, somehow the kernel would need to safely export
the measurement list, or some portion of the measurement list, to a
file and then delete that portion.  What protects the exported records
stored in a file from modification?

Instead of exporting the measurement records, one option as suggested
by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
file for backing store.  The existing securityfs measurement lists
would then read from this private copy of the anonymous file.

I've Cc'ed fsdevel for additional comments/suggestions.

thanks,

Mimi

