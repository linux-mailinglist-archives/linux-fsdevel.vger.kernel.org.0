Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB41409F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgAQMtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:49:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20757 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbgAQMtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579265364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YZJEySeW4x60PWnXaTPYPXKUUGWLoo4eTenx7+ZFSLc=;
        b=NDLsLZm/3AlPpZUIcqnAI6XzNxJkAVk0q1IX2qvKIaUY5yrPjgZQj9uKhqqdyLP65gzb8D
        fiCCygCJ8PWzFDaJjLVGLkZ7U+gIOx6msBrqcZwd1vEEA6UJ/Gg0yhfpXYTpC+i0SA617J
        uv11EhHGk5VjwzDGkixwZtDVB7bndRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-naUjuSu3PR-IuY-PLpsC0g-1; Fri, 17 Jan 2020 07:49:21 -0500
X-MC-Unique: naUjuSu3PR-IuY-PLpsC0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 725A48017CC;
        Fri, 17 Jan 2020 12:49:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E68341001925;
        Fri, 17 Jan 2020 12:49:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     lsf-pc@lists.linux-foundation.org,
        Amir Goldstein <amir73il@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <364530.1579265357.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 12:49:17 +0000
Message-ID: <364531.1579265357@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It may be worth a discussion of whether linkat() could be given a flag to
allow the destination to be replaced or if a new syscall should be made for
this - or whether it should be disallowed entirely.

A set of patches has been posted by Omar Sandoval that makes this possible:

    https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/

though it only includes filesystem support for btrfs.

This could be useful for cachefiles:

	https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/

and overlayfs.

David

