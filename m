Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7596517AFCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 21:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEUfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 15:35:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24664 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgCEUfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583440513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U5JtOxyT2J/jqnRkTwxu/wWznmUdm4uGYD+aZ7B6ZU=;
        b=HmDe5409YmAPU3cbyIVSmpqcuD27z9J5fQCBO8Di75PHKTvCItPZ5n6dDumB9PIoCLCV2R
        jQNSZsJem6CfyLxqSt1xlCRrUknsPkSNE+o27OsGcZJeM46JRkOkfpZJq4rLFRXmlj5M8r
        D87gJYfJexny2+EJKA+K8t8GPp4VGXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-HfKQmJQFOQCbDo7hC9AehQ-1; Thu, 05 Mar 2020 15:35:11 -0500
X-MC-Unique: HfKQmJQFOQCbDo7hC9AehQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D7A1100550E;
        Thu,  5 Mar 2020 20:35:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB36E5D9CD;
        Thu,  5 Mar 2020 20:35:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4e915f46-093b-c566-1746-938dbd6dcf62@samba.org>
References: <4e915f46-093b-c566-1746-938dbd6dcf62@samba.org> <3774367.1583430213@warthog.procyon.org.uk>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        cyphar@cyphar.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Mark AT_* path flags as deprecated and add missing RESOLVE_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3786500.1583440507.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 05 Mar 2020 20:35:07 +0000
Message-ID: <3786501.1583440507@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Metzmacher <metze@samba.org> wrote:

> Where's the RESOLVE_NO_TERMINAL_AUTOMOUNTS check?

See:

      (3) Make openat2() support RESOLVE_NO_TERMINAL_SYMLINKS.  LOOKUP_OPE=
N
          internally implies LOOKUP_AUTOMOUNT, and AT_EMPTY_PATH is probab=
ly not
          worth supporting (maybe use dup2() instead?).

As things currently stand, automount following is explicitly forced on for
open and create.  We can make it error out instead if this is desirable if
RESOLVE_NO_TERMINAL_AUTOMOUNTS in such a case.

David

