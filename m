Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14218C22C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 22:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSVSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 17:18:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40726 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCSVSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:18:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id y71so4300945oia.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4C+0nKFxrFROQId9OciywMK+cltQuGW8rSImB/XpE18=;
        b=Tf78afLj/m/bi1jEn2dedtTK5zop4owAQzcX3wyo5V2S+9CuMcHQb2WI6FP6o3Jb2Z
         9kG2/43U+Ux4h8FtNpjk+dvWJOkqXBWhJc6u+oszorqaLHlefR2HxruTLUgbDo9vtvs9
         VsZfgRLTaDof9ve4kEgPIrUa3y1cMTBN6hZtnaLs1AUr6TNJz6UU0YHepkEtgP5XiUBo
         yKfGqXYLL9STToaIsbEUGRI1l+5P/o1MiTU9WHK8HQ7e2atdfkQmnMU4HyHhfDTty3Hg
         tRea4auOXg+pxAvVuGDWpY9By8Z3tZloSjkVxqfNaY2jmWk33NoRBXSoywuJZbuc6Elk
         IvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4C+0nKFxrFROQId9OciywMK+cltQuGW8rSImB/XpE18=;
        b=mdH1WYKGfposyywhIeYWT4oXWD02+h28CZRTO8+15MN4pfoRVeiXeuLv93QsQvtFit
         JdHiGBJ80RzTe73x7JK3kOohFNrKk/RHfSqSZIaR233ZyxOJxQubx29PwZnGuLpa64xg
         kiFyWgO0mPULZqmmYZ9r63i5CimSG8eeuhiZlku5QZZjINNDr9wbDVZQDM8pIIRoqP4z
         wUm3fe6W9/Sp4DE03pkK/A/4MiUeTTX+cr0dzXmCazzRzC1R4xKBC3ng3Bpxcan2Rqn1
         CExl1xFoUGZSs6zo1odBFW2qAOhjmF25DZg6q2eNgzM9wr9GHqRAgJepfXsljl3Fj/8h
         E9jg==
X-Gm-Message-State: ANhLgQ1wMb7yhXU9VWAUezBYpwDuzOkyxCThm9XsaK1HxdYIRB6N8m3b
        EqkvrcAO6r6Eo1RCphAmaj6PxRgTvviEiioVmXNZpw==
X-Google-Smtp-Source: ADFU+vvHueiVN2vm54kmRzDAr+XPiDXdCxsSO49VaaCHt9qN865al8ErN5y3kk+48T9ySDC+IbgANXTlwgqIxqx4psI=
X-Received: by 2002:aca:bac1:: with SMTP id k184mr4023086oif.157.1584652683852;
 Thu, 19 Mar 2020 14:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
 <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net> <CAG48ez0=0W5Ok-8nASqZrZ28JboXRRi3gDxV5u6mdcOtzwuRVA@mail.gmail.com>
 <688dda0f-0907-34eb-c19e-3e9e5f613a74@digikod.net> <CAG48ez16yT+zbK1WPxr2TnxrifW5c2DnpFLbWRRLUT_WpuFNmw@mail.gmail.com>
 <e8530226-f295-a897-1132-7e6970dad49f@digikod.net> <CAG48ez1K-7Lq2Ep_p9fOvXQ-fwj_8dA1CFd5SVDbT4ccqejDzA@mail.gmail.com>
 <2d48e3e3-e7b2-ec33-91c5-be6a308a12d4@digikod.net>
In-Reply-To: <2d48e3e3-e7b2-ec33-91c5-be6a308a12d4@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 19 Mar 2020 22:17:37 +0100
Message-ID: <CAG48ez18LrDVLdp3agTwHNYxOBJyEb5PZ1dkwbNjpPVQoTsLcA@mail.gmail.com>
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

On Thu, Mar 19, 2020 at 5:58 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 19/03/2020 00:33, Jann Horn wrote:
> > On Wed, Mar 18, 2020 at 1:06 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
[...]
> >> As I understand your proposition, we need to build the required_bits
> >> when adding a rule or enforcing/merging a ruleset with a domain. The
> >> issue is that a rule only refers to a struct inode, not a struct path.
> >> For your proposition to work, we would need to walk through the file
> >> path when adding a rule to a ruleset, which means that we need to depe=
nd
> >> of the current view of the process (i.e. its mount namespace), and its
> >> Landlock domain.
> >
> > I don't see why that is necessary. Why would we have to walk the file
> > path when adding a rule?
> >
> >> If the required_bits field is set when the ruleset is
> >> merged with the domain, it is not possible anymore to walk through the
> >> corresponding initial file path, which makes the enforcement step too
> >> late to check for such consistency. The important point is that a
> >> ruleset/domain doesn't have a notion of file hierarchy, a ruleset is
> >> only a set of tagged inodes.
> >>
> >> I'm not sure I got your proposition right, though. When and how would
> >> you generate the required_bits?
> >
> > Using your terminology:
> > A domain is a collection of N layers, which are assigned indices 0..N-1=
.
> > For each possible access type, a domain has a bitmask containing N
> > bits that stores which layers control that access type. (Basically a
> > per-layer version of fs_access_mask.)
>
> OK, so there is a bit for each domain, which means that you get a limit
> of, let's say 64 layers? Knowing that each layer can be created by a
> standalone application, potentially nested in a bunch of layers, this
> seems artificially limiting.

