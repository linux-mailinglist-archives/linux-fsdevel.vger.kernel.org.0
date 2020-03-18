Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00718A944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 00:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCRXeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 19:34:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38238 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRXeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:34:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id k21so747268oij.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6IKlL+I/c+Hjy4y3Xx8YKRHHyf6Y2ndtzTeKefGZ0X0=;
        b=DrrXM1TfGXM7JpdPjJELh2Jet/0olmv7sgsJVcrfO7NNAm/C/uyNtme7E3RQnm7e+i
         2YJureu5k61DYblkRP+iPdXjAj6EmoxPiSARalPXqDlODHBYpQUrTo+7+LWZQEaGtq4z
         PWxPkuzUsv3k04l7Z0iBS0WqR/llQh3FVVrQOOulX84B2lD338s2/H/o5WrE5DPjv/Ky
         ROl0qCPSz4ymdkxl27Z6MsJBAKiP17fV4389dy1Dn5iuD3LMNBb4AGc09RyXd4B7XEHE
         ySE3qNl/9EKEnQS5sd1SsSKs/oXsgIHSjA6vuGQmMLZGV+j7AlmeM0VBLcPchf3vk+8Q
         fJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6IKlL+I/c+Hjy4y3Xx8YKRHHyf6Y2ndtzTeKefGZ0X0=;
        b=IYHWhmjFlfLivWr/nw4Pi7qTBmAECBQNYRASS3Nk8ANTwINz5/DIORHVOqav106/pv
         h/ahz6TQp3folEsxbiOqix2LJLyHn9GDPPXoEoI8z7Ge41rTbqopAyPVc+VayqoF4jWY
         rgmJ/f1nK391MvyoJxPuGlR0GOku3x8CQGn+yZqJT3BlxlpwKg3jpNEh0G3eY/ABSoRB
         G5843nKtcP9jSJR73UAhJYpdjwDTN+53GxAV8Gkn5UxE/DTADXz492f3FNknPGvW6vMu
         R3ab7ULVfug+/1p2hyQRv++I/nWqHDouQPKDEPPNBswvl1jzQREXQOjnneNfISk1rZex
         HaTA==
X-Gm-Message-State: ANhLgQ1jToHkD8QdWajMgHXXAVRJC9Dn2dgibKwhiYhNBtJ5TjP30dCR
        GNBAcc8pwi47tPlr1aG9I2lLsV9KqEi5+PUNZRhMng==
X-Google-Smtp-Source: ADFU+vv8F3Y9wGStW1nBrbFs3yrWKsAXE0IC+0piatRYJ3uczWe5YH3FoAj96UZ0SHVWroel259FmrrZ8VibD0XoKz8=
X-Received: by 2002:aca:5e88:: with SMTP id s130mr335083oib.47.1584574450560;
 Wed, 18 Mar 2020 16:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
 <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net> <CAG48ez0=0W5Ok-8nASqZrZ28JboXRRi3gDxV5u6mdcOtzwuRVA@mail.gmail.com>
 <688dda0f-0907-34eb-c19e-3e9e5f613a74@digikod.net> <CAG48ez16yT+zbK1WPxr2TnxrifW5c2DnpFLbWRRLUT_WpuFNmw@mail.gmail.com>
 <e8530226-f295-a897-1132-7e6970dad49f@digikod.net>
