Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203E555B2B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiFZPsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZPsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:48:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D956BC0E;
        Sun, 26 Jun 2022 08:48:52 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25QEC3hk026475;
        Sun, 26 Jun 2022 15:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Vx8qhw9gsD0GT+n5MLIi+2BfObnIPd+FACJyCWPp8I8=;
 b=a1+0w5V9zR4fLwolFFcdgiYDd9Z0TtUsQm43h6ECifBvltnDtebBIT74AiGh/hV8cI9s
 xmAQQRRJvkrnXzWr9BmuRdKgmf6quhX+c4Xwtxy2PNLTw9yHax1iwKVJYlJDB0hV7D+z
 U77yZiNCQKeCLF6jkr1Rn0wQLWbVR6IpO3SPGolpog30oQfs14cGd0RpJv8mcE7jrHsD
 gaqjXphF1jwO4d4OzrefKH2MDlvtb075DKJZ6ZI3elO8wW1eGkSZQg9IUzEYDNLu0Y0O
 YdEVAsWKg9ahk/obUuQ5nnz8yCXrIMcL+tHfVVsRRfQVMkthfR6LI1X9vHrvbuvJxjSj Yg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxs0hs6vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 15:48:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25QFlSel001778;
        Sun, 26 Jun 2022 15:48:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj1qn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 15:48:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25QFmBZt14221784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 15:48:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A40C11C050;
        Sun, 26 Jun 2022 15:48:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA1811C04A;
        Sun, 26 Jun 2022 15:48:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.95.64])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jun 2022 15:48:07 +0000 (GMT)
Message-ID: <54af4a92356090d88639531413ea8cb46837bd18.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 2/3] fs: define a firmware security filesystem
 named fwsecurityfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Date:   Sun, 26 Jun 2022 11:48:06 -0400
In-Reply-To: <41ca51e8db9907d9060cc38adb59a66dcae4c59b.camel@HansenPartnership.com>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
         <20220622215648.96723-3-nayna@linux.ibm.com> <YrQqPhi4+jHZ1WJc@kroah.com>
         <41ca51e8db9907d9060cc38adb59a66dcae4c59b.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9AuopBc9nCHv2PWc6MREZAyjLibJAqd-
X-Proofpoint-ORIG-GUID: 9AuopBc9nCHv2PWc6MREZAyjLibJAqd-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-26_03,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206260064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-06-23 at 09:23 -0400, James Bottomley wrote:
> On Thu, 2022-06-23 at 10:54 +0200, Greg Kroah-Hartman wrote:
> [...]
> > > diff --git a/fs/fwsecurityfs/inode.c b/fs/fwsecurityfs/inode.c
> > > new file mode 100644
> > > index 000000000000..5d06dc0de059
> > > --- /dev/null
> > > +++ b/fs/fwsecurityfs/inode.c
> > > @@ -0,0 +1,159 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2022 IBM Corporation
> > > + * Author: Nayna Jain <nayna@linux.ibm.com>
> > > + */
> > > +
> > > +#include <linux/sysfs.h>
> > > +#include <linux/kobject.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/fs_context.h>
> > > +#include <linux/mount.h>
> > > +#include <linux/pagemap.h>
> > > +#include <linux/init.h>
> > > +#include <linux/namei.h>
> > > +#include <linux/security.h>
> > > +#include <linux/lsm_hooks.h>
> > > +#include <linux/magic.h>
> > > +#include <linux/ctype.h>
> > > +#include <linux/fwsecurityfs.h>
> > > +
> > > +#include "internal.h"
> > > +
> > > +int fwsecurityfs_remove_file(struct dentry *dentry)
> > > +{
> > > +	drop_nlink(d_inode(dentry));
> > > +	dput(dentry);
> > > +	return 0;
> > > +};
> > > +EXPORT_SYMBOL_GPL(fwsecurityfs_remove_file);
> > > +
> > > +int fwsecurityfs_create_file(const char *name, umode_t mode,
> > > +					u16 filesize, struct dentry
> > > *parent,
> > > +					struct dentry *dentry,
> > > +					const struct file_operations
> > > *fops)
> > > +{
> > > +	struct inode *inode;
> > > +	int error;
> > > +	struct inode *dir;
> > > +
> > > +	if (!parent)
> > > +		return -EINVAL;
> > > +
> > > +	dir = d_inode(parent);
> > > +	pr_debug("securityfs: creating file '%s'\n", name);
> > 
> > Did you forget to call simple_pin_fs() here or anywhere else?
> > 
> > And this can be just one function with the directory creation file,
> > just check the mode and you will be fine.  Look at securityfs as an
> > example of how to make this simpler.
> 
> Actually, before you go down this route can you consider the namespace
> ramifications.  In fact we're just having to rework securityfs to pull
> out all the simple_pin_... calls because simple_pin_... is completely
> inimical to namespaces.
> 
> The first thing to consider is if you simply use securityfs you'll
> inherit all the simple_pin_... removal work and be namespace ready.  It
> could be that creating a new filesystem that can't be namespaced is the
> right thing to do here, but at least ask the question: would we ever
> want any of these files to be presented selectively inside containers? 
> If the answer is "yes" then simple_pin_... is the wrong interface.

Greg, the securityfs changes James is referring to are part of the IMA
namespacing patch set:
https://lore.kernel.org/linux-integrity/20220420140633.753772-1-stefanb@linux.ibm.com/

I'd really appreciate your reviewing the first two patches:
[PATCH v12 01/26] securityfs: rework dentry creation
[PATCH v12 02/26] securityfs: Extend securityfs with namespacing
support

thanks,

Mimi



