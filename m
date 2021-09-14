Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6A40B0AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhINOdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233780AbhINOdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631629937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kfXYUmJTGW/jK+1WjU3DFfoUA/V3RTprHGsP9ym3psc=;
        b=gpY3bJC28Gl43L09hhG7NKDLDKMA4BtxFloHXoWH4x/wSffw+sf3uJElQAN/BQWXUak/MU
        xKqkMyjf+CgUs2RpxeciEy6Fu5qT+1EedFGJBduoPml5ZfXYTX3dVXzw6sI8JGXToegSXP
        V6D9OaJux6uChstAWERmeZRnhQZ4+7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-EUqDmxvLNaC-bY9gFNnT9w-1; Tue, 14 Sep 2021 10:32:16 -0400
X-MC-Unique: EUqDmxvLNaC-bY9gFNnT9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D96E10144E3;
        Tue, 14 Sep 2021 14:32:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B62955D6A8;
        Tue, 14 Sep 2021 14:32:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 380F5220779; Tue, 14 Sep 2021 10:32:13 -0400 (EDT)
Date:   Tue, 14 Sep 2021 10:32:13 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YUCybaYK/0RLvY9J@redhat.com>
References: <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com>
 <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
 <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com>
 <YUCa6pWpr5cjCNrU@redhat.com>
 <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 09:59:19AM -0400, Bruce Fields wrote:
> On Tue, Sep 14, 2021 at 8:52 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > Same is the requirement for regular containers and that's why
> > podman (and possibly other container managers), make top level
> > storage directory only readable and searchable by root, so that
> > unpriveleged entities on host can not access container root filesystem
> > data.
> 
> Note--if that directory is on NFS, making it readable and searchable
> by root is very weak protection, since it's often possible for an
> attacker to guess filehandles and access objects without the need for
> directory lookups.

open_by_handle_at() requires CAP_DAC_READ_SEARCH. And if you have
CAP_DAC_READ_SEARCH, you don't need to even guess file handles. You
should be able to read/search through all directories, IIUC.

So how does one make sure that shared directory on host is not
accessible to unprivileged entities. If making directory accessible
to root only is weaker security, what are the options for stronger
security.

Vivek

