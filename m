Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF5562604
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiF3WXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiF3WXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786F2A40B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 15:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD6E6241B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 22:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36323C341C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656627817;
        bh=SQKoyn5kVCTEuv2x9BpgY6SkbJcTWu9FblAzM0k3V2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIvlKa1TnPv0jRY9SilzVgYXc7EnpFMfYwjOM+1hYYk0Z68jf9B8kRPlvA4DvVUSE
         +kB7trWk29tCb5XOJX03mmyaOMrWen57+wEM6/VTVm3AY9U9AqDVq0BD7KxGZ7UoGJ
         3mJIyMeFaFmAzivLgaBasGE0Vnu8rW/A+Ztc5eogFutqgIUpPkwCRWrwttqI+DWuyV
         0Rh2w+iZdtaZChYNAY23s49As2tbWfy/T7OzomV3+7i9bj6jH0Ua85fGWm3U0hkkfw
         v811HnkhgJwsz9M43zUFzJC/GRK75MW7Hq+G+Qf+KlEMCAFZJ1w/sEjDxuh5q6KU8C
         i3E3z6VbjBQTg==
Received: by mail-yb1-f169.google.com with SMTP id x184so848450ybg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 15:23:37 -0700 (PDT)
X-Gm-Message-State: AJIora8rmCXg18GeMjHopPRSQ1j01xYR3CTdlmkNA4/wNLyutHjVvoWG
        wOVwKVVWvA+QIWRArhDDof0lqEJZIyYGzS/xXBUcQw==
X-Google-Smtp-Source: AGRyM1vsLBUfT9vAV0bMh0uSX5XzxWoxYL+h6qV2Y99mvb3e+8apNEe0aCPbzLXW2qCPozxo1tmAugMj2N88kF0BArQ=
X-Received: by 2002:a25:9a48:0:b0:669:b51a:5b8d with SMTP id
 r8-20020a259a48000000b00669b51a5b8dmr11984447ybo.404.1656627816087; Thu, 30
 Jun 2022 15:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220628173344.h7ihvyl6vuky5xus@wittgenstein> <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
 <20220629081119.ddqvfn3al36fl27q@wittgenstein> <20220629095557.oet6u2hi7msit6ff@wittgenstein>
 <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
 <20220630114549.uakuocpn7w5jfrz2@wittgenstein> <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
 <20220630132635.bxxx7q654y5icd5b@wittgenstein> <CACYkzJ6At2T9YGgs25mbqdVUiLtOh1LabZ5Auc+oDm4605A31A@mail.gmail.com>
 <20220630134702.bn2eq3mxeiqmg2fj@wittgenstein> <7d42faf7-1f55-03cb-e17e-e12f7cffe3de@schaufler-ca.com>
