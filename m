Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E826F176021
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBQhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 11:37:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbgCBQhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583167074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fC95qP5SJj04fpXo5+HmQBZoe9M23e68wzRbVjI+h48=;
        b=fujqORQa8lYmCZW0y9DBwwkGh3gaLkaEvE1+FMXDSTVut+2vf2DcDt5Dm5Xej/zneobcum
        wxy08Ln2KYYbSpau45AIgTP3Vao0uuO6vhKUQxZtpsGHaDOuYbi3FDkKa5NcwMpy7gJgnW
        00LHPQeMQTyPgQSMcS1te04LegZwIZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-nBzKOs3jP-GRZrHcsh7How-1; Mon, 02 Mar 2020 11:37:50 -0500
X-MC-Unique: nBzKOs3jP-GRZrHcsh7How-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE814101044E;
        Mon,  2 Mar 2020 16:37:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA6B60CD3;
        Mon,  2 Mar 2020 16:37:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200302152458.hznqqssixhlpykgr@yavin>
References: <20200302152458.hznqqssixhlpykgr@yavin> <20200302143546.srzk3rnh4o6s76a7@wittgenstein> <20200302115239.pcxvej3szmricxzu@wittgenstein> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <848282.1583159228@warthog.procyon.org.uk> <888183.1583160603@warthog.procyon.org.uk> <20200302150528.okjdx2mkluicje4w@wittgenstein>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <932112.1583167065.1@warthog.procyon.org.uk>
Date:   Mon, 02 Mar 2020 16:37:45 +0000
Message-ID: <932113.1583167065@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> wrote:

> Now let's just hope no new syscalls need both AT_RECURSIVE and
> RESOLVE_NO_SYMLINKS

Ummm...  AT_RECURSIVE is used by open_tree() to determine whether to copy just
the mount it's looking at or the entire subtree from that point.

David