Yes, that is a downside of my approach.

> > To validate an access, you start by ORing together the bitmasks for
> > the requested access types; that gives you the required_bits mask,
> > which lists all layers that want to control the access.
> > Then you set seen_policy_bits=3D0, then do the
> > check_access_path_continue() loop while keeping track of which layers
> > you've seen with "seen_policy_bits |=3D access->contributing_policies",
> > or something like that.
> > And in the end, you check that seen_policy_bits is a superset of
> > required_bits - something like `(~seen_policy_bits) & required_bits =3D=
=3D
> > 0`.
> >
> > AFAICS to create a new domain from a bunch of layers, you wouldn't
> > have to do any path walking.
>
> Right, I misunderstood your previous email.
>
> >
> >> Here is my updated proposition: add a layer level and a depth to each
> >> rule (once enforced/merged with a domain), and a top layer level for a
> >> domain. When enforcing a ruleset (i.e. merging a ruleset into the
> >> current domain), the layer level of a new rule would be the incremente=
d
> >> top layer level.
> >> If there is no rule (from this domain) tied to the same
> >> inode, then the depth of the new rule is 1. However, if there is alrea=
dy
> >> a rule tied to the same inode and if this rule's layer level is the
> >> previous top layer level, then the depth and the layer level are both
> >> incremented and the rule is updated with the new access rights (boolea=
n
> >> AND).
> >>
> >> The policy looks like this:
> >> domain top_layer=3D2
> >> /a RW policy_bitmask=3D0x00000003 layer=3D1 depth=3D1
> >> /a/b R policy_bitmask=3D0x00000002 layer=3D2 depth=3D1
> >>
> >> The path walk access check walks through all inodes and start with a
> >> layer counter equal to the top layer of the current domain. For each
> >> encountered inode tied to a rule, the access rights are checked and a
> >> new check ensures that the layer of the matching rule is the same as t=
he
> >> counter (this may be a merged ruleset containing rules pertaining to t=
he
> >> same hierarchy, which is fine) or equal to the decremented counter (i.=
e.
> >> the path walk just reached the underlying layer). If the path walk
> >> encounter a rule with a layer strictly less than the counter minus one=
,
> >> there is a whole in the layers which means that the ruleset
> >> hierarchy/subset does not match, and the access must be denied.
> >>
> >> When accessing a file at /private/b/foo for a read access:
> >> /private/b/foo <no rules>
> >>   allowed_access=3Dunknown layer_counter=3D2
> >> /private/b <access: R, policy_bitmask=3D0x00000002, layer=3D2, depth=
=3D1>
> >>   allowed_access=3Dallowed layer_counter=3D2
> >> /private <no rules>
> >>   allowed_access=3Dallowed layer_counter=3D2
> >> / <no rules>
> >>   allowed_access=3Dallowed layer_counter=3D2
> >>
> >> Because the layer_counter didn't reach 1, the access request is then d=
enied.
> >>
> >> This proposition enables not to rely on a parent ruleset at first, onl=
y
> >> when enforcing/merging a ruleset with a domain. This also solves the
> >> issue with multiple inherited/nested rules on the same inode (in which
> >> case the depth just grows). Moreover, this enables to safely stop the
> >> path walk as soon as we reach the layer 1.
> >
> > (FWIW, you could do the same optimization with the seen_policy_bits app=
roach.)
> >
> > I guess the difference between your proposal and mine is that in my
> > proposal, the following would work, in effect permitting W access to
> > /foo/bar/baz (and nothing else)?
> >
> > first ruleset:
> >   /foo W
> > second ruleset:
> >   /foo/bar/baz W
> > third ruleset:
> >   /foo/bar W
> >
> > whereas in your proposal, IIUC it wouldn't be valid for a new ruleset
> > to whitelist a superset of what was whitelisted in a previous ruleset?
> >
>
> This behavior seems dangerous because a process which sandbox itself to
> only access /foo/bar W can bypass the restrictions from one of its
> parent domains (i.e. only access /foo/bar/baz W). Indeed, each layer is
> (most of the time) a different and standalone security policy.

It isn't actually bypassing the restriction: You still can't actually
access files like /foo/bar/blah, because a path walk from there
doesn't encounter any rules from the second ruleset.

> To sum up, the bitmask approach doesn't have the notion of layers
> ordering. It is then not possible to check that a rule comes from a
> domain which is the direct ancestor of a child's domain. I want each
> policy/layer to be really nested in the sense that a process sandboxing
> itself can only add more restriction to itself with regard to its parent
> domain (and the whole hierarchy). This is a similar approach to
> seccomp-bpf (with chained filters), except there is almost no overhead
> to nest several policies/layers together because they are flattened.
> Using the layer level and depth approach enables to implement this.
