Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234001D9D32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgESQvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 12:51:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728778AbgESQvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 12:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589907081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtRZf2ZwAvTQXfJaRpOwCoc+bkth0Vxa4PwzhJLJdWA=;
        b=gtOj1M02E5L/giHnrbXQdb5GN10vnwq2BppEQc/Y+43ed9JMFBYxm7tRIMxzxuj/LObmSf
        JllUOTV5Z+1JeWdpau+WXJPXTKmsgPINLgwYiRhlqElEznQQh8WH5d7UkH84mUwWkr6L0i
        8yviJXEwGpy43wokIPXMfT0HqDt3Rh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-AF-PsqXGOMmG-UC5yYzX3A-1; Tue, 19 May 2020 12:51:17 -0400
X-MC-Unique: AF-PsqXGOMmG-UC5yYzX3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23539100CCC0;
        Tue, 19 May 2020 16:51:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93BA110013D9;
        Tue, 19 May 2020 16:51:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <22d91c05-49ed-0c32-ba02-e2ded4947f46@infradead.org>
References: <22d91c05-49ed-0c32-ba02-e2ded4947f46@infradead.org> <20200512225400.6abf0bda@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: linux-next: Tree for May 12 (fs/namespace.c)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1596936.1589907073.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 May 2020 17:51:13 +0100
Message-ID: <1596937.1589907073@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

>   CC      fs/namespace.o
> ../fs/namespace.c: In function "fsinfo_generic_mount_topology":
> ../fs/namespace.c:4274:42: error: "struct mount" has no member named "mn=
t_topology_changes"
>   p->mnt_topology_changes =3D atomic_read(&m->mnt_topology_changes);
>                                           ^~
> =

> i.e., CONFIG_MOUNT_NOTIFICATIONS is not set/enabled.

All the accesses to struct mount::mnt_topology_changes should now be wrapp=
ed
in #ifdef CONFIG_MOUNT_NOTIFICATIONS.

David

