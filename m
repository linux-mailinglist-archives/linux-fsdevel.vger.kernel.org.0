Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B421A5CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGIR0o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 9 Jul 2020 13:26:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGIR0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:26:41 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mqagw-1kg8Ym2LE8-00mZEm; Thu, 09 Jul 2020 19:26:36 +0200
Received: by mail-qk1-f173.google.com with SMTP id j80so2591176qke.0;
        Thu, 09 Jul 2020 10:26:35 -0700 (PDT)
X-Gm-Message-State: AOAM531+RKtRkkuSgXgTqUGILhhWbsxIdzAT1aBSgOG939KHumFUyfDJ
        eWFXpmRL+71z92CX6oRBXDPp8T60OLHgnFZAaJw=
X-Google-Smtp-Source: ABdhPJxrBo0AwUBiMw2v4TVCTLmtL0EMGqThmAS9J2fIdN9aQHe1QjAu6oSNR/5pXdXtSVlu3fBviu/RfylxDKEg8NM=
X-Received: by 2002:a37:b484:: with SMTP id d126mr64230494qkf.394.1594315594655;
 Thu, 09 Jul 2020 10:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-9-mic@digikod.net>
 <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com>
 <7f407b67-d470-25fd-1287-f4f55f18e74a@digikod.net> <CAK8P3a1ehWZErD2a0iBqn37s-LTAtW0AbV_gt32iX3cQkXbpOQ@mail.gmail.com>
 <ec79f6ad-1c11-d69f-724b-622baa28f19f@digikod.net>
In-Reply-To: <ec79f6ad-1c11-d69f-724b-622baa28f19f@digikod.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Jul 2020 19:26:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34X1qfDhn8u3nR+aQA_g+V2i35L0oTnvhNAs83YJPB_w@mail.gmail.com>
Message-ID: <CAK8P3a34X1qfDhn8u3nR+aQA_g+V2i35L0oTnvhNAs83YJPB_w@mail.gmail.com>
Subject: Re: [PATCH v19 08/12] landlock: Add syscall implementation
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:iRcBYKYD93f4v9LIOGfIm9I4Jp5dCKpb7azDIbgiJg8MrXcXS0A
 3PCcVOfAYcRI9RqKDmiQkMbYZ0QWQ6tXDL9rxGCxG5WlrFaRDOHKRYbFbSi+6Jy2pHO6Mi7
 ZmGLAnY8GSKliBqfkmuFGhPZwK8eksVzan4/FCfakwNgDc9B+RW3Cqwl+rIdyoYOhp9Tspf
 qWrlkU+dQjTqliSx9OkkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WxxayRk9FsM=:QmAt6LpR2PYdjIOJRYCOna
 YmuweTPad0jSOk4xLYarpEbL3+Lz2qI4ov91Vv6HgZn1TjYdFhYMbBLWSIRD9z0ONmEC/Dj40
 eTrg0Gh21wO6R/XIqO6ZORm24FmXJNf/0mwvIpb5CE9zvnauBR/D1rtzBZ7Jctu4l22Y17yfD
 vhiqbsyyQWYIo58aSys4A/i2qzeG96QlY0wS8fTB0a3WovdWwRiSI5dbK34Sm6vCkSLXZDgrV
 rv4F/p2xCSWNBPMooK0TpdZCwOIxQiE4vg4vBIZwHHe4sjbHXCKaWByl+qX8f3u/khlSgTRxb
 egFgqzbTu5sVx/C3HjWYcWmI0yKZl0x3x0phWjW3+w2vYhVw0YRts/56DoDCBCjVqkZt/q9kv
 wCn4FBYj4IrA7noE2G3Th3IW9EaaiE93o6gA2k3ud8dXOaK4ulv6eQ1EsDJOb3wZrRSKxvBgN
 XVMUjYRNtIPeSJrTltDIX3jNoyNF8hv20nhsc0Kc9fzro69Ojbh/2/4/OzaiLnEBLimKCn0b/
 iKXxWrAkeLRlFowhCQhwdeIEmJRFb2zu/cAIcAAkZWksMs4jbd3rSArDHQHuPsILWYqxRg13K
 iFFzBzdUY1ZqcykQLM6enKSuZuw+OUKeT3iKkBbgfO8Gd2tsWcLRC5fgO35ZAR9KznOJ1k6kf
 WrGbsvvHsZW1Iet+CftRVJc2jDgHzxnf6xvowb6HBGkoPx/h0hXaQq+1mmiGBC/7cRYyPZCXs
 cQhdR1tIqqrj/pUIZddn67Bt/x7hWKVN30aRN7AZ1q7/kjurvCOT3di1tTbzE6KWKS9rQ4eYK
 JQc29xsgJ0H4SvDaEN2pjcpk1H+DyP2e2GWPGHU7OuCWiHggc/0tWLT7nQFpPRjba96tGBGoz
 kRLqm6K6weffT+IhAusDJDQzbjHB9bbZjmEy+WqFrTkgAXX6gKumolSL3IBRFE1kkeS+78xU8
 zlD5T7QyG89ju9iSiVyQ6rOlaPvfbUoggHMzw/SdtQsFpZvphgm3E
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 8, 2020 at 7:50 PM Mickaël Salaün <mic@digikod.net> wrote:
> On 08/07/2020 15:49, Arnd Bergmann wrote:
> > On Wed, Jul 8, 2020 at 3:04 PM Mickaël Salaün <mic@digikod.net> wrote:
> >> On 08/07/2020 10:57, Arnd Bergmann wrote:
> >>> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
> >>>
> >>> It looks like all you need here today is a single argument bit, plus
> >>> possibly some room for extensibility. I would suggest removing all
> >>> the extra bits and using a syscall like
> >>>
> >>> SYSCALL_DEFINE1(landlock_create_ruleset, u32, flags);
> >>>
> >>> I don't really see how this needs any variable-length arguments,
> >>> it really doesn't do much.
> >>
> >> We need the attr_ptr/attr_size pattern because the number of ruleset
> >> properties will increase (e.g. network access mask).
> >
> > But how many bits do you think you will *actually* need in total that
> > this needs to be a two-dimensional set of flags? At the moment you
> > only have a single bit that you interpret.
>
> I think there is a misunderstanding. For this syscall I wasn't talking
> about the "options" field but about the "handled_access_fs" field which
> has 14 bits dedicated to control access to the file system:
> https://landlock.io/linux-doc/landlock-v19/security/landlock/user.html#filesystem-flags

