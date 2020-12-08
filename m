Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6352D2B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 14:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgLHNBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 08:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgLHNBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607432380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJuycivZ+AGkxRm8Uh8ZFQ/EkEn5NEsY/G+sybB3iCk=;
        b=AuB5PSOfsC9rtMdB/hUT5EtxbuqrJjD25Wrfft8GrMn9NqcGWRfSIeHHcz8KyrHxel2iJv
        RsyMFwhHCuo2ck0sUsINfxMTH4r0S3Y9rwlQhr6dGxuFtwHeS8OnmnmlsrryikEETs1XFF
        fROk4fm9KG7csL9iTPosgUFsX9gA5hA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-YPk_nV1tMeGdtiy9SzJOuA-1; Tue, 08 Dec 2020 07:59:39 -0500
X-MC-Unique: YPk_nV1tMeGdtiy9SzJOuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9040A84E251;
        Tue,  8 Dec 2020 12:59:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F7EE10023AC;
        Tue,  8 Dec 2020 12:59:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201208003117.342047-1-krisman@collabora.com>
References: <20201208003117.342047-1-krisman@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/8] Superblock Notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <953339.1607432374.1@warthog.procyon.org.uk>
Date:   Tue, 08 Dec 2020 12:59:34 +0000
Message-ID: <953340.1607432374@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> After the two previous RFCs this is an attempt to get the ball spinning
> again.
> 
> The problem I'm trying to solve is providing an interface to monitor
> filesystem errors.  This patchset includes an example implementation of
> ext4 error notification.  This goes obviously on top of the watch_queue
> mechanism.

Thanks for picking this up and advancing it.

> Regarding the buffer overrun issue that would require fsinfo or another
> method to expose counters, I think they can be added at a later date
> with no change to what this patch series attempts to do, therefore I'm
> proposing we don't wait for fsinfo before getting this merged.

That's fine, but anyone wanting to use this will need to be aware that
overruns are a problem.

David

