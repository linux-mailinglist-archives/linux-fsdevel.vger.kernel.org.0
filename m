Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0292B87D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 23:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgKRWj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 17:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKRWj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:39:56 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808DC061A48
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 14:39:56 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id m16so3764910edr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mh4Qjzb8KLSgaMNmAYGectlp/+Zs2oISPb70IoHgsI8=;
        b=CRZIVIaWJn4wRTqExaJYLXqnr5OhuX/Ux33O/CKOWLZw+6wBPmuXEyiSTB3fn/OuoB
         5W7kGYZwmmLIjODlbM1WZgo/01YuAEr0CtnFBOV16R4EfITvzzkyEd8XO075r/UTcJt+
         zImZ+g75iGdxnhvDVM6/d6dyWVqZMgivbYHNHtVo27ZrWnAK7egyTI5flEh2L5o1F2Zc
         peaGWkXGnNSPGL/j6sgFZiGnhQ62hcV06/KYWEuTYsZJEskQEaXB7Wp4YlAEe9vWwqY0
         c1fiNV9lk1053jw3Yucz8Rp5fk4RAcK6rlIp9pJBUHkJ5EJFsKuW0LiA8cZKrqaYTwhn
         yh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh4Qjzb8KLSgaMNmAYGectlp/+Zs2oISPb70IoHgsI8=;
        b=Me75aF1xFvRoThGT6/jvIEiBIEj1VjR6LCQqL+/BNk4tOYl3phYkrA+d0t+C2ps7jF
         kav98K0D0hwPEY8nvRkE4GcG5f7Xke+bIJmFPOoCtniQiT1OIZYdLQWLpUVERKa0jYxV
         YlYRHZKNdRT6x8C9KGkdTeA9sy/PaPJ6wYsBCL6ggmhnKcI3rBJEp4Q1XgXGllZttVzJ
         OzB7WLE6G5nbCehpcbDljhvdizWwTtDULM5VGZer+QKUCMXo72yCGbgCijbQJPjJUyKS
         ioxMvEi7T7Q0OnStoLwu6Wt5vFlpw0J72mNH3pQQvt1qx8WKLgqQWKjA0dAvEjMG0Xq8
         0asA==
X-Gm-Message-State: AOAM531va8Gppl1hrlcyNPXhV7Vi3jWtL/Wh9ceFqtYfzAlMdBUK9hXj
        8xfEP3MOK5Yhh3KfouXYa4a/7Mww1LImVZcG5jX4MA==
X-Google-Smtp-Source: ABdhPJwQhDxciSRkAl2VxK0vZnAeNRN4fgcGI2LnmSEZCHTKqJlvVqW32Uzql9y2c4OzJjhY30YrLxWXujyaeuTcCCU=
X-Received: by 2002:aa7:c704:: with SMTP id i4mr27725768edq.51.1605739194344;
 Wed, 18 Nov 2020 14:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com> <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
