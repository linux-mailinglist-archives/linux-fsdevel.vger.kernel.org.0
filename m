Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B64D6FB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiCLPSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 10:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiCLPSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:18:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3220C186
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Mar 2022 07:17:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t1so14101102edc.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Mar 2022 07:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pxin1j5j6CcmsdIEAHJPFzyAPatANahFw6X6/cFoxnM=;
        b=SU4xr4X6+2waARawoylMlsiCPWBIBETU0MciuaZEiWdrDk2hx5UmhtjVBnOvAg/j8Y
         P5AEc3LcMVyzxEP5nHlv2Olz53uvkKS0fxrgUxGcRFmX98+Qq6Q6eMA/vwzJmqCvzO/O
         j+/mBzE+2Hp2rK2NI//4QDTmfX1LS9FohQxULpnfR8tTvY+r5fNWcupz8YhvqN+Qfuv8
         G8GJScHk8gdOrtgUA2dETidap7xy6kcyCZ5Ayh4fMOWadoH7T5SieRyl6yB9ATdxntP9
         /mrpSZqnk7afxXSrRZfLG9VUNA1B3WEMpKhYck68O+2UM4Q/g0ZrqJAGonS296H4uEre
         YMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pxin1j5j6CcmsdIEAHJPFzyAPatANahFw6X6/cFoxnM=;
        b=wfoX31TRM74neVQ3KUPbxN6MBfpf+TVvBNDDyShodCA0+q9ASfLHtrqGaAsxdcDiwJ
         Lp9GpH/iFnO0wIRBRVKcNdWJm0F0g4i2cn5C/Ab/35FNL6XeOXbro56CdY5ALaJT7wnT
         T029rwJ9wRp9Nb/Q7C2gc7Bi+uS3rsiJc8Vc/nh8+NXuKBDy+7OqeoPgtPc7saMGCcm/
         YhwsFOpfbHEbS+rX5TPzmlLj0cPZhg+OYS0g2bMQNOrGts2L785FTwgV2paKdRaXzJBA
         cwKiSIHYdDWP9CsZgo39v1Syqyov7NrcjBwHh0uYiAjgkL9dNoYEyECCeC8RlLH+82WI
         i+sQ==
X-Gm-Message-State: AOAM5300F988dEcnG+xDOQYhpGUyNpZFx48Vsl5f/ioQEpi8woviFLev
        fJ24awBR/+onTboZ+eInCFjvErdMI5jDbv/6Jon0
X-Google-Smtp-Source: ABdhPJx4I73OmpEwBz9ywyJrJAWk2KLqVxBU5gzL/MTLzVaMx0+vl+oJ6aU8A6EOZmbP9Kz1KnrnrjH5oF/o50aIp00=
X-Received: by 2002:a05:6402:2552:b0:416:a745:9626 with SMTP id
 l18-20020a056402255200b00416a7459626mr13558015edb.405.1647098256718; Sat, 12
 Mar 2022 07:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20220228215935.748017-1-mic@digikod.net> <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net> <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
 <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com> <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
 <b848fe63-e86d-af38-5198-5519cb3c02ef@I-love.SAKURA.ne.jp>
In-Reply-To: <b848fe63-e86d-af38-5198-5519cb3c02ef@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 12 Mar 2022 10:17:25 -0500
Message-ID: <CAHC9VhQqx7B+6Ji_92eMZ1o9O_yaDQQoPVw92Av0Zznv7i8F8w@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 8:35 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/03/12 7:15, Paul Moore wrote:
> > The silence on this has been deafening :/  No thoughts on fixing, or
> > not fixing OPEN_FMODE(), Al?
>
> On 2022/03/01 19:15, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 01/03/2022 10:22, Christian Brauner wrote:
> >> That specific part seems a bit risky at first glance. Given that the
> >> patch referenced is from 2009 this means we've been allowing O_WRONLY =
|
> >> O_RDWR to succeed for almost 13 years now.
> >
> > Yeah, it's an old bug, but we should keep in mind that a file descripto=
r
> > created with such flags cannot be used to read nor write. However,
> > unfortunately, it can be used for things like ioctl, fstat, chdir=E2=80=
=A6 I
> > don't know if there is any user of this trick.
>
> I got a reply from Al at https://lkml.kernel.org/r/20090212032821.GD28946=
@ZenIV.linux.org.uk
> that sys_open(path, 3) is for ioctls only. And I'm using this trick when =
opening something
> for ioctls only.

Thanks Tetsuo, that's helpful.  After reading your email I went
digging around to see if this was documented anywhere, and buried in
the open(2) manpage, towards the bottom under the "File access mode"
header, is this paragraph:

 "Linux reserves the special, nonstandard access mode 3 (binary 11)
  in flags to mean: check for read and write permission on the file
  and return a file descriptor that can't be used for reading or
  writing.  This nonstandard access mode is used by some Linux
  drivers to return a file descriptor that is to be used only for
  device-specific ioctl(2) operations."

I learned something new today :)  With this in mind it looks like
doing a SELinux file:ioctl check is the correct thing to do.

Thanks again Tetsuo for clearing things up.

--=20
paul-moore.com
