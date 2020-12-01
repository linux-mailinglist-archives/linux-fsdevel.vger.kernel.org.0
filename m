Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DF2CA9B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbgLARaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 12:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404112AbgLARaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606843731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5Fh+Y6emSlpgthUwTm3aw8jw437MaCs2J9N9xWqfdY=;
        b=OKlO8jwVZloKaHD1zr4upSdqCV0k3+0fmxkDIitDEWSa6aAdrGhy67PS/nCHgCiuZTwwrT
        lChOLTy+r/YxLYY+JvR4zTQz4AArtgYDO7Zn2j31EL3zH59WtvZlvUG3PL7V72GT+7UIdM
        k0DjNLma5Tjwpe+0IoLMtRJZMpzbFXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-yFLVe0qUPSWYZ48nuri9ow-1; Tue, 01 Dec 2020 12:28:48 -0500
X-MC-Unique: yFLVe0qUPSWYZ48nuri9ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9526480EDAA;
        Tue,  1 Dec 2020 17:28:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A6B5D9C2;
        Tue,  1 Dec 2020 17:28:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <286508.1606843256@warthog.procyon.org.uk>
References: <286508.1606843256@warthog.procyon.org.uk> <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com> <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to filesystems
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286928.1606843717.1@warthog.procyon.org.uk>
Date:   Tue, 01 Dec 2020 17:28:37 +0000
Message-ID: <286929.1606843717@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > -	if (IS_DAX(inode))
> > -		stat->attributes |= STATX_ATTR_DAX;
> > -
> 
> This could probably be left in and not distributed amongst the filesytems
> provided that any filesystem that might turn it on sets the bit in the
> attributes_mask.

On further consideration, it's probably better to split it as you've done it.

Reviewed-by: David Howells <dhowells@redhat.com>

You do need one or more Fixes: lines, though.

David

