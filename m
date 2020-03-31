Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9750F19A156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgCaVyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:54:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731250AbgCaVyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585691675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4Y5CiKm/LKKyC2EdDN4EKODm6x124ZxcM4b75twPGg=;
        b=Ds3AXDzlDLajd+O9uuYBYijFAC10AiJGI/+KDm+SC8y/CNK10SjwbtdFyY5W4FrsSn5xBy
        aQ2HhIHV2W4FykbT0o+ATqJP1/uwpi1kKzGvtrwOQU6TYm/43snTzZH34s3i8TBYMgAoQ0
        zgp/ZPSe/bwlsqURu5cFfFTMPHFVcHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-vUNL5qBdMzO7pWaCUUVbEQ-1; Tue, 31 Mar 2020 17:54:29 -0400
X-MC-Unique: vUNL5qBdMzO7pWaCUUVbEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079FE800D5B;
        Tue, 31 Mar 2020 21:54:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DDD796B95;
        Tue, 31 Mar 2020 21:54:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200331083430.kserp35qabnxvths@ws.net.home>
References: <20200331083430.kserp35qabnxvths@ws.net.home> <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2418415.1585691663.1@warthog.procyon.org.uk>
Date:   Tue, 31 Mar 2020 22:54:23 +0100
Message-ID: <2418416.1585691663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Karel Zak <kzak@redhat.com> wrote:

> - improve fsinfo() to provide set (list) of the attributes by one call

That would be my preferred way.  I wouldn't want to let the user pin copies of
state, and I wouldn't want to make open(O_PATH) do it automatically.

David

