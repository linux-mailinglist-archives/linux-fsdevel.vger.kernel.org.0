Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CB60143C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJQRDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiJQRDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:03:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4070E5D;
        Mon, 17 Oct 2022 10:03:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k3so13987203ybk.9;
        Mon, 17 Oct 2022 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1gM2OhPkZ6+CVHU/B6ywYxdhbtgkPzENmTLQaUuvjkI=;
        b=cZIQgpIJQMIYS77HywyT+t1No+jvE3iaIWeu9auSgMVTDDkiouT8bS/VE8qSdKT0d7
         ozM1qOetOvplkyukd+qBZxkr/6vTKMLKt7PUFZzF/0LCSQHtLqKu5MUsdgH10hWpnr5H
         4/21CuM9XyiM5QgBk5Pp9GqrpY9PRRieeJiUIRxWRp7TuGZFuZQwQagPv4ryPCsPHnX1
         4wD+30MmtV04vpLsPmjY3pKLq/Zf8T2tiTmjy4yG9kNZBHlfdfx9oD/GIOqhEf73Mq8l
         5rFU4v0nBIdfCVPGcf705WrSo4Xh9xFKZ1WgzZ4Xpr+uTaAxmPkQzptZWZrdjJUwm+I6
         80DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gM2OhPkZ6+CVHU/B6ywYxdhbtgkPzENmTLQaUuvjkI=;
        b=wjDgPXXRQaluJNxU6BIu+SW0t4PTZVnsv9p/5Yq8+U+r1XQ9w3jfh45cqrGa7kpblV
         WK/jOZXcTFZjh3UojOp5SDRdjdXqMv99o4eOqHcQPwPjggZC5lCrcqUe+jjS/Ak27Vcn
         E11ZwX9z6zArfnO0S6KAXiceljoM3zZ2pCZio7HEPNFt6NuNqFv1sHwvWLbLtWd59VYT
         EBAVMj/zdCBnG8Vh44nKSj9H4kSnYWiXogZ/Fx7Xseps6LyZaZEKxrxfIsG6Wle5u2QW
         WD0OKdXtWfDomCvkLkotyALWLsbAzy9G6GGd1XWDOKnR8bZB9lOuPU6iunh8rYLHW4qE
         UFYA==
X-Gm-Message-State: ACrzQf3nx6R7m7Hdi4hT/kFN9+jfVIaAw6Wc+rVT4zHpsVkMRhwuKoT/
        9+ZOR6OZ+eDxm41nH6hdzMyEpF6qNyv3ig3mFCE=
X-Google-Smtp-Source: AMsMyM54HWiafe2uq2dl3gt7Md5lNHao++4/jaAzrj0jQke8Zcm1vzvnTP8vRn3Now7tETxpKUpDojnpfnywgJIOW7A=
X-Received: by 2002:a05:6902:1186:b0:6c1:653a:ba74 with SMTP id
 m6-20020a056902118600b006c1653aba74mr10104010ybu.546.1666026220102; Mon, 17
 Oct 2022 10:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221004171351.3678194-1-daeho43@gmail.com> <20221004171351.3678194-2-daeho43@gmail.com>
 <Yz6S3kP4rjm5/30N@infradead.org> <Yz8DJROpwCcNyxVX@magnolia>
In-Reply-To: <Yz8DJROpwCcNyxVX@magnolia>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 17 Oct 2022 10:03:29 -0700
Message-ID: <CACOAw_z61txMMH+5Pq+4LS5hmC9rbvHaEiY5-V-M9mq56Tx6yg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 6, 2022 at 9:32 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Oct 06, 2022 at 01:33:34AM -0700, Christoph Hellwig wrote:
> > On Tue, Oct 04, 2022 at 10:13:51AM -0700, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > introduce a new ioctl to replace the whole content of a file atomically,
> > > which means it induces truncate and content update at the same time.
> > > We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
> > > F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
> > > F2FS_IOC_ABORT_ATOMIC_WRITE.
> >
> > It would be great to Cc Darrick and linux-fsdevel as there have been
> > attempts to do this properly at the VFS level instead of a completely
> > undocumented ioctl.
>
> It's been a while since I sent the last RFC, but yes, it's still in my
> queue as part of the xfs online fsck patchserieses.
>
> https://lore.kernel.org/linux-fsdevel/161723932606.3149451.12366114306150243052.stgit@magnolia/
>
> More recent git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates

Hi,

It's a very interesting suggestion and we might use this in F2FS someday.
However, I think it's not exactly matched for what
F2FS_IOC_START_ATOMIC_REPLACE is doing now.

Thanks for bringing my attention to this.

>
> --D
