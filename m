Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7161649B7C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385563AbiAYPhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 10:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353755AbiAYPet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643124887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QjyE7wz6cil8LO6HiDitf7P9QNfNrKVet24hXy+TY64=;
        b=VAizpfV+v5eHGSacgj7lFmP1ndd9cHGY2+hsRuB3s5izKdVmjCqnelo1MWIIzSh6N2e0jo
        R1hBdqDHisJCgyKfZatPtvCskHh/ZLZ/9w2MpoquYqYHSSJetbYFl4O09QRj9JwzVLGx+s
        4btXelmG5OrRHUiqfsIGgKZCOewkc/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-5MdDGyFQNUC_uojbNYtUKg-1; Tue, 25 Jan 2022 10:34:45 -0500
X-MC-Unique: 5MdDGyFQNUC_uojbNYtUKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D8C84B9A7;
        Tue, 25 Jan 2022 15:34:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 210947DE2F;
        Tue, 25 Jan 2022 15:34:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220118131216.85338-12-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-12-jefflexu@linux.alibaba.com> <20220118131216.85338-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/20] erofs: add cookie context helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2812798.1643124872.1@warthog.procyon.org.uk>
Date:   Tue, 25 Jan 2022 15:34:32 +0000
Message-ID: <2812799.1643124872@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +static int erofs_fscahce_init_ctx(struct erofs_fscache_context *ctx,

fscahce => fscache?

David

