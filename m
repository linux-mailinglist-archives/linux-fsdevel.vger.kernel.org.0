Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B92B130F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgKMANC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 19:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMANB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:13:01 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CFC0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 16:13:01 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id p93so8578193edd.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 16:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DjY6XkqhlITuoym201ff+iT5LHP6KrjkxHpOYjOgco=;
        b=ahMflSkrxJR5Zuhl4NUIQ124OwkN1LA6lmuJvLMid7FM2wLDllvvQRc1+k+XiXAblG
         eO1o3Imld2j1XySYdp1IxdzHHxv+xKPHNIDhgo6L3KOtg2ggfRsdRH9Sh6fcrbu1JKsB
         JpK+dOSmbRCshBLb5q+1w9pW+LWdC6PlGmlNhUh1X9rfOw/KhBwG0AuOqLOlttd9kqYD
         ym3TyvLcJM64I1JrR0Cc+eFhdvHG8hZ/Rwh7lyPLKjYfWfEPtA1i1IjFlXkwEd0DYNia
         f9IEkw2JFzOj5XEroVEj/6OTwSlddWQd7x4d3SAJwvUdRlnbw9+o8ATkS9I0ZpleY0w7
         e/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DjY6XkqhlITuoym201ff+iT5LHP6KrjkxHpOYjOgco=;
        b=RoXTjyz6HpGH8KKBNPWswGpQxJMZuHbOXW0nNJWI941pPfURgUfDBp4lai/VAudWuv
         +1RVfvUnC8pvEsqpJhcFpqIeCqorjBkf/SbBGTubDWu+WPbU/c/fh7NvxTako6YVjsfr
         aLqYLJFgVOC32ZV5fcpFfr6Z/8VfeRcGg1SRH+ZfkYDOAcbWdvE+2le3UplB/7ZbLlGC
         RQAEMyF1HPAh1pN25Je03+7SCJXnVSnKURnZAGfitRI7QO9Z/9AoREyjFFVlo5vF1T6F
         6LAtQeHqptG3bbZyuOZlOJcYh2217KgMKEI6LzG8YHhxVjN9gpFyVz0OLxj0qohmRYB/
         LK6w==
X-Gm-Message-State: AOAM531YMevyNvUc89HbUSqG2kceAygeIwuCZpMsyk+PkyxIA3v/oL+m
        WwHlriazzm8g/U0SJ9nPwAnqkBCIoWifCCGBxK8g
X-Google-Smtp-Source: ABdhPJyLe5Wsyx3ZTidlTWm5cVl+5L72KjbFcxrTxF7K5Pnlk8CCOe5rJ0VvothYSb7coXyY6KaB3KRYBkLE/gqRD3Q=
X-Received: by 2002:a05:6402:44b:: with SMTP id p11mr2671067edw.164.1605226379951;
 Thu, 12 Nov 2020 16:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com> <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
