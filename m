Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D389149C587
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiAZIvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 03:51:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234764AbiAZIvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643187110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfOp64U0iYvSw+YJXe3pmYBUfoothO/ocAN1AyLo5xI=;
        b=iNv6FgCr2RzZBFMt/oAuSjVBhgEodPib8UPS9zGaQ5SmlRv3z9QkdJ+ws9yzMXNH2qu5AP
        URGfYotPfCrbjzGnp8zqKLct8awiYAnrbkNziZurjvSrp/FqAg6CprZLCRighrApH/SByz
        33NQmGjwGlkACGNDVmMc2xoh5kGB0qY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-8QxKUfNEP4SBWpgli8BY4w-1; Wed, 26 Jan 2022 03:51:44 -0500
X-MC-Unique: 8QxKUfNEP4SBWpgli8BY4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D402100C609;
        Wed, 26 Jan 2022 08:51:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAD2B56F6A;
        Wed, 26 Jan 2022 08:51:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
References: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com> <20220118131216.85338-1-jefflexu@linux.alibaba.com> <2815558.1643127330@warthog.procyon.org.uk>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <100894.1643187095.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jan 2022 08:51:35 +0000
Message-ID: <100895.1643187095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> "/path/to/file+offset"
> 		^
> 
> Besides, what does the 'offset' mean?

Assuming you're storing multiple erofs files within the same backend file, you
need to tell the the cache backend how to find the data.  Assuming the erofs
data is arranged such that each erofs file is a single contiguous region, then
you need a pathname and a file offset to find one of them.

David

