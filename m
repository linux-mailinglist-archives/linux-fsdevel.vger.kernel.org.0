Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2661D5448
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgEOPV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:21:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726479AbgEOPV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589556085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9/34K8DyCduL8IGZODiZffSbWOR6EGIIlhbYFcxqDY=;
        b=LEEhWFrKFyNtyUOvO7XF5d2u7iTR8ey9xcuDHwPJWk6KS8eJGl8ZKzBcFiz6thnDaDXTMk
        ndQZtXGr+1Vaj/v3LeOmPCQo/xOat+m+meX6cjGaEda+cfYF4KZvDyArGQYRq1h+IjHOC/
        P1mnp/ZgPXW+XCHFLEZPKFcL4smGOKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-2obm2pHAMP6xdBmL5MUTMQ-1; Fri, 15 May 2020 11:21:21 -0400
X-MC-Unique: 2obm2pHAMP6xdBmL5MUTMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEB62801503;
        Fri, 15 May 2020 15:21:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 523332E16E;
        Fri, 15 May 2020 15:21:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200513065656.2110441-2-hch@lst.de>
References: <20200513065656.2110441-2-hch@lst.de> <20200513065656.2110441-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 01/14] cachefiles: switch to kernel_write
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <129175.1589556077.1@warthog.procyon.org.uk>
Date:   Fri, 15 May 2020 16:21:17 +0100
Message-ID: <129176.1589556077@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> __kernel_write doesn't take a sb_writers references, which we need here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

