Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3814626152F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgIHQpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:45:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42232 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732052AbgIHQpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:45:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088GYdAi052451;
        Tue, 8 Sep 2020 12:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EdCDJoIowvj8hEecoVwFygUk4z9JYo3xbIrlmFvo17A=;
 b=UR62F6ImD5MURUhgXFM42aLvkVYPvq5sPhR1rY6VJonpNmtvc5nP/bOB3dJCf402kK+8
 yphQ7qCjYaMxQ5+5eFSBV31AYzvBEOF0QPsMuuJlRDD49PDU90wZy8yliNOD5ZTk/69m
 eHMg3uJVH47K1U1ldRUgVIeD30XKw3e3Zrwe6A2Jdon1I9jfnJjm9N9xiwd4cHrNYQVb
 heMYAjEohI8+J9+MVtk8hhKeNJ3an85NTWzpmj808jOENIX5lGgN6hUEy80+d3pUo9KU
 6/tAc3Zah0u6db62MKT96y07x4lOpyXnRRUHkjDC3bTuLaZCV6FOZV030/8fNW5I3eZj sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eckptcy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 12:44:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088G2R1j052727;
        Tue, 8 Sep 2020 12:44:36 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33eckptcw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 12:44:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088Gg7Ho017018;
        Tue, 8 Sep 2020 16:44:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8bn4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 16:44:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088GiThb33685798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 16:44:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0612A4054;
        Tue,  8 Sep 2020 16:44:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3597FA405F;
        Tue,  8 Sep 2020 16:44:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.24.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Sep 2020 16:44:21 +0000 (GMT)
Message-ID: <fd635b544ba4f409a76047a4620656ad67738db1.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v8 1/3] fs: Introduce AT_INTERPRETED flag for
 faccessat2(2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Philippe =?ISO-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Date:   Tue, 08 Sep 2020 12:44:20 -0400
In-Reply-To: <ed832b7f-dc47-fe54-468b-41de3b64fd83@digikod.net>
References: <20200908075956.1069018-1-mic@digikod.net>
         <20200908075956.1069018-2-mic@digikod.net>
         <d216615b48c093ebe9349a9dab3830b646575391.camel@linux.ibm.com>
         <75451684-58f3-b946-dca4-4760fa0d7440@digikod.net>
         <01c23b2607a7dbf734722399931473c053d9b362.camel@linux.ibm.com>
         <ed832b7f-dc47-fe54-468b-41de3b64fd83@digikod.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=919 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-08 at 17:44 +0200, Mickaël Salaün wrote:
> On 08/09/2020 17:24, Mimi Zohar wrote:
> > On Tue, 2020-09-08 at 14:43 +0200, Mickaël Salaün wrote:
> >> On 08/09/2020 14:28, Mimi Zohar wrote:
> >>> Hi Mickael,
> >>>
> >>> On Tue, 2020-09-08 at 09:59 +0200, Mickaël Salaün wrote:
> >>>> diff --git a/fs/open.c b/fs/open.c
> >>>> index 9af548fb841b..879bdfbdc6fa 100644
> >>>> --- a/fs/open.c
> >>>> +++ b/fs/open.c
> >>>> @@ -405,9 +405,13 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
> >>>>  	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
> >>>>  		return -EINVAL;
> >>>>  
> >>>> -	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
> >>>> +	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH |
> >>>> +				AT_INTERPRETED))
> >>>>  		return -EINVAL;
> >>>>  
> >>>> +	/* Only allows X_OK with AT_INTERPRETED for now. */
> >>>> +	if ((flags & AT_INTERPRETED) && !(mode & S_IXOTH))
> >>>> +		return -EINVAL;
> >>>>  	if (flags & AT_SYMLINK_NOFOLLOW)
> >>>>  		lookup_flags &= ~LOOKUP_FOLLOW;
> >>>>  	if (flags & AT_EMPTY_PATH)
> >>>> @@ -426,7 +430,30 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
> >>>>  
> >>>>  	inode = d_backing_inode(path.dentry);
> >>>>  
> >>>> -	if ((mode & MAY_EXEC) && S_ISREG(inode->i_mode)) {
> >>>> +	if ((flags & AT_INTERPRETED)) {
> >>>> +		/*
> >>>> +		 * For compatibility reasons, without a defined security policy
> >>>> +		 * (via sysctl or LSM), using AT_INTERPRETED must map the
> >>>> +		 * execute permission to the read permission.  Indeed, from
> >>>> +		 * user space point of view, being able to execute data (e.g.
> >>>> +		 * scripts) implies to be able to read this data.
> >>>> +		 *
> >>>> +		 * The MAY_INTERPRETED_EXEC bit is set to enable LSMs to add
> >>>> +		 * custom checks, while being compatible with current policies.
> >>>> +		 */
> >>>> +		if ((mode & MAY_EXEC)) {
> >>>
> >>> Why is the ISREG() test being dropped?   Without dropping it, there
> >>> would be no reason for making the existing test an "else" clause.
> >>
> >> The ISREG() is not dropped, it is just moved below with the rest of the
> >> original code. The corresponding code (with the path_noexec call) for
> >> AT_INTERPRETED is added with the next commit, and it relies on the
> >> sysctl configuration for compatibility reasons.
> > 
> > Dropping the S_ISREG() check here without an explanation is wrong and
> > probably unsafe, as it is only re-added in the subsequent patch and
> > only for the "sysctl_interpreted_access" case.  Adding this new test
> > after the existing test is probably safer.  If the original test fails,
> > it returns the same value as this test -EACCES.
> 
> The original S_ISREG() is ANDed with a MAY_EXEC check and with
> path_noexec(). The goal of this patch is indeed to have a different
> behavior than the original faccessat2(2) thanks to the AT_INTERPRETED
> flag. This can't work if we add the sysctl check after the current
> path_noexec() check. Moreover, in this patch an exec check is translated
> to a read check. This new behavior is harmless because using
> AT_INTERPRETED with the current faccessat2(2) would return -EINVAL. The
> current vanilla behavior is then unchanged.

Don't get me wrong.  I'm very interested in having this support and
appreciate all the work you're doing on getting it upstreamed.  With
the change in this patch, I see the MAY_EXEC being changed to MAY_READ,
but I don't see -EINVAL being returned.  It sounds like this change is
dependent on the faccessat2 version for -EINVAL to be returned.

> 
> The whole point of this patch series is to have a policy which do not
> break current systems and is easy to configure by the sysadmin through
> sysctl. This patch series also enable LSMs to take advantage of it
> without the current faccess* limitations. For instance, it is then
> possible for an LSM to implement more complex policies which may allow
> execution of data from pipes or sockets, while verifying the source of
> this data. Enforcing S_ISREG() in this patch would forbid such policies
> to be implemented. In the case of IMA, you may want to add the same
> S_ISREG() check.

> > 
> >>
> >>>
> >>>> +			mode |= MAY_INTERPRETED_EXEC;
> >>>> +			/*
> >>>> +			 * For compatibility reasons, if the system-wide policy
> >>>> +			 * doesn't enforce file permission checks, then
> >>>> +			 * replaces the execute permission request with a read
> >>>> +			 * permission request.
> >>>> +			 */
> >>>> +			mode &= ~MAY_EXEC;
> >>>> +			/* To be executed *by* user space, files must be readable. */
> >>>> +			mode |= MAY_READ;
> > 
> > 


