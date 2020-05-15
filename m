Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD161D5909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOSZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 14:25:05 -0400
Received: from smtp-190a.mail.infomaniak.ch ([185.125.25.10]:44103 "EHLO
        smtp-190a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgEOSZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 14:25:05 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49NxdT5yJKzlhXY4;
        Fri, 15 May 2020 20:24:29 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49NxdJ36FHzlk0vX;
        Fri, 15 May 2020 20:24:20 +0200 (CEST)
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to
 enforce noexec mounts or file exec through O_MAYEXEC)
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
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
        Florian Weimer <fweimer@redhat.com>,
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
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Rich Felker <dalias@aerifal.cx>
References: <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook> <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
 <202005142343.D580850@keescook>
 <1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net>
 <202005150740.F0154DEC@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <d5df691d-bfcb-2106-08a2-cfe589b0a86c@digikod.net>
Date:   Fri, 15 May 2020 20:24:19 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202005150740.F0154DEC@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/05/2020 17:46, Kees Cook wrote:
> On Fri, May 15, 2020 at 01:04:08PM +0200, Mickaël Salaün wrote:
>>
>> On 15/05/2020 10:01, Kees Cook wrote:
>>> On Thu, May 14, 2020 at 09:16:13PM +0200, Mickaël Salaün wrote:
>>>> On 14/05/2020 18:10, Stephen Smalley wrote:
>>>>> On Thu, May 14, 2020 at 11:45 AM Kees Cook <keescook@chromium.org> wrote:
>>>>>> So, it looks like adding FMODE_EXEC into f_flags in do_open() is needed in
>>>>>> addition to injecting MAY_EXEC into acc_mode in do_open()? Hmmm
>>>>>
>>>>> Just do both in build_open_flags() and be done with it? Looks like he
>>>>> was already setting FMODE_EXEC in patch 1 so we just need to teach
>>>>> AppArmor/TOMOYO to check for it and perform file execute checking in
>>>>> that case if !current->in_execve?
>>>>
>>>> I can postpone the file permission check for another series to make this
>>>> one simpler (i.e. mount noexec only). Because it depends on the sysctl
>>>> setting, it is OK to add this check later, if needed. In the meantime,
>>>> AppArmor and Tomoyo could be getting ready for this.
>>>
>>> So, after playing around with this series, investigating Stephen's
>>> comments, digging through the existing FMODE_EXEC uses, and spending a
>>> bit more time thinking about Lev and Aleksa's dislike of the sysctls, I've
>>> got a much more radically simplified solution that I think could work.
>>
>> Not having a sysctl would mean that distros will probably have to patch
>> script interpreters to remove the use of O_MAYEXEC. Or distros would
>> have to exclude newer version of script interpreters because they
>> implement O_MAYEXEC. Or distros would have to patch their kernel to
>> implement themselves the sysctl knob I'm already providing. Sysadmins
>> may not control the kernel build nor the user space build, they control
>> the system configuration (some mount point options and some file
>> execution permissions) but I guess that a distro update breaking a
>> running system is not acceptable. Either way, unfortunately, I think it
>> doesn't help anyone to not have a controlling sysctl. The same apply for
>> access-control LSMs relying on a security policy which can be defined by
>> sysadmins.
>>
>> Your commits enforce file exec checks, which is a good thing from a
>> security point of view, but unfortunately that would requires distros to
>> update all the packages providing shared objects once the dynamic linker
>> uses O_MAYEXEC.
> 
> I used to agree with this, but I'm now convinced now that the sysctls are
> redundant and will ultimately impede adoption. In looking at what levels
> the existing (CLIP OS, Chrome OS) and future (PEP 578) implementations
> have needed to do to meaningfully provide the protection, it seems
> like software will not be using this flag out of the blue. It'll need
> careful addition way beyond the scope of just a sysctl. (As in, I don't
> think using O_MAYEXEC is going to just get added without thought to all
> interpreters. And developers that DO add it will want to know that the
> system will behave in the specified way: having it be off by default
> will defeat the purpose of adding the flag for the end users.)

I think that the different points of view should be the following:
- kernel developer: the app *may* behave this way;
- user space developer: the app *should* behave this way;
- sysadmin: the app *must* behave this way (either enforcing O_MAYEXEC
or not).

The idea is to push adoption of O_MAYEXEC to upstream interpreters,
knowing that it will not break anything on running systems which do not
care about this features. However, on systems which want this feature
enforced, there will be knowledgeable peoples (i.e. sysadmins who
enforced O_MAYEXEC deliberately) to manage it.

