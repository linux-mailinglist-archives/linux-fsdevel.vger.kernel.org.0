Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6921C2861B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgJGO7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 10:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728694AbgJGO7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602082780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7N51+8sQh2H8W9MnGonUz2RHvBYt0K/Eby2kep8UCRc=;
        b=ZeqMy4GBgox1PcxxxmYy6y3ZEER1v7eAY6Kc44eDBTktfNx0krysbQXrxxpXZU7kiUt4uz
        m9cPeJYQTtY80kooG1pHhYlMXkVK8v3EWK3ynWLY00JfURqUYJW0OzBnIChhmxjZaUzFGW
        9V+nBu7RM5YDwAy+227Pvy8fidrxYXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-B_T5IR5CNSmQWc6bIYMBCw-1; Wed, 07 Oct 2020 10:59:38 -0400
X-MC-Unique: B_T5IR5CNSmQWc6bIYMBCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652AE191E2A0;
        Wed,  7 Oct 2020 14:59:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-196.rdu2.redhat.com [10.10.116.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C0B96EF42;
        Wed,  7 Oct 2020 14:59:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160207693283.3934207.6150787285715868358.stgit@warthog.procyon.org.uk>
References: <160207693283.3934207.6150787285715868358.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix deadlock between writeback and truncate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4013287.1602082775.1@warthog.procyon.org.uk>
Date:   Wed, 07 Oct 2020 15:59:35 +0100
Message-ID: <4013288.1602082775@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

>  (1) Use the vnode validate_lock to mediate access between afs_setattr()
>      and afs_writepages():

Hmmm...  I wonder if the problem can occur between afs_setattr() and
afs_writepage() too.

David