In-Reply-To: <7d42faf7-1f55-03cb-e17e-e12f7cffe3de@schaufler-ca.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 1 Jul 2022 00:23:25 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7fVCWFtKhFqth5CNHGTiPnS8d=T2+-xSc03UBGLgW+4Q@mail.gmail.com>
Message-ID: <CACYkzJ7fVCWFtKhFqth5CNHGTiPnS8d=T2+-xSc03UBGLgW+4Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>, casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 6:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/30/2022 6:47 AM, Christian Brauner wrote:
> > On Thu, Jun 30, 2022 at 03:29:53PM +0200, KP Singh wrote:
> >> On Thu, Jun 30, 2022 at 3:26 PM Christian Brauner <brauner@kernel.org> wrote:
> >>> On Thu, Jun 30, 2022 at 02:21:56PM +0200, KP Singh wrote:
> >>>> On Thu, Jun 30, 2022 at 1:45 PM Christian Brauner <brauner@kernel.org> wrote:
> >>>>> On Wed, Jun 29, 2022 at 08:02:50PM -0700, Alexei Starovoitov wrote:
> >>>>>> On Wed, Jun 29, 2022 at 2:56 AM Christian Brauner <brauner@kernel.org> wrote:
> >>>> [...]
> >>>>
> >>>>>>>>>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
> >>>>>>>>>> [...]
> >>>>>>>>>>
> >>>>>>>>>>>> +SEC("lsm.s/bprm_committed_creds")
> >>>>>>>>>>>> +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +     struct task_struct *current = bpf_get_current_task_btf();
> >>>>>>>>>>>> +     char dir_xattr_value[64] = {0};
> >>>>>>>>>>>> +     int xattr_sz = 0;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> >>>>>>>>>>>> +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> >>>>>>>>>>>> +                             dir_xattr_value, 64);
> >>>>>>>>>>> Yeah, this isn't right. You're not accounting for the caller's userns
> >>>>>>>>>>> nor for the idmapped mount. If this is supposed to work you will need a
> >>>>>>>>>>> variant of vfs_getxattr() that takes the mount's idmapping into account
> >>>>>>>>>>> afaict. See what needs to happen after do_getxattr().
> >>>>>>>>>> Thanks for taking a look.
> >>>>>>>>>>
> >>>> [...]
> >>>>
> >>>>>>>>> That will not be correct.
> >>>>>>>>> posix_acl_fix_xattr_to_user checking current_user_ns()
> >>>>>>>>> is checking random tasks that happen to be running
> >>>>>>>>> when lsm hook got invoked.
> >>>>>>>>>
> >>>>>>>>> KP,
> >>>>>>>>> we probably have to document clearly that neither 'current*'
> >>>>>>>>> should not be used here.
> >>>>>>>>> xattr_permission also makes little sense in this context.
> >>>>>>>>> If anything it can be a different kfunc if there is a use case,
> >>>>>>>>> but I don't see it yet.
> >>>>>>>>> bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
> >>>>>>>>> call it directly. It's the kernel that is doing its security thing.
> >>>>>>>> Right, but LSMs usually only retrieve their own xattr namespace (ima,
> >>>>>>>> selinux, smack) or they calculate hashes for xattrs based on the raw
> >>>>>>>> filesystem xattr values (evm).
> >>>>>>>>
> >>>>>>>> But this new bpf_getxattr() is different. It allows to retrieve _any_
> >>>>>>>> xattr in any security hook it can be attached to. So someone can write a
> >>>>>>>> bpf program that retrieves filesystem capabilites or posix acls. And
> >>>>>>>> these are xattrs that require higher-level vfs involvement to be
> >>>>>>>> sensible in most contexts.
> >>>>>>>>
> >>>> [...]
> >>>>
> >>>>>>>> This hooks a bpf-lsm program to the security_bprm_committed_creds()
> >>>>>>>> hook. It then retrieves the extended attributes of the file to be
> >>>>>>>> executed. The hook currently always retrieves the raw filesystem values.
> >>>>>>>>
> >>>>>>>> But for example any XATTR_NAME_CAPS filesystem capabilities that
> >>>>>>>> might've been stored will be taken into account during exec. And both
> >>>>>>>> the idmapping of the mount and the caller matter when determing whether
> >>>>>>>> they are used or not.
> >>>>>>>>
> >>>>>>>> But the current implementation of bpf_getxattr() just ignores both. It
> >>>>>>>> will always retrieve the raw filesystem values. So if one invokes this
> >>>>>>>> hook they're not actually retrieving the values as they are seen by
> >>>>>>>> fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
> >>>>>>>> some use-cases it might very well become a security issue in others if
> >>>>>>>> access decisions are always based on the raw values.
> >>>>>>>>
> >>>>>>>> I'm not well-versed in this so bear with me, please.
> >>>>>>> If this is really just about retrieving the "security.bpf" xattr and no
> >>>>>>> other xattr then the bpf_getxattr() variant should somehow hard-code
> >>>>>>> that to ensure that no other xattrs can be retrieved, imho.
> >>>>>> All of these restrictions look very artificial to me.
> >>>>>> Especially the part "might very well become a security issue"
> >>>>>> just doesn't click.
> >>>>>> We're talking about bpf-lsm progs here that implement security.
> >>>>>> Can somebody implement a poor bpf-lsm that doesn't enforce
> >>>>>> any actual security? Sure. It's a code.
> >>>>> The point is that with the current implementation of bpf_getxattr() you
> >>>>> are able to retrieve any xattrs and we have way less control over a
> >>>>> bpf-lsm program than we do over selinux which a simple git grep
> >>>>> __vfs_getxattr() is all we need.
> >>>>>
> >>>>> The thing is that with bpf_getxattr() as it stands it is currently
> >>>>> impossible to retrieve xattr values - specifically filesystem
> >>>>> capabilities and posix acls - and see them exactly like the code you're
> >>>>> trying to supervise is. And that seems very strange from a security
> >>>>> perspective. So if someone were to write
> >>>>>
> >>>>> SEC("lsm.s/bprm_creds_from_file")
> >>>>> void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> >>>>> {
> >>>>>         struct task_struct *current = bpf_get_current_task_btf();
> >>>>>
> >>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> >>>>>                                 bprm->file->f_path.dentry->d_inode,
> >>>>>                                 XATTR_NAME_POSIX_ACL_ACCESS, ..);
> >>>>>         // or
> >>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> >>>>>                                 bprm->file->f_path.dentry->d_inode,
> >>>>>                                 XATTR_NAME_CAPS, ..);
> >>>>>
> >>>>> }
> >>>>>
> >>>>> they'd get the raw nscaps and the raw xattrs back. But now, as just a
> >>>>> tiny example, the nscaps->rootuid and the ->e_id fields in the posix
> >>>>> ACLs make zero sense in this context.
> >>>>>
> >>>>> And what's more there's no way for the bpf-lsm program to turn them into
> >>>>> something that makes sense in the context of the hook they are retrieved
> >>>>> in. It lacks all the necessary helpers to do so afaict.
> >>>>>
> >>>>>> No one complains about the usage of EXPORT_SYMBOL(__vfs_getxattr)
> >>>>>> in the existing LSMs like selinux.
> >>>>> Selinux only cares about its own xattr namespace. It doesn't retrieve
> >>>>> fscaps or posix acls and it's not possible to write selinux programs
> >>>>> that do so. With the bpf-lsm that's very much possible.
> >>>>>
> >>>>> And if we'd notice selinux would start retrieving random xattrs we'd ask
> >>>>> the same questions we do here.
> >>>>>
> >>>>>> No one complains about its usage in out of tree LSMs.
> >>>>>> Is that a security issue? Of course not.
> >>>>>> __vfs_getxattr is a kernel mechanism that LSMs use to implement
> >>>>>> the security features they need.
> >>>>>> __vfs_getxattr as kfunc here is pretty much the same as EXPORT_SYMBOL
> >>>>>> with a big difference that it's EXPORT_SYMBOL_GPL.
> >>>>>> BPF land doesn't have an equivalent of non-gpl export and is not going
> >>>>>> to get one.
> >>>> I want to reiterate what Alexei is saying here:
> >>>>
> >>>> *Please* consider this as a simple wrapper around __vfs_getxattr
> >>>> with a limited attach surface and extra verification checks and
> >>>> and nothing else.
> >>>>
> >>>> What you are saying is __vfs_getxattr does not make sense in some
> >>>> contexts. But kernel modules can still use it right?
> >>>>
> >>>> The user is implementing an LSM, if they chose to do things that don't make
> >>>> sense, then they can surely cause a lot more harm:
> >>>>
> >>>> SEC("lsm/bprm_check_security")
> >>>> int BPF_PROG(bprm_check, struct linux_binprm *bprm)
> >>>> {
> >>>>      return -EPERM;
> >>>> }
> >>>>
> >>>>> This discussion would probably be a lot shorter if this series were sent
> >>>>> with a proper explanation of how this supposed to work and what it's
> >>>>> used for.
> >>>> It's currently scoped to BPF LSM (albeit limited to LSM for now)
> >>>> but it won't just be used in LSM programs but some (allow-listed)
> >>>> tracing programs too.
> >>>>
> >>>> We want to leave the flexibility to the implementer of the LSM hooks. If the
> >>>> implementer choses to retrieve posix_acl_* we can also expose
> >>>> posix_acl_fix_xattr_to_user or a different kfunc that adds this logic too
> >>>> but that would be a separate kfunc (and a separate use-case).
> >>> No, sorry. That's what I feared and that's why I think this low-level
> >>> exposure of __vfs_getxattr() is wrong:
> >>> The posix_acl_fix_xattr_*() helpers, as well as the helpers like
> >>> get_file_caps() will not be exported. We're not going to export that
> >> I don't want to expose them and I don't want any others to be
> >> exposed either.
> >>
> >>> deeply internal vfs machinery. So I would NACK that. If you want that -
> >>> and that's what I'm saying here - you need to encapsulate this into your
> >>> vfs_*xattr() helper that you can call from your kfuncs.
> >> It seems like __vfs_getxattr is already exposed and does the wrong thing in
> >> some contexts, why can't we just "fix" __vfs_getxattr then?
> > To me having either a version of bpf_getxattr() that restricts access to
> > certain xattrs or a version that takes care to perform the neccesary
> > translations is what seems to make the most sense. I suggested that in
> > one of my first mails.
> >
> > The one thing where the way the xattrs are retrieved really matters is
> > for vfscaps (see get_vfs_caps_from_disk()) you really need something
> > like that function in order for vfs caps to make any sense and be
> > interpretable by the user of the hook.
> >
> > But again, I might just misunderstand the context here and for the
> > bpf-lsm all of this isn't really a concern. If your new series comes out
> > I'll try to get more into the wider context.
> > If the security folks are happy with this then I won't argue.
>
> A security module (BPF) using another security module's (Smack)
> xattrs without that module's (Smack) explicit approval would be
> considered extremely rude.  Smack and SELinux use published interfaces
> of the capability security module, but never access the capability
> attributes directly. The details of a security module's implementation
> are not a factor. The fact that BPF uses loadable programs as opposed
> to loadable policy is not relevant. The only security.xattr values
> that the BPF security module should allow the programs it runs to
> access are the ones it is managing. If you decided to create an eBPF

What about kernel modules who can use __vfs_getxattr already as
it's an exported symbol? This can still end up influencing
security policy or using them in any way they like.

Anyways, I think, for now, for the use case we have, it can work with
a restriction to security.bpf xattrs.



> implementation of SELinux you would still have to use attributes
> specific to the BPF security module. If, on the other hand, you wanted
> to extend Smack using eBPF programs, and the Smack maintainer liked
> the idea, it would be OK for the BPF security module to access some
> of the security.SMACK64 attributes.
>
> I want it to be clear that BPF is a Linux Security Module (LSM) and
> a collection of eBPF programs is *not* an LSM. BPF is responsible
> for being a good kernel citizen, and must ensure that it does not
> allow a set of configuration data that violates proper behavior.
> You can't write an SELinux policy that monster-mashes an ACL.
> You can't allow BPF to permit that either. You can't count on the
> good intentions, wisdom or skill of the author of an unreviewed,
> out of tree, eBPF program. I believe that this was understood during
> the review process of the BPF LSM.
>
>