If we don't give the opportunity to sysadmins to control this feature,
no upstream interpreters will adopt it. Only tailored distro will use
it, maybe with custom LSM or other way to enforce it anyway, and having
a sysctl or not is not an issue neither. I think it would be a missed
opportunity to help harden most Linux systems.

> 
> I think it boils down to deciding how to control enforcement: should it
> be up to the individual piece of software, or should it be system-wide?
> Looking at the patches Chrome OS has made to the shell (and the
> accompanying system changes), and Python's overall plans, it seems to
> me that the requirements for meaningfully using this flag is going to
> be very software-specific.
> 
> Now, if the goal is to try to get O_MAYEXEC into every interpreter as
> widely as possible without needing to wait for the software-specific
> design changes, then I can see the reason to want a default-off global
> sysctl.

Yes, that is our intention: to make this flag used by most interpreters,
without breaking any existing systems.

> (Though in that case, I suspect it needs to be tied to userns or
> something to support containers with different enforcement levels.)

The LSMs already manage security policies, but the sysctl could indeed
be tied to mount namespaces. This is interesting, but it requires more
complexity. We can start by the current sysctl's bits to manage all the
mount namespaces.

> 
>>> Maybe I've missed some earlier discussion that ruled this out, but I
>>> couldn't find it: let's just add O_EXEC and be done with it. It actually
>>> makes the execve() path more like openat2() and is much cleaner after
>>> a little refactoring. Here are the results, though I haven't emailed it
>>> yet since I still want to do some more testing:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1
>>>
>>> I look forward to flames! ;)
>>>
>>
>> Like Florian said, O_EXEC is for execute-only (which obviously doesn't
>> work for scripts):
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/open.html
>> On the other hand, the semantic of O_MAYEXEC is complementary to other
>> O_* flags. It is inspired by the VM_MAYEXEC flag.
> 
> Ah! I see now -- it's intended to be like the O_*ONLY flags. I
> misunderstood what Florian meant. Okay, sure that's a good enough reason
> for me to retain the O_MAYEXEC name. (And then I think this distinction
> from O_EXEC needs to be well documented.)
> 
>> The O_EXEC flag is specified for open(2). openat2(2) is Linux-specific
>> and it is highly unlikely that new flags will be added to open(2) or
>> openat(2) because of compatibility issues.
> 
> Agreed. (Which in my mind is further rationale that a sysctl isn't
> wanted here: adding O_MAYEXEC will need to be very intentional.)
> 
>> FYI, musl implements O_EXEC on Linux with O_PATH:
>> https://www.openwall.com/lists/musl/2013/02/22/1
>> https://git.musl-libc.org/cgit/musl/commit/?id=6d05d862975188039e648273ceab350d9ab5b69e
>>
>> However, the O_EXEC flag/semantic could be useful for the dynamic
>> linkers, i.e. to only be able to map files in an executable (and
>> read-only) way. If this is OK, then we may want to rename O_MAYEXEC to
>> something like O_INTERPRET. This way we could have two new flags for
>> sightly (but important) different use cases. The sysctl bitfield could
>> be extended to manage both of these flags.
> 
> If it's not O_EXEC, then I do like keeping "EXEC" in the flag name,
> since it has direct relation to noexec and exec-bit. I'm fine with
> O_MAYEXEC -- I just couldn't find the rationale for why it _shouldn't_
> be O_EXEC. (Which is now well understood -- thanks to you you and
> Florian!)
> 
>> Other than that, the other commits are interesting. I'm a bit worried
>> about the implication of the f_flags/f_mode change though.
> 
> That's an area I also didn't see why FMODE_EXEC wasn't retained in
> f_mode. Especially given the nature of the filtering out FMODE_NONOTIFY
> in build_open_flags(). Why would FMODE_NONOTIFY move to f_mode, but not
> FMODE_EXEC?
> 
>> From a practical point of view, I'm also wondering how you intent to
>> submit this series on LKML without conflicting with the current
>> O_MAYEXEC series (versions, changes…). I would like you to keep the
>> warnings from my patches about other ways to execute/interpret code and
>> the threat model (patch 1/6 and 5/6).
> 
> I don't intend it to conflict -- I wanted to have actual code written
> out to share as a basis for discussion. I didn't want to talk about
> "maybe we can try $foo", but rather "here's $foo; what do y'all think?"
> :)
> 

Good :)
