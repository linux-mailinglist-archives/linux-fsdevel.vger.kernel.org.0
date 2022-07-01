Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66174562FE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiGAJZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 05:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiGAJZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:02 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C5570E6F;
        Fri,  1 Jul 2022 02:25:01 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id w187so1782089vsb.1;
        Fri, 01 Jul 2022 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coMdZsoBLFF2SPgIqz5Om1GKfC6D/IFyXSVjO+sm1WA=;
        b=GeFetqCLVEvof4iBAZyA89rSx4tq9yXzo+ey3N0IKao1e4lT3Hy8t34I9Oh2Kl+2LY
         h7oIV9LXd7ZUppFh5YQtRaAJFumBZsH8tKifbG4j2NXffSB5aqAnKP7Ny1wV/ZOYzD94
         CvDMikDOjzWtsJMWmjWvpgddWazIUYMTnZcwds5cUILnWt0QOE0R5sFP2WzmWGrwbdeC
         4cFWaHjKM44fc7ZVVTjV2KrfFwaQJh5qrg+iiC9RxWg79pzLNrI/pyJ3F3l2YabaLdXW
         Mz0nEWM3shQqWGpRxTtK/YREAcjCyUUDyBzbWw8tfs4VssKgoO6TqhBTF8xXZNhwxxn5
         CtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coMdZsoBLFF2SPgIqz5Om1GKfC6D/IFyXSVjO+sm1WA=;
        b=34EsP6pHvOus26D56/zek5Ch4D/+lG/TAV5XqCVVnKl8sAoO8xxsb96Mrc1c0Gb9xi
         z+5EWXR3kUPhkIVVDWOrD/xyGk5AvLuvHmeBPAi0H70Q9kiDroeYnPcmG5uVCjwJ3bq9
         wBOSpxmu9ZNpAn9cVVErac1v//4LMiRt53c1EznVqqG9xMKEcIEIxVIX4ZNTHTfy3Gq8
         eC0N9FXnf8WTejhPZI1WZNNVDV9r2g3ilTDqqWJqvOKAZ3s32AmPNPFWGVR4oo1WqEGK
         pZZHNjUhziQt+eDw14nhZ//nY1QdkUlBUDcrYtwGtSuXJpBRJW2ZF2TTWoaL4/5Oh9Ul
         MWnA==
X-Gm-Message-State: AJIora96GWE49YDSvL1JFwv3bWQlWZbxOomqMkqwGAYW+EA12TxOgLbZ
        hnW9yZ2p7Rr+VId+xi/QNgXWFbbeX4Wi8TmE7qw=
X-Google-Smtp-Source: AGRyM1u4JMUnBkLlcY9JynQS2OtpUIXzwM163MAp0K6YA6aH0HINrPerXILHn+G5fN/ZG/4mLHiy9WXgTKr55pJkPtc=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr9936014vsq.2.1656667500175; Fri, 01 Jul
 2022 02:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
 <20220630114549.uakuocpn7w5jfrz2@wittgenstein> <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
 <20220630132635.bxxx7q654y5icd5b@wittgenstein> <CACYkzJ6At2T9YGgs25mbqdVUiLtOh1LabZ5Auc+oDm4605A31A@mail.gmail.com>
 <20220630134702.bn2eq3mxeiqmg2fj@wittgenstein> <7d42faf7-1f55-03cb-e17e-e12f7cffe3de@schaufler-ca.com>
 <CACYkzJ7fVCWFtKhFqth5CNHGTiPnS8d=T2+-xSc03UBGLgW+4Q@mail.gmail.com>
 <e95e107e-e279-6efc-0011-3995b96414af@schaufler-ca.com> <CAOQ4uxgyPYK78Cs_OvjNrCF3wMJ9rnZooZZPenzRN_jDs7pXwQ@mail.gmail.com>
 <20220701085817.7jzdyqcboj6vkl5m@wittgenstein>
In-Reply-To: <20220701085817.7jzdyqcboj6vkl5m@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 1 Jul 2022 12:24:48 +0300
Message-ID: <CAOQ4uxgXWa4x9+Ec2PTrztk4ZvPvewLbavg3VpxSFjhJp-v4=A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Tyler Hicks <code@tyhicks.com>
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

> >
> > Apropos __vfs_getxattr(), looks like ecryptfs_getxattr_lower()
> > is abusing it.
>
> Heh, quoting what I wrote to KP yesterday off-list about
> __vfs_getxattr():
>
> "it's [__vfs_getxattr()] exported but [afaict] it's not used in kernel
> modules. afaict it's only exposed because of ecryptfs"
>
> So right at the beginning I had already pondered whether we should just
> rip out __vfs_getxattr() from ecryptfs and unexport the helper
> completely because there's barely a reason to use it. Module/driver code
> should not use something as low-level as __vfs_getxattr() imho.
>
> Overlayfs does it correctly and uses vfs_getxattr() but maybe ecryptfs
> needs to use it for for some reason?. I haven't looked yet.
>

No reason AFAIK (CC Tyler+Miklos)

Most lower ecryptfs operations use vfs_XXX()
48b512e68571 ("ecryptfs: call vfs_setxattr() in ecryptfs_setxattr()")
fixed vfs_setxattr() which was later changed to __vfs_setxattr_locked(),
but left __vfs_getxattr(), __vfs_removexattr() and i_op->listxattr().

> > Christian, not sure if you intend to spend time of idmapped
> > mount support of ecryptfs lower layer, but anyway that's that.
>
> Not really. Remember the conversation we had with Tyler at LSFMM where
> he considered marking it deprecated. I don't think it's worth putting in
> the work.

OK, so just need a volunteer to close the security hole and
possibly unexport __vfs_getxattr().

Does anybody know of any out of tree modules that use it
for a good reason?

Thanks,
Amir.
