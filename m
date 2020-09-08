Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C3261D8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgIHTiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:38:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730531AbgIHPzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088D3GUh133075;
        Tue, 8 Sep 2020 09:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jfLTOkb0DRyPqo4i4l2p3Sh7Mx8d6J0Yw6pAMOu9mVM=;
 b=nX/01NNxaa92Rl1Ego8qtBlBABFCgR8pOwh/ocMM0ry65QsBwr2XWMKftfg/am870VDp
 stVQ3SJxUP3f6yOobHXoROZmOPZAvEQ6eFZCX9AgIAwavmUq8wRdG5qn3QfY9MxB+8iI
 CV3QaH/gqz2IziqKcP7slNrUzQzCGepZgpp2yrOmLHAswCGz2GaNMVT/QcoXRUSj0vAV
 tuzek9sNCkYWH1LaSxRy8y3Qdx5QkMu3KE1RYbN7lVXw3Z1GGE1rYEKHuzmYJTsfZZ4k
 mj83KsuWDs7Reu1Y7W6uYU9Xf5amXHRNHilE6HXSRIColM6/3hHZbqX+srzr30PqAaUm fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ea0ca170-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 09:29:25 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088D3tGi136068;
        Tue, 8 Sep 2020 09:29:25 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ea0ca14t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 09:29:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088DNdg8022818;
        Tue, 8 Sep 2020 13:29:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 33c2a824t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 13:29:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088DTJ3l18284972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 13:29:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95785A405B;
        Tue,  8 Sep 2020 13:29:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78C3AA4054;
        Tue,  8 Sep 2020 13:29:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.24.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Sep 2020 13:29:11 +0000 (GMT)
Message-ID: <bdc10ab89cf9197e104f02a751009cf0d549ddf5.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v8 1/3] fs: Introduce AT_INTERPRETED flag for
 faccessat2(2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
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
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        John Johansen <john.johansen@canonical.com>
Date:   Tue, 08 Sep 2020 09:29:10 -0400
In-Reply-To: <CAEjxPJ6ZTKeunzJvWf_kS3QYjca6v1yJq=ad-jCCuDSgG6n60g@mail.gmail.com>
References: <20200908075956.1069018-1-mic@digikod.net>
         <20200908075956.1069018-2-mic@digikod.net>
         <d216615b48c093ebe9349a9dab3830b646575391.camel@linux.ibm.com>
         <75451684-58f3-b946-dca4-4760fa0d7440@digikod.net>
         <CAEjxPJ49_BgGX50ZAhHh79Qy3OMN6sssnUHT_2yXqdmgyt==9w@mail.gmail.com>
         <CAEjxPJ6ZTKeunzJvWf_kS3QYjca6v1yJq=ad-jCCuDSgG6n60g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_06:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=866
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-08 at 08:52 -0400, Stephen Smalley wrote:
> On Tue, Sep 8, 2020 at 8:50 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Sep 8, 2020 at 8:43 AM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > >
> > > On 08/09/2020 14:28, Mimi Zohar wrote:
> > > > Hi Mickael,
> > > >
> > > > On Tue, 2020-09-08 at 09:59 +0200, Mickaël Salaün wrote:
> > > >> +                    mode |= MAY_INTERPRETED_EXEC;
> > > >> +                    /*
> > > >> +                     * For compatibility reasons, if the system-wide policy
> > > >> +                     * doesn't enforce file permission checks, then
> > > >> +                     * replaces the execute permission request with a read
> > > >> +                     * permission request.
> > > >> +                     */
> > > >> +                    mode &= ~MAY_EXEC;
> > > >> +                    /* To be executed *by* user space, files must be readable. */
> > > >> +                    mode |= MAY_READ;
> > > >
> > > > After this change, I'm wondering if it makes sense to add a call to
> > > > security_file_permission().  IMA doesn't currently define it, but
> > > > could.
> > >
> > > Yes, that's the idea. We could replace the following inode_permission()
> > > with file_permission(). I'm not sure how this will impact other LSMs though.

I wasn't suggesting replacing the existing security_inode_permission
hook later, but adding a new security_file_permission hook here.

> >
> > They are not equivalent at least as far as SELinux is concerned.
> > security_file_permission() was only to be used to revalidate
> > read/write permissions previously checked at file open to support
> > policy changes and file or process label changes.  We'd have to modify
> > the SELinux hook if we wanted to have it check execute access even if
> > nothing has changed since open time.
> 
> Also Smack doesn't appear to implement file_permission at all, so it
> would skip Smack checking.

My question is whether adding a new security_file_permission call here
would break either SELinux or Apparmor?

Mimi

