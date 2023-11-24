Return-Path: <linux-fsdevel+bounces-3680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478067F77E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27DF1F20F4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7112EAED;
	Fri, 24 Nov 2023 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSl3JGGC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1219D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700840024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LbHOKemj3x3i/RRfgL4O8FQ7JtEapB4R9zBWaNJlTbY=;
	b=JSl3JGGCDSSIA6Hj6ZFsjULyHEV7lT7GSPK472O45rEsczZGKFE/h4uJLf/F9WIiWuvZ66
	7MCJ24h8Rh8jDpymjhiku6lAs9Oj521n/DR/FAK6433RZC5HJncn5PEOJwZVdPW4C7gdx1
	HYvfv08UUA24b4KH1hVzQsfvnEkPX5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-oiTfhCSzPOGE4YlKer0wwg-1; Fri, 24 Nov 2023 10:33:43 -0500
X-MC-Unique: oiTfhCSzPOGE4YlKer0wwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEF7B811E7E;
	Fri, 24 Nov 2023 15:33:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CEC1B2166B26;
	Fri, 24 Nov 2023 15:33:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: dhowells@redhat.com, linux-cachefs@redhat.com,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
    hsiangkao@linux.alibaba.com
Subject: Re: [PATCH V6 RESEND 0/5] cachefiles: Introduce failover mechanism for on-demand mode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1172305.1700840020.1@warthog.procyon.org.uk>
Date: Fri, 24 Nov 2023 15:33:40 +0000
Message-ID: <1172306.1700840020@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Reviewed-by: David Howells <dhowells@redhat.com>


