Return-Path: <linux-fsdevel+bounces-7596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3C82847C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89165286CED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74E36AFB;
	Tue,  9 Jan 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABadMjDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF536AE4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704798516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVq6Bvt43xx2ZZr7NjW5k0lYlPpCHdUkD3QuDPePB8I=;
	b=ABadMjDEuvJqNX9Lj+RHU8ndpUOuvs4Gd+lfgg8wyvoqoSRCyqOJ0B1q6ZsimnngPEjS+p
	HxC2I6iI3kFsrwXZiq2fia9Ssgm5tuJcBtLjtFyvGBoJkVOgjF8bPRKji6oQObvttpZOTJ
	nEsmmTnxjVeB1hdfkxV1Oqd9fyEky/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-tJeXuIr2MX6fcUVVyYDIeQ-1; Tue,
 09 Jan 2024 06:08:34 -0500
X-MC-Unique: tJeXuIr2MX6fcUVVyYDIeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 560381C05151;
	Tue,  9 Jan 2024 11:08:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83E3740C6EB9;
	Tue,  9 Jan 2024 11:08:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZZyCTPz+uuvgjPIL@casper.infradead.org>
References: <ZZyCTPz+uuvgjPIL@casper.infradead.org> <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com> <1542013.1704750095@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
    linux-cachefs@redhat.com,
    linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reference to non-existing CONFIG_NETFS_FSCACHE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1571879.1704798511.1@warthog.procyon.org.uk>
Date: Tue, 09 Jan 2024 11:08:31 +0000
Message-ID: <1571880.1704798511@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Matthew Wilcox <willy@infradead.org> wrote:

> > netfs_writepages_begin() has the wait on the fscache folio conditional on
> > CONFIG_NETFS_FSCACHE - which doesn't exist.
> > 
> > Fix it to be conditional on CONFIG_FSCACHE instead.
> 
> Why is it conditional at all?  Why don't we have a stub function if
> CONFIG_FSCACHE is not defined?

At this point, I'd rather just change the #ifdef and then (hopefully) next
cycle get rid of PG_fscache entirely, rendering this unnecessary.

David


