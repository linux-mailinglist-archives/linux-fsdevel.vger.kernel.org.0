Return-Path: <linux-fsdevel+bounces-5704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D817680F00A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91458281BD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E67542A;
	Tue, 12 Dec 2023 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXaNpla2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BABAAA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702394559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Vj+fbHv6NW6omZNTVJBYVMBbUe/sacN33LNV8nhf4E=;
	b=NXaNpla2aDoAIRvrPQT8BFKJsOmCDbhh2vOitvtENTtwf0H37vB2sELM45NhWzNLT3Z7lz
	oR6gnB3pRMdGs9ZB7qrGDSfMbYnbowGdLka3QOlru4CJ7dbI4jULp4vuwgBcRVgLBOTzOC
	E+XPvobgvtn56SS3dxpw5jRPZKouh+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-KIDAXbBfPBmn_8VTc6UHHA-1; Tue, 12 Dec 2023 10:22:35 -0500
X-MC-Unique: KIDAXbBfPBmn_8VTc6UHHA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC498185A781;
	Tue, 12 Dec 2023 15:22:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0711492BF0;
	Tue, 12 Dec 2023 15:22:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231212094440.250945-2-amir73il@gmail.com>
References: <20231212094440.250945-2-amir73il@gmail.com> <20231212094440.250945-1-amir73il@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
    Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
    Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
    Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] splice: return type ssize_t from all helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3138448.1702394551.1@warthog.procyon.org.uk>
Date: Tue, 12 Dec 2023 15:22:31 +0000
Message-ID: <3138449.1702394551@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Barring Jan's nit,

Reviewed-by: David Howells <dhowells@redhat.com>


