Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BC2740608
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjF0V6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 17:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjF0V6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:58:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50168E5A
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:58:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bd6d9d7da35so5181892276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687903099; x=1690495099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ+N2CuvmAc+wSVX5vK53Z8eetMsRLGAFF7lJpIJfks=;
        b=yZmGrcWcj5pZWgnmUzy8P0MNqCMof88icxobA86fP/l45vue+mRRI6eWcXK63Ef3Go
         FTI//QnmS1jCsU1O7a31qy/2/oGu88vMSOXH8iw0oXdmRDwQZWkmqSaSJPov/40JcKyV
         R8UEG143N5iPzajAx0cfIecyu4OYnohi1A8XXcKOiUgXMYNd0LCmG3b+4UHogC3kUBjZ
         5nAwVTsD2r92uhw3P9j/uCFa5F4nh8POi4STatDMKBzfObiIAE0j3BT79Kz+R4dhmsYE
         ZhpOfEfuAHped4zA05Qz+Jbp+x7TpwvW1OjM67VFetV3y+OphL91lSriK/CmLXfG7f9i
         FkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687903099; x=1690495099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ+N2CuvmAc+wSVX5vK53Z8eetMsRLGAFF7lJpIJfks=;
        b=XZ8tKozJ34VHt6KDBjUw0YegwOggxS78dsmAJI887JlRZooclDqBtHG5EN+eeUTtSs
         dcEMoWf0R1NolmydFZo9I/NvWzdl9nuN+DK0YLrxLIqfghcl9+7U8x6zBhzmuaYEMgo4
         vzX+gXuc7/H3soGHJBKkwwnz00eopw6zd3Mxs4J+8ImTQePQ//iOAP09iagaMIjGHdZW
         lRU7hrXH0s3t6B+7EvDP/G1LMfaH77agXHAbAXonYEb2MUJ/HQRiA2y+lzIaOofX3uuG
         Fu67u/TMT6h5jD2I1BJk2eCq9HRcnQJwEmn9F2E/Qmj9+Jyzko1IBCu6ZBMXD+bnMATa
         BQXg==
X-Gm-Message-State: AC+VfDwGNktz+JKUqwKuSM/AtM5cahnQzro4mzKO/+Takc4oJ+h1gAGb
        LyK7wmKuQDKkkL5KVmg/dCmGxDXtVCCO7L9WXICC9g==
X-Google-Smtp-Source: ACHHUZ6BRXujNARUx/P9s0LrdGtHz9hVIdad5izfvH+vy5Maxs5onv/E0YqXK8OSS13iB6TZa/Wk4ogMUGfzBYwCLsg=
X-Received: by 2002:a25:a4aa:0:b0:c00:e6c4:1812 with SMTP id
 g39-20020a25a4aa000000b00c00e6c41812mr16841209ybi.63.1687903099324; Tue, 27
 Jun 2023 14:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner> <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner> <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com> <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 14:58:08 -0700
Message-ID: <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 2:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jun 27, 2023 at 1:09=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Jun 27, 2023 at 11:42=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
> > >
> > > Hello, Christian.
> > >
> > > On Tue, Jun 27, 2023 at 07:30:26PM +0200, Christian Brauner wrote:
> > > ...
> > > > ->release() was added in
> > > >
> > > >     commit 0e67db2f9fe91937e798e3d7d22c50a8438187e1
> > > >     kernfs: add kernfs_ops->open/release() callbacks
> > > >
> > > >     Add ->open/release() methods to kernfs_ops.  ->open() is called=
 when
> > > >     the file is opened and ->release() when the file is either rele=
ased or
> > > >     severed.  These callbacks can be used, for example, to manage
> > > >     persistent caching objects over multiple seq_file iterations.
> > > >
> > > >     Signed-off-by: Tejun Heo <tj@kernel.org>
> > > >     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >     Acked-by: Acked-by: Zefan Li <lizefan@huawei.com>
> > > >
> > > > which mentions "either releases or severed" which imho already poin=
ts to
> > > > separate methods.
> > >
> > > This is because kernfs has revoking operation which doesn't exist for=
 other
> > > filesystems. Other filesystem implemenations can't just say "I'm done=
. Bye!"
> > > and go away. Even if the underlying filesystem has completely failed,=
 the
> > > code still has to remain attached and keep aborting operations.
> > >
> > > However, kernfs serves as the midlayer to a lot of device drivers and=
 other
> > > internal subsystems and it'd be really inconvenient for each of them =
to have
> > > to implement "I want to go away but I gotta wait out this user who's =
holding
> > > onto my tuning knob file". So, kernfs exposes a revoke or severing se=
mantics
> > > something that's exposing interface through kernfs wants to stop doin=
g so.
> > >
> > > If you look at it from file operation implementation POV, this seems =
exactly
> > > like ->release. All open files are shutdown and there won't be any fu=
ture
> > > operations. After all, revoke is forced closing of all fd's. So, for =
most
> > > users, treating severing just like ->release is the right thing to do=
.
> > >
> > > The PSI file which caused this is a special case because it attaches
> > > something to its kernfs file which outlives the severing operation by=
passing
> > > kernfs infra. A more complete way to fix this would be supporting the
> > > required behavior from kernfs side, so that the PSI file operates on =
kernfs
> > > interface which knows the severing event and detaches properly. That =
said,
> > > currently, this is very much an one-off.
> > >
> > > Suren, if you're interested, it might make sense to pipe poll through=
 kernfs
> > > properly so that it has its kernfs operation and kernfs can sever it.=
 That
> > > said, as this is a fix for something which is currently causing crash=
es,
> > > it'd be better to merge this simpler fix first no matter what.
> >
> > I'm happy to implement the right fix if you go into more details.
> > AFAIKT kernfs_ops already has poll() operation, we are hooking
> > cgroup_file_poll() to it and using kernfs_generic_poll(). I thought
> > this is the right way to pipe poll through kernfs but if that's
> > incorrect, please let me know. I'm happy to fix that.
>
> Ah, sorry, for PSI we are not using kernfs_generic_poll(), so my claim
> misrepresents the situation. Let me look into how
> kernfs_generic_poll() is implemented and maybe I can find a better
> solution for PSI.

Ok in kernfs_generic_poll() we are using kernfs_open_node.poll
waitqueue head for polling and kernfs_open_node is freed from inside
kernfs_unlink_open_file() which is called from kernfs_fop_release().
So, it is destroyed only when the last fput() is done, unlike the
ops->release() operation which we are using for destroying PSI
trigger's waitqueue. So, it seems we still need an operation which
would indicate that the file is truly going away.

Christian's suggestion to rename current ops->release() operation into
ops->drain() (or ops->flush() per Matthew's request) and introduce a
"new" ops->release() which is called only when the last fput() is done
seems sane to me. Would everyone be happy with that approach?


> Thanks,
> Suren.
>
> > Thanks,
> > Suren.
> >
> > >
> > > Thanks.
> >
> > >
> > > --
> > > tejun
