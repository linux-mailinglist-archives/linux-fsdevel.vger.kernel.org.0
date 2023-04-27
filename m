Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAF6F0944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbjD0QLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0QLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:11:41 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0B2712
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 09:11:37 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7782debbc4bso5676215241.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682611896; x=1685203896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1swpDKNxVTEaQR6iZfz0AlWgoys+IcyCD/MqYviHl3E=;
        b=biufCn9w1ksP7iFSdRPZJCzfOERJrnX7pE6F6bTqj+RKu5jXZpFAwyCvP5prTK/MZI
         FxTCrpqQ1hJcn4t/t9Rd9GnpW3bhTO38Y3Hd6ipG46Ithu1nAzTKcLz+45FExQr4djAO
         4UyHDud5AzyCGfytGDJPSXPk/N0Mbqy3uHcktISGPxq6WWVoRFlOvYw1JC5iBLYFfhFV
         zE5f8sxfuzIZG/OxqN9/QtrjDWFh5WAd0fvhHzF0wH6bx6ZVQKky5sLDEt8xQjvBKUsy
         L20l+HllI9XuyH2KHhiuR/tq46b59SxRxjGRprbSfFGBYCKHay9maoWTxBj9N3mQI+xI
         xmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611896; x=1685203896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1swpDKNxVTEaQR6iZfz0AlWgoys+IcyCD/MqYviHl3E=;
        b=XjN3oiMsIYgTGCyca8+kTPgLi2/DXTG5CKWLsenwku5B4qP2O3gSxOK58AStk1klZq
         i+7OFG/qrLqqDT3BDtHwkkDzfD6t4c7OHbNncBOBLS9l4oCENUuQmjr22n+B3qTlAqeg
         aFY0NBHJo8phO2YPfs2IT+ODe8xbzTAsyiMBCN15h0TmWZ6ITAcaX4H0+0R9TcGM8WQ8
         ZSTLAJPYzu/GXlYAlWP4v5FZv2rR7jHquNd9zBng4N6/Z1r7Ikc2nPyTrSRr5Kqec0B8
         E1cWRY12EIrA1jQdqw05DpnegqANzdunspCJyxaNBxJ0aqM9lVue5vQ3PHW7P8VtjMkt
         t7QQ==
X-Gm-Message-State: AC+VfDzpDX0hatfgwNFRKmwmkSbaPh5rGhGsMDiRDwJd/fgTanpKFy65
        EgRZLxvgvJEWlWmNoY4GTB2teZuAIpPbWKh/W5oBRUtg
X-Google-Smtp-Source: ACHHUZ5LpXSEZJsrkojOSaJqbyrOToIwoO9bI0wiYuWb9lRfWt1rqdO2wfFkL78Qu6WirIR8M1jFQRRIQXu+0Zf+jGU=
X-Received: by 2002:a67:ebd7:0:b0:42f:f9f0:70f8 with SMTP id
 y23-20020a67ebd7000000b0042ff9f070f8mr1231304vso.7.1682611896545; Thu, 27 Apr
 2023 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com> <20230227105855.s5sdn5juh3o37cus@wittgenstein>
In-Reply-To: <20230227105855.s5sdn5juh3o37cus@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 19:11:25 +0300
Message-ID: <CAOQ4uxg3Gxc1jG2qFEc3-jv7C=6uiEYVcTYqWmYq4==OnLwLoA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Christian Brauner <brauner@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org,
        Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:59=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Feb 27, 2023 at 06:45:50PM +0800, Gao Xiang wrote:
> >
> > (+cc Jingbo Xu and Christian Brauner)
> >
> > On 2023/2/27 17:22, Alexander Larsson wrote:
> > > Hello,
> > >
> > > Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] th=
e
> > > Composefs filesystem. It is an opportunistically sharing, validating
> > > image-based filesystem, targeting usecases like validated ostree
> > > rootfs:es, validated container images that share common files, as wel=
l
> > > as other image based usecases.
> > >
> > > During the discussions in the composefs proposal (as seen on LWN[3])
> > > is has been proposed that (with some changes to overlayfs), similar
> > > behaviour can be achieved by combining the overlayfs
> > > "overlay.redirect" xattr with an read-only filesystem such as erofs.
> > >
> > > There are pros and cons to both these approaches, and the discussion
> > > about their respective value has sometimes been heated. We would like
> > > to have an in-person discussion at the summit, ideally also involving
> > > more of the filesystem development community, so that we can reach
> > > some consensus on what is the best apporach.
> > >
> > > Good participants would be at least: Alexander Larsson, Giuseppe
> > > Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
> > > Jingbo Xu
> > I'd be happy to discuss this at LSF/MM/BPF this year. Also we've addres=
sed
> > the root cause of the performance gap is that
> >
> > composefs read some data symlink-like payload data by using
> > cfs_read_vdata_path() which involves kernel_read() and trigger heuristi=
c
> > readahead of dir data (which is also landed in composefs vdata area
> > together with payload), so that most composefs dir I/O is already done
> > in advance by heuristic  readahead.  And we think almost all exist
> > in-kernel local fses doesn't have such heuristic readahead and if we ad=
d
> > the similar stuff, EROFS could do better than composefs.
> >
> > Also we've tried random stat()s about 500~1000 files in the tree you sh=
ared
> > (rather than just "ls -lR") and EROFS did almost the same or better tha=
n
> > composefs.  I guess further analysis (including blktrace) could be show=
n by
> > Jingbo later.
> >
> > Not sure if Christian Brauner would like to discuss this new stacked fs
>
> I'll be at lsfmm in any case and already got my invite a while ago. I
> intend to give some updates about a few vfs things and I can talk about
> this as well.
>

FYI, I schedule a ~30min session lead by Alexander
on remaining composefs topics
another ~30min session lead by Gao on EROFS topics
and another session for Christian dedicated to mounting images inside usern=
s.

Thanks,
Amir.
