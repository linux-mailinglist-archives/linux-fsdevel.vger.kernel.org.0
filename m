Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F146423CC0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHEQUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 12:20:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41347 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726217AbgHEQS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOmiaPGZyWfLelA46Ml6D9sENv38lZYZOuC+13qLzsM=;
        b=VhawphbVb4CjWVesMD3drTw0fAFthTjG0BGyIZu7Szw43G2DPylX4xoPF6IPxx0AGj3Y8D
        Xef1/JyfSV62bCGHNQSUIo6AGTUz+w599WN+sog5XzOdsPcwAq7lrm8am/y8AUD7CB6y7k
        G+MQd6vxqu3Ykd9dZVvEYrMRItKfv7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-AxTiy8ZWOS-ruwjeo1BfXg-1; Wed, 05 Aug 2020 11:37:36 -0400
X-MC-Unique: AxTiy8ZWOS-ruwjeo1BfXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 666F057;
        Wed,  5 Aug 2020 15:37:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F20B45D9E2;
        Wed,  5 Aug 2020 15:37:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200804133817.GD32719@miu.piliscsaba.redhat.com>
References: <20200804133817.GD32719@miu.piliscsaba.redhat.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk> <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] fsinfo: Allow mount topology and propagation info to be retrieved [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2316805.1596641851.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 05 Aug 2020 16:37:31 +0100
Message-ID: <2316806.1596641851@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > +	__u32	shared_group_id;	/* Shared: mount group ID */
> > +	__u32	dependent_source_id;	/* Dependent: source mount group ID */
> > +	__u32	dependent_clone_of_id;	/* Dependent: ID of mount this was clon=
ed from */
> =

> Another set of ID's that are currently 32bit *internally* but that doesn=
't
> mean they will always be 32 bit.
> =

> And that last one (apart from "slave" being obfuscated)

I had "slave" in there.  It got objected to.  See
Documentation/process/coding-style.rst section 4.

> is simply incorrect.  It has nothing to do with cloning.  It's the "ID o=
f
> the closest peer group in the propagation chain that has a representativ=
e
> mount in the current root".

You appear to be in disagreement with others that I've asked.

David

