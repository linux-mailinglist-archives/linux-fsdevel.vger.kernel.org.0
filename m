Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE484C5526
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiBZKXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 05:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZKXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:23:15 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A54210450;
        Sat, 26 Feb 2022 02:22:41 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id t11so9376210ioi.7;
        Sat, 26 Feb 2022 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jsdZ9DhlS+cuBn5e0nl64bHzF3fsXAHgkXh5/R5ncc=;
        b=Pk/5G1ltlqkex9Y+38e0ALpLwIfmXwSdGhfyk3KPmYg7jA8caCJ5ptjHVJ8qkrApBN
         PNsT6YFchzjpfgqUDntNayFb7qHshC7M4cynt2wDG3w+qRcIzmjT4A123luLgdFYZZyS
         cfl3zIwmajvZby33ZoWHTOS7wjzJuwU9rc/p/psW6U9qElutFiMDXtaStoHn4VAIWJxw
         ccZNKUp3cfUMQjAfMaTlYk9sZSlPgpRDqIFTEPIHlUdaY8Vc4uecClBtQmeTHpV2GhcN
         qk3uBpZ7ZrG11i2NUPBf1rSerH/IpgTqx7BhceHzb94piiA5AWXht/y/hOcWWVVaBLUr
         VF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jsdZ9DhlS+cuBn5e0nl64bHzF3fsXAHgkXh5/R5ncc=;
        b=smss3/zdVsBBpcb/6UipHbZ7LvuK7YUcX6FGSw0F0XgP8D8Ac3Oju4qGox1aSSIpYo
         vaJINX4v2cRXeoixg088luVXGYT/rz28PqO9p/2kc8TbOnvNZKH6Oh8PHN+p1Poxqdfd
         sMLq5xs2VwpfGTSi8M2oJ4mmxhBJPcNlERPEA2XaC1O2Uowr9YscNkB1ejfyXEKjyaoS
         /1m08TwpFIZ1mMhnam+xYOVVZxx2iJGN4nqUJkUQVVm2y3dYoDKqyAfiGOWCnVJYtFsv
         IXKGKGrX4a7BsIh4Rx4lbB+Xix2m+Zo56honvcM3IfW/ZzHASJa+20aaEcvfCSrOUFvm
         xKHA==
X-Gm-Message-State: AOAM532P8eA1jr/oQhsG0QKoNq+Lf81a/tAdgDLR9UysESV44AkQ8Lqu
        aCUZYzlXH5pnkN0dXcNpem64Uck8c+SdTkm9pGQ=
X-Google-Smtp-Source: ABdhPJwz8AsXgVV4L2PxrAIHcbkuaegZX2IWrny5SGALDuwN9dFZuBKCYJAaU1OIMy4FNI+KTaHOiybD2TFeolYhkIo=
X-Received: by 2002:a05:6638:4905:b0:317:1dda:b116 with SMTP id
 cx5-20020a056638490500b003171ddab116mr985704jab.188.1645870961399; Sat, 26
 Feb 2022 02:22:41 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com> <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com> <YhjeX0HvXbED65IM@casper.infradead.org>
 <CAH2r5mt9EtTEJCKsHkvRctfhMv7LnT6XT_JEvAb7ji6-oYnTPg@mail.gmail.com>
 <YhkFZE8wUWhycwX2@redhat.com> <CAH2r5msPz1JZK4OWX_=+2HTzKTZE07ACxbEv3xM-1T0HTnVWMw@mail.gmail.com>
In-Reply-To: <CAH2r5msPz1JZK4OWX_=+2HTzKTZE07ACxbEv3xM-1T0HTnVWMw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 26 Feb 2022 12:22:26 +0200
Message-ID: <CAOQ4uxi+VJG56TPvcpOqoVAGgbb8gZQJEfvhXyGyB5VboRE2wA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Enabling change notification for
 network and cluster fs
To:     Steve French <smfrench@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 8:11 PM Steve French <smfrench@gmail.com> wrote:
>
> > IOW, in general disable all local events and let filesystems decide which
> local events to generate? And locally cached write is one such example?
>
> The fs doesn't see cached writes so probably best to still use the common
> existing code for notification on local writes
>

I guess SMB protocol does not allow client B to request a NOTIFY on change
when client A has a directory lease, because requesting NOTIFY requires
getting a read file handle on the dir?

Effectively, smb client needs to open the remote directory for read in order
to prove that the client has read access to the directory, which is the
prerequisite for getting directory change notifications.

The local check for permissions is not enough for remote notifications:
        /* you can only watch an inode if you have read permissions on it */
        error = path_permission(path, MAY_READ);

Thanks,
Amir.