In-Reply-To: <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 18 Nov 2020 14:39:42 -0800
Message-ID: <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
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
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: multipart/mixed; boundary="00000000000048c66905b4694aa9"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000048c66905b4694aa9
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 12, 2020 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Nov 10, 2020 at 10:30 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Tue, Nov 10, 2020 at 6:13 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Nov 10, 2020 at 1:24 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > On Mon, Nov 9, 2020 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Fri, Nov 6, 2020 at 10:56 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > > >
> > > > > > From: Daniel Colascione <dancol@google.com>
> > > > > >
> > > > > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > > > > the previous patches to give SELinux the ability to control
> > > > > > anonymous-inode files that are created using the new
> > > > > > anon_inode_getfd_secure() function.
> > > > > >
> > > > > > A SELinux policy author detects and controls these anonymous inodes by
> > > > > > adding a name-based type_transition rule that assigns a new security
> > > > > > type to anonymous-inode files created in some domain. The name used
> > > > > > for the name-based transition is the name associated with the
> > > > > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > > > > "[perf_event]".
> > > > > >
> > > > > > Example:
> > > > > >
> > > > > > type uffd_t;
> > > > > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > > > > allow sysadm_t uffd_t:anon_inode { create };
> > > > > >
> > > > > > (The next patch in this series is necessary for making userfaultfd
> > > > > > support this new interface.  The example above is just
> > > > > > for exposition.)
> > > > > >
> > > > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > ---
> > > > > >  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
> > > > > >  security/selinux/include/classmap.h |  2 ++
> > > > > >  2 files changed, 55 insertions(+)
> > > > > >
> > > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > > index 6b1826fc3658..1c0adcdce7a8 100644
> > > > > > --- a/security/selinux/hooks.c
> > > > > > +++ b/security/selinux/hooks.c
> > > > > > @@ -2927,6 +2927,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > > > > +                                           const struct qstr *name,
> > > > > > +                                           const struct inode *context_inode)
> > > > > > +{
> > > > > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > > > > +       struct common_audit_data ad;
> > > > > > +       struct inode_security_struct *isec;
> > > > > > +       int rc;
> > > > > > +
> > > > > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       isec = selinux_inode(inode);
> > > > > > +
> > > > > > +       /*
> > > > > > +        * We only get here once per ephemeral inode.  The inode has
> > > > > > +        * been initialized via inode_alloc_security but is otherwise
> > > > > > +        * untouched.
> > > > > > +        */
> > > > > > +
> > > > > > +       if (context_inode) {
> > > > > > +               struct inode_security_struct *context_isec =
> > > > > > +                       selinux_inode(context_inode);
> > > > > > +               isec->sclass = context_isec->sclass;
> > > > > > +               isec->sid = context_isec->sid;
> > > > >
> > > > > I suppose this isn't a major concern given the limited usage at the
> > > > > moment, but I wonder if it would be a good idea to make sure the
> > > > > context_inode's SELinux label is valid before we assign it to the
> > > > > anonymous inode?  If it is invalid, what should we do?  Do we attempt
> > > > > to (re)validate it?  Do we simply fallback to the transition approach?
> > > >
> > > > Frankly, I'm not too familiar with SELinux. Originally this patch
> > > > series was developed by Daniel, in consultation with Stephen Smalley.
> > > > In my (probably naive) opinion we should fallback to transition
> > > > approach. But I'd request you to tell me if this needs to be addressed
> > > > now, and if so then what's the right approach.
> > > >
> > > > If the decision is to address this now, then what's the best way to
> > > > check the SELinux label validity?
> > >
> > > You can check to see if an inode's label is valid by looking at the
> > > isec->initialized field; if it is LABEL_INITIALIZED then it is all
> > > set, if it is any other value then the label isn't entirely correct.
> > > It may have not have ever been fully initialized (and has a default
> > > value) or it may have live on a remote filesystem where the host has
> > > signaled that the label has changed (and the label is now outdated).
> > >
> > > This patchset includes support for userfaultfd, which means we don't
> > > really have to worry about the remote fs problem, but the
> > > never-fully-initialized problem could be real in this case.  Normally
> > > we would revalidate an inode in SELinux by calling
> > > __inode_security_revalidate() which requires either a valid dentry or
> > > one that can be found via the inode; does d_find_alias() work on
> > > userfaultfd inodes?
> > >
> > > If all else fails, it seems like the safest approach would be to
> > > simply fail the selinux_inode_init_security_anon() call if a
> > > context_inode was supplied and the label wasn't valid.  If we later
> > > decide to change it to falling back to the transition approach we can
> > > do that, we can't go the other way (from transition to error).
> >
> > I'm not sure about d_find_alias() on userfaultfd inodes. But it seems
> > ok to fail selinux_inode_init_security_anon() to begin with.
>
> I'm okay with simply failing here, but I'm growing a bit concerned
> that this patchset hasn't been well tested.  That is a problem.
>
> > > > > This brings up another question, and requirement - what testing are
> > > > > you doing for this patchset?  We require that new SELinux kernel
> > > > > functionality includes additions to the SELinux test suite to help
> > > > > verify the functionality.  I'm also *strongly* encouraging that new
> > > > > contributions come with updates to The SELinux Notebook.  If you are
> > > > > unsure about what to do for either, let us know and we can help get
> > > > > you started.
> > > > >
> > > > > * https://github.com/SELinuxProject/selinux-testsuite
> > > > > * https://github.com/SELinuxProject/selinux-notebook
> > > > >
> > > > I'd definitely need help with both of these. Kindly guide how to proceed.
> > >
> > > Well, perhaps the best way to start is to explain how you have been
> > > testing this so far and then using that information to draft a test
> > > for the testsuite.
> >
> > As I said in my previous reply, Daniel worked on this patch along with
> > Stephan Smalley. Here's the conversation regarding testing from back
> > then:
> > https://lore.kernel.org/lkml/CAEjxPJ4iquFSBfEj+UEFLUFHPsezuQ-Bzv09n+WgOWk38Nyw3w@mail.gmail.com/
> >
> > There have been only minor changes (fixing comments/coding-style),
> > except for addressing a double free issue with userfaultfd_ctx since
> > last time it was tested as per the link above.
>
> I should probably be more clear.  I honestly don't care who originally
> wrote the patch, the simple fact is that you are the one who is
> posting it *now* for inclusion in the kernel; at the very least I
> expect you to be able to demonstrate that you are able to reliably
> test this functionality and prove it is working.  While being able to
> test this submission initially is important, it is far more important
> to have the tests and docs necessary to maintain this functionality
> long term.  Perhaps you and/or Google will continue to contribute and
> support this functionality long term, but it would be irresponsible of
> me to assume that to be true; both people and companies come and go
> but code has a tendency to live forever.
>
> Let's start again; how have you been testing this code?
>
I have created a cuttlefish build and have tested with the attached
userfaultfd program:

1) Without these kernel patches the program executes without any restrictions

vsoc_x86_64:/ $ ./system/bin/userfaultfdSimple
api: 170
features: 511
ioctls: 9223372036854775811

read: Try again


2) With these patches applied but without any policy the 'permission
denied' is thrown

