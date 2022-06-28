Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB155F10F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiF1W27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 18:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiF1W26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:28:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C35326F4;
        Tue, 28 Jun 2022 15:28:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ge10so28653459ejb.7;
        Tue, 28 Jun 2022 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p+VBJHi7cSugXFzDfkbh/toN1rTiOXrhRk0iFHxs+w=;
        b=L2hTwYVED6MA41WA6gbymxFKubwf1toua3N2XTav+vNkwVUbHqK8CHQ0fVv5fb+UwO
         q1Qk/cpgUb+fYyMIWMUC69Khuo0hfg4SgaiVhO7Pfccn/1WIiReGI0c3E0hVW+Ownq8x
         q0TEbShWi8T8CVy4sF0TvXiJXWzo3zMYS2O9dpbGIAiyTnugcFT6AumFnS2sntayxLQH
         09QzHQ5NEM1DGizZJzKs3gqw7rcnlxU5W/TKkHK+0ERh2i6RB+TNYjJmiaGb4ks/sQ7v
         yZypTe3uO6d3tGeCOUf7MnHXCGwlLjDan4F1fq450PwxWQe+UkEIYqDIk3Aj4VjzQjUD
         GjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p+VBJHi7cSugXFzDfkbh/toN1rTiOXrhRk0iFHxs+w=;
        b=YTBjC+AP2KSrM6RNIbwJ9UhSNQfZrCULfTxOz29EA5t8uSfhevddAeAh4qCLbmpOGK
         DMcnKqwdr4G0h3ppfM34mK2hHOqKQWKa5SUXn3WZBlcofrnQw/o+fdPUuH8CAr30SXl4
         Ojo75Q9fmaCdi+no1TFAkEFMZZcP5WrIvC9T8QTiR+N2FhqDmAuAXeNOGUrn/jbe2fPh
         uT+koBRQnEMS1Upje4VhjAEUrbTbwjPHlxANNadQZJoGj95ZgcCFmsE+60oxHOmivM5t
         4QBgnvFcSGtyQR0XpAlWklV9nke062Nel3NGaIQH8aRQ9bgUfV46RhOm+otaFwPsnTgq
         38Vg==
X-Gm-Message-State: AJIora8Gjxt7bNLAESnnqXnHYJAm2ZPCB2N9Vo/u4K90gkBcU5HNaRHx
        dUTKK3pZE56uYtHblalbc3fZSM3HgU/4vXFPT5nmofstSv4=
X-Google-Smtp-Source: AGRyM1v1p1Kn3v/cTgLk0NVTh9TAohxGe0CcC7eKkBrms2nF0ev42HUXkW129A7zcpUM82FYs5reNB421pMvN7d89N0=
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id
 p6-20020a170906614600b00722f8c4ec9bmr358606ejl.708.1656455334132; Tue, 28 Jun
 2022 15:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein> <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
In-Reply-To: <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Jun 2022 15:28:42 -0700
Message-ID: <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     KP Singh <kpsingh@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:52 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 7:33 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 04:19:48PM +0000, KP Singh wrote:
> > > A simple test that adds an xattr on a copied /bin/ls and reads it back
> > > when the copied ls is executed.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
>
> [...]
>
> > > +SEC("lsm.s/bprm_committed_creds")
> > > +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > > +{
> > > +     struct task_struct *current = bpf_get_current_task_btf();
> > > +     char dir_xattr_value[64] = {0};
> > > +     int xattr_sz = 0;
> > > +
> > > +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > > +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> > > +                             dir_xattr_value, 64);
> >
> > Yeah, this isn't right. You're not accounting for the caller's userns
> > nor for the idmapped mount. If this is supposed to work you will need a
> > variant of vfs_getxattr() that takes the mount's idmapping into account
> > afaict. See what needs to happen after do_getxattr().
>
> Thanks for taking a look.
>
> So, If I understand correctly, we don't need xattr_permission (and
> other checks in
> vfs_getxattr) here as the BPF programs run as CAP_SYS_ADMIN.
>
> but...
>
> So, Is this bit what's missing then?
>
> error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
> if (error > 0) {
>     if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
>         posix_acl_fix_xattr_to_user(mnt_userns, d_inode(d),
>             ctx->kvalue, error);

That will not be correct.
posix_acl_fix_xattr_to_user checking current_user_ns()
is checking random tasks that happen to be running
when lsm hook got invoked.

KP,
we probably have to document clearly that neither 'current*'
should not be used here.
xattr_permission also makes little sense in this context.
If anything it can be a different kfunc if there is a use case,
but I don't see it yet.
bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
call it directly. It's the kernel that is doing its security thing.