Ok, got it. I didn't read far enough there.

> The idea is to add other handled_access_* fields for other kernel object
> types (e.g. network, process, etc.).
>
> The "options" field is fine as a raw __u32 syscall argument.

I'd still like to avoid having it variable-length and structured though.
How about having a __u32 "options" flag, plus an indirect argument
with 32 fixed-length (all 32 bit or all 64 bit) flag words, each of which
corresponds to one of the option bits?

It's still fairly complex that way, but not as much as the version
you have right now that can be extended in multiple dimensions.

This could possibly also help avoid the need for the get_features
syscall: If user space just passes the bitmap of all the access flags
it wants to use in a fixed-size structure, the kernel can update the
bits to mask out the ones it does not understand and write back
that bitmap as the result of create_ruleset().

> >>> To be on the safe side, you might split up the flags into either the
> >>> upper/lower 16 bits or two u32 arguments, to allow both compatible
> >>> (ignored by older kernels if flag is set) and incompatible (return error
> >>> when an unknown flag is set) bits.
> >>
> >> This may be a good idea in general, but in the case of Landlock, because
> >> this kind of (discretionary) sandboxing should be a best-effort security
> >> feature, we should avoid incompatible behavior. In practice, every
> >> unknown bit returns an error because userland can probe for available
> >> bits thanks to the get_features command. This kind of (in)compatibility
> >> can then be handled by userland.
> >
> > If there are not going to be incompatible extensions, then just ignore
> > all unknown bits and never return an error but get rid of the user
> > space probing that just complicates the interface.
>
> There was multiple discussions about ABI compatibility, especially
> inspired by open(2) vs. openat2(2), and ignoring flags seems to be a bad
> idea. In the "sandboxer" example, we first probe the supported features
> and then mask unknown bits (i.e. access rights) at run time in userland.
> This strategy is quite straightforward, backward compatible and
> future-proof.

