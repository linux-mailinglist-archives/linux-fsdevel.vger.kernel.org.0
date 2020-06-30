Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5F20EEF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 09:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgF3HFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 03:05:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730386AbgF3HFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593500707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8NTchzE1eUj7ZN1L/9CKJjVnTES6K0rTu7Zt52Chgwg=;
        b=auoUCscMH77U0YrOgCHwec8s3uqE+EAcQce83uvDNTZwMnJDIj1H15Rsw9E6Q747aNFylX
        UshIRUTGyw6JrXpVZ5wT/wV0rQOA3j9ycQVAygSC3SfpGWzTHBVDI9EI/MZBLHb2q3PGhT
        ZE38EBoCmxsEUQs9WdIUCkQgnzeHngc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-98FthR-1NB2z1c-3uEPPyQ-1; Tue, 30 Jun 2020 03:05:03 -0400
X-MC-Unique: 98FthR-1NB2z1c-3uEPPyQ-1
Received: by mail-qv1-f71.google.com with SMTP id g17so11574333qvw.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NTchzE1eUj7ZN1L/9CKJjVnTES6K0rTu7Zt52Chgwg=;
        b=fU67VgHr2/SLKnjsSeBiAlJ7uPAKlZQ+ot/IBec5jda/smPZIpZEQyuOUui/WJ/ZHw
         6a5dft/aXap69zNF4wgG+hv7n/V7TEF5tLcNlKneeDbbjGzXyLvzlvhQKIeCc2DYZBSv
         l8zv0gkyFIEo5zQfQHwjBaMDGLXBO3c0kTWas+JKFqbPyQ8LvQZTyruWkLHhM7xfws7i
         3aBP621e9wxITS814KejJlSoaqt9HAShw7+D/JvcmrKSvOr1zufcbE97C32Biwru46Ng
         y3nKaudsLTeVxfcOdixu4jjN8r2vGNhC55xDb0t0BlShhvjqyycFkhW2IwEg4i5QA0Zr
         QhpQ==
X-Gm-Message-State: AOAM532dP1iCLBdf0TbQLS4NzJGaLy+WGJY2sZ7ujoseV5hvGDA3B3Xz
        cIkfehx2cG2wN/mVA8nglAVuDF9yWsAnybsWpp1B7/EXRbPbMYKy/yxEDNi7e0cq/VvP0ZXZ0cD
        J6LWeZkKKYNqdZF1eS41zNUUqNvxDr3oSgqSUn7tRRQ==
X-Received: by 2002:a37:a6ce:: with SMTP id p197mr18185580qke.211.1593500703001;
        Tue, 30 Jun 2020 00:05:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6xxd6hymdR27bStUeOqF6w+NbR6jL/SFpPCdXe7+C9PbcguQJG+UcKKi2n7bcmmdfLYg3qZC7T7/O0zfJDFI=
X-Received: by 2002:a37:a6ce:: with SMTP id p197mr18185559qke.211.1593500702729;
 Tue, 30 Jun 2020 00:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk> <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
 <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag> <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
 <bffa6591-6698-748d-ba26-a98142b03ae8@profihost.ag> <CAJfpegur2+5b0ecSx7YZcY-FB_VYrK=5BMY=g96w+uf3eLDcCw@mail.gmail.com>
 <1492c31e-9b0c-64b5-8dd9-d9c0b4372f29@profihost.ag> <CAOssrKdX5X7WB_tt43h_Pb7nc=3Vb+WyG_kttNd16pxtS4Z0_g@mail.gmail.com>
In-Reply-To: <CAOssrKdX5X7WB_tt43h_Pb7nc=3Vb+WyG_kttNd16pxtS4Z0_g@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 30 Jun 2020 09:04:51 +0200
Message-ID: <CAOssrKcHQXbPUjec4x5zu4jWxXbx6u1Oe3APF1Wmx_2Y9XA9GQ@mail.gmail.com>
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Back on-list]

On Mon, Jun 29, 2020 at 8:19 PM Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
> Hi,
>
> here we go (Off list):
>
> 4.19 kernel:
> # timeout 20 strace -ff -s1024 -- ceph-fuse -f /var/log/pve/tasks -o
> noatime,nonempty
>
> Output: see attached file
>
>
> 5.4.47 kernel:
> # timeout 20 strace -ff -s1024 -- ceph-fuse -f /var/log/pve/tasks -o
> noatime,nonempty
>
> Output: see attached file
>

Thanks.  This is the relevant line:

[pid  6448] mount("ceph-fuse", "/var/log/pve/tasks", 0x557e68f75cb0,
MS_MGC_VAL|MS_REMOUNT|MS_NOATIME, "nonempty") = 0

It's "mount -o remount -o unknownoption" that is broken.   Fix is a
little complex, because we want the old behavior on the old mount(2)
api, but the new behavior on the fsconfig(2) api.  Will post a patch
tomorrow.

Thanks,
Miklos

