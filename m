Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE35B65C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 04:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIMCmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIMCmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:42:04 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70652FC4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 19:42:02 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 134so5152313vkz.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 19:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=xSq83h+oDn6GLZfLolK8+zCQq6x4Cikcqm6qM9lFCds=;
        b=bqu634K4us69ieyOqZ4p0bZpA/R9IQep3uibHolgYyNxuaqePA8BPZisTYdt7r1hLc
         V+7lg615ubMJl9e0YvflmdgbB2dis9MAuB9xt94kAWKzrV1f/de/DD4Jk/PE03MCQOi7
         CJo55SCEg8bNLTz/x+0bLbtHhsd5XpyuR+TSz0C6o4ELogAIgSWEqIObofOfd6dV+NTC
         hn3LEjs3MAGu408BXSDtiCOTk8TBdewM0vRVXSe+l5k96w83YzYocB5Ux/XNlOyXiFP+
         TIp6d6aOLLUfmk9ybNqTKWkHuQtPn6mI6lENfXvSXxlfWEWZ0ni8zNtwy3SWU801JRNg
         xlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xSq83h+oDn6GLZfLolK8+zCQq6x4Cikcqm6qM9lFCds=;
        b=4UoAFmkryYmIIJ5G6GhFUsA9HSmWrUbAI0NjsV6ne5losE8IrHYHgpMrlXjL/I5y18
         k+zz7t7xdD755qwWpnmOI8BZEfpKXaBRjNr38GFIxT4mmei0mgE2uSl1qiF0mNqjZals
         RLc2k4Na04ooXHemNbkPewXxT9opbVF7W5//COP9ffj2OpePCaoMmw0bYcu2etqrz8Nj
         +r9GQJdVXcrWi9QRGvywVmrhMpsbPAfaQkcc8bIoPBmIzgmzN5DBiuJxKq7Zu2DcCnPk
         L3hrSRU9hssR5Sdlkr87wIp71XYnjZsw7z/wO6umLycMSjanNDw7qyxtDvV5h25y6AF4
         gklQ==
X-Gm-Message-State: ACgBeo1qdfJAPt0fUW1qXKDsS56bQPm2xq+u2tx6QOSLaABlPxVT9b5J
        juyZWkvkCuPlzkL2FkwyErjknqDU3wgzQtOU+qbKA9CBJls=
X-Google-Smtp-Source: AA6agR7Qjxon/5JxgEE9Ow10Cb6DZlzgu0n61bVQZR4UGq+PwG4IRgs/aUzxgHYjSSoCaiSZsQHk2OtWpEqgVofyWcs=
X-Received: by 2002:a1f:19cf:0:b0:375:6144:dc41 with SMTP id
 198-20020a1f19cf000000b003756144dc41mr9601976vkz.3.1663036921837; Mon, 12 Sep
 2022 19:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <BY5PR07MB652953061D3A2243F66F0798A3449@BY5PR07MB6529.namprd07.prod.outlook.com>
In-Reply-To: <BY5PR07MB652953061D3A2243F66F0798A3449@BY5PR07MB6529.namprd07.prod.outlook.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 13 Sep 2022 05:41:50 +0300
Message-ID: <CAOQ4uxhZzqZgq8exYYQmTQUxXC_6K2Et19t6ksJPy8+pdw2JFQ@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     "Plaster, Robert" <rplaster@deepspacestorage.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
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

> From: Amir Goldstein <amir73il@gmail.com>
> Date: Monday, September 12, 2022 at 9:38 AM
> To: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos=
@szeredi.hu>
> Subject: Re: thoughts about fanotify and HSM
>
> On Mon, Sep 12, 2022 at 3:57 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > On Sun 11-09-22 21:12:06, Amir Goldstein wrote:
> > > I wanted to consult with you about preliminary design thoughts
> > > for implementing a hierarchical storage manager (HSM)
> > > with fanotify.
> > >
> > > I have been in contact with some developers in the past
> > > who were interested in using fanotify to implement HSM
> > > (to replace old DMAPI implementation).
> >
> > Ah, DMAPI. Shiver. Bad memories of carrying that hacky code in SUSE ker=
nels
> > ;)
> >
> > So how serious are these guys about HSM and investing into it? Because
>
> Let's put it this way.
> They had to find a replacement for DMAPI so that they could stop
> carrying DMAPI patches, so pretty serious.
> They had to do it one way or the other.
>
> They approached me around the time that FAN_MARK_FILESYSTEM
> was merged, so I explained them how to implement HSM using
> FAN_MARK_FILESYSTEM+FAN_OPEN_PERM
> Whether they ended up using it or not - I don't know.
>


On Tue, Sep 13, 2022 at 2:01 AM Plaster, Robert
<rplaster@deepspacestorage.com> wrote:
>
> Hi Amir =E2=80=93 Dan got back to me. He said (fyi - SMS referenced below=
 is our HSM app):
>

Hi Rob,

I will add that from what I read on your website [1], your entire
product is open source,
code is available on your web servers as rpms and will be put up on GitHub =
soon.
That's very good news, because it means I will be able to demo my proposed
fanotify interface improvements on your code base :)

[1] https://deepspacestorage.com/resources/#downloads

>
>
> =E2=80=9CAmir talks about specific fanotify events used for an HSM.  He s=
ays FAN_MARK_FILESYSTEM+FAN_OPEN_PERM should be enough for a basic HSM.  As=
 it is currently implemented, SMS uses FAN_MARK_ADD+FAN_OPEN_PERM to detect=
 purged files and FAN_MARK_ADD+FAN_CLOSE_WRITE events to determine when a f=
ile has been potentially modified.  There are other FANOTIFY events that wo=
uld be useful, but we're currently limited by the older Linux kernels in th=
e RHEL releases we're supporting.
>
>
>
> If I understand what Amil is proposing, it appears to be some new FANOTIF=
Y FAN_PRE_* events.  Some of it looks like something we would be interested=
 in but as long as we continue to support older RHEL kernels, we're very li=
mited to what we have to work with.=E2=80=9D
>

My goal is to design the interfaces for the use of future more
advanced HSM clients.
The experience that you can bring to the table from customers using your
current HSM client is very important for making design choices for future
HSM clients - i.e. understand and address the pain points with current
fanotify interface.

So as long as this is "something that you would be interested in" I know I =
am
in the right direction ;-)

Thanks,
Amir.
