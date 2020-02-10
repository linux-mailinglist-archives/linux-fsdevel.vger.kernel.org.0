Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341EE158439
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBJUY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 15:24:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbgBJUY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:24:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AKOM3r013021
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 15:24:26 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn55p4v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 15:24:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 10 Feb 2020 20:24:23 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 20:24:21 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AKOKj058785940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 20:24:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5491A11C052;
        Mon, 10 Feb 2020 20:24:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 621D411C04C;
        Mon, 10 Feb 2020 20:24:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 20:24:19 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     david.safford@gmail.com, Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 15:24:18 -0500
In-Reply-To: <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021020-0008-0000-0000-000003519EFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021020-0009-0000-0000-00004A723E07
Message-Id: <1581366258.5585.891.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_07:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=2 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-10 at 13:18 -0500, david.safford@gmail.com wrote:
> On Thu, 2020-02-06 at 09:13 -0500, Mimi Zohar wrote:
> > Hi Janne,
> > 
> > On Fri, 2020-01-10 at 10:48 +0200, Janne Karhunen wrote:
> > > On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> > > > Some systems can end up carrying lots of entries in the ima
> > > > measurement list. Since every entry is using a bit of kernel
> > > > memory, allow the sysadmin to export the measurement list to
> > > > the filesystem to free up some memory.
> > > 
> > > Hopefully this addressed comments from everyone. The flush event can
> > > now be triggered by the admin anytime and unique file names can be
> > > used for each flush (log.1, log.2, ...) etc, so getting to the correct
> > > item should be easy.
> > > 
> > > While it can now be argued that since this is an admin-driven event,
> > > kernel does not need to write the file. However, the intention is to
> > > bring out a second patch a bit later that adds a variable to define
> > > the max number of entries to be kept in the kernel memory and
> > > workqueue based automatic flushing. In those cases the kernel has to
> > > be able to write the file without any help from the admin..
> > 
> > The implications of exporting and removing records from the IMA-
> > measurement list needs to be considered carefully.  Verifying a TPM
> > quote will become dependent on knowing where the measurements are
> > stored.  The existing measurement list is stored in kernel memory and,
> > barring a kernel memory attack, is protected from modification.
> >  Before upstreaming this or a similar patch, there needs to be a
> > discussion as to how the measurement list will be protected once is it
> > exported to userspace.
> 
> "Protected" here can mean two different aspects: cryptographically
> protected from tampering, which is covered with the TPM_QUOTE, and
> availability protected from even accidental deletion, which is what
> I suspect you are concerned about. Certainly my original TLV patches
> were too flippant about this, as userspace had to be trusted not to
> drop any records. In this patch, the kernel writes the data in an
> atomic fashion. Either all records are successfully written, or none
> are, and an error is returned.

A third aspect, which I'm concerned about, is removing records from
the measurement list.  This changes the existing userspace
expectations of returning the entire measurement list.  Now userspace
will need some out of band method of knowing where to look for the
measurements.

> 
> > This patch now attempts to address two very different scenarios.  The
> > first scenario is where userspace is requesting exporting and removing
> > of the measurement list records.  The other scenario is the kernel
> > exporting and removing of the measurement list records.  Conflating
> > these two different use cases might not be the right solution, as we
> > originally thought.
> 
> Actually there are at least four significant use cases: userspace
> requested, and kernel initiated, both for running out of memory or
> for saving the list prior to a kexec. Exporting everything to a file
> prior to kexec can really simplify all the vaious use cases of 
> template vs TLV formatted lists across kexec. (Consider a modern
> TLV firmware kernel wanting to boot an older kernel that only
> understands template formats. How simple it would be for the first
> kernel to export its list to a file, and the second kernel keeps
> its list in template.)

When Thiago and I added support for carrying the measurement list
across kexec, there were a number of additional measurements after the
kexec load.  These additional measurements will need to be safely
written out to file in order to validate the TPM quote.

> I have been testing this patch on all of these scenarios, and it
> provides a simple, powerful approach for all of them.
 
Were you able to walk the measurement list and validate the TPM quote
after a kexec?

> 
> > The kernel already exports the IMA measurement list to userspace via a
> > securityfs file.  From a userspace perspective, missing is the ability
> > of removing N number of records.  In this scenario, userspace would be
> > responsible for safely storing the measurements (e.g. blockchain).
> >  The kernel would only be responsible for limiting permission, perhaps
> > based on a capability, before removing records from the measurement
> > list. 
> 
> I don't think we want to export 'N' records, as this would
> be really hard to understand and coordinate with userspace.
> Exporting all or none seems simpler.

Userspace already has the ability of exporting the measurement list.
 However, beetween saving the measurement list to a file and telling
the kernel to delete the records from the kernel, additional
measurement could have been added.

> 
> > In the kernel usecase, somehow the kernel would need to safely export
> > the measurement list, or some portion of the measurement list, to a
> > file and then delete that portion.  What protects the exported records
> > stored in a file from modification?
> 
> Tampering is prevented with the TPM_QUOTE. Accidental deletion is
> protected with CAP_SYS_ADMIN. If CAP_SYS_ADMIN is untrusted, you 
> have bigger problems, and even then it will be detected.

Agreed, attestation will detect any tampering, but up to now we didn't
have to rely on DAC/MAC to prevent tampering of the measurement list.

> > Instead of exporting the measurement records, one option as suggested
> > by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
> > file for backing store.  The existing securityfs measurement lists
> > would then read from this private copy of the anonymous file.
> 
> This doesn't help in use cases where we really do want to
> export to a persistent file, without userspace help.

Is to prevent needing to carry the measurement list across kexec the
only reason for the kernel needing to write to a persistent file?

Mimi

