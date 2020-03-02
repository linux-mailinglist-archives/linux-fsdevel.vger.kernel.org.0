Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA48175CFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCBO1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 09:27:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbgCBO1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583159235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+UBgX7eoIkK/t5w+2bDxE2KMKopb4wrJcspZOaATZ0=;
        b=gLPXoq9j2Ddth4kHHrUT+yoZNC2EXO9wBYs6XFF8OQArxN/86xpB4CKJ5YbCz6ejtWdPa/
        DXjN/PQa8gpJeDBB9OHwSFs9SooRKubU5mzXcKD1OO2K3yuzYAlTnkNWF+RatzxTGE4W2Z
        5zS63FHAcukjpyqHZaWHOkTZ57mDzPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-_RitG97wNkGAfE8aopeJaA-1; Mon, 02 Mar 2020 09:27:12 -0500
X-MC-Unique: _RitG97wNkGAfE8aopeJaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDC02107ACCC;
        Mon,  2 Mar 2020 14:27:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D890C5D9C9;
        Mon,  2 Mar 2020 14:27:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200302115239.pcxvej3szmricxzu@wittgenstein>
References: <20200302115239.pcxvej3szmricxzu@wittgenstein> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, Florian Weimer <fweimer@redhat.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <848281.1583159228.1@warthog.procyon.org.uk>
Date:   Mon, 02 Mar 2020 14:27:08 +0000
Message-ID: <848282.1583159228@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> > AT_SYMLINK_NOFOLLOW only applies to the last pathname component anyway,
> > so it's relatively little protection.
> 
> So this is partially why I think it's at least worth considerings: the
> new RESOLVE_NO_SYMLINKS flag does block all symlink resolution, not just
> for the last component in contrast to AT_SYMLINK_NOFOLLOW. This is
> 278121417a72d87fb29dd8c48801f80821e8f75a

That sounds like a potentially significant UAPI change.  What will that break?

David

