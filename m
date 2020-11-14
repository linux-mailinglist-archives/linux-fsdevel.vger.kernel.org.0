Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A52B2EF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKNR1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 12:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgKNR1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 12:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605374836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfQwZC9YEADpefDeufIxu3TSYRi4xlUPbbTH8N+O+PE=;
        b=Snim3ETWZ0YXu3Z+s6Y0nGJHp4EC6xYo4OJGDWJtZas0MiFtpGLVsXDJKSo6kl87GaxpvX
        bXLi1hViYfbqHPEl5AIlK7Jkk+NpomB6+TjVUnJBRW51Lxd8QrKHxnUJ6AtxBSr6Sesl8M
        D/+Conr6Q/9WqGFmcpvG2wN8I2VnL58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-830PN4vbN2CZ5S5_3NWqQw-1; Sat, 14 Nov 2020 12:27:14 -0500
X-MC-Unique: 830PN4vbN2CZ5S5_3NWqQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B69E80EF8B;
        Sat, 14 Nov 2020 17:27:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF7E5D9E8;
        Sat, 14 Nov 2020 17:27:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160537468016.3082569.17243477803724537224.stgit@warthog.procyon.org.uk>
References: <160537468016.3082569.17243477803724537224.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix afs_write_end() when called with copied == 0 [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3082979.1605374831.1@warthog.procyon.org.uk>
Date:   Sat, 14 Nov 2020 17:27:11 +0000
Message-ID: <3082980.1605374831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> -		SetPageUptodate(page);
> +		SetPageUptoodate(page);

I'm not sure what happened there.  Will try again :-(

