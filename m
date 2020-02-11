Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B984159CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBKXK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 18:10:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25128 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727330AbgBKXK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:10:26 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BMnVAE071012
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 18:10:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucks34f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 18:10:24 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 11 Feb 2020 23:10:20 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Feb 2020 23:10:19 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BNAI4Q53674148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 23:10:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D85A405C;
        Tue, 11 Feb 2020 23:10:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFAE2A4054;
        Tue, 11 Feb 2020 23:10:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.128.4])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Feb 2020 23:10:16 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     david.safford@gmail.com, Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 11 Feb 2020 18:10:16 -0500
In-Reply-To: <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
         <1581366258.5585.891.camel@linux.ibm.com>
         <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021123-4275-0000-0000-000003A03FA9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021123-4276-0000-0000-000038B4789A
Message-Id: <1581462616.5125.69.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_07:2020-02-11,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=2 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-11 at 11:10 -0500, david.safford@gmail.com wrote:
> On Mon, 2020-02-10 at 15:24 -0500, Mimi Zohar wrote:
> > On Mon, 2020-02-10 at 13:18 -0500, david.safford@gmail.com wrote:
> > > On Thu, 2020-02-06 at 09:13 -0500, Mimi Zohar wrote:
> > > > Hi Janne,
> > > > 
> > > > On Fri, 2020-01-10 at 10:48 +0200, Janne Karhunen wrote:
> > > > > On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> > > > > > Some systems can end up carrying lots of entries in the ima
> > > > > > measurement list. Since every entry is using a bit of kernel
> > > > > > memory, allow the sysadmin to export the measurement list to
> > > > > > the filesystem to free up some memory.
> > > > > 
> > > > > Hopefully this addressed comments from everyone. The flush event can
> > > > > now be triggered by the admin anytime and unique file names can be
> > > > > used for each flush (log.1, log.2, ...) etc, so getting to the correct
> > > > > item should be easy.
> > > > > 
> > > > > While it can now be argued that since this is an admin-driven event,
> > > > > kernel does not need to write the file. However, the intention is to
> > > > > bring out a second patch a bit later that adds a variable to define
> > > > > the max number of entries to be kept in the kernel memory and
> > > > > workqueue based automatic flushing. In those cases the kernel has to
> > > > > be able to write the file without any help from the admin..
> > > > 
> > > > The implications of exporting and removing records from the IMA-
> > > > measurement list needs to be considered carefully.  Verifying a TPM
> > > > quote will become dependent on knowing where the measurements are
> > > > stored.  The existing measurement list is stored in kernel memory and,
> > > > barring a kernel memory attack, is protected from modification.
> > > >  Before upstreaming this or a similar patch, there needs to be a
> > > > discussion as to how the measurement list will be protected once is it
> > > > exported to userspace.
> > > 
> > > "Protected" here can mean two different aspects: cryptographically
> > > protected from tampering, which is covered with the TPM_QUOTE, and
> > > availability protected from even accidental deletion, which is what
> > > I suspect you are concerned about. Certainly my original TLV patches
> > > were too flippant about this, as userspace had to be trusted not to
> > > drop any records. In this patch, the kernel writes the data in an
> > > atomic fashion. Either all records are successfully written, or none
> > > are, and an error is returned.
> > 
> > A third aspect, which I'm concerned about, is removing records from
> > the measurement list.  This changes the existing userspace
> > expectations of returning the entire measurement list.  Now userspace
> > will need some out of band method of knowing where to look for the
> > measurements.
> 
> This is a feature, not a bug. :-)
> There is no reason to resend the same data for every attestation,
> nor is there any reason to store already attested measurements anywhere
> on the client. By versioning the log file names, userspace gets a
> simple way to know what has and has not been attested, and for small
> embedded devices we don't need to waste memory or filesystem space
> on the data already attested.

This new feature will require setting up some infrastructure for
storing the partial measurement list(s) in order to validate a TPM
quote.  Userspace already can save partial measurement list(s) without
any kernel changes.  The entire measurement list does not need to be
read each time.  lseek can read past the last record previously read.
 The only new aspect is truncating the in kernel measurement list in
order to free kernel memory.

< snip> 

> > > > Instead of exporting the measurement records, one option as suggested
> > > > by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
> > > > file for backing store.  The existing securityfs measurement lists
> > > > would then read from this private copy of the anonymous file.
> > > 
> > > This doesn't help in use cases where we really do want to
> > > export to a persistent file, without userspace help.
> > 
> > Is to prevent needing to carry the measurement list across kexec the
> > only reason for the kernel needing to write to a persistent file?
> 
> Well, that and the other reasons mentioned, such as completely freeing
> the data from the client after attestation, and simplicity of the
> mechanism.

Until there is proof that the measurement list can be exported to a
file before kexec, instead of carrying the measurement list across
kexec, and a TPM quote can be validated after the kexec, there isn't a
compelling reason for the kernel needing to truncate the measurement
list.

Mimi

