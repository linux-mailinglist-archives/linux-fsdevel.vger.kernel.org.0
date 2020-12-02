Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDE2CC22F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLBQZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 11:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbgLBQZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606926242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/KvFOz7MMzTDoHF0bJjNyv+MeqNtUt9D2w2PnLZk360=;
        b=Z/SymytwvLnd0KnCMoQAezx/ITzFjKo6QenBB8pu4DPgW+MohbEBhg6LgkQqeC1Tm6zU5c
        6UAgiXdwAbt2SvB4CLncw1jNEMsPZSsgLIPxeGZfmGYLroYXcpelqCsTkDF/nAo8iNtaEN
        iZlyK0TMEx+fcnWRmoRK9S4k+tOKQ2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-9wNKgQKzOJy9g31KKd79iw-1; Wed, 02 Dec 2020 11:24:00 -0500
X-MC-Unique: 9wNKgQKzOJy9g31KKd79iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAA4F100E421;
        Wed,  2 Dec 2020 16:23:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94C285D9C6;
        Wed,  2 Dec 2020 16:23:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
References: <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com> <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com> <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <641396.1606926232.1@warthog.procyon.org.uk>
Date:   Wed, 02 Dec 2020 16:23:52 +0000
Message-ID: <641397.1606926232@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Stable cc also?
> 
> Cc: <stable@vger.kernel.org> # 5.8

That seems to be unnecessary, provided there's a Fixes: tag.

David