In-Reply-To: <e8530226-f295-a897-1132-7e6970dad49f@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 19 Mar 2020 00:33:44 +0100
Message-ID: <CAG48ez1K-7Lq2Ep_p9fOvXQ-fwj_8dA1CFd5SVDbT4ccqejDzA@mail.gmail.com>
Subject: Re: [RFC PATCH v14 00/10] Landlock LSM
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 1:06 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 17/03/2020 20:45, Jann Horn wrote:
> > On Tue, Mar 17, 2020 at 6:50 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> On 17/03/2020 17:19, Jann Horn wrote:
> >>> On Thu, Mar 12, 2020 at 12:38 AM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> >>>> On 10/03/2020 00:44, Jann Horn wrote:
> >>>>> On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> >>
> >> [...]
> >>
> >>>>> Aside from those things, there is also a major correctness issue wh=
ere
> >>>>> I'm not sure how to solve it properly:
> >>>>>
> >>>>> Let's say a process installs a filter on itself like this:
> >>>>>
> >>>>> struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
> >>>>> ACCESS_FS_ROUGHLY_WRITE};
> >>>>> int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
> >>>>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> >>>>> struct landlock_attr_path_beneath path_beneath =3D {
> >>>>>   .ruleset_fd =3D ruleset_fd,
> >>>>>   .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
> >>>>>   .parent_fd =3D open("/tmp/foobar", O_PATH),
> >>>>> };
> >>>>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> >>>>> sizeof(path_beneath), &path_beneath);
> >>>>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> >>>>> struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D rul=
eset_fd };
> >>>>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET=
,
> >>>>> sizeof(attr_enforce), &attr_enforce);
> >>>>>
> >>>>> At this point, the process is not supposed to be able to write to
> >>>>> anything outside /tmp/foobar, right? But what happens if the proces=
s
> >>>>> does the following next?
> >>>>>
> >>>>> struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
> >>>>> ACCESS_FS_ROUGHLY_WRITE};
> >>>>> int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
> >>>>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> >>>>> struct landlock_attr_path_beneath path_beneath =3D {
> >>>>>   .ruleset_fd =3D ruleset_fd,
> >>>>>   .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
> >>>>>   .parent_fd =3D open("/", O_PATH),
> >>>>> };
> >>>>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> >>>>> sizeof(path_beneath), &path_beneath);
> >>>>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> >>>>> struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D rul=
eset_fd };
> >>>>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET=
,
> >>>>> sizeof(attr_enforce), &attr_enforce);
> >>>>>
> >>>>> As far as I can tell from looking at the source, after this, you wi=
ll
> >>>>> have write access to the entire filesystem again. I think the idea =
is
> >>>>> that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileg=
es,
> >>>>> not increase them, right?
> >>>>
> >>>> There is an additionnal check in syscall.c:get_path_from_fd(): it is
> >>>> forbidden to add a rule with a path which is not accessible (accordi=
ng
> >>>> to LANDLOCK_ACCESS_FS_OPEN) thanks to a call to security_file_open()=
,
> >>>> but this is definitely not perfect.
> >>>
> >>> Ah, I missed that.
> >>>
> >>>>> I think the easy way to fix this would be to add a bitmask to each
> >>>>> rule that says from which ruleset it originally comes, and then let
> >>>>> check_access_path() collect these bitmasks from each rule with OR, =
and
> >>>>> check at the end whether the resulting bitmask is full - if not, at
> >>>>> least one of the rulesets did not permit the access, and it should =
be
> >>>>> denied.
> >>>>>
> >>>>> But maybe it would make more sense to change how the API works
> >>>>> instead, and get rid of the concept of "merging" two rulesets
> >>>>> together? Instead, we could make the API work like this:
> >>>>>
> >>>>>  - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
> >>>>> ->private_data contains a pointer to the old ruleset of the process=
,
> >>>>> as well as a pointer to a new empty ruleset.
> >>>>>  - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
> >>>>> permitted by the old ruleset, then adds the rule to the new ruleset
> >>>>>  - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
> >>>>> ->private_data doesn't match the current ruleset of the process, th=
en
> >>>>> replaces the old ruleset with the new ruleset.
> >>>>>
> >>>>> With this, the new ruleset is guaranteed to be a subset of the old
> >>>>> ruleset because each of the new ruleset's rules is permitted by the
> >>>>> old ruleset. (Unless the directory hierarchy rotates, but in that c=
ase
> >>>>> the inaccuracy isn't much worse than what would've been possible
> >>>>> through RCU path walk anyway AFAIK.)
> >>>>>
> >>>>> What do you think?
> >>>>>
> >>>>
> >>>> I would prefer to add the same checks you described at first (with
> >>>> check_access_path), but only when creating a new ruleset with
> >>>> merge_ruleset() (which should probably be renamed). This enables not=
 to
> >>>> rely on a parent ruleset/domain until the enforcement, which is the =
case
> >>>> anyway.
> >>>> Unfortunately this doesn't work for some cases with bind mounts. Bec=
ause
> >>>> check_access_path() goes through one path, another (bind mounted) pa=
th
> >>>> could be illegitimately allowed.
> >>>
> >>> Hmm... I'm not sure what you mean. At the moment, landlock doesn't
> >>> allow any sandboxed process to change the mount hierarchy, right? Can
> >>> you give an example where this would go wrong?
> >>
> >> Indeed, a Landlocked process must no be able to change its mount
> >> namespace layout. However, bind mounts may already exist.
> >> Let's say a process sandbox itself to only access /a in a read-write
> >> way.
> >
> > So, first policy:
> >
> > /a RW
> >
> >> Then, this process (or one of its children) add a new restriction
> >> on /a/b to only be able to read this hierarchy.
> >
> > You mean with the second policy looking like this?
>
> Right.
>
> >
> > /a RW
> > /a/b R
> >
> > Then the resulting policy would be:
> >
> > /a RW policy_bitmask=3D0x00000003 (bits 0 and 1 set)
> > /a/b R policy_bitmask=3D0x00000002 (bit 1 set)
> > required_bits=3D0x00000003 (bits 0 and 1 set)
> >
> >> The check at insertion
> >> time would allow this because this access right is a subset of the
> >> access right allowed with the parent directory. However, If /a/b is bi=
nd
> >> mounted somewhere else, let's say in /private/b, then the second
> >> enforcement just gave new access rights to this hierarchy too.
> >
> > But with the solution I proposed, landlock's path walk would see
> > something like this when accessing a file at /private/b/foo:
> > /private/b/foo <no rules>
> >   policies seen until now: 0x00000000
> > /private/b <access: R, policy_bitmask=3D0x00000002>
> >   policies seen until now: 0x00000002
> > /private <no rules>
> >   policies seen until now: 0x00000002
> > / <no rules>
> >   policies seen until now: 0x00000002
> >
> > It wouldn't encounter any rule from the first policy, so the OR of the
> > seen policy bitmasks would be 0x00000002, which is not the required
> > value 0x00000003, and so the access would be denied.
> As I understand your proposition, we need to build the required_bits
> when adding a rule or enforcing/merging a ruleset with a domain. The
> issue is that a rule only refers to a struct inode, not a struct path.
> For your proposition to work, we would need to walk through the file
> path when adding a rule to a ruleset, which means that we need to depend
> of the current view of the process (i.e. its mount namespace), and its
> Landlock domain.

