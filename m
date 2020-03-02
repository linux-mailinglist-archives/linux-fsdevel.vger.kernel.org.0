Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3910175D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 15:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCBOad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 09:30:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727085AbgCBOac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583159429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4g9ejPyZjnXkSrIMqykLr/Nbkbvn0R1XhqNJLqCOnUc=;
        b=IoGZev10+uCW1Z5PGWYu/B/1XDn8WSHWGb0sKF/UjR4cmYrPlIZ8WoMxLmMYBwlCjaEqwW
        w5ERLVYjOjOotuoQa0JJ096VuM2WQeDxqRYAuXRF08sLELxyuGBMFJwk9/vK1zSd2QhRJ6
        TcsdiXAgOax8j6AqarcDSikaLwyy+IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-gXhPO-zzMAOf_Chrw4ZSrA-1; Mon, 02 Mar 2020 09:30:28 -0500
X-MC-Unique: gXhPO-zzMAOf_Chrw4ZSrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45349DB61;
        Mon,  2 Mar 2020 14:30:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A95160BF7;
        Mon,  2 Mar 2020 14:30:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
References: <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <859018.1583159423.1@warthog.procyon.org.uk>
Date:   Mon, 02 Mar 2020 14:30:23 +0000
Message-ID: <859019.1583159423@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:

> Regarding open flags, I think the key point for future APIs is to avoid
> using the set of flags for both control of the operation itself
> (O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
> resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that would
> help code that has to re-create an equivalent descriptor.  The operation
> flags are largely irrelevant to that if you can get the descriptor by
> other means.

It would also be nice to sort out the problem with O_CLOEXEC.  That can have a
different value, depending on the arch - so it excludes at least three bits
from the O_* flag set.

David

