Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B456817EAEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCIVNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 17:13:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36988 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726838AbgCIVNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583788392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il8BHXhlu0rpVwjSDD1TcJtiqIzjydKT/JxTacOBPvo=;
        b=ZHNtAPJPBiIT91FePIAP1f47Yx2Cy84ctHB4ZOHid8hy4Q7A0gGlYNRoyIibXVoIDHAhrO
        lLi/nNbG5VqiImXmEZb+TwbbXbR7AhIXXKjBdGAFE5Phvq0qpGOu5v8wvRrgmT6xyEXGyw
        9D15T728ZK1UbPiTwI5aWTKFj0LvYVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-8LJQfvrlOuG6Zr6VQp3twA-1; Mon, 09 Mar 2020 17:13:10 -0400
X-MC-Unique: 8LJQfvrlOuG6Zr6VQp3twA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C9F3107ACC9;
        Mon,  9 Mar 2020 21:13:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 499805D9CA;
        Mon,  9 Mar 2020 21:13:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a2012ba2-e322-39e2-fa80-c8d4aef501de@samba.org>
References: <a2012ba2-e322-39e2-fa80-c8d4aef501de@samba.org> <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk> <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Aleksa Sarai <cyphar@cyphar.com>,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <530114.1583788384.1@warthog.procyon.org.uk>
Date:   Mon, 09 Mar 2020 21:13:04 +0000
Message-ID: <530115.1583788384@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Metzmacher <metze@samba.org> wrote:

> > Automounting is currently forced by doing an open(), so adding support to
> > openat2() for RESOLVE_NO_TRAILING_AUTOMOUNTS is not trivial.
> 
> lookup_flags &= ~LOOKUP_AUTOMOUNT won't work?

No.  LOOKUP_OPEN overrides that.

David

