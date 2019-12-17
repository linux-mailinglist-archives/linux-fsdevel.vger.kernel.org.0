Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49352123404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 18:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfLQR6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 12:58:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47412 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbfLQR6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576605482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shPEKSYyrqxVgC6gE1FRRG/d4tEh/vqgoW+2Rgiz3Bg=;
        b=C/LilPBLdarCgNgKnmDgE8v54XN0XYczq5CPHaU7VBMbGZMQc3Cd99BHkmV1iVUQLKys4M
        NbvLvPpO9y0ekFpPTR8p7XbzbLcdUI3y/dSpBJT5xBXxy7EWISj5y+FRqa6Os0GiCBRHrJ
        QqqCYKaZa2x4yLhc4WLZqEIicEDkygI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-1bGu3EB7OLOI1VGJT9YERA-1; Tue, 17 Dec 2019 12:57:58 -0500
X-MC-Unique: 1bGu3EB7OLOI1VGJT9YERA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C54FE107ACC4;
        Tue, 17 Dec 2019 17:57:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04EEF19427;
        Tue, 17 Dec 2019 17:57:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191216105432.5969-1-jack@suse.cz>
References: <20191216105432.5969-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pipe: Fix bogus dereference in iov_iter_alignment()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <574.1576605476.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 17 Dec 2019 17:57:56 +0000
Message-ID: <575.1576605476@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:

> We cannot look at 'i->pipe' unless we know the iter is a pipe. Move the
> ring_size load to a branch in iov_iter_alignment() where we've already
> checked the iter is a pipe to avoid bogus dereference.
> =

> Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
> Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not=
 cursor and length")
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: David Howells <dhowells@redhat.com>

