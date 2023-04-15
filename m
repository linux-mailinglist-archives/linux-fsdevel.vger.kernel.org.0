Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5906E3108
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDOLHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDOLHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 07:07:01 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B132D73;
        Sat, 15 Apr 2023 04:06:58 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id p12so1334943uak.13;
        Sat, 15 Apr 2023 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681556818; x=1684148818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVGsSDU61/EuKltyjrXqAdX0XD2PqbdZCRx1bpZ6xCk=;
        b=X5tzDCCejdJvbofekQqDCL6jYGXndkgENYffMcZyz0H8IghP1GJAU/5C960PWIaZor
         kWzzrE/Sl2Rm0sIyY7uGJn8luAzLxsOArABMgNoUcJTv3kUQKxZSWgi3fZKSoX6ftE+G
         i9HmXwnQoc3eJVYv4QFJneoxtiJwOwQwgPgbp6QL/2def5qyHBTgxZ4Ce/qaQ/Cs3P5G
         BrkvUDoanJloSNDWwtYiG2NW8xBd4TtKvZhkd7K/+tTugljwssIm2+Ur033PQKd9A4fc
         GFvOasrrxqKVCzkTWWEXUF3S77uPzGIOKGELEbxxZVR5XSH14SgPgT3/W64uH9COCqrF
         8wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681556818; x=1684148818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVGsSDU61/EuKltyjrXqAdX0XD2PqbdZCRx1bpZ6xCk=;
        b=FZobX4asFlPEPjKZh15jmJNAcaapVjhs3i9y97b1nJltDeuhDDk8sk5nllI4INJc28
         mmKUaEINm2EPuz8Jnq+ch0ZweIaHGCrjaH4QbviQiyNRFP7J3KHFIeKpw7OYbcZYyIV0
         aJ6/nY0cEzaERMLMUJmIK1OxpCZah70OkdIzWJ0VC7CpZZSUFXbFUhhXD/lAvG6ZdTKM
         n32ukb9eDmlPRoIfHix3MvnKQAcew4nkdcrsZ+eAczZJGby4nT7qw97LKoK4sm1HIVvi
         z0z6i86NZ4P6a5Y4GQLLJ8VGWL5Vbx95nRSzSKEK9GWNnbPMYtC6RE65qRin//8UPwHN
         wuFA==
X-Gm-Message-State: AAQBX9e1K8AbHsriYAyS61JT7qM7qTjvBXzDWEWxJ6a85HTJwbRSiW8F
        2GlOivtFxt2+66ZL+078jweb+kUOFD2pw0PD2Bk=
X-Google-Smtp-Source: AKy350ajYHddrdnQrEFILBzfyaG+m6smLJQW39SyhgN7Unq0V4I6LbZK1QtK2k9FHdVHmiIlf9FrM4R2FD5SH7cjuVY=
X-Received: by 2002:a05:6122:17a1:b0:440:60e7:f8e6 with SMTP id
 o33-20020a05612217a100b0044060e7f8e6mr5162222vkf.0.1681556817879; Sat, 15 Apr
 2023 04:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
In-Reply-To: <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 Apr 2023 14:06:46 +0300
Message-ID: <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] fsinfo and mount namespace notifications
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 2:36=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 14 Nov 2022 at 10:00, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >
> > Hi Miklos and anyone interested in this proposal, is there any update o=
n
> > this? Sorry that I didn't find any..
>
> No update.
>
> Which part are you interested in?
>
> Getting mount attributes?  Or a generic key-value retrieval and
> storage interface?
>
> For the first one there are multiple proposals, one of them is adding
> a new system call using binary structs.  The fsinfo(2) syscall was
> deemed overdesigned and rejected.  Something simpler would probably be
> fairly uncontroversial.
>
> As for the other proposal it seems like some people would prefer a set
> of new syscalls, while some others would like to reuse the xattr
> syscalls.  No agreement seems to have been reached.
>
> Also I think a notification system for mount related events is also a
> much needed component.   I've tried to explore using the fsnotify
> framework for this, but the code is pretty convoluted and I couldn't
> get prototype working.
>

Hi Miklos,

You indicated that you would like to discuss the topic of
"mount info/mount notification" in LSF/MM, so I am resurrecting
this thread [1] from last year's topic.

Would you be interested to lead a session this year?
So far, it felt like the topic was in a bit of a stalemate.

Do you have a concrete suggestion of how to escape this stalemate?
I think it is better that we start discussing it a head of LSF/MM if we hop=
e
to reach consensus in LSF/MM, so that people will have a chance to
get re-familiar with the problems and proposed solutions.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/YnEeuw6fd1A8usjj@miu.piliscsaba.r=
edhat.com/