vsoc_x86_64:/ $ ./system/bin/userfaultfdSimple
syscall(userfaultfd): Permission denied

with the following logcat message:
11-18 14:21:44.041  3130  3130 W userfaultfdSimp: type=1400
audit(0.0:107): avc: denied { create } for dev="anon_inodefs"
ino=45031 scontext=u:r:shell:s0 tcontext=u:object_r:shell:s0
tclass=anon_inode permissive=0


3) With the attached .te policy file in place the following output is
observed, confirming that the patch is working as intended.
vsoc_x86_64:/ $ ./vendor/bin/userfaultfdSimple
UFFDIO_API: Permission denied

with the following logcat message:
11-18 14:33:29.142  2028  2028 W userfaultfdSimp: type=1400
audit(0.0:104): avc: denied { ioctl } for
path="anon_inode:[userfaultfd]" dev="anon_inodefs" ino=41169
ioctlcmd=0xaa3f scontext=u:r:userfaultfdSimple:s0
tcontext=u:object_r:uffd_t:s0 tclass=anon_inode permissive=0


> --
> paul moore
> www.paul-moore.com

--00000000000048c66905b4694aa9
Content-Type: text/x-c++src; charset="US-ASCII"; name="userfaultfd_simple.cc"
Content-Disposition: attachment; filename="userfaultfd_simple.cc"
Content-Transfer-Encoding: base64
Content-ID: <f_khnyhxjz0>
X-Attachment-Id: f_khnyhxjz0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+
CiNpbmNsdWRlIDxjc3RyaW5nPgoKI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lz
L2lvY3RsLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgoKI2luY2x1ZGUgPGxpbnV4L3VzZXJm
YXVsdGZkLmg+Cgp2b2lkIHByaW50X2FwaShjb25zdCBzdHJ1Y3QgdWZmZGlvX2FwaSAqYXBpKQp7
CglwcmludGYoImFwaTogJWxsdVxuIiwgYXBpLT5hcGkpOwoJcHJpbnRmKCJmZWF0dXJlczogJWxs
dVxuIiwgYXBpLT5mZWF0dXJlcyk7CglwcmludGYoImlvY3RsczogJWxsdVxuIiwgYXBpLT5pb2N0
bHMpOwoKCXByaW50ZigiXG4iKTsKfQoKaW50IG1haW4odm9pZCkKewoJbG9uZyB1ZmZkID0gc3lz
Y2FsbChfX05SX3VzZXJmYXVsdGZkLCBPX0NMT0VYRUMgfCBPX05PTkJMT0NLKTsKCWlmICh1ZmZk
IDwgMCkgewoJCXBlcnJvcigic3lzY2FsbCh1c2VyZmF1bHRmZCkiKTsKCQlyZXR1cm4gLTE7Cgl9
CgoJc3RydWN0IHVmZmRpb19hcGkgYXBpOwoJc3RkOjptZW1zZXQoJmFwaSwgMHgwLCBzaXplb2Yg
YXBpKTsKCWFwaS5hcGkgPSBVRkZEX0FQSTsKCWlmIChpb2N0bCh1ZmZkLCBVRkZESU9fQVBJLCAm
YXBpKSA8IDApIHsKCQlwZXJyb3IoIlVGRkRJT19BUEkiKTsKCQlyZXR1cm4gLTE7Cgl9CgoJcHJp
bnRfYXBpKCZhcGkpOwoKCXN0cnVjdCB1ZmZkX21zZyBtc2c7CglzdGQ6Om1lbXNldCgmbXNnLCAw
eDAsIHNpemVvZiBtc2cpOwoJc3NpemVfdCBjb3VudCA9IHJlYWQodWZmZCwgJm1zZywgc2l6ZW9m
KG1zZykpOwoJaWYgKGNvdW50IDwgMCkgewoJCXBlcnJvcigicmVhZCIpOwoJCXJldHVybiAtMTsK
CX0gZWxzZSBpZiAoY291bnQgPT0gMCkgewoJCXByaW50ZigicmVhZCBFT0ZcblxuIik7Cgl9CgoJ
cHJpbnRmKCJyZWFkIHVmZmRcblxuIik7CgoJcmV0dXJuIDA7Cn0K
--00000000000048c66905b4694aa9
Content-Type: application/octet-stream; name="userfaultfdSimple.te"
Content-Disposition: attachment; filename="userfaultfdSimple.te"
Content-Transfer-Encoding: base64
Content-ID: <f_khnziydf1>
X-Attachment-Id: f_khnziydf1

