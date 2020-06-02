Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F51EBF69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFBPyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 11:54:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgFBPyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591113251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILYFG9rCBpVJEie9Ek0zgJwbrCArrQiaGkL5V6EbSUg=;
        b=d74ZHXFukzjADAI3FDG4iicyxa2oskp5INMWDrzYWQ6pVeN1cAINmAN5ujR9Y6/tUwT5P8
        iqsfie1XtVh5x8oYVuihcIrFs7maS1CuUK+jMez0sW6dazD4vJUaBbZgIDEK/OvPZ40Dnc
        TI5ji2BXHh/tKBeKcZAus3lJD4gYlXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-vhCrBKoQOgqcpCjqZyASCw-1; Tue, 02 Jun 2020 11:54:10 -0400
X-MC-Unique: vhCrBKoQOgqcpCjqZyASCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA203461;
        Tue,  2 Jun 2020 15:54:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C63F0610AF;
        Tue,  2 Jun 2020 15:54:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1503047.1591113104@warthog.procyon.org.uk>
References: <1503047.1591113104@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com,
        raven@themaw.net, andres@anarazel.de, christian.brauner@ubuntu.com,
        jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1503556.1591113245.1@warthog.procyon.org.uk>
Date:   Tue, 02 Jun 2020 16:54:05 +0100
Message-ID: <1503557.1591113245@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops - I forgot to include the pull request.  Will resend.

David

