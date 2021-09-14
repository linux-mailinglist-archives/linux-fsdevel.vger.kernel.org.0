Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6F40B264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhINPCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 11:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234038AbhINPCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631631674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=Y53JofNK1EGyD5cIt2cehClYrsSMeKGmy2ehe6TD7dqeKQjE+D1fnIL0B91N4EXaT5Bd6/
        pG35x6FcVw3EruoKY/dOUF9mgy678L6eHt2qWN/Q8oA61Xx5MQfTIpkQOIb+tcx5Ir7geb
        gyNjJzW+T0A6Dm9LOMg0TASx9/1Trb0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-UjLTJfXZN_WAEhua7141aA-1; Tue, 14 Sep 2021 11:01:12 -0400
X-MC-Unique: UjLTJfXZN_WAEhua7141aA-1
Received: by mail-io1-f72.google.com with SMTP id e2-20020a056602044200b005c23c701e26so16426392iov.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 08:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=nKXmDVyQY1p82F6MlsJ3qRMoO9O1/RQjKDiaDt3P7zl3Ic8KeUY5iQtv2UhpAQ5PaR
         uP7yuwHTlSX4YaOmEjJE2mnRJUrlWDApi3jWrT+i/mV201CnnuK3Yl7vt2ayyj7qAhsa
         3fLkF8YtclCvB2uJ/hW2c3IYWu0I+7xUXlc1VNuoe+2jq9oVjLRi1o+0quJsKyrF4vP3
         DMlixQGfpp/EvQfplWAiEJyBw7g7KXFOtrtokS8ZqpfjTYghFmlMz8XrSZtRdrfqLXgl
         S27MWmom6STPWTE7ZZ+VAamYjs9md4bZ+BW9qrbSsWY24/zJdMzowBmFVGbTaLkb4gHV
         g1YA==
X-Gm-Message-State: AOAM531vgW6hPicD48BlQIdfuzuKafg/HY4mOoxUV30zNP7NexyNxFsX
        n6O8lb+IPpHZ05mhPD5UE5zdZTDZDdHcpgFlG5IKr9xhcoWoJtxIT/O65r5c0fwH+GRq8i2BK//
        1sP3zajzb7muqp0I3YzhlmpI/6MoYPh6wRDizJACfZA==
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302573ili.29.1631631671750;
        Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaAeiekMMKeZruAEeYbCxZpJjpmCzKAy5WCzmfRtD8PhxXBHVBLZZb+MFaozIMIyxqQwE9MVbD21EwvnT+xp8=
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302560ili.29.1631631671531;
 Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
 <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com> <YUCybaYK/0RLvY9J@redhat.com>
In-Reply-To: <YUCybaYK/0RLvY9J@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 11:01:00 -0400
Message-ID: <CAPL3RVGXWtakCS9bvE60gWp0tcsduJFKfoU4aoqANRgp7HvFow@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 10:32 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> open_by_handle_at() requires CAP_DAC_READ_SEARCH.

Or some sort of access to the network.  If you can send rpc requests
to the nfs server that appear to be from someone with access to the
export, you can guess filehandles that allow access to objects under
that directory.  You'll need access to particular objects, but you
won't need read or lookup access to the directory.

You can prevent that if you set things up right, but these
filehandle-issues are poorly understood, and people often forget to
take them into account.

--b.

> And if you have
> CAP_DAC_READ_SEARCH, you don't need to even guess file handles. You
> should be able to read/search through all directories, IIUC.
>
> So how does one make sure that shared directory on host is not
> accessible to unprivileged entities. If making directory accessible
> to root only is weaker security, what are the options for stronger
> security.

