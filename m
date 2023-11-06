Return-Path: <linux-fsdevel+bounces-2100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7857E272B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA43B2080C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F927701;
	Mon,  6 Nov 2023 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO3rSRIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799A18AEB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:40:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22537F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699281646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kACIP7GDh0+h4vv2zlCPYJD3hmqzFL0/Lj7oS/N2oGE=;
	b=AO3rSRIqwJpsNYi9SMJaiXlmeB7SHtZDyaX11rnNUqeNzOPxE0NvoC3G1+uUtfqlSVUv6l
	fZsbir2a3+cyUd73EiOd9d9LFhMFMLhintYWAZp8qjeoGx3EcyWqXK1ZfmADiW/wxhLvrn
	fdVAze+n1uxqKK6OV2yxCJbk6nc+sTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-MMlwinTBOHyBxE8KK-DDjQ-1; Mon, 06 Nov 2023 09:40:43 -0500
X-MC-Unique: MMlwinTBOHyBxE8KK-DDjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CC95101AA44;
	Mon,  6 Nov 2023 14:40:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECFE2026D66;
	Mon,  6 Nov 2023 14:40:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>
References: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net> <20231027-vfs-autofs-018bbf11ed67@brauner> <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net> <ZT+9kixqhgsRKlav@redhat.com> <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
To: Ian Kent <raven@themaw.net>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [GIT PULL for v6.7] autofs updates
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610870.1699281640.1@warthog.procyon.org.uk>
Date: Mon, 06 Nov 2023 14:40:40 +0000
Message-ID: <2610871.1699281640@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Ian Kent <raven@themaw.net> wrote:

> David, are you ok with me resurrecting your conversion patch and posting it
> on your behalf?

Yes, that's fine.

David


