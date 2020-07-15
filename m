Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F330220677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgGOHsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOHsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:48:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17850C061755;
        Wed, 15 Jul 2020 00:48:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v8so1288264iox.2;
        Wed, 15 Jul 2020 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Jccfp2oNJt1HrsGzFk4h4PJ44TgtIZuDADLeh+4YZok=;
        b=H1U4R4r2h/fLl4slZLL1wyxioF29o00xgKLg5uTsiYPuFw1cWu8p42i3K9FPYcVz42
         aAD6GY+xSmzxd/y2kWVO5Inv1n71to6wLo5CeARmRjwvjhrHgWEd90AAlkWOxzqvs8cb
         3Vf9UYsSwgb29uW7EQ+7Y2Mn/fZZ/Zlu8HV824MMuEl/7FLSWbF/dlisuNikQ1gXOJ8l
         QAkTnO5YHHAuLyfiSfu/Hubalev5H8o1x9OazVL27m66a2Hoj/Xvtl7nwrsy1MpqNjQJ
         AjNHvDWnXKvK9v45NofwwYZpHJOzkECHM5ppydCFl60D1ZzgSL8wzORrsL5ZyI5iM6Si
         nNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Jccfp2oNJt1HrsGzFk4h4PJ44TgtIZuDADLeh+4YZok=;
        b=h/qskm4oxqdlhhVrbY2Ytzc7Qu0ShbptJ94EvFBDzFcjJjmjW4YrXbZRx2fBgXJr3+
         cGV9zM4u/UweJq3t8mlVUwgpO+gJc4wazFEzDGSkfeEKJvM1n4jA9n8aIjZTysQ4wYXn
         P9khGRybwCEjr3cIV8JAeirCJzJHP/2E+rKHEa44QFRCRwaE89SzsTSdrvNgqb+DSPSF
         WmQVNy5wPuXz1bHXlWHdWU8F3rkguANqzABAjW8ejB5DgxVzgUlE9+uelo6K/YqTE7L+
         B5hb91gifVBp0SbeBz5/uoezZEepnfd8GvaCE/4E0XeAo0cPIbF98mhVUZW0S5dVYxnc
         fbnw==
X-Gm-Message-State: AOAM532qYSoh0VrhtB2MT9hNgVfDdwlnqtLA92psm2ziL6mMM+AYxPgd
        ECa0xNumFigBFB6LA8FQV9RPFAQIqARzMkG4Rb8=
X-Google-Smtp-Source: ABdhPJwrtnQrYazl29CU7+zmtfNBiLquKPbrXzX5QLJgrUgSoItWQhTZNPgWQERFAAgv0BIXlILa5DrOI+5+6g1IIW0=
X-Received: by 2002:a5e:c91a:: with SMTP id z26mr671341iol.70.1594799292282;
 Wed, 15 Jul 2020 00:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com> <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com> <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
 <CA+icZUXtYt6LtaB4Fc3UWS0iCOZPV1ExaZgc-1-cD6TBw29Q8A@mail.gmail.com>
 <CAJfpegs+hN2G02qigUyQMp=0Ev+t_vYHmK5kh3z+U1GkSuLH-w@mail.gmail.com> <CA+icZUWSeUJwtymRL2MXXCRy3SyhQ9LraQAzUwCB2my09BWRcA@mail.gmail.com>
In-Reply-To: <CA+icZUWSeUJwtymRL2MXXCRy3SyhQ9LraQAzUwCB2my09BWRcA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 09:48:00 +0200
Message-ID: <CA+icZUX7xRy+duwQpR_8R_tJi7ru-si5_HZ_9rrdJFTJs73KXA@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:57 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Jul 14, 2020 at 2:53 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, Jul 14, 2020 at 2:40 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > > Did you sent out a new version of your patch?
> > > If yes, where can I get it from?
> >
> > Just pushed a bunch of fixes including this one to
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
> >
>
> Just-In-Time... I stopped my kernel-build and applied from <fuse.git#for-next>.
>
> Thanks.
>

Tested with my usual testcase "mount Ubuntu/precise 12.04 LTS
(WUBI-installation):

fdisk -l /dev/sdb

mount -r -t auto /dev/sdb2 /mnt/win7

cd /path/to/disks/
mount -r -t ext4 -o loop ./root.disk /mnt/ubuntu

df -hT

cd /mnt/ubuntu/
ls -alhR

dmesg -T | tail

Looks good.

- Sedat -
