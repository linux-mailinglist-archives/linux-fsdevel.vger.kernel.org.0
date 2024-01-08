Return-Path: <linux-fsdevel+bounces-7551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24C82706B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 14:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0632B282698
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E246B9A;
	Mon,  8 Jan 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHQLJGcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE994653F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704722163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cwOcp1MFrryPduML1Amlp6Emi0Gczn0iuACZPucAo0=;
	b=NHQLJGcBa5H7KQJXI67q2vfqjN5CQGcOgmMjITGPTGPJDvjlq1NLJ3jaSb2GxXMnr3x8O5
	0BUUDq1M74q6TryROP+Tc7r7nn0BUoa636EQobsWLeDe99d0pPie5KjtD+w/XCJIz91O3K
	l7tfxsbb0xGPXSyucNijCbmnsE4Qp4A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-atEy6GbmOziBnIbtdvJL3w-1; Mon,
 08 Jan 2024 08:55:58 -0500
X-MC-Unique: atEy6GbmOziBnIbtdvJL3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C356B29AA389;
	Mon,  8 Jan 2024 13:55:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F419240C6EB9;
	Mon,  8 Jan 2024 13:55:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20240108101404.19818-1-duminjie@vivo.com>
References: <20240108101404.19818-1-duminjie@vivo.com>
To: Minjie Du <duminjie@vivo.com>
Cc: dhowells@redhat.com, linux-cachefs@redhat.com,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    opensource.kernel@vivo.com
Subject: Re: [PATCH v1] netfs: use kfree_sensitive() instend of kfree() in fscache_free_volume()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1522541.1704721959.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Mon, 08 Jan 2024 13:55:56 +0000
Message-ID: <1522761.1704722156@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

You sent this twice - I replied to the other post.  But this is an unnecessary
use of kfree_sensitive() as the key is made public.

David


