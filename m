Return-Path: <linux-fsdevel+bounces-7574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CA827A54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64470B22F31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B256471;
	Mon,  8 Jan 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4+ZB1TE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2F5646C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704750102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PouS+fcfRBFYHLc59Q6jvOZOpQHzKSFm7NNqEvCIUk8=;
	b=T4+ZB1TEHMcPtWQTHpwDL2lSuJEi61/4ESZ49u7LMT/1sBOea1aK84l36KYfSYb1c2z+r5
	NP3JpXxuHOFcmn4tMVY8JLu2qJv60AUjAVWeExzKrRAykdKUQV7r0i1+sCccjjpQrG+l7M
	dTQelTsBOoVRQ9dxFv/NDNto0fj/Ln0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-xSjPy8pPM0Sj570e6fr0mA-1; Mon,
 08 Jan 2024 16:41:37 -0500
X-MC-Unique: xSjPy8pPM0Sj570e6fr0mA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B96B3C02B64;
	Mon,  8 Jan 2024 21:41:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8342B492BC7;
	Mon,  8 Jan 2024 21:41:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com>
References: <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: dhowells@redhat.com, linux-cachefs@redhat.com,
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
Content-ID: <1542012.1704750095.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jan 2024 21:41:35 +0000
Message-ID: <1542013.1704750095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> In commit 62c3b7481b9a ("netfs: Provide a writepages implementation"),
> you have added some code that is included under #ifdef
> CONFIG_NETFS_FSCACHE, but if I read the code correctly, the actual
> intended config here is called CONFIG_FSCACHE.

Yeah - it should be the latter.  Something like the attached patch should =
fix
it.

David
---
netfs: Fix wrong #ifdef hiding wait

netfs_writepages_begin() has the wait on the fscache folio conditional on
CONFIG_NETFS_FSCACHE - which doesn't exist.

Fix it to be conditional on CONFIG_FSCACHE instead.

Fixes: 62c3b7481b9a ("netfs: Provide a writepages implementation")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 0b2b7a60dabc..de517ca70d91 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1076,7 +1076,7 @@ static ssize_t netfs_writepages_begin(struct address=
_space *mapping,
 		folio_unlock(folio);
 		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
 			folio_wait_writeback(folio);
-#ifdef CONFIG_NETFS_FSCACHE
+#ifdef CONFIG_FSCACHE
 			folio_wait_fscache(folio);
 #endif
 			goto lock_again;


