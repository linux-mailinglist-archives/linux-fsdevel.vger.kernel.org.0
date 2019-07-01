Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC85BE53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfGAObt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 10:31:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728461AbfGAObt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:31:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61ERVtH106275
        for <linux-fsdevel@vger.kernel.org>; Mon, 1 Jul 2019 10:31:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfjx1cb5t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2019 10:31:47 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 1 Jul 2019 15:31:45 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 15:31:39 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61EVcOE23855312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 14:31:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C52E4C044;
        Mon,  1 Jul 2019 14:31:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A394C058;
        Mon,  1 Jul 2019 14:31:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 14:31:36 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-cpio@gnu.org,
        zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, james.w.mcmechan@gmail.com,
        niveditas98@gmail.com
Date:   Mon, 01 Jul 2019 10:31:25 -0400
In-Reply-To: <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
         <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
         <541e9ea1-024f-5c22-0b58-f8692e6c1eb1@landley.net>
         <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
         <1561909199.3985.33.camel@linux.ibm.com>
         <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070114-0028-0000-0000-0000037F5E7C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070114-0029-0000-0000-0000243F94B0
Message-Id: <1561991485.4067.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010179
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-07-01 at 16:42 +0300, Roberto Sassu wrote:
> On 6/30/2019 6:39 PM, Mimi Zohar wrote:
> > On Wed, 2019-06-26 at 10:15 +0200, Roberto Sassu wrote:
> >> On 6/3/2019 8:32 PM, Rob Landley wrote:
> >>> On 6/3/19 4:31 AM, Roberto Sassu wrote:
> >>>>> This patch set aims at solving the following use case: appraise files from
> >>>>> the initial ram disk. To do that, IMA checks the signature/hash from the
> >>>>> security.ima xattr. Unfortunately, this use case cannot be implemented
> >>>>> currently, as the CPIO format does not support xattrs.
> >>>>>
> >>>>> This proposal consists in including file metadata as additional files named
> >>>>> METADATA!!!, for each file added to the ram disk. The CPIO parser in the
> >>>>> kernel recognizes these special files from the file name, and calls the
> >>>>> appropriate parser to add metadata to the previously extracted file. It has
> >>>>> been proposed to use bit 17:16 of the file mode as a way to recognize files
> >>>>> with metadata, but both the kernel and the cpio tool declare the file mode
> >>>>> as unsigned short.
> >>>>
> >>>> Any opinion on this patch set?
> >>>>
> >>>> Thanks
> >>>>
> >>>> Roberto
> >>>
> >>> Sorry, I've had the window open since you posted it but haven't gotten around to
> >>> it. I'll try to build it later today.
> >>>
> >>> It does look interesting, and I have no objections to the basic approach. I
> >>> should be able to add support to toybox cpio over a weekend once I've got the
> >>> kernel doing it to test against.
> >>
> >> Ok.
> >>
> >> Let me give some instructions so that people can test this patch set.
> >>
> >> To add xattrs to the ram disk embedded in the kernel it is sufficient
> >> to set CONFIG_INITRAMFS_FILE_METADATA="xattr" and
> >> CONFIG_INITRAMFS_SOURCE="<file with xattr>" in the kernel configuration.
> >>
> >> To add xattrs to the external ram disk, it is necessary to patch cpio:
> >>
> >> https://github.com/euleros/cpio/commit/531cabc88e9ecdc3231fad6e4856869baa9a91ef
> >> (xattr-v1 branch)
> >>
> >> and dracut:
> >>
> >> https://github.com/euleros/dracut/commit/a2dee56ea80495c2c1871bc73186f7b00dc8bf3b
> >> (digest-lists branch)
> >>
> >> The same modification can be done for mkinitramfs (add '-e xattr' to the
> >> cpio command line).
> >>
> >> To simplify the test, it would be sufficient to replace only the cpio
> >> binary and the dracut script with the modified versions. For dracut, the
> >> patch should be applied to the local dracut (after it has been renamed
> >> to dracut.sh).
> >>
> >> Then, run:
> >>
> >> dracut -e xattr -I <file with xattr> (add -f to overwrite the ram disk)
> >>
> >> Xattrs can be seen by stopping the boot process for example by adding
> >> rd.break to the kernel command line.
> > 
> > A simple way of testing, without needing any changes other than the
> > kernel patches, is to save the dracut temporary directory by supplying
> > "--keep" on the dracut command line, calling
> > usr/gen_initramfs_list.sh, followed by usr/gen_init_cpio with the "-e
> > xattr" option.
> 
> Alternatively, follow the instructions to create the embedded ram disk
> with xattrs, and use the existing external ram disk created with dracut
> to check if xattrs are created.

True, but this alternative is for those who normally use dracut to
create an initramfs, but don't want to update cpio or dracut.

Mimi

