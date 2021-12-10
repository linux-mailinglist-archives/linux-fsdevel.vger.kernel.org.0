Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0B470410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbhLJPpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 10:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242978AbhLJPpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639150924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXcsyPR601Yj3OPOwr7kbflW1Oar2nIVgWDWOuLn61o=;
        b=KCtoYOU0PSm1tEkJPaxFesP76/W6g/I8SCq0XVd0SdVYwOeuNa5hpCjpVXRMQ08ltxjtwF
        0ZnpGEXAqSDwr8Tc7GNV9PalBeZdyInwpsErARryY1ivD7ah2HfN1zmAbLm2rI+9l3bpkY
        UdaK2/w0GFt5YbzJifErXDYJqvIJ3Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-40-n9EIVVDQMLmhaVgyRWP9oQ-1; Fri, 10 Dec 2021 10:42:01 -0500
X-MC-Unique: n9EIVVDQMLmhaVgyRWP9oQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3761E86A07B;
        Fri, 10 Dec 2021 15:41:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5ED91B42C;
        Fri, 10 Dec 2021 15:41:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-10-jefflexu@linux.alibaba.com> <20211210073619.21667-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 09/19] netfs: refactor netfs_rreq_unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <292571.1639150908.1@warthog.procyon.org.uk>
Date:   Fri, 10 Dec 2021 15:41:48 +0000
Message-ID: <292572.1639150908@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> In demand-read case, the input folio of netfs API is may not the page

"is may not the page"?  I think you're missing a verb (and you have too many
auxiliary verbs;-)

David