For behavior changing flags, I agree they should be seen as
incompatible flags (i.e. return an error if an unknown bit is set).

However, for the flags you pass in in an allowlist, treating them
as compatible (i.e. ignore any unknown flags, allowing everything
you are not forbidding already) seems completely reasonable
to me. Do you foresee user space doing anything other than masking
out the bits that the kernel doesn't know about? If not, then doing
it in the  kernel should always be simpler.

> >> I suggest this syscall signature:
> >> SYSCALL_DEFINE3(landlock_create_ruleset, __u32, options, const struct
> >> landlock_attr_ruleset __user *, ruleset_ptr, size_t, ruleset_size);
> >
> > The other problem here is that indirect variable-size structured arguments
> > are a pain to instrument with things like strace or seccomp, so you
> > should first try to use a fixed argument list, and fall back to a fixed
> > structure if that fails.
>
> I agree that it is not perfect with the current tools but this kind of
> extensible structs are becoming common and well defined (e.g. openat2).
> Moreover there is some work going on for seccomp to support "extensible
> argument" syscalls: https://lwn.net/Articles/822256/

openat2() is already more complex than we'd ideally want, I think we
should try hard to make new syscalls simpler than that, following the
rule that any interface should be as simple as possible, but no simpler.

> >>>> +static int syscall_add_rule_path_beneath(const void __user *const attr_ptr,
> >>>> +               const size_t attr_size)
> >>>> +{
> >>>> +       struct landlock_attr_path_beneath attr_path_beneath;
> >>>> +       struct path path;
> >>>> +       struct landlock_ruleset *ruleset;
> >>>> +       int err;
> >>>
> >>> Similarly, it looks like this wants to be
> >>>
> >>> SYSCALL_DEFINE3(landlock_add_rule_path_beneath, int, ruleset, int,
> >>> path, __u32, flags)
> >>>
> >>> I don't see any need to extend this in a way that wouldn't already
> >>> be served better by adding another system call. You might argue
> >>> that 'flags' and 'allowed_access' could be separate, with the latter
> >>> being an indirect in/out argument here, like
> >>>
> >>> SYSCALL_DEFINE4(landlock_add_rule_path_beneath, int, ruleset, int, path,
> >>>                            __u64 *, allowed_acces, __u32, flags)
> >>
> >> To avoid adding a new syscall for each new rule type (e.g. path_beneath,
> >> path_range, net_ipv4_range, etc.), I think it would be better to keep
> >> the attr_ptr/attr_size pattern and to explicitely set a dedicated option
> >> flag to specify the attr type.
> >>
> >> This would look like this:
> >> SYSCALL_DEFINE4(landlock_add_rule, __u32, options, int, ruleset, const
> >> void __user *, rule_ptr, size_t, rule_size);
> >>
> >> The rule_ptr could then point to multiple types like struct
> >> landlock_attr_path_beneath (without the current ruleset_fd field).
> >
> > This again introduces variable-sized structured data. How many different
> > kinds of rule types do you think there will be (most likely, and maybe an
> > upper bound)?
>
> I don't know how many rule types will come, but right now I think it may
> be less than 10.

Ok,

> > Could (some of) these be generalized to use the same data structure?
>
> I don't think so, file path and network addresses are an example of very
> different types.

Clearly the target object is something different, but maybe there is
enough commonality to still make them fit into a more regular form.

For the file system case, you have an identify for an object
(the file descriptor) and the  '__u64 allowed_access'. I would
expect that the 'allowed_access' concept is generic enough that
you can make it a direct argument (32 bit register arg, or pointer
to a __u64). Do you expect others to need something besides
an object identifier and a permission bitmask? Maybe it could
be something like

 SYSCALL_DEFINE4(landlock_add_rule, int, ruleset, __u32, options,
                       const void __user *, object, const __u64 __user
*, allowed_access,
                       __u32, flags);

with a fixed-length 'object' identifier type (file descriptor,
sockaddr_storage, ...) for each option.

    Arnd
