Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB041D6073
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgEPKxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 06:53:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42178 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEPKxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 06:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589626434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Sgk4L76+G8NMqHYS6ddlBe3JD0wGPSl87Vyk1kROUo=;
        b=OPdJwO2wxM8IJNmWFz+qq5Ifmn534kfTeiCd/fhSOuzR5Vhepy2wXyfECg1vvpacmv7SRl
        XSrcvaF8/V8qs8s2xrRMBYFPqJzmyJJba+rS4K5d5x2VlWvnbZQ9h+QGVvM4Trv8QbfxCl
        VAXyevdltaHhWzVp9/lH1ObK9w53laI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-GcqHfzqTMWmxPdkJ6SiDpg-1; Sat, 16 May 2020 06:53:50 -0400
X-MC-Unique: GcqHfzqTMWmxPdkJ6SiDpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD92F1005512;
        Sat, 16 May 2020 10:53:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10CCB5C6CA;
        Sat, 16 May 2020 10:53:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7c446f9f404135f0f4109e03646c4ce598484cae.camel@hammerspace.com>
References: <7c446f9f404135f0f4109e03646c4ce598484cae.camel@hammerspace.com> <f91b8f29-271a-b5cd-410b-a43a399d34aa@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH -next] nfs: fsinfo: fix build when CONFIG_NFS_V4 is not enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <537091.1589626426.1@warthog.procyon.org.uk>
Date:   Sat, 16 May 2020 11:53:46 +0100
Message-ID: <537092.1589626426@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> This whole thing needs to be reviewed and acked by the NFS community,
> and quite frankly I'm inclined to NAK this. This is the second time
> David tries to push this unwanted rewrite of totally unrelated code.

Rewrite?  What?

It's example code of what NFS could export through this interface.  I didn't
submit it to Linus with the rest of the patches as it's only an example; same
for the ext4 example.  I've tried running it past you and other NFS people a
couple of times to try and elicit a response and wanted to try and ask you
about it at LSF:-(

Anyway, I've dropped it for now.

David

