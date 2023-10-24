Return-Path: <linux-fsdevel+bounces-1112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DC17D5857
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22186B20D29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0B3A269;
	Tue, 24 Oct 2023 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOlUJtAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85C3A262;
	Tue, 24 Oct 2023 16:29:45 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189FAF;
	Tue, 24 Oct 2023 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G1sGCpTPpRYH405Dgwk8POGwifgPfOBE6A+Qe0PTDec=; b=IOlUJtAJ09C7MZ/SDOOBwO4TMZ
	DucMW7t6CRgCvBKWdz4gT0wgX9FudlG5ubBzB4fBzk5yKbyQkZn/5vAetcPopbm1nG9pz3B5pq92J
	/dlE+IIdOHvrLJ1Fr3mL2qZRm7eIlesLo/JMq8sbOwGc3DQtSI9IcSaW+Zi+1SgBw5QHU+zfyfatW
	ehw9AeZRM4q+6TvBuy01/9RS0ANCaFH9i9WtKpDpZfBNG3MZHRYkJzYq1+UUzuvnbqRtaFdeEdgg4
	7C2xBkTKAJ0+1yc4wDFquGcCisdrSx3lqrngxha26jYdXw57e6z3jSvfnsUgAqytBdMfNpbVPgW3g
	z55O1/VA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvKHG-003V45-PV; Tue, 24 Oct 2023 16:29:10 +0000
Date: Tue, 24 Oct 2023 17:29:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
	brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
	mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
	npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
	mst@redhat.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <ZTfw1nw15wijNnCB@casper.infradead.org>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
 <20231024083258.65750-4-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083258.65750-4-zhangpeng.00@bytedance.com>

On Tue, Oct 24, 2023 at 04:32:51PM +0800, Peng Zhang wrote:
> +++ b/lib/maple_tree.c
> @@ -4,6 +4,10 @@
>   * Copyright (c) 2018-2022 Oracle Corporation
>   * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>   *	    Matthew Wilcox <willy@infradead.org>
> + *
> + * Implementation of algorithm for duplicating Maple Tree

I thought you agreed that line made no sense, and you were just going to
drop it?  just add your copyright, right under ours.

> + * Copyright (c) 2023 ByteDance
> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>

