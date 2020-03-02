Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3098D175ABD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCBMnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:43:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727644AbgCBMnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583152979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBO8EEOjfex8u0t23SNnR9VcuJJE9A6M8SfZYPDK40Y=;
        b=GFXEFLG0X2b4N3JzzX8EgrEP16EvZbeW4qLE4ziLQ5XIRPOSR6dHeH+rvMFnMWXxWPEJD1
        ylMOpfdGCoAbYEb3Gn51PpyfXNuvDlvOApqX7d04uFBttX/k29A9d8EHeiYJ4rybHK/Q+7
        g2NVS+4vHQYmoK/rqv7VQF/+53jsWV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-VdUHncH4OyKzclJAazqbEg-1; Mon, 02 Mar 2020 07:42:56 -0500
X-MC-Unique: VdUHncH4OyKzclJAazqbEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ED5F10CE780;
        Mon,  2 Mar 2020 12:42:54 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-127.ams2.redhat.com [10.36.116.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F46B5DA2C;
        Mon,  2 Mar 2020 12:42:52 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
References: <96563.1582901612@warthog.procyon.org.uk>
        <20200228152427.rv3crd7akwdhta2r@wittgenstein>
        <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
        <20200302115239.pcxvej3szmricxzu@wittgenstein>
        <8736arnel9.fsf@oldenburg2.str.redhat.com>
        <20200302121959.it3iophjavbhtoyp@wittgenstein>
        <20200302123510.bm3a2zssohwvkaa4@wittgenstein>
Date:   Mon, 02 Mar 2020 13:42:50 +0100
In-Reply-To: <20200302123510.bm3a2zssohwvkaa4@wittgenstein> (Christian
        Brauner's message of "Mon, 2 Mar 2020 13:35:10 +0100")
Message-ID: <87y2sjlygl.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

> One difference to openat() is that openat2() doesn't silently ignore
> unknown flags. But I'm not sure that would matter for iplementing
> openat() via openat2() since there are no flags that openat() knows about
> that openat2() doesn't know about afaict. So the only risks would be
> programs that accidently have a bit set that isn't used yet.

Will there be any new flags for openat in the future?  If not, we can
just use a constant mask in an openat2-based implementation of openat.

Thanks,
Florian

