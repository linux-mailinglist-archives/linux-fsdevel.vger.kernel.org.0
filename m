Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D6264C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIJSLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 14:11:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726676AbgIJSK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:10:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AI3eiS035469;
        Thu, 10 Sep 2020 14:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FjhvSZCWrVc2GuEefwPTWWMXiO1Vz/54oCDqSvjTAUA=;
 b=jvZvaNyI3D6ck4Vz/wLNL+BUdL6il13Jzma6dPEMLvd9/QeiVtmpYZ9G2BDJrKoa2Pf3
 qDWxD3uxUvazXL5StzKj+/VPK+8VP5hSyc4Nv+4kFBeg+6Zm2EOWIXcxoxQXJnmGvw8y
 jhPs1RbJ58LPa1GITBKDVer6VbPxzVaBegxACm6xawR3UOrN6+2imVMI+fdWQkm2zPkv
 eRWfpMBze4Fb3hhffadOi1lgnJVFga96Emvwi14G4SFbGe2923+2ROTZZF365Cl1HpIC
 yx+QplZfITiq781JYwgyvt/h8Gcs6H4yoTwqCi8Aq3fNrMnl6/WBKpqE9JIXX8CEdvDr Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33frc6hgmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 14:09:10 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AI4aDF038208;
        Thu, 10 Sep 2020 14:09:10 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33frc6hgk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 14:09:09 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AI97tB003145;
        Thu, 10 Sep 2020 18:09:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 33f91w8gmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 18:09:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AI95de33948012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 18:09:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2130B4C046;
        Thu, 10 Sep 2020 18:09:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D3B84C040;
        Thu, 10 Sep 2020 18:08:57 +0000 (GMT)
Received: from sig-9-65-238-209.ibm.com (unknown [9.65.238.209])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 18:08:57 +0000 (GMT)
Message-ID: <a48145770780d36e90f28f1526805a7292eb74f6.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v9 0/3] Add introspect_access(2) (was O_MAYEXEC)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Philippe =?ISO-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 10 Sep 2020 14:08:56 -0400
In-Reply-To: <f6e2358c-8e5e-e688-3e66-2cdd943e360e@digikod.net>
References: <20200910164612.114215-1-mic@digikod.net>
         <20200910170424.GU6583@casper.infradead.org>
         <f6e2358c-8e5e-e688-3e66-2cdd943e360e@digikod.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=3 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100162
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-10 at 19:21 +0200, Mickaël Salaün wrote:
> On 10/09/2020 19:04, Matthew Wilcox wrote:
> > On Thu, Sep 10, 2020 at 06:46:09PM +0200, Mickaël Salaün wrote:
> >> This ninth patch series rework the previous AT_INTERPRETED and O_MAYEXEC
> >> series with a new syscall: introspect_access(2) .  Access check are now
> >> only possible on a file descriptor, which enable to avoid possible race
> >> conditions in user space.
> > 
> > But introspection is about examining _yourself_.  This isn't about
> > doing that.  It's about doing ... something ... to a script that you're
> > going to execute.  If the script were going to call the syscall, then
> > it might be introspection.  Or if the interpreter were measuring itself,
> > that would be introspection.  But neither of those would be useful things
> > to do, because an attacker could simply avoid doing them.
> 

Michael, is the confusion here that IMA isn't measuring anything, but
verifying the integrity of the file?   The usecase, from an IMA
perspective, is enforcing a system wide policy requiring everything
executed to be signed.  In this particular use case, the interpreter is
asking the kernel if the script is signed with a permitted key.  The
signature may be an IMA signature or an EVM portable and immutable
signature, based on policy.

> Picking a good name other than "access" (or faccessat2) is not easy. The
> idea with introspect_access() is for the calling task to ask the kernel
> if this task should allows to do give access to a kernel resource which
> is already available to this task. In this sense, we think that
> introspection makes sense because it is the choice of the task to allow
> or deny an access.
> 
> > 
> > So, bad name.  What might be better?  sys_security_check()?
> > sys_measure()?  sys_verify_fd()?  I don't know.
> > 
> 
> "security_check" looks quite broad, "measure" doesn't make sense here,
> "verify_fd" doesn't reflect that it is an access check. Yes, not easy,
> but if this is the only concern we are on the good track. :)

Maybe replacing the term "measure" with "integrity", but rather than
"integrity_check", something along the lines of fgetintegrity,
freadintegrity, fcheckintegrity.

Mimi

> 
> 
> Other ideas:
> - interpret_access (mainly, but not only, for interpreters)
> - indirect_access
> - may_access
> - faccessat3


