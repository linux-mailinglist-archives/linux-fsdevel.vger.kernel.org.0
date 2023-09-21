Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF907A9AD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjIUSvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjIUSus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:50:48 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E98C622
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:42:29 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77411614b57so31065385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318148; x=1695922948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4COJWRPSDOtzsNDUNUDDVcrPJQtBDHpVoY2tFTToimY=;
        b=izoVMSgBPyBGRvcplAgv2MHMNaE32qpPiAFWi/klCqcyw5F6+Mr2aDH5MaZuoieRx7
         Yxa8VJGfto39gNS44vFenBRwA6A671wpIaCLYMxH/XFkeKYFT9/Az9DyD7E/hsZZmfEz
         2ZsSGU7uXQs4mr33rmo6uku2fAIlrdnyqsw+Xh6LslZjRKyhnjM//ji3l7XysJMQ9ALf
         gUQOzkqKUBOw34jLMYlFxdBdwSe111ErEz88tJ2dv1tRzvpUKsW41sWcA5SEjTahbWzJ
         EhMD6ea+oiAJDKEhmCR71Ca80/QIdSb+pEoRCE9R2fERlBo9lL76kOJPwayj4aSfzdBF
         B0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318148; x=1695922948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4COJWRPSDOtzsNDUNUDDVcrPJQtBDHpVoY2tFTToimY=;
        b=ogF7JPFSQZcvH3QrTU0HXiGg2EIY3pL4jVkY33lpqpApx5xPc8/b6cTLcLIS9Mhblq
         2yBwGKP60EP+jxBu8iqqtfMMIt7TLeTfKXW76qRnW3mgIGPMgi5fHbYsEkLChDfeMov/
         pHJjf4mGfl62d4XOfjp5WTRK+/Mm13dT9YgakqLvP8VqZ1ZDumRLUHW4ZO2FAI9ketID
         1N6xLuIbourGch93WhaNvxjCL9R/kVJufPmUzlpI1C5jwr4htirHwyMFtPX2pFNZAJpm
         9CKQ0SEF7aKIZi3NiMuTg6AdiEIBt3F8SWiTXXquZfQhXW/mElPUPv6VTggO7vnrVlnT
         6LoA==
X-Gm-Message-State: AOJu0Yy5cavedZv4T9OXW2e5VHi3cb70HLi8gXI/3e2eeC9awi/+9wT0
        d7YljWBxxL2oz+pRbTV6V1QIPvyxs+b4eptMEYs33Z710Sw=
X-Google-Smtp-Source: AGHT+IHTApGPDL1k5+/3ELyI1ZtVNEegQYBreudlASo8LoyI3GsmkNq1JF98YVOLlAJCj+ocEOKmZuleMszOAd4N35E=
X-Received: by 2002:a67:ad02:0:b0:452:6d5b:f4b9 with SMTP id
 t2-20020a67ad02000000b004526d5bf4b9mr6675708vsl.12.1695306252880; Thu, 21 Sep
 2023 07:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230920173445.3943581-1-bschubert@ddn.com> <CAOQ4uxi+jk7rv7mtnpH4RXbZJx6N+cWecqd3UyJJHsW8yw_SXg@mail.gmail.com>
 <b22b8760-fca0-4251-b1a8-5989c26e1657@ddn.com>
In-Reply-To: <b22b8760-fca0-4251-b1a8-5989c26e1657@ddn.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 17:24:01 +0300
Message-ID: <CAOQ4uxgbSFDfgz1vFnDAaJo-36T6UPnUXZnk_y=bZMi0NqzvKQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 3:00=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 9/21/23 11:33, Amir Goldstein wrote:
> > On Thu, Sep 21, 2023 at 9:31=E2=80=AFAM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> >>
> >> In FUSE, as of now, uncached lookups are expensive over the wire.
> >> E.g additional latencies and stressing (meta data) servers from
> >> thousands of clients. With atomic-open lookup before open
> >> can be avoided.
> >>
> >> Here is the link to performance numbers
> >> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans=
87@gmail.com/
> >>
> >> Here is the libfuse pull request
> >> https://github.com/libfuse/libfuse/pull/813
> >>
> >> The patches are passing passthrough_hp xfstests (libfuse part applied)=
,
> >> although we had to introduce umount retries into xfstests, as recent
> >> kernels/xfstests fail umount in some tests with
> >> EBUSY - independent of atomic open. (Although outstanding for v7)
> >
> > Hi Bernd!
> >
> > I was using xfstests to test passthrough_hp (for FUSE kernel passthroug=
h).
> > FYI, I have made some improvements to the mount helper
> > in libfuse [1] to support remount, which helps pass a few tests.
>
> Thanks, just asked there to send it separate to upstream.
>
> >
> > So far, I have all the tests in group -g quick.rw pass with the baselin=
e
> > passthrough_hp (over xfs).
> >
> > Do you have a baseline for the entire quick/auto group to share with me=
?
>
> Please find my results attached.

Not too bad.
3 more tests can pass with my mount helper fix for remount ;)

> I have opened a libfuse issue for generic/477,
> (open_by_handle_at tests) but I'm not sure if this is passthrough_hp only=
 (it
> trusts the passed node id, without checking if there is an inode object f=
or it).
> Possibly fuse.ko passes an invalide node id - this is something for a rai=
ny
> weekend (or so) to investigate...

Stale file handles after mount cycle are expected.
FUSE is not equipped to handle this correctly.

NFS clients may even get access to the wrong inode
after FUSE restart/reexport, if FUSE is exported with the same
NFS fsid.

See this discussion [3] about how this could be solved hackishly
with existing FUSE protocol (for fs that know how to open by ino)
and about the LOOKUP_HANDLE protocol command that is
needed to solve this in a generic way.

>
>
> > Can you share the patch that you are using to avoid the EBUSY errors?
>
>
> The simple version to avoid _most_ of EBUSY is this
>
>
> diff --git a/common/rc b/common/rc
> index 741579af..a40fca3b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -305,6 +305,7 @@ _scratch_mount_idmapped()
>
>   _scratch_unmount()
>   {
> +       sync
>          case "$FSTYP" in
>          overlay)
>                  _overlay_scratch_unmount
>
>
>
> The better version is this
> https://github.com/kdave/xfstests/commit/33a15af07bb044e2773a83df1c7e0a0d=
f280a4b7
>
> >
> > Note that Chritian has suggested a method to use inotify
> > IN_UNMOUNT event to wait for sb shutdown in fstests [2].
>
> Thanks, I had seen the discussion. Although I (silently) wondered if some=
thing
> like MNT_BLOCk as umount2 flag wouldn't be easier.
>

You'd better keep wondering silently unless you want to upset Christian ;)

Thanks,
Amir.

> > [1] https://github.com/amir73il/libfuse/commits/fuse-backing-fd
> > [2] https://lore.kernel.org/linux-fsdevel/20230908-verflachen-neudefini=
tion-4da649d673a9@brauner/
[3] https://lore.kernel.org/linux-fsdevel/CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy=
9Gci41bmak4_ROSc3g@mail.gmail.com/