In-Reply-To: <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Nov 2020 19:12:48 -0500
Message-ID: <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:30 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Tue, Nov 10, 2020 at 6:13 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Nov 10, 2020 at 1:24 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > On Mon, Nov 9, 2020 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Nov 6, 2020 at 10:56 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > >
> > > > > From: Daniel Colascione <dancol@google.com>
> > > > >
> > > > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > > > the previous patches to give SELinux the ability to control
> > > > > anonymous-inode files that are created using the new
> > > > > anon_inode_getfd_secure() function.
> > > > >
> > > > > A SELinux policy author detects and controls these anonymous inodes by
> > > > > adding a name-based type_transition rule that assigns a new security
> > > > > type to anonymous-inode files created in some domain. The name used
> > > > > for the name-based transition is the name associated with the
> > > > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > > > "[perf_event]".
> > > > >
> > > > > Example:
> > > > >
> > > > > type uffd_t;
> > > > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > > > allow sysadm_t uffd_t:anon_inode { create };
> > > > >
> > > > > (The next patch in this series is necessary for making userfaultfd
> > > > > support this new interface.  The example above is just
> > > > > for exposition.)
> > > > >
> > > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > ---
> > > > >  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
> > > > >  security/selinux/include/classmap.h |  2 ++
> > > > >  2 files changed, 55 insertions(+)
> > > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 6b1826fc3658..1c0adcdce7a8 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -2927,6 +2927,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > > > +                                           const struct qstr *name,
> > > > > +                                           const struct inode *context_inode)
> > > > > +{
> > > > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > > > +       struct common_audit_data ad;
> > > > > +       struct inode_security_struct *isec;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > > > +               return 0;
> > > > > +
> > > > > +       isec = selinux_inode(inode);
> > > > > +
> > > > > +       /*
> > > > > +        * We only get here once per ephemeral inode.  The inode has
> > > > > +        * been initialized via inode_alloc_security but is otherwise
> > > > > +        * untouched.
> > > > > +        */
> > > > > +
> > > > > +       if (context_inode) {
> > > > > +               struct inode_security_struct *context_isec =
> > > > > +                       selinux_inode(context_inode);
> > > > > +               isec->sclass = context_isec->sclass;
> > > > > +               isec->sid = context_isec->sid;
> > > >
> > > > I suppose this isn't a major concern given the limited usage at the
> > > > moment, but I wonder if it would be a good idea to make sure the
> > > > context_inode's SELinux label is valid before we assign it to the
> > > > anonymous inode?  If it is invalid, what should we do?  Do we attempt
> > > > to (re)validate it?  Do we simply fallback to the transition approach?
> > >
> > > Frankly, I'm not too familiar with SELinux. Originally this patch
> > > series was developed by Daniel, in consultation with Stephen Smalley.
> > > In my (probably naive) opinion we should fallback to transition
> > > approach. But I'd request you to tell me if this needs to be addressed
> > > now, and if so then what's the right approach.
> > >
> > > If the decision is to address this now, then what's the best way to
> > > check the SELinux label validity?
> >
> > You can check to see if an inode's label is valid by looking at the
> > isec->initialized field; if it is LABEL_INITIALIZED then it is all
> > set, if it is any other value then the label isn't entirely correct.
> > It may have not have ever been fully initialized (and has a default
> > value) or it may have live on a remote filesystem where the host has
> > signaled that the label has changed (and the label is now outdated).
> >
> > This patchset includes support for userfaultfd, which means we don't
> > really have to worry about the remote fs problem, but the
> > never-fully-initialized problem could be real in this case.  Normally
> > we would revalidate an inode in SELinux by calling
> > __inode_security_revalidate() which requires either a valid dentry or
> > one that can be found via the inode; does d_find_alias() work on
> > userfaultfd inodes?
> >
> > If all else fails, it seems like the safest approach would be to
> > simply fail the selinux_inode_init_security_anon() call if a
> > context_inode was supplied and the label wasn't valid.  If we later
> > decide to change it to falling back to the transition approach we can
> > do that, we can't go the other way (from transition to error).
>
> I'm not sure about d_find_alias() on userfaultfd inodes. But it seems
> ok to fail selinux_inode_init_security_anon() to begin with.

I'm okay with simply failing here, but I'm growing a bit concerned
that this patchset hasn't been well tested.  That is a problem.

> > > > This brings up another question, and requirement - what testing are
> > > > you doing for this patchset?  We require that new SELinux kernel
> > > > functionality includes additions to the SELinux test suite to help
> > > > verify the functionality.  I'm also *strongly* encouraging that new
> > > > contributions come with updates to The SELinux Notebook.  If you are
> > > > unsure about what to do for either, let us know and we can help get
> > > > you started.
> > > >
> > > > * https://github.com/SELinuxProject/selinux-testsuite
> > > > * https://github.com/SELinuxProject/selinux-notebook
> > > >
> > > I'd definitely need help with both of these. Kindly guide how to proceed.
> >
> > Well, perhaps the best way to start is to explain how you have been
> > testing this so far and then using that information to draft a test
> > for the testsuite.
>
> As I said in my previous reply, Daniel worked on this patch along with
> Stephan Smalley. Here's the conversation regarding testing from back
> then:
> https://lore.kernel.org/lkml/CAEjxPJ4iquFSBfEj+UEFLUFHPsezuQ-Bzv09n+WgOWk38Nyw3w@mail.gmail.com/
>
> There have been only minor changes (fixing comments/coding-style),
> except for addressing a double free issue with userfaultfd_ctx since
> last time it was tested as per the link above.

I should probably be more clear.  I honestly don't care who originally
wrote the patch, the simple fact is that you are the one who is
posting it *now* for inclusion in the kernel; at the very least I
expect you to be able to demonstrate that you are able to reliably
test this functionality and prove it is working.  While being able to
test this submission initially is important, it is far more important
to have the tests and docs necessary to maintain this functionality
long term.  Perhaps you and/or Google will continue to contribute and
support this functionality long term, but it would be irresponsible of
me to assume that to be true; both people and companies come and go
but code has a tendency to live forever.

Let's start again; how have you been testing this code?

-- 
paul moore
www.paul-moore.com
