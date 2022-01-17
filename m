Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF85A490A40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiAQO1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238212AbiAQO1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642429640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XTu3HS6DOuMKhxNN0uXtnGhr2o6a4IoS4bZ6mA5nUKc=;
        b=b+sykfpC/oywF1U0exjPAmJpMHJYOc2VpWjj6SBvVTfHLwa4lINxvTJnGf4i03phYz9CUE
        LMl5yEP0eQSWvDx8o1aOxEEoI5VVTE0rWaTqgWviBvTH9HmJ7ShZ4QcnfPedSRE2id+nbz
        dhUCTfGcr/aVFRArtPrw7AWGSBoHWzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-jVOH2pl7ORejyzrtUfhphw-1; Mon, 17 Jan 2022 09:27:15 -0500
X-MC-Unique: jVOH2pl7ORejyzrtUfhphw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E20CD83DEA8;
        Mon, 17 Jan 2022 14:27:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E144177460;
        Mon, 17 Jan 2022 14:27:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org>
References: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org> <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk> <YeVzZZLcsX5Krcjh@casper.infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2768910.1642429628.1@warthog.procyon.org.uk>
Date:   Mon, 17 Jan 2022 14:27:08 +0000
Message-ID: <2768911.1642429628@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> That would be nicer, I think. If you do that though, then patch #3
> probably needs to come first in the series...

Seems reasonable.  Could you do that, or do you want me to have a go at it?

David