CnR5cGUgdXNlcmZhdWx0ZmRTaW1wbGUsIGRvbWFpbjsKCnR5cGUgdXNlcmZhdWx0ZmRTaW1wbGVf
ZXhlYywgdmVuZG9yX2ZpbGVfdHlwZSwgZXhlY190eXBlLCBmaWxlX3R5cGU7Cgp0eXBlIHVmZmRf
dDsKdHlwZV90cmFuc2l0aW9uIHVzZXJmYXVsdGZkU2ltcGxlIHVzZXJmYXVsdGZkU2ltcGxlIDog
YW5vbl9pbm9kZSB1ZmZkX3QgIlt1c2VyZmF1bHRmZF0iOwphbGxvdyB1c2VyZmF1bHRmZFNpbXBs
ZSB1ZmZkX3Q6YW5vbl9pbm9kZSB7IGNyZWF0ZSBpb2N0bCByZWFkIH07CgojIFVuY29tbWVudCBv
bmUgb2YgdGhlIGFsbG93eCBsaW5lcyBiZWxvdyB0byB0ZXN0IGlvY3RsIHdoaXRlbGlzdGluZy4K
IyBOb25lCmFsbG93eHBlcm0gdXNlcmZhdWx0ZmRTaW1wbGUgdWZmZF90OmFub25faW5vZGUgaW9j
dGwgMHgwOwojIFVGRkRJT19BUEkKI2FsbG93eHBlcm0gdXNlcmZhdWx0ZmRTaW1wbGUgdWZmZF90
OmFub25faW5vZGUgaW9jdGwgMHhhYTNmOwoKZG9udGF1ZGl0IHVzZXJmYXVsdGZkU2ltcGxlIGFk
YmQ6ZmQgdXNlOwpkb250YXVkaXQgdXNlcmZhdWx0ZmRTaW1wbGUgYWRiZDp1bml4X3N0cmVhbV9z
b2NrZXQgeyByZWFkIHdyaXRlIH07CmRvbnRhdWRpdCB1c2VyZmF1bHRmZFNpbXBsZSBkZXZwdHM6
Y2hyX2ZpbGUgeyBnZXRhdHRyIGlvY3RsIHJlYWQgd3JpdGUgfTsKZG9udGF1ZGl0IHVzZXJmYXVs
dGZkU2ltcGxlIHNoZWxsOmZkIHVzZTsKCmRvbWFpbl9hdXRvX3RyYW5zKHNoZWxsLCB1c2VyZmF1
bHRmZFNpbXBsZV9leGVjLCB1c2VyZmF1bHRmZFNpbXBsZSk7Cg==
--00000000000048c66905b4694aa9--
