Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73102140CFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgAQOrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 09:47:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726827AbgAQOrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579272456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7KK7ZShm6NSNwUSSYbNYTvBvQjEDriyh01VLRuLoAQ=;
        b=ZrBin8FgnXNmwUfMzhVx77viLwTHYqRy6uvBWLz8EA+tV1gDcdKFxyQZKEadbbdDxDD0z4
        ULVTVDF/9xjM8Bat3IJ0m7v9gWEgN7hfJPCsFEOET1Flq4X8ZsRER/cJ6WTOTGKbEf51oY
        G+FHfZ9yW0XcB1xpoWjgiN+2lwgViu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-0U7LkqKAMHqSrt5gokk3OA-1; Fri, 17 Jan 2020 09:47:31 -0500
X-MC-Unique: 0U7LkqKAMHqSrt5gokk3OA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650D2800EBF;
        Fri, 17 Jan 2020 14:47:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C202B81207;
        Fri, 17 Jan 2020 14:47:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
References: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com> <364531.1579265357@warthog.procyon.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com, "osandov@osandov.com" <osandov@osandov.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <448105.1579272445.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 14:47:25 +0000
Message-ID: <448106.1579272445@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> That seems to me like a "just go ahead and do it if you can justify it"
> kind of thing. It has plenty of precedent, and fits easily into the
> existing syscall, so why do we need a face-to-face discussion?

Amir said "This sounds like a good topic to be discussed at LSF/MM (hint
hint)"

Also Christoph H is okay with the idea, but suggested it should be a separate
syscall and Al doesn't seem to like it.  Omar posted patches to do this, but
they didn't seem to get anywhere.

David

