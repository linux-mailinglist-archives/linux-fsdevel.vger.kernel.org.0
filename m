Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD34A4A97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379575AbiAaPcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:32:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379557AbiAaPcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643643136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53Ps9beOdW2O+7ZMJWjK1Iq0DgZCvoa89wIZJ4nk1Uc=;
        b=OkAy2gLt0p+AcvebYLSATiR+wwDgfFXNttbGZUlPN9/pYSDoNrroHvbrr25TBtSO5qMj4k
        qS6rqIAY8Sc4vUBOY+onjtD1X6zSnb/Mn1/BUknj29DJEhObFoK7OhtcZMutgcSzYMz9uS
        bc/k8Ev+vdPBoqQBsstZc0oYZT+NlyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-ZDuH1LTJPAGm6Oy8JssAUw-1; Mon, 31 Jan 2022 10:32:13 -0500
X-MC-Unique: ZDuH1LTJPAGm6Oy8JssAUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55F485108E;
        Mon, 31 Jan 2022 15:32:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D2884D04;
        Mon, 31 Jan 2022 15:32:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxiorvXhhJbCsGo-B7aBX0BbSYp7wUHmYS1e1xxJ4dpF3w@mail.gmail.com>
References: <CAOQ4uxiorvXhhJbCsGo-B7aBX0BbSYp7wUHmYS1e1xxJ4dpF3w@mail.gmail.com> <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk> <164364197646.1476539.3635698398603811895.stgit@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] vfs, overlayfs, cachefiles: Turn I_OVL_INUSE into something generic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1531205.1643643128.1@warthog.procyon.org.uk>
Date:   Mon, 31 Jan 2022 15:32:08 +0000
Message-ID: <1531209.1643643128@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> Please leave ovl_* as wrappers instead of changing super.c.

Do you want them turning into inline functions?

David