I don't see why that is necessary. Why would we have to walk the file
path when adding a rule?

> If the required_bits field is set when the ruleset is
> merged with the domain, it is not possible anymore to walk through the
> corresponding initial file path, which makes the enforcement step too
> late to check for such consistency. The important point is that a
> ruleset/domain doesn't have a notion of file hierarchy, a ruleset is
> only a set of tagged inodes.
>
> I'm not sure I got your proposition right, though. When and how would
> you generate the required_bits?

Using your terminology:
A domain is a collection of N layers, which are assigned indices 0..N-1.
For each possible access type, a domain has a bitmask containing N
bits that stores which layers control that access type. (Basically a
per-layer version of fs_access_mask.)
To validate an access, you start by ORing together the bitmasks for
the requested access types; that gives you the required_bits mask,
which lists all layers that want to control the access.
Then you set seen_policy_bits=3D0, then do the
check_access_path_continue() loop while keeping track of which layers
you've seen with "seen_policy_bits |=3D access->contributing_policies",
or something like that.
And in the end, you check that seen_policy_bits is a superset of
required_bits - something like `(~seen_policy_bits) & required_bits =3D=3D
0`.

AFAICS to create a new domain from a bunch of layers, you wouldn't
have to do any path walking.

> Here is my updated proposition: add a layer level and a depth to each
> rule (once enforced/merged with a domain), and a top layer level for a
> domain. When enforcing a ruleset (i.e. merging a ruleset into the
> current domain), the layer level of a new rule would be the incremented
> top layer level.
> If there is no rule (from this domain) tied to the same
> inode, then the depth of the new rule is 1. However, if there is already
> a rule tied to the same inode and if this rule's layer level is the
> previous top layer level, then the depth and the layer level are both
> incremented and the rule is updated with the new access rights (boolean
> AND).
>
> The policy looks like this:
> domain top_layer=3D2
> /a RW policy_bitmask=3D0x00000003 layer=3D1 depth=3D1
> /a/b R policy_bitmask=3D0x00000002 layer=3D2 depth=3D1
>
> The path walk access check walks through all inodes and start with a
> layer counter equal to the top layer of the current domain. For each
> encountered inode tied to a rule, the access rights are checked and a
> new check ensures that the layer of the matching rule is the same as the
> counter (this may be a merged ruleset containing rules pertaining to the
> same hierarchy, which is fine) or equal to the decremented counter (i.e.
> the path walk just reached the underlying layer). If the path walk
> encounter a rule with a layer strictly less than the counter minus one,
> there is a whole in the layers which means that the ruleset
> hierarchy/subset does not match, and the access must be denied.
>
> When accessing a file at /private/b/foo for a read access:
> /private/b/foo <no rules>
>   allowed_access=3Dunknown layer_counter=3D2
> /private/b <access: R, policy_bitmask=3D0x00000002, layer=3D2, depth=3D1>
>   allowed_access=3Dallowed layer_counter=3D2
> /private <no rules>
>   allowed_access=3Dallowed layer_counter=3D2
> / <no rules>
>   allowed_access=3Dallowed layer_counter=3D2
>
> Because the layer_counter didn't reach 1, the access request is then deni=
ed.
>
> This proposition enables not to rely on a parent ruleset at first, only
> when enforcing/merging a ruleset with a domain. This also solves the
> issue with multiple inherited/nested rules on the same inode (in which
> case the depth just grows). Moreover, this enables to safely stop the
> path walk as soon as we reach the layer 1.

(FWIW, you could do the same optimization with the seen_policy_bits approac=
h.)

I guess the difference between your proposal and mine is that in my
proposal, the following would work, in effect permitting W access to
/foo/bar/baz (and nothing else)?

first ruleset:
  /foo W
second ruleset:
  /foo/bar/baz W
third ruleset:
  /foo/bar W

whereas in your proposal, IIUC it wouldn't be valid for a new ruleset
to whitelist a superset of what was whitelisted in a previous ruleset?
