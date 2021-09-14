Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8D40B013
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhINOBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233309AbhINOA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631627981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaya3EDVq+i2kEee2RcyRm9vp7G1d6PEMiE8V6O0cGg=;
        b=Bzto1HZ1ddl/YTVictY57RlHvlE0bWuoaC3l4Fc8tY+vz9m8X6YdgUjn1O2PojVfMjkM+L
        ExSry0SE189T74/pXv8jpxDN5wG4210orXlc5Mdl8WcEnVtU7qkiqP7p3JNMAVBhxHa8Uv
        yqVK/ZkGfqjSBvU4M47k7DOiZdXaNqA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-g12S_92QPNC3hVVskjkGPg-1; Tue, 14 Sep 2021 09:59:31 -0400
X-MC-Unique: g12S_92QPNC3hVVskjkGPg-1
Received: by mail-io1-f71.google.com with SMTP id b202-20020a6bb2d3000000b005b7fb465c4aso16319773iof.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 06:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaya3EDVq+i2kEee2RcyRm9vp7G1d6PEMiE8V6O0cGg=;
        b=HlIx7gFHp7X2G4bT8AKCO220t82oWXSaRJh07Sj2qG7SHOZHzmdmQur4uy50lp6+Q2
         KF7QXdl/fFtHxg7c8U3xzCD6yYN9xLJ8x0cw/Q4aaZYS8fZ7rlTfql0SO6GykR21rjEQ
         0pJlRnA5ai2USKe50LkTf/3SB03xmkVnl0zj6FGVRKWNDussXOxkEeI6+f3ZQ8iJONNT
         +0YPlgPdua8sMpBk4gI2WA2Ei/7vE0Ai7wuUdTxAIo+GI57eHtLC4JwwzzdTUxZzXfNo
         CiiNW9vc3gQ8txG/eszAor8r4UDFYPJvc88p+Cqs17hmzqqlkTjdbbMlLf9v7z8opnxi
         jubw==
X-Gm-Message-State: AOAM532PqJbV48pixPvURdGWsJJ3PuUzkK81iV+BUADl3KcdkVGnwGai
        +sQqqpfDaGnDrBvC1HX8htgqfXyutirrYP+upFXB7AJ4c3x2AnEYTgmx9IkU1HLZDXsbMDT7x9W
        lRG8fZfMNGbi62sheo82Yf5DOnT6mZSap3M9D5d4zLA==
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr14896501jas.25.1631627970921;
        Tue, 14 Sep 2021 06:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyykZ0VYVJ0bOaRFeN+fD5tTcAMHGgErQub0XJv3DCUagog8L0n472IWYdPHqWMZTwm1ZepJvhHcI2h2Lqcvw4=
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr14896484jas.25.1631627970753;
 Tue, 14 Sep 2021 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
In-Reply-To: <YUCa6pWpr5cjCNrU@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 09:59:19 -0400
Message-ID: <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:52 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> Same is the requirement for regular containers and that's why
> podman (and possibly other container managers), make top level
> storage directory only readable and searchable by root, so that
> unpriveleged entities on host can not access container root filesystem
> data.

Note--if that directory is on NFS, making it readable and searchable
by root is very weak protection, since it's often possible for an
attacker to guess filehandles and access objects without the need for
directory lookups.

--b.

