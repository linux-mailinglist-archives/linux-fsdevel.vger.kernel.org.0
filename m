Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7D4B0313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 03:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiBJCIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 21:08:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiBJCIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:08:13 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88894F76
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 18:06:20 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id c36so2262806uae.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 18:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Akgx51vaaMrtc+I5CN79O3ziymolIo3sR9qZ9Dclibo=;
        b=AEBGLpCXKdcPH9e6PUy58PqQod9wcJMMmgPof7QbAjGzdeRF0q/P+pH44kUmDYXM/F
         C6+CQsZ6c9rK9EupFMDkbqrM+DfqjV3UqaYarinoJuK8CpLMuOSYGk0Nq3fK7PkcpJiv
         gc3gi9uZiUi5N6F9eFpds1/g29PT9p4qlJyx2BXQXdYrOZgxEQFLAhy5KtNI/x0tz2d1
         CYDNsBHC8TGTARw17XIoxMfsxSrrgp9U8OU+gFqikpI0xY7rPvk77/dEVBzWrqP9NPvs
         WxZKuHq9PDqZh1noKcc4emoD1TSxaY52F/MXWdCIbNnZArQhD6UiMiq20odVQfx2X8Tt
         bfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Akgx51vaaMrtc+I5CN79O3ziymolIo3sR9qZ9Dclibo=;
        b=XJSoX3KIlB22YqdY5rWW8px272VxCso5+Z8CPOolI+bttypeNwCnC8tfYT5nZZSphW
         EW2J4ozdD7Bfr3DAUWEYoAVxisTbz+la0Ic9ZliunZjH8WC70/woeHY5qtVzom5yOqZ8
         zf2ZSjRWEc80uMyAZ+Gm75jjTdGSYqZ9d2pkeVnYVDd23xK2Og/UYWqg12Qq1+cADYk6
         oTb5GSeo3Cq8gkH9Nh5vrcWLj7m8PxjUZm+nU4zsMR22WhKFO33KqrdKFWeVK0v/7yj5
         ZBU1jKF1ga885CXX6eEBsttZbjkJdP/lcYPB5a2NQAyFAoU4nwB0Wj70e10eFbdxWs+q
         OXtQ==
X-Gm-Message-State: AOAM533YCbHedgrWXPtwRMtNqrfBj6VTEs5GjkjbgEcpXN8sP9bnnhsv
        UhHesrbWL/Wod0L+GUJWaFJzPUR/7ugjR4CA97QAZY/Dsq271w==
X-Google-Smtp-Source: ABdhPJx4o8BFRxE3WtS5vfxB6Q7U0LsX8rDHfugHML6AhQxaWreAtX6zQ2pAj5U4yGvassMurqhVlDu9siwHSMj6Cbg=
X-Received: by 2002:a81:310:: with SMTP id 16mr4869228ywd.35.1644452058925;
 Wed, 09 Feb 2022 16:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209225758.476724-1-mcgrof@kernel.org> <CAA5qM4BBHj44NgH2210nfZCBru0NV04gd1t8Yp7Et6M7LmJK-w@mail.gmail.com>
 <YgROSgDA3keJowks@bombadil.infradead.org> <CAA5qM4C2g6=6mWsQW4vkbSV0ykEjBgNYGp8oVFKtQfKFn5OFjA@mail.gmail.com>
In-Reply-To: <CAA5qM4C2g6=6mWsQW4vkbSV0ykEjBgNYGp8oVFKtQfKFn5OFjA@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 9 Feb 2022 16:14:08 -0800
Message-ID: <CAA5qM4CGCfLUv8o0Er1FL-2+ntqsTgw1FQODnCH9FA8WvuSr=w@mail.gmail.com>
Subject: Re: [PATCH v2] fs: move binfmt_misc sysctl to its own file as built-in
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, nixiaoming@huawei.com,
        Eric Biederman <ebiederm@xmission.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        patches@lists.linux.dev,
        Domenico Andreoli <domenico.andreoli@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 9, 2022 at 3:39 PM Tong Zhang <ztong0001@gmail.com> wrote:
>
> On Wed, Feb 9, 2022 at 3:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Feb 09, 2022 at 03:15:53PM -0800, Tong Zhang wrote:
> > > On Wed, Feb 9, 2022 at 2:58 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > This is the second attempt to move binfmt_misc sysctl to its
> > > > own file. The issue with the first move was that we moved
> > > > the binfmt_misc sysctls to the binfmt_misc module, but the
> > > > way things work on some systems is that the binfmt_misc
> > > > module will load if the sysctl is present. If we don't force
> > > > the sysctl on, the module won't load. The proper thing to do
> > > > is to register the sysctl if the module was built or the
> > > > binfmt_misc code was built-in, we do this by using the helper
> > > > IS_ENABLED() now.
> > > >
> > > > The rationale for the move:
> > > >
> > > > kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> > > > dishes, this makes it very difficult to maintain.
> > > >
> > > > To help with this maintenance let's start by moving sysctls to places
> > > > where they actually belong.  The proc sysctl maintainers do not want to
> > > > know what sysctl knobs you wish to add for your own piece of code, we
> > > > just care about the core logic.
> > > >
> > > > This moves the binfmt_misc sysctl to its own file to help remove clutter
> > > > from kernel/sysctl.c.
> > > >
> > > > Cc: Domenico Andreoli <domenico.andreoli@linux.com>
> > > > Cc: Tong Zhang <ztong0001@gmail.com>
> > > > Reviewed-by: Tong Zhang <ztong0001@gmail.com>
> > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > ---
> > > >
> > > > Andrew,
> > > >
> > > > If we get tested-by from Domenico and Tong I think this is ready.
> > > >
> > > > Demenico, Tong, can you please test this patch? Linus' tree
> > > > should already have all the prior work reverted as Domenico requested
> > > > so this starts fresh.
> > > >
> > > >  fs/file_table.c |  2 ++
> > > >  kernel/sysctl.c | 13 -------------
> > > >  2 files changed, 2 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > > index 57edef16dce4..4969021fa676 100644
> > > > --- a/fs/file_table.c
> > > > +++ b/fs/file_table.c
> > > > @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
> > > >  static int __init init_fs_stat_sysctls(void)
> > > >  {
> > > >         register_sysctl_init("fs", fs_stat_sysctls);
> > > > +       if (IS_ENABLED(CONFIG_BINFMT_MISC))
> > > > +               register_sysctl_mount_point("fs/binfmt_misc");
                             ^^^^


I'm looking at this code again and we need to mark this return value
in kmemleak to avoid a false positive.


diff --git a/fs/file_table.c b/fs/file_table.c
index 4969021fa676..7303aa33b3fd 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -27,6 +27,7 @@
 #include <linux/task_work.h>
 #include <linux/ima.h>
 #include <linux/swap.h>
+#include <linux/kmemleak.h>

 #include <linux/atomic.h>

@@ -119,8 +120,10 @@ static struct ctl_table fs_stat_sysctls[] = {
 static int __init init_fs_stat_sysctls(void)
 {
        register_sysctl_init("fs", fs_stat_sysctls);
-       if (IS_ENABLED(CONFIG_BINFMT_MISC))
-               register_sysctl_mount_point("fs/binfmt_misc");
+       if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
+               struct ctl_table_header *hdr =
register_sysctl_mount_point("fs/binfmt_misc");
+               kmemleak_not_leak(hdr);
+    }
        return 0;
 }
 fs_initcall(init_fs_stat_sysctls);
