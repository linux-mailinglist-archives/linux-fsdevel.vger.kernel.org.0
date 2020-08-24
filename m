Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3046924FB0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHXKIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 06:08:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726356AbgHXKIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598263710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niBQvcJM3tboigqGIQvzntcj0FQMHRCY5rtN6djQmRo=;
        b=gZLYfwEWpVEAQ3mwWhfRXqx/tWFIy0oz9g6lvjMyQoR1PmxsuYaxw7z2I9HMMI0+cWmuZG
        /wHUAmcqzDv2QiWKMaSrAUGWcUz8vA/Ne8xmRq5nusLJ2nM38kwt8nBTlzmA0V7MfH7Lq+
        z+PliDNMDo4DKWCZxGROqhVUqyvp1Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-OFTgyMFtMyaGYi25_niVHg-1; Mon, 24 Aug 2020 06:08:26 -0400
X-MC-Unique: OFTgyMFtMyaGYi25_niVHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDE5DAEF60;
        Mon, 24 Aug 2020 10:08:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 420BA7C84C;
        Mon, 24 Aug 2020 10:08:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAKgNAkjHcxYpzVohhJnxcHXO4s-4Ti_pNsmTZrD-CMu-EUCOoA@mail.gmail.com>
References: <CAKgNAkjHcxYpzVohhJnxcHXO4s-4Ti_pNsmTZrD-CMu-EUCOoA@mail.gmail.com> <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk> <159680894741.29015.5588747939240667925.stgit@warthog.procyon.org.uk>
To:     mtk.manpages@gmail.com
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/5] Add manpages for move_mount(2) and open_tree(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <287643.1598263702.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 24 Aug 2020 11:08:22 +0100
Message-ID: <287644.1598263702@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> > +To access the source mount object or the destination mountpoint, no
> > +permissions are required on the object itself, but if either pathname=
 is
> > +supplied, execute (search) permission is required on all of the direc=
tories
> > +specified in
> > +.IR from_pathname " or " to_pathname .
> > +.PP
> > +The caller does, however, require the appropriate capabilities or per=
mission
> > +to effect a mount.
> =

> Maybe better: s/effect/create/

The mount has already been created.  We're moving/attaching it.  Maybe:

	The caller does, however, require the appropriate privilege (Linux:
	the CAP_SYS_ADMIN capability) to move or attach mounts.

David

