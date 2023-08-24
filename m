Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA7786ECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjHXMMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 08:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbjHXMMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:12:21 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5B1995;
        Thu, 24 Aug 2023 05:12:05 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a0254de2fdso2278885241.1;
        Thu, 24 Aug 2023 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692879124; x=1693483924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGo5hfjcvdmUMo1YfifwNSty4SGLCMBumi8JkXBFf8I=;
        b=Rn2jffmudrhdWEtAVVkPys1xyti4QJIMg+fcPEHNPhXRJj7mJnMCV2t741nQ08w796
         03xGVQ1MWVCym8nbKwVWjN/a1pE9bzYbee3pFl4hL4YPfbmSbgiEKWB6MSGZSg/j2iKV
         XeNNgtbfhuWljgy7hNYywgX9U+q1t1Ht5Ks3TKGAtKkK+EcLMDSUl94anEWOjwqA9VSY
         hqbaWF3GhOk+tUl0L5eHXfbkuHmV7YtN0TpoTcxqF5TduzcCtl9aRQSPBl7x+Uh08Sbs
         jK4cdV3Orj/19yBZdOojxXFqp79+V1bKZVcZVRwkyx4MvgvAstf9U8BE9vNmiRgN2G5n
         U+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879124; x=1693483924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGo5hfjcvdmUMo1YfifwNSty4SGLCMBumi8JkXBFf8I=;
        b=GhW2XFShMLzyBqPK35d0irBCu7mXbSqwsn6piaqDknswk3QuHnHFkGcXHNqy+KKy+Z
         I/t6uIDW5xmMMEtDBzDpjqiYKRuP7qLGl8qvG4GsQDjnvvJmCD/FYAQu4NDYDJT2Zncu
         F0kpwFZhe1W29ytQJzUck1gCuf9f2qwv/We3EAQkF/HS1j+VjwUHsdsapYYg/oHy6JKT
         b8DQuitreDBB8ZYvzcstVUhYLH6PH3qzqHGBcuAQ3/pNm2v/+AGWAlyGqEXw1QJ7kjFQ
         WHsRD9JxTFxv2x9PoBLLHJaHOHxnNbWYRmPaf9uO9yjjFPTmjKgFMC+vPZ6joOs798cm
         nzZg==
X-Gm-Message-State: AOJu0YxeionYAch5aM3muuz41MrSemCXuK2kOuxlKoUS+cCWXqoxVJiE
        p4bWPO+9D1kfklcky6ieumXHIA9cLz12EHkryio=
X-Google-Smtp-Source: AGHT+IHpfDhOY2l5X2WzlzGT6gteoma6tdVJnjbk9cTfr+7+RiQERiTRNAFtKfhuOg19q8Zx+QfaSxtZosOBE5+K+OA=
X-Received: by 2002:a05:6102:1cf:b0:44d:50f0:f43e with SMTP id
 s15-20020a05610201cf00b0044d50f0f43emr10012819vsq.30.1692879124295; Thu, 24
 Aug 2023 05:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
 <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
 <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
 <CAOQ4uxirdrsaHPyctxRgSMxb2mBHJCJqB12Eof02CnouExKgzQ@mail.gmail.com> <CAJfpegth3TASZKvc_HrhGLOAFSGiAriiqO6iCN2OzT2bu62aDA@mail.gmail.com>
In-Reply-To: <CAJfpegth3TASZKvc_HrhGLOAFSGiAriiqO6iCN2OzT2bu62aDA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Aug 2023 15:11:53 +0300
Message-ID: <CAOQ4uxgzYevVCaGBjjckOr1vv0gKvVPYiOAL6E_KQY-YQx_7hg@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 22, 2023 at 2:03=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 22 Aug 2023 at 12:18, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Aug 21, 2023 at 6:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
>
> > > Getting back to this.
> > > Did you mean something like that? (only compile tested)
> > >
> > > https://github.com/amir73il/linux/commits/backing_fs
> > >
> > > If yes, then I wonder:
> > > 1. Is the difference between FUSE_IOCB_MASK and OVL_IOCB_MASK
> > >     (i.e. the APPEND flag) intentional?
>
> Setting IOCB_APPEND on the backing file doesn't make a difference as
> long as the backing file is not modified during the write.
>
> In overlayfs the case of the backing file being modified is not
> defined, so I guess that's the reason to omit it.  However I don't see
> a problem with setting it on the backing file either, the file
> size/position is synchronized after the write, so nothing bad should
> happen if the backing file was modified.
>

That raises the question if FUSE passthrough behavior is defined when
backing file is being modified. Should it be any different than ovl?
I don't really care if we set IOCB_APPEND or not, just if we need
a different mask for ovl and FUSE.

> > > 2. What would be the right way to do ovl_copyattr() on io completion?
> > >     Pass another completion handler to read/write helpers?
> > >     This seems a bit ugly. Do you have a nicer idea?
> > >
>
> Ugh, I missed that little detail.   I don't have a better idea than to
> use a callback function.
>

Ok. added the cleanup callback.
I think it's not that bad?

https://github.com/amir73il/linux/commits/backing_fs

> >
> > Hmm. Looking closer, ovl_copyattr() in ovl_aio_cleanup_handler()
> > seems a bit racy as it is not done under inode_lock().
> >

Decided to fix that by taking ovl inode spinlock inside ovl_copyattr()
and did the same for ovl_file_accessed() for read ops.

I've found and fixed two other issues with aio completion on this branch,
one of them is a fix for a possible realfile refcount leak, so will probabl=
y
need to backport this one.

Thanks,
Amir.
