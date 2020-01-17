Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4935140931
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgAQLnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:43:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbgAQLnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579261385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd8m04MBeBFjlqqhoY1pGB2lRynPKyQkVinKGfYGuLE=;
        b=Ro6qziJXNxPLuSws0aZLi8pWmdSQq1iuWy+uronljlXTvn3fo7wTUDUR+PYZPLfFypfLKf
        jLYxbuEUdcdceW1ZtOhmVk/gBADym01GMgtreDsji9kCibUiWzuMml812mvP1t4do1PZYJ
        dRWKE1C60cm6xGWQAlFSaEVOOrsVx0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-3ZtNOC-EPnyeBRrPstvaeQ-1; Fri, 17 Jan 2020 06:43:02 -0500
X-MC-Unique: 3ZtNOC-EPnyeBRrPstvaeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90542108597A;
        Fri, 17 Jan 2020 11:42:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F88910013A1;
        Fri, 17 Jan 2020 11:42:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com>
References: <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com> <20200114170250.GA8904@ZenIV.linux.org.uk> <3326.1579019665@warthog.procyon.org.uk> <9351.1579025170@warthog.procyon.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dhowells@redhat.com, "Colin Walters" <walters@verbum.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        "Christoph Hellwig" <hch@lst.de>, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Chris Mason" <clm@fb.com>, josef@toxicpanda.com, dsterba@suse.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <359590.1579261375.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Jan 2020 11:42:55 +0000
Message-ID: <359591.1579261375@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Omar,

Do you still have your AT_REPLACE patches?  You said that you'd post a v4
series, though I don't see it.  I could make use of such a feature in
cachefiles inside the kernel.  For my original question, see:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

And do you have ext4 support for it?

Colin Walters <walters@verbum.org> wrote:

> On Tue, Jan 14, 2020, at 1:06 PM, David Howells wrote:
> =

> > Yes, I suggested AT_LINK_REPLACE as said magical flag.
> =

> This came up before right?
> =

> https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.co=
m/

David

