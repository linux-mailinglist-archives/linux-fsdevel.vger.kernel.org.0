Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A884172B3AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFKTZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFKTZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:25:37 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94010A;
        Sun, 11 Jun 2023 12:25:36 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-463d48183ddso682003e0c.3;
        Sun, 11 Jun 2023 12:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686511536; x=1689103536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZJBHMKgeEhYDJZsY3bPyitNVxAFsHYE1LxNw+0VaUk=;
        b=A7qYKVcG4NbhydB8dwtW9oWe+SRZsLJdtBw32WeD7ZKHRKb/J/b8SET1obwhlau1JV
         N/paoy6zKnoEMYBwKZ09ab1ItH9DK0ku5lhPM/U+MBv3OBUCG9hJSHb9KVNj5DVS4fog
         I63vlv2zIHW0KmhbG/tOm9UM2OZzj1visu2yiz3yFu84xz9YvQ2lNOeFoHAJg9olcire
         ApqVpc5jsqdFjH9DC7oHbveHG3VNhEJ97UMlISpxB3q4tLdcIsK7wiMhy5z9FMuhI7PU
         HBnQ9MNHvQQT9W7IerbMOT1SfXtSI/AWjJYlau9qtnAd5DoXJyb06Yl43bDei5qQAouy
         THpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686511536; x=1689103536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZJBHMKgeEhYDJZsY3bPyitNVxAFsHYE1LxNw+0VaUk=;
        b=KI6MHJEmng0R4/dY3XxniJqV8q2VrVUHLu9aelefFuQKTJjaPxnXsdyC/XzTVR/Ktg
         HRFX4EtIjvE05uQLVLRt7d3XZL+ojjCaZ4r9ximAfmyrqKM9jhbyLWlnXgza885vlCSV
         Twi9fnekD1iodUnbSeYmxs/PP6wl3C+75cXG0bX0+NsInKsm2/r7Fs9dLydN5mSzEHRF
         5UsnxMTqEhWn2n8EvtBIDUQIFR2SjbpgP9BaMlPOpcjxsPZ5dNVGwAuIpn3QnjCH+iuN
         BfJvJDWxmxcTKpuVm9SCkpEoOIEkUxpHvPO8q1iVLFWckzQrDbKB4PKhAYPrm+jauKuM
         49HA==
X-Gm-Message-State: AC+VfDzP52VvCHRf/LwiFDyodosrpMwuJKJXOZnI2uZEhUzJlvH6k5bu
        ULjipQcJokX/42k70QUzaIMlOkOIjmxKhfoaRtU=
X-Google-Smtp-Source: ACHHUZ6rI8f4OBuADFVpb5MXfNugKY609GYCf5u+5gjDGoPh/JuInA1rP1Agx/CMLIK7vxN6Y5RuQ/j53VQTRoFSecY=
X-Received: by 2002:a1f:bf94:0:b0:465:d885:2040 with SMTP id
 p142-20020a1fbf94000000b00465d8852040mr2300004vkf.2.1686511535974; Sun, 11
 Jun 2023 12:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
 <CAOQ4uxgA9=-gTngiiFjBc5E1M==qP4T0aeiD5608nJxhQuqp+Q@mail.gmail.com>
 <CAOQ4uxiDL+u3SS-=HsNaHwPLz2CAV=8oDCED5RtzPhmFwQmkZw@mail.gmail.com> <CAJfpegu2CAvrqGfACuc+ux4430wwDrSeuXPEeUy0FE=fDrW6FA@mail.gmail.com>
In-Reply-To: <CAJfpegu2CAvrqGfACuc+ux4430wwDrSeuXPEeUy0FE=fDrW6FA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Jun 2023 22:25:25 +0300
Message-ID: <CAOQ4uxiX3joJ7P1wJZMmLb6jsmzhAeLDXD0aZzf5-5Brop1C3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Sun, Jun 11, 2023 at 10:12=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Sun, 11 Jun 2023 at 19:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Is it because getting f_real_path() and file_dentry() via d_real()
> > is more expensive?
> > and caching this information in file_fake container would be
> > more efficient?
> >
> > I will restore the file_fake container and post v3.
>
> I simply dislike the fact that ->d_real() is getting more complex.
> I'd prefer d_real to die, which is unfortunately not so easy, as
> you've explained.
>
> But if we can make it somewhat less complex (remove the inode
> parameter) instead of more complex (add a vfsmount * parameter) then
> that's already a big win in my eyes.
>

OK, I can relate to that.

Here is file_fake restored, now with fsnotify fix also tested:

https://github.com/amir73il/linux/commits/ovl_fake_path

IIUC, you would now want to change file_dentry(f) to using
f_real_file(f)->dentry and get rid of the inode argument to d_real().

Do you want that change also in v3 or should we save some fun for later
and just fix fsnotify for now?

Thanks,
Amir.
