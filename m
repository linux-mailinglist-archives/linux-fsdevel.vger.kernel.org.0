Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A47241C6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHKObg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:31:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728516AbgHKObf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:31:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BEHBiD045362;
        Tue, 11 Aug 2020 10:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Yagmxe/0xhCzV7sViC0w5EaEzbjV9ZVLiyjz2Hf7nwI=;
 b=WmW+XsVE/7niqWHy/JQJxwCEU6SzQ8cNLjGhq+hM+ezjPGd9JoAGlQIx9TmCtAnoX7uQ
 VLoe//iO1QFAZkYxGLt2yzgnyuMoeraNGIuFs7m2GVcN4a2CpTY/SjM3bybatskt10B+
 Vg6qtcTqwlyJcsNTfFljGYHPTTT2++5VZrDbOVYCGAJb6qlo7mpts2V561GJnewkfqXz
 nNs+NPvbVIL8u8WRT+x10NGC8XCTtFUJl4TBgJ9AFaR7SI1TGjrDGyxNQsOSeK/V9g5h
 eAXZzQLTc+ukqNEt3co+p4QVzapn55P3N6MaL8PobSVtjMUMeB8oC8ShyF4kVob3i0mV Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32uvjarjea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 10:30:27 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07BEI9l4049005;
        Tue, 11 Aug 2020 10:30:26 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32uvjarj9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 10:30:25 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BERPcC004395;
        Tue, 11 Aug 2020 14:30:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 32skah251j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 14:30:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07BEUG5V25625072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 14:30:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF94C42049;
        Tue, 11 Aug 2020 14:30:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FD9142054;
        Tue, 11 Aug 2020 14:30:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Aug 2020 14:30:07 +0000 (GMT)
Message-ID: <e7c1f99d7cdf706ca0867e5fb76ae4cb38bc83f5.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/7] Add support for O_MAYEXEC
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 11 Aug 2020 10:30:06 -0400
In-Reply-To: <20200811140203.GQ17456@casper.infradead.org>
References: <20200723171227.446711-1-mic@digikod.net>
         <202007241205.751EBE7@keescook>
         <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
         <20200810202123.GC1236603@ZenIV.linux.org.uk>
         <917bb071-8b1a-3ba4-dc16-f8d7b4cc849f@digikod.net>
         <CAG48ez0NAV5gPgmbDaSjo=zzE=FgnYz=-OHuXwu0Vts=B5gesA@mail.gmail.com>
         <0cc94c91-afd3-27cd-b831-8ea16ca8ca93@digikod.net>
         <5db0ef9cb5e7e1569a5a1f7a0594937023f7290b.camel@linux.ibm.com>
         <20200811140203.GQ17456@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_13:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110095
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-11 at 15:02 +0100, Matthew Wilcox wrote:
> On Tue, Aug 11, 2020 at 09:56:50AM -0400, Mimi Zohar wrote:
> > On Tue, 2020-08-11 at 10:48 +0200, Mickaël Salaün wrote:
> > > On 11/08/2020 01:03, Jann Horn wrote:
> > > > On Tue, Aug 11, 2020 at 12:43 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > On 10/08/2020 22:21, Al Viro wrote:
> > > > > > On Mon, Aug 10, 2020 at 10:11:53PM +0200, Mickaël Salaün wrote:
> > > > > > > It seems that there is no more complains nor questions. Do you want me
> > > > > > > to send another series to fix the order of the S-o-b in patch 7?
> > > > > > 
> > > > > > There is a major question regarding the API design and the choice of
> > > > > > hooking that stuff on open().  And I have not heard anything resembling
> > > > > > a coherent answer.
> > > > > 
> > > > > Hooking on open is a simple design that enables processes to check files
> > > > > they intend to open, before they open them. From an API point of view,
> > > > > this series extends openat2(2) with one simple flag: O_MAYEXEC. The
> > > > > enforcement is then subject to the system policy (e.g. mount points,
> > > > > file access rights, IMA, etc.).
> > > > > 
> > > > > Checking on open enables to not open a file if it does not meet some
> > > > > requirements, the same way as if the path doesn't exist or (for whatever
> > > > > reasons, including execution permission) if access is denied.
> > > > 
> > > > You can do exactly the same thing if you do the check in a separate
> > > > syscall though.
> > > > 
> > > > And it provides a greater degree of flexibility; for example, you can
> > > > use it in combination with fopen() without having to modify the
> > > > internals of fopen() or having to use fdopen().
> > > > 
> > > > > It is a
> > > > > good practice to check as soon as possible such properties, and it may
> > > > > enables to avoid (user space) time-of-check to time-of-use (TOCTOU)
> > > > > attacks (i.e. misuse of already open resources).
> > > > 
> > > > The assumption that security checks should happen as early as possible
> > > > can actually cause security problems. For example, because seccomp was
> > > > designed to do its checks as early as possible, including before
> > > > ptrace, we had an issue for a long time where the ptrace API could be
> > > > abused to bypass seccomp filters.
> > > > 
> > > > Please don't decide that a check must be ordered first _just_ because
> > > > it is a security check. While that can be good for limiting attack
> > > > surface, it can also create issues when the idea is applied too
> > > > broadly.
> > > 
> > > I'd be interested with such security issue examples.
> > > 
> > > I hope that delaying checks will not be an issue for mechanisms such as
> > > IMA or IPE:
> > > https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/
> > > 
> > > Any though Mimi, Deven, Chrome OS folks?
> > 
> > One of the major gaps, defining a system wide policy requiring all code
> > being executed to be signed, is interpreters.  The kernel has no
> > context for the interpreter's opening the file.  From an IMA
> > perspective, this information needs to be conveyed to the kernel prior
> > to ima_file_check(), which would allow IMA policy rules to be defined
> > in terms of O_MAYEXEC.
> 
> This is kind of evading the point -- Mickaël is proposing a new flag
> to open() to tell IMA to measure the file being opened before the fd
> is returned to userspace, and Al is suggesting a new syscall to allow
> a previously-obtained fd to be measured.
> 
> I think what you're saying is that you don't see any reason to prefer
> one over the other.

Being able to define IMA appraise and measure file open
(func=FILE_CHECK) policy rules  to prevent the interpreter from
executing unsigned files would be really nice.  Otherwise, the file
would be measured and appraised multiple times, once on file open and
again at the point of this new syscall.

Mimi

