Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476D51D9419
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESKNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 06:13:40 -0400
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169]:52227 "EHLO
        smtp-42a9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgESKNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 06:13:40 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49RBYF2vl5zlhWfh;
        Tue, 19 May 2020 12:13:37 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49RBY15MbkzlkJkD;
        Tue, 19 May 2020 12:13:25 +0200 (CEST)
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to
 enforce noexec mounts or file exec through O_MAYEXEC)
To:     Aleksa Sarai <cyphar@cyphar.com>, Kees Cook <keescook@chromium.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
 <202005142343.D580850@keescook> <87a729wpu1.fsf@oldenburg2.str.redhat.com>
 <202005150732.17C5EE0@keescook> <87r1vluuli.fsf@oldenburg2.str.redhat.com>
 <202005150847.2B1ED8F81@keescook>
 <20200519022307.oqpdb4vzghs3coyi@yavin.dot.cyphar.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <1477d3d7-4b36-afad-7077-a38f42322238@digikod.net>
Date:   Tue, 19 May 2020 12:13:10 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200519022307.oqpdb4vzghs3coyi@yavin.dot.cyphar.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/05/2020 04:23, Aleksa Sarai wrote:
> On 2020-05-15, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, May 15, 2020 at 04:43:37PM +0200, Florian Weimer wrote:
>>> * Kees Cook:
>>>
>>>> On Fri, May 15, 2020 at 10:43:34AM +0200, Florian Weimer wrote:
>>>>> * Kees Cook:
>>>>>
>>>>>> Maybe I've missed some earlier discussion that ruled this out, but I
>>>>>> couldn't find it: let's just add O_EXEC and be done with it. It actually
>>>>>> makes the execve() path more like openat2() and is much cleaner after
>>>>>> a little refactoring. Here are the results, though I haven't emailed it
>>>>>> yet since I still want to do some more testing:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1
>>>>>
>>>>> I think POSIX specifies O_EXEC in such a way that it does not confer
>>>>> read permissions.  This seems incompatible with what we are trying to
>>>>> achieve here.
>>>>
>>>> I was trying to retain this behavior, since we already make this
>>>> distinction between execve() and uselib() with the MAY_* flags:
>>>>
>>>> execve():
>>>>         struct open_flags open_exec_flags = {
>>>>                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>>>>                 .acc_mode = MAY_EXEC,
>>>>
>>>> uselib():
>>>>         static const struct open_flags uselib_flags = {
>>>>                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>>>>                 .acc_mode = MAY_READ | MAY_EXEC,
>>>>
>>>> I tried to retain this in my proposal, in the O_EXEC does not imply
>>>> MAY_READ:
>>>
>>> That doesn't quite parse for me, sorry.
>>>
>>> The point is that the script interpreter actually needs to *read* those
>>> files in order to execute them.
>>
>> I think I misunderstood what you meant (Mickaël got me sorted out
>> now). If O_EXEC is already meant to be "EXEC and _not_ READ nor WRITE",
>> then yes, this new flag can't be O_EXEC. I was reading the glibc
>> documentation (which treats it as a permission bit flag, not POSIX,
>> which treats it as a complete mode description).
> 
> On the other hand, if we had O_EXEC (or O_EXONLY a-la O_RDONLY) then the
> interpreter could re-open the file descriptor as O_RDONLY after O_EXEC
> succeeds. Not ideal, but I don't think it's a deal-breaker.
> 
> Regarding O_MAYEXEC, I do feel a little conflicted.
> 
> I do understand that its goal is not to be what O_EXEC was supposed to
> be (which is loosely what O_PATH has effectively become), so I think
> that this is not really a huge problem -- especially since you could
> just do O_MAYEXEC|O_PATH if you wanted to disallow reading explicitly.
> It would be nice to have an O_EXONLY concept, but it's several decades
> too late to make it mandatory (and making it optional has questionable
> utility IMHO).
> 
> However, the thing I still feel mildly conflicted about is the sysctl. I
> do understand the argument for it (ultimately, whether O_MAYEXEC is
> usable on a system depends on the distribution) but it means that any
> program which uses O_MAYEXEC cannot rely on it to provide the security
> guarantees they expect. Even if the program goes and reads the sysctl
> value, it could change underneath them. If this is just meant to be a
> best-effort protection then this doesn't matter too much, but I just
> feel uneasy about these kinds of best-effort protections.

I think there is a cognitive bias here. There is a difference between
application-centric policies and system policies. For example, openat2
RESOLVE_* flags targets application developers and are self-sufficient:
the kernel provides features (applied to FDs, owned and managed by user
space) which must be known (by the application) to be supported (by the
kernel), otherwise the application may give more privileges than
expected. However, the O_MAYEXEC flag targets system administrators: it
does not make sense to enable an application to know nor enforce the
system(-wide) policy, but only to enable applications to follow this
policy (i.e. best-effort *from the application developer point of
view*). Indeed, access-control such as file executability depends on
multiple layers (e.g. file permission, mount options, ACL, SELinux
policy), most of them managed and enforced in a consistent way by
(multiple parts of) the system.

Applications should not and it does not make sense for them to expect
anything from O_MAYEXEC. This flag only enables the system to enforce a
security policy and that's all. It is really a different use case than
FD management. This feature is meant to extend the system ability thanks
to applications collaboration. Here the sysctl should not be looked at
by applications, the same way an application should not look at the
currently enforced SELinux policy nor the mount options. An application
may be launched differently according to the system-wide policy, but
this is again a system configuration. There is a difference between ABI
compatibility (i.e. does this feature is supported by the kernel?) and
system-wide security policy (what is the policy of the running system?),
in which case (common) applications should not care about system-wide
policy management but only care about policy enforcement (at their
level, if it makes sense from the system point of view). If the feature
is not provided by the system, then it is not the job of applications to
change their behavior, which means applications do their job by using
O_MAYEXEC but they do not care if it is enforce or not. It does not make
sense for an application to stop because the system does not provide a
system-centric security feature, moreover based on system introspection
(i.e. through sysctl read). It is the system role to provide and
*manage* other components executability.

More explanation can be found in a separate thread:
https://lore.kernel.org/lkml/d5df691d-bfcb-2106-08a2-cfe589b0a86c@digikod.net/

> 
> I do wonder if we could require that fexecve(3) can only be done with
> file descriptors that have been opened with O_MAYEXEC (obviously this
> would also need to be a sysctl -- *sigh*). This would tie in to some of
> the magic-link changes I wanted to push (namely, upgrade_mask).
> 

An O_EXEC flag could make sense for execveat(2), but O_MAYEXEC targets a
different and complementary use case. See
https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/
But again, see the above comment about the rational of system-wide
policy management.
