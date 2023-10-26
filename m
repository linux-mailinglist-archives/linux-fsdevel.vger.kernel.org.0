Return-Path: <linux-fsdevel+bounces-1250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD3A7D857D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094152820E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257992F501;
	Thu, 26 Oct 2023 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYJU0CVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACA1D52B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:04:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E21A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698332683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xcgpm5FyjFqTemGBTnIPqZ37PcnGyir9Nrd1x+JqZkw=;
	b=eYJU0CVXfICQojF3esAMdQfMpf5hlK6tmlmJ0dtZgqVbflL+osot2bbnY9fpY0AR0E2nwj
	IEv/yLYNDY1Tj+9VKqK5Z6LbmqlJSub50J6HmDO6NaFQ7p9wr44iID86lefIyZ/1GGC0iH
	YGl+2TtUpZSidp+oXQxaRk1bh2zmS9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-ncRMg-7YOae_cswAK-0W3w-1; Thu, 26 Oct 2023 11:04:39 -0400
X-MC-Unique: ncRMg-7YOae_cswAK-0W3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D055101A529;
	Thu, 26 Oct 2023 15:04:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id CD5D21C060AE;
	Thu, 26 Oct 2023 15:04:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 26 Oct 2023 17:03:37 +0200 (CEST)
Date: Thu, 26 Oct 2023 17:03:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fs: Remove unneeded semicolon
Message-ID: <20231026150334.GA13945@redhat.com>
References: <20231026005634.6581-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026005634.6581-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 10/26, Yang Li wrote:
>
> @@ -3826,7 +3826,7 @@ static struct task_struct *first_tid(struct pid *pid, int tid, loff_t f_pos,
>  	for_each_thread(task, pos) {
>  		if (!nr--)
>  			goto found;
> -	};
> +	}

Ah, I forgot to remove this semicolon :/

This is on top of

	document-while_each_thread-change-first_tid-to-use-for_each_thread.patch

perhaps this cleanup can be folded into the patch above along with Yang's sob ?

If Yang doesn't object.

Oleg.


