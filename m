Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C56C2E1CE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgLWNzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 08:55:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728449AbgLWNzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608731614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DcbrkMu3uylfJtScwJjrH6s3pciipVZZ9W53PNc+mm8=;
        b=GiI38fqnY6NBilCq29cvrRDIaQoXu4HVToDoSkSHjaqsCJ/XnTPrKeoPF/zUQT9EOhTTZY
        eo/ifcvh4btdnqtiiaESpzWXHVWHUOHH6vEzlTG47tfkzWsE0TR8JxLyMOJRQKbJaA+JYR
        YV4/KtEmXMzpPAWpDNFJP577YZIEEtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-nsM0Y3sGNTitZtcU3_XP9w-1; Wed, 23 Dec 2020 08:53:30 -0500
X-MC-Unique: nsM0Y3sGNTitZtcU3_XP9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71EBB15720;
        Wed, 23 Dec 2020 13:53:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-204.rdu2.redhat.com [10.10.112.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BB795D6D7;
        Wed, 23 Dec 2020 13:53:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160873135094.834130.9048269997292829364.stgit@warthog.procyon.org.uk>
References: <160873135094.834130.9048269997292829364.stgit@warthog.procyon.org.uk>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <834551.1608731607.1@warthog.procyon.org.uk>
Date:   Wed, 23 Dec 2020 13:53:27 +0000
Message-ID: <834552.1608731607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apologies, this is the old version.  I meant to post the new one.

David

