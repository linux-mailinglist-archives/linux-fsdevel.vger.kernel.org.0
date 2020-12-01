Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7C2CA96E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgLARUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 12:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728896AbgLARUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606843132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vydv8w43cnFgjfkZU3nZrnMx51U7DpJsIR+Fxa/fu3g=;
        b=iifByUnTJ3arsZa3jOlxI5Jd924QgsKzRis4A8IBJmwdDkcyglAAD7sxJwLqiY+9dkpFb0
        f/A7DIUMQSjIUPrj8hpncy9tLlISjCGDFtJ8OO3ggPJTeVaLn+qun9nh3FM9gjMkxQ6YHw
        cEExoIY92JozFRXiYtTWsY2NrQbRzqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-hKil68X3Mi2a70ALDMAQxw-1; Tue, 01 Dec 2020 12:18:51 -0500
X-MC-Unique: hKil68X3Mi2a70ALDMAQxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 339351005E45;
        Tue,  1 Dec 2020 17:18:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 510DE60854;
        Tue,  1 Dec 2020 17:18:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
References: <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com> <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286419.1606843124.1@warthog.procyon.org.uk>
Date:   Tue, 01 Dec 2020 17:18:44 +0000
Message-ID: <286420.1606843124@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Sandeen <sandeen@redhat.com> wrote:

> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
> so one of them needs fixing. Move STATX_ATTR_DAX.
> 
> While we're in here, clarify the value-matching scheme for some of the
> attributes, and explain why the value for DAX does not match.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

You should probably have one or two Fixes: lines in it.  It might be worth
referencing both of the patches that added conflicting bits.

Fixes: 80340fe3605c ("statx: add mount_root")
Fixes: 712b2698e4c0 ("fs/stat: Define DAX statx attribute")

It should probably have:

Reported-by: David Howells <dhowells@redhat.com>

also as you mentioned that in the cover.

You can also add:

Reviewed-by: David Howells <dhowells@redhat.com>

David

