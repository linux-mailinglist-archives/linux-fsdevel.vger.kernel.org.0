Return-Path: <linux-fsdevel+bounces-5524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA5980D237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE8E1C21170
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402F208A1;
	Mon, 11 Dec 2023 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ2d0ebw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A604899
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6fINjgYzDp4pT6EiKMHp9CdMk4eAHEGQUt/Jxjj7L0=;
	b=PQ2d0ebwl1gkZfaQ73EVWHG8lTJ6iIccHihHAzAvgcqLP5891AC12LzOEVaj3vOvk5boF1
	5ZSlodfsW4VCSLMg76dO0a36MQyWHCE74105hxna87QA5mqxaX46T8+KAiESbfppQD01Zf
	3gZQ4CFR/86scJlDrXDfwSXmw4Scbfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-66pKNrKKPKGDcqdc3R7j0Q-1; Mon, 11 Dec 2023 11:40:14 -0500
X-MC-Unique: 66pKNrKKPKGDcqdc3R7j0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFFAC88D7A1;
	Mon, 11 Dec 2023 16:40:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C80432166B32;
	Mon, 11 Dec 2023 16:40:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231211163412.2766147-1-dhowells@redhat.com>
References: <20231211163412.2766147-1-dhowells@redhat.com>
To: Markus Suvanto <markus.suvanto@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS lookups
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2766463.1702312811.1@warthog.procyon.org.uk>
Date: Mon, 11 Dec 2023 16:40:11 +0000
Message-ID: <2766464.1702312811@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

This is the related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216637


