Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C51F83A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFMONL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 10:13:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58658 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgFMONK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 10:13:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jk6u9-0007ZI-A7; Sat, 13 Jun 2020 08:13:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jk6u7-0004rb-3O; Sat, 13 Jun 2020 08:13:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606201956.rvfanoqkevjcptfl@ast-mbp>
        <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
        <20200607014935.vhd3scr4qmawq7no@ast-mbp>
        <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
        <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
        <87r1uo2ejt.fsf@x220.int.ebiederm.org>
        <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
        <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
Date:   Sat, 13 Jun 2020 09:08:52 -0500
In-Reply-To: <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Thu, 11 Jun 2020 16:31:34 -0700")
Message-ID: <87bllngirv.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jk6u7-0004rb-3O;;;mid=<87bllngirv.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/13iYtZbp91xMxA5L8c/W+i6dn7Oc4uWE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_08,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1685 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 9 (0.5%), b_tie_ro: 7 (0.4%), parse: 1.62 (0.1%),
        extract_message_metadata: 11 (0.7%), get_uri_detail_list: 9 (0.5%),
        tests_pri_-1000: 6 (0.3%), tests_pri_-950: 1.45 (0.1%),
        tests_pri_-900: 1.20 (0.1%), tests_pri_-90: 315 (18.7%), check_bayes:
        313 (18.6%), b_tokenize: 28 (1.7%), b_tok_get_all: 48 (2.9%),
        b_comp_prob: 8 (0.5%), b_tok_touch_all: 223 (13.2%), b_finish: 0.91
        (0.1%), tests_pri_0: 1321 (78.4%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 1.14 (0.1%), tests_pri_10:
        2.1 (0.1%), tests_pri_500: 7 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jun 10, 2020 at 04:12:29PM -0500, Eric W. Biederman wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> 
>> > On Tue, Jun 09, 2020 at 03:02:30PM -0500, Eric W. Biederman wrote:
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >> 
>> >> > bpf_lsm is that thing that needs to load and start acting early.
>> >> > It's somewhat chicken and egg. fork_usermode_blob() will start a process
>> >> > that will load and apply security policy to all further forks and
>> >> > execs.
>> >> 
>> >> What is the timeframe for bpf_lsm patches wanting to use
>> >> fork_usermode_blob()?
>> >> 
>> >> Are we possibly looking at something that will be ready for the next
>> >> merge window?
>> >
>> > In bpf space there are these that want to use usermode_blobs:
>> > 1. bpfilter itself.
>> > First of all I think we made a mistake delaying landing the main patches:
>> > https://lore.kernel.org/patchwork/patch/902785/
>> > https://lore.kernel.org/patchwork/patch/902783/
>> > without them bpfilter is indeed dead. That probably was the reason
>> > no one was brave enough to continue working on it.
>> > So I think the landed skeleton of bpfilter can be removed.
>> > I think no user space code will notice that include/uapi/linux/bpfilter.h
>> > is gone. So it won't be considered as user space breakage.
>> > Similarly CONFIG_BPFILTER can be nuked too.
>> > bpftool is checking for it (see tools/bpf/bpftool/feature.c)
>> > but it's fine to remove it.
>> > I still think that the approach taken was a correct one, but
>> > lifting that project off the ground was too much for three of us.
>> > So when it's staffed appropriately we can re-add that code.
>> >
>> > 2. bpf_lsm.
>> > It's very active at the moment. I'm working on it as well
>> > (sleepable progs is targeting that), but I'm not sure when folks
>> > would have to have it during the boot. So far it sounds that
>> > they're addressing more critical needs first. "bpf_lsm ready at boot"
>> > came up several times during "bpf office hours" conference calls,
>> > so it's certainly on the radar. If I to guess I don't think
>> > bpf_lsm will use usermode_blobs in the next 6 weeks.
>> > More likely 2-4 month.
>> >
>> > 3. bpf iterator.
>> > It's already capable extension of several things in /proc.
>> > See https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
>> > Cat-ing bpf program as "cat /sys/fs/bpf/my_ipv6_route"
>> > will produce the same human output as "cat /proc/net/ipv6_route".
>> > The key difference is that bpf is all tracing based and it's unstable.
>> > struct fib6_info can change and prog will stop loading.
>> > There are few FIXME in there. That is being addressed right now.
>> > After that the next step is to make cat-able progs available
>> > right after boot via usermode_blobs.
>> > Unlike cases 1 and 2 here we don't care that they appear before pid 1.
>> > They can certainly be chef installed and started as services.
>> > But they are kernel dependent, so deploying them to production
>> > is much more complicated when they're done as separate rpm.
>> > Testing is harder and so on. Operational issues pile up when something
>> > that almost like kernel module is done as a separate package.
>> > Hence usermode_blob fits the best.
>> > Of course we were not planning to add a bunch of them to kernel tree.
>> > The idea was to add only _one_ such cat-able bpf prog and have it as
>> > a selftest for usermode_blob + bpf_iter. What we want our users to
>> > see in 'cat my_ipv6_route' is probably different from other companies.
>> > These patches will likely be using usermode_blob() in the next month.
>> >
>> > But we don't need to wait. We can make the progress right now.
>> > How about we remove bpfilter uapi and rename net/bpfilter/bpfilter_kern.c
>> > into net/umb/umb_test.c only to exercise Makefile to build elf file
>> > from simple main.c including .S with incbin trick
>> > and kernel side that does fork_usermode_blob().
>> > And that's it.
>> > net/ipv4/bpfilter/sockopt.c and kconfig can be removed.
>> > That would be enough base to do use cases 2 and 3 above.
>> > Having such selftest will be enough to adjust the layering
>> > for fork_usermode_blob(), right?
>> 
>> If I understand correctly you are asking people to support out of tree
>> code.  I see some justification for this functionality for in-tree code.
>> For out of tree code there really is no way to understand support or
>> maintain the code.
>
> It's just like saying that sys_finit_module() is there to support out
> of tree code. There are in- and out- tree modules and there will be
> in- and out- of tree bpf programs, but the focus is on those that
> are relevant for the long term future of the kernel.
> The 1 case above is in-tree only. There is nothing in bpfilter
> that makes sense out of tree.
> The 2 case (bpf_lsm) is primarily in-tree. Security is something
> everyone wants its own way, but majority of bpf_lsm functionality
> should live in-tree.
> The 3 case is mostly out-of-tree. If there was obvious way to
> extend /proc it could have been in-tree, but no one will agree.
>
>> We probably also need to have a conversation about why this
>> functionality is a better choice that using a compiled in initramfs,
>> such as can be had by setting CONFIG_INITRAMFS_SOURCE.
>
> I explained it several times already. I don't see how initramfs solves 1 and 2.

You said whatever it was needed to live in the kernel image.
A compiled in initramfs that can be supplemented by a initramfs from the
bootloader is that compiled in situation.  That is what is implemented
with CONFIG_INITRAMFS_SOURCE.

>> Even with this write up and the conversations so far I don't understand
>> what problem fork_usermode_blob is supposed to be solving.  Is there
>> anything kernel version dependent about bpf_lsm?  For me the primary
>> justification of something like fork_usermode_blob is something that is
>> for all practical purposes a kernel module but it just happens to run in
>> usermode.
>
> that's what it is. It's a kernel module that runs in user space.
>
>> From what little I know about bpf_lsm that isn't the case.  So far all
>
> It is.

So the bpf programs will live in the kernel?  Where can I look or has
that part not been merged yet?

>> you have mentioned is that bpf_lsm needs to load early.  That seems like
>> something that could be solved by a couple of lines init/main.c that
>> forks and exec's a program before init if it is present.  Maybe that
>> also needs a bit of protection so the bootloader can't override the
>> binary.
>> 
>> The entire concept of a loadable lsm has me scratching my head.  Last
>> time that concept was seriously looked at the races for initializing per
>> object data were difficult enough to deal with modular support was
>> removed from all of the existing lsms.
>
> I'm not sure what races you're talking about.
> usermode_blob will interact with kernel via syscalls and other standard
> communication mechanism.

The races between the kernel allocating objects say inodes and the code
to place security labels or other markes onto those objects so an
LSM can later make security decisions.

>> Not to mention there are places where the lsm hooks are a pretty lousy
>> API and will be refactored to make things better with no thought of any
>> out of tree code.
>
> I don't see how refactoring LSM hooks is relevant in this discussion.

We were talking about the bpf_lsm, and I have been refactoring the lsm
hooks that run through exec, because they did not have obvious calling
conventions.

If all of the bpf programs for bpf_lsm live in the kernel tree then I
guess there is no problem, but I don't see why in that case you are
using bpf instead of compiling things to C.

When I looked at the bpf_lsm code all I see is a hooks that call out to
bpf programs.  So I made the rather obvious assumption that those bpf
programs are loaded like any other bpf programs from ordinary userspace.

>> > If I understood you correctly you want to replace pid_t
>> > in 'struct umh_info' with proper 'struct pid' pointer that
>> > is refcounted, so user process's exit is clean? What else?
>> 
>> No "if (filename)" or "if (file)" on the exec code paths.  No extra case
>> for the LSM's to have to deal with.  Nothing fork_usermode_blob does is
>> something that can't be done from userspace as far as execve is
>> concerned so there is no justification for any special cases in the core
>> of the exec code.
>
> Adding getname_kernel() instead of filename==NULL is trivial enough
> and makes sense as a cleanup.
> But where do you see 'if (file)' ?
> The correct 'file' pointer is passed from shmem_kernel_file_setup() all
> the way to exec.

In the middle of __do_execve_file:

	if (!file)
		file = do_open_execat(fd, filename, flags);
	retval = PTR_ERR(file);
	if (IS_ERR(file))
		goto out_unmark;

Then just after it we have:

	if (!filename) {
		bprm->filename = "none";
	} else if (fd == AT_FDCWD || filename->name[0] == '/') {
		bprm->filename = filename->name;
	} else {
		if (filename->name[0] == '\0')
			pathbuf = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
		else
			pathbuf = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
					    fd, filename->name);
		if (!pathbuf) {
			retval = -ENOMEM;
			goto out_unmark;
		}
		/*
		 * Record that a name derived from an O_CLOEXEC fd will be
		 * inaccessible after exec. Relies on having exclusive access to
		 * current->files (due to unshare_files above).
		 */
		if (close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
			bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
		bprm->filename = pathbuf;
	}

So we have two core cases in the code that are specific to
fork_usermode_blob, and quite frankly they are both wrong today.

The if (!filename) case does not set BINPRM_FLAGS_PATH_INACCESSIBLE.
The if (file) case does not call get_file(file) and deny_write_access(file).

>> Getting the deny_write_count and the reference count correct on the file
>> argument as well as getting BPRM_FLAGS_PATH_INACCESSIBLE set.
>
> There is no fd because there is no task, but there is a file. I think 
> do_execve should assume BINPRM_FLAGS_PATH_INACCESSIBLE in this case.

I agree that why I said it needs to set that flag, as you can see above
that flag is not set today.

Having BINPRM_FLAGS_PATH_INACCESSIBLE set would slightly relieve
Tetsuo's concern about fork_usermode_blob having a shell script.

>> Using the proper type for argv and envp.
>
> I guess that's going to be a part of other cleanup.

No.  Already answered but again.  Today do_execve_file has the prototype:

int do_execve_file(struct file *file, void *__argv, void *__envp);

void * is definitely not the type that is passed to __argv and __envp,
and that needs to be fixed for that function to remain.

>> Those are the things I know of that need to be addressed.
>> 
>> 
>> Getting the code refactored so that the do_open_execat can be called
>> in do_execveat_common instead of __do_execve_file is enough of a
>> challenge of code motion I really would rather not do that.   Unfortunately that is
>> the only way I can see right now to have both do_execveat_common and
>> do_execve_file pass in a struct file.
>
> The 'struct file' is there. Please take another look at the code.

do_execveat_common passes a NULL file.
While do_execveat_common to be maintainable in this scenario needs to
perform the do_open_execat and pass the file.

That would allow separating out what is specific to do_execve_file
from do_execveat_common.

Which would fundamentally simplify the logic in what is today
__do_execve_file.  The way things are factored today it takes serious
digging to figure out what is going with !file and the !filename
arguments.  We can and should do much better.

Another possible solution which would clean up the code in exec and make
things easier to understand is that there could exist a directory in an
initramfs filesystem somewhere with the names of the programs matching
the module names, and do_execveat_common could just be called with a cwd
on that directory and the name of the module.  Which would remove the
need to have a do_execve_file and do_execve could be used like
everywhere else.

I don't understand why fork_usermode_blob has to reimplement
INITRAMFS_SOURCE but perhaps there is good reason for it.

>> Calling deny_write_access and get_file in do_execve_file and probably
>> a bit more is the only way I can see to cleanly isoloate the special
>> cases fork_usermode_blob brings to the table.
>> 
>> 
>> Strictly speaking I am also aware of the issue that the kernel has to
>> use set_fs(KERNEL_DS) to allow argv and envp to exist in kernel space
>> instead of userspace.  That needs to be fixed as well, but for all
>> kernel uses of exec.  So any work fixing fork_usermode_blob can ignore
>> that issue.
>
> well, this is the problem of usermodehelper_exec.
> usermode_blob doesn't use argv/envp.
> They could be NULL for all practical purpose.

fork_usermode_blob
   call_usermode_helper_setup_file
      split_argv

Addmittedly the only argument split_argv is called on currently is
"bpfilter_umh".  But the code does try and support more.

Should that split_argv be removed?

....

Anyway you asked what needs to be done in exec.

I am in the middle of cleaning up exec.  Send the patches that address
the issues and make this mess not a maintenance issue, and I will be
happy to leave fork_usermode_blob alone.  Otherwise I plan to just
remove the code for now as it is all dead at the moment.

Enough of the argument has been the code which is not merged yet needs
to do X, that this conversation has not been able to point at concrete
parts of the code and argue about them.  I strongly suspect for this
code to be maintainable we need the in-tree users so we can discuss what
is going on.

Eric
