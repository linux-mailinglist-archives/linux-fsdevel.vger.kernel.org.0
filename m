Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92021897E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgGHNsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:48:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729288AbgGHNsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:48:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068DXE6K143958;
        Wed, 8 Jul 2020 09:47:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 325brdf91s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 09:47:56 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068DcUxh156791;
        Wed, 8 Jul 2020 09:47:55 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 325brdf90a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 09:47:55 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068DaDE2022178;
        Wed, 8 Jul 2020 13:47:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3251dw0cts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 13:47:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068DkSUQ60096810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 13:46:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C87D42042;
        Wed,  8 Jul 2020 13:47:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B175842041;
        Wed,  8 Jul 2020 13:47:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.202.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 13:47:46 +0000 (GMT)
Message-ID: <1594216064.23056.208.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] module: Add hook for
 security_kernel_post_read_file()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 08 Jul 2020 09:47:44 -0400
In-Reply-To: <202007071951.605F38D43@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
         <20200707081926.3688096-5-keescook@chromium.org>
         <1594169240.23056.143.camel@linux.ibm.com>
         <202007071951.605F38D43@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_11:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 adultscore=0 cotscore=-2147483648
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080095
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-07-07 at 20:10 -0700, Kees Cook wrote:
> On Tue, Jul 07, 2020 at 08:47:20PM -0400, Mimi Zohar wrote:
> > On Tue, 2020-07-07 at 01:19 -0700, Kees Cook wrote:
> > > Calls to security_kernel_load_data() should be paired with a call to
> > > security_kernel_post_read_file() with a NULL file argument. Add the
> > > missing call so the module contents are visible to the LSMs interested
> > > in measuring the module content. (This also paves the way for moving
> > > module signature checking out of the module core and into an LSM.)
> > > 
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > Fixes: c77b8cdf745d ("module: replace the existing LSM hook in init_module")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  kernel/module.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/module.c b/kernel/module.c
> > > index 0c6573b98c36..af9679f8e5c6 100644
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -2980,7 +2980,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
> > >  		return -EFAULT;
> > >  	}
> > >  
> > > -	return 0;
> > > +	err = security_kernel_post_read_file(NULL, (char *)info->hdr,
> > > +					     info->len, READING_MODULE);
> > 
> > There was a lot of push back on calling security_kernel_read_file()
> > with a NULL file descriptor here.[1]  The result was defining a new
> > security hook - security_kernel_load_data - and enumeration -
> > LOADING_MODULE.  I would prefer calling the same pre and post security
> > hook.
> > 
> > Mimi
> > 
> > [1] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/007110.html
> 
> Ah yes, thanks for the pointer to the discussion.
> 
> I think we have four cases then, for differing LSM hooks:
> 
> - no "file", no contents
> 	e.g. init_module() before copying user buffer
> 	security_kernel_load_data()
> - only a "file" available, no contents
> 	e.g. kernel_read_file() before actually reading anything
> 	security_kernel_read_file()
> - "file" and contents
> 	e.g. kernel_read_file() after reading
> 	security_kernel_post_read_file()
> - no "file" available, just the contents
> 	e.g. firmware platform fallback from EFI space (no "file")
> 	unimplemented!
> 
> If an LSM wants to be able to examine the contents of firmware, modules,
> kexec, etc, it needs either a "file" or the full contents.
> 
> The "file" methods all pass through the kernel_read_file()-family. The
> others happen via blobs coming from userspace or (more recently) the EFI
> universe.
> 
> So, if a NULL file is unreasonable, we need, perhaps,
> security_kernel_post_load_data()
> 
> ?

Agreed.

Mimi
