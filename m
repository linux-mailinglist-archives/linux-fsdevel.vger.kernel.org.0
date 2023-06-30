Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F170743A41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjF3LEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjF3LD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:03:27 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A43C17;
        Fri, 30 Jun 2023 04:03:15 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7943105effbso1185381241.1;
        Fri, 30 Jun 2023 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688122994; x=1690714994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaSOpIJ34lE/i1x2tvGLBrOLs+W6vzHjfhEOuxV19ks=;
        b=YSIXiaEyLlHOfSAOzhdmuXHBtBRPuHjhe0IyZTMaZXYA8Q1ogf9WjKBK4ubNa8yy7T
         LPOgne/3levBQ5eJi0FN09VM7LWClcOYf8OFKIifA7n3KB2/DUE54fg+dKc+24t129xF
         E2KBQTXY9m+XcIz9Ujq2xvREBbBwO8z/Uh10CgDirRTkaB52VnHSl8ntL2w+A2TdOwPl
         llqETPyym5UZag9qJKX2OTZYfAwR8IkaIhATI3sfd8UagvhSwpst3NtH0pCf9yHoK+nK
         40y36X5oIgJ8j4CrAeXf3euSOpzbUlybMgLZ3wE3fdPIr6lmhZslW2AWFTfa//A/vsr9
         L1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122994; x=1690714994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaSOpIJ34lE/i1x2tvGLBrOLs+W6vzHjfhEOuxV19ks=;
        b=At047k+3YeGQlOheI7yxyPPx5MmunsV1uGL8hRB5kt2ToPpIu2ZeefAqViXLiTd2VY
         Iva5ET0vXjZ4BmT2vMQYwH+gG0EVIYub1dgtBWx1P+kaberZBW4zMjWe4CUq+LB5nRQC
         NRzR02nK0TRWdhS94fo2IJ34oRGsqB0iiSz3XqIwopTrFx6a+jYCjln4Gdd+Ss4RoyqU
         WiRxp1MD7iS27X3XD5uetjwkvVcMkmUGu9wlJrGM6n4ZPjWOevloK6Lsxn2o4gHOXcg3
         DSS6G2cBiHRO1xPnUdhrcU0ETqc9A20iBAMMgB8RurX6to/7O6b3OkK2v7g8ihYKkuJa
         NBqQ==
X-Gm-Message-State: AC+VfDxlbqTvunQr/eVzEwhC3xhyr1IlC1j8IOlDg8caHHFnspLsqPRn
        fN/Nxy4xThy1DhPIyo1bO3cUn+m8/jGD1uCkvyvBUmfg
X-Google-Smtp-Source: ACHHUZ4oNPOjaFNEydL2qyGVP7Z5jKQXqW/31qp5iGWHqBT5c1C+evMUhHBNERjdX4J6ki6cDnI2zUPb7veFKa1qmlw=
X-Received: by 2002:a05:6102:ec8:b0:443:8053:f969 with SMTP id
 m8-20020a0561020ec800b004438053f969mr3563175vst.17.1688122994516; Fri, 30 Jun
 2023 04:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz> <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
 <q2nwpf74fngjdlhukkxvlxuz3xkaaq4aup7hzpqjkqlmlthag5@dsx6m7cgk5yt>
 <CAOQ4uxh-ALXa0N-aZzVtO9E5e6C5++OOnkbL=aPSwRbF=DL1Pw@mail.gmail.com> <3nfsszygfgzpli4xvwuwpli5ozpqtcnlij737qid6riwramjkv@pj23p6q5tzrb>
In-Reply-To: <3nfsszygfgzpli4xvwuwpli5ozpqtcnlij737qid6riwramjkv@pj23p6q5tzrb>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Jun 2023 14:03:03 +0300
Message-ID: <CAOQ4uxjqnaB1JJbd3u_oeFsH3V-zYwKftWy=gLhqTQVJvxAgKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
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

On Wed, Jun 28, 2023 at 11:18=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> On Wed, Jun 28, 2023 at 09:38:03PM +0300, Amir Goldstein wrote:
> > On Wed, Jun 28, 2023 at 8:09=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> > <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > > On Wed, Jun 28, 2023 at 09:33:43AM +0300, Amir Goldstein wrote:
> > > > I think we need to add a rule to fanotify_events_supported() to ban
> > > > sb/mount marks on SB_KERNMOUNT and backport this
> > > > fix to LTS kernels (I will look into it) and then we can fine tune
> > > > the s_fsnotify_connectors optimization in fsnotify_parent() for
> > > > the SB_KERNMOUNT special case.
> > > > This may be able to save your patch for the faith of NACKed
> > > > for performance regression.
> > > This goes over my head, but if Jan says it makes sense
> > > then it must do.
> > Here you go:
> > https://github.com/amir73il/linux/commits/fsnotify_pipe
> >
> > I ended up using SB_NOUSER which is narrower than
> > SB_KERNMOUNT.
> >
> > Care to test?
> > 1) Functionally - that I did not break your tests.
> ) | gzip -d > inotify13; chmod +x inotify13; exec ./inotify13
> tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
> inotify13.c:260: TINFO: file_to_pipe
> inotify13.c:269: TPASS: =D0=BE=D0=BA
> inotify13.c:260: TINFO: file_to_pipe
> inotify13.c:269: TPASS: =D0=BE=D0=BA
> inotify13.c:260: TINFO: splice_pipe_to_file
> inotify13.c:269: TPASS: =D0=BE=D0=BA
> inotify13.c:260: TINFO: pipe_to_pipe
> inotify13.c:269: TPASS: =D0=BE=D0=BA
> inotify13.c:260: TINFO: pipe_to_pipe
> inotify13.c:269: TPASS: =D0=BE=D0=BA
> inotify13.c:260: TINFO: vmsplice_pipe_to_mem
> inotify13.c:269: TPASS: =D0=BE=D0=BA
> inotify13.c:260: TINFO: vmsplice_mem_to_pipe
> inotify13.c:269: TPASS: =D0=BE=D0=BA
>
> Summary:
> passed   7
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> The discrete tests from before also work as expected,
> both to a fifo and an anon pipe.
>
> > 2) Optimization - that when one anon pipe has an inotify watch
> > write to another anon pipe stops at fsnotify_inode_has_watchers()
> > and does not get to fsnotify().
> Yes, I can confirm this as well: fsnotify_parent() only continues to
> fsnotify() for the watched pipe; writes to other pipes early-exit.
>
> To validate the counterfactual, I reverted "fsnotify: optimize the case
> of anonymous pipe with no watches" and fsnotify() was being called
> for each anon pipe write, so long as any anon pipe watches were registere=
d.

Thank you for testing!

As Jan suggested, when you post v5, with my Reviewed-by and Jan's
Acked-by, please ask Christian to review and consider taking these
patches through the vfs tree for the 6.6 release.

Please include a link to your LTP test in the cover letter and a link to
my performance optimization patches.

Unless the kernel test bots detect a performance regression due to
your patches, I am not sure whether or not or when we will apply the
optimization patches.

Thanks,
Amir.
