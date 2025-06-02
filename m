Return-Path: <linux-fsdevel+bounces-50359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF66ACB251
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0713B9F67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184D226D09;
	Mon,  2 Jun 2025 14:15:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5A21885A;
	Mon,  2 Jun 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873716; cv=none; b=gzc03wcbOV+2wNKdAbEw+/sNaXvHod4/Rq/R2luqx7xAMG1vOotd1ADVndHdcTXcq9I7c7hSrr1zd4ifJ32xhxPa71pqEJqWhQ4jdQOFHY3796p8UK7a/Xzo/FlUfZxMWQswvOVGkbItBLsOMrQIan1NFU5+4vHoXldMU3rD5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873716; c=relaxed/simple;
	bh=8N90mTDB8S3ifT3mxaQLdxFpLDUjMDwWxA6UqhG9Bg0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=t0/7iJjVIJkNPPlELqomTZSbZalGUidRuBVLf34oanyAlblJ+INVri8UqWjTOhyultpoMify9/oiU6T/H06uDeHcWFNI9viIG2y1pqfgQ9nKo5VyL3tjqSc/88jYZLP6NSpWuSS3MEQw0Tg/BXBD8V8CYBcvry3cB83ycueyw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b9wpT574Dz52SGw;
	Mon,  2 Jun 2025 22:14:57 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 552EEsEb075609;
	Mon, 2 Jun 2025 22:14:54 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Jun 2025 22:14:58 +0800 (CST)
Date: Mon, 2 Jun 2025 22:14:58 +0800 (CST)
X-Zmail-TransId: 2af9683db1e25dc-fe1e1
X-Mailer: Zmail v1.0
Message-ID: <20250602221458798de-eCxDE3QgOIkg0WG1nB@zte.com.cn>
In-Reply-To: <t7q2d73nxdd75sghobnpmzi7bsbvden6lbrtejkxyoqfl2xilv@4ewvm2od2sf3>
References: ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5,20250506130925568unpXQ7vLOEaRX4iDWSow2@zte.com.cn,t7q2d73nxdd75sghobnpmzi7bsbvden6lbrtejkxyoqfl2xilv@4ewvm2od2sf3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <shakeel.butt@linux.dev>
Cc: <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <wang.yaxin@zte.com.cn>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAwLzldIHN1cHBvcnQga3NtX3N0YXQgc2hvd2luZyBhdCBjZ3JvdXAgbGV2ZWw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 552EEsEb075609
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 683DB1E1.001/4b9wpT574Dz52SGw

> > > > Users can obtain the KSM information of a cgroup just by:
> > > > 
> > > > # cat /sys/fs/cgroup/memory.ksm_stat
> > > > ksm_rmap_items 76800
> > > > ksm_zero_pages 0
> > > > ksm_merging_pages 76800
> > > > ksm_process_profit 309657600
> > > > 
> > > > Current implementation supports both cgroup v2 and cgroup v1.
> > > > 
> > > 
> > > Before adding these stats to memcg, add global stats for them in
> > > enum node_stat_item and then you can expose them in memcg through
> > > memory.stat instead of a new interface.
> > 
> > Dear shakeel.butt,
> > 
> > If adding these ksm-related items to enum node_stat_item and bringing extra counters-updating
> > code like __lruvec_stat_add_folio()... embedded into KSM procudure, it increases extra
> > CPU-consuming while normal KSM procedures happen.
> 
> How is it more expensive than traversing all processes?
> __lruvec_stat_add_folio() and related functions are already called in many
> performance critical code paths, so I don't see any issue to call in the
> ksm.
> 
> > Or, we can just traversal all processes of
> > this memcg and sum their ksm'counters like the current patche set implmentation.
> > 
> > If only including a single "KSM merged pages" entry in memory.stat, I think it is reasonable as
> > it reflects this memcg's KSM page count. However, adding the other three KSM-related metrics is
> > less advisable since they are strongly coupled with KSM internals and would primarily interest
> > users monitoring KSM-specific behavior.
> 
> We can discuss and decide each individual ksm stat if it makes sense to
> added to memcg or not.
> 
> > 
> > Last but not least, the rationale for adding a ksm_stat entry to memcg also lies in maintaining
> > structural consistency with the existing /proc/<pid>/ksm_stat interface.
> 
> Sorry, I don't agree with this rationale. This is a separate interface
> and can be different from exisiting ksm interface. We can define however
> we think is right way to do for memcg and yes there can be stats overlap
> with older interface.
> 
> For now I would say start with the ksm metrics that are appropriate to
> be exposed globally and then we can see if those are fine for memcg as
> well.

Thank you very much for your suggestion, and I'm sorry for the delayed reply
as last month I was exceptionally busy. 

Upon further consideration, I agree that adding entries to the existing memory.stat
interface is indeed preferable to arbitrarily creating new interfaces.  Therefore, my
next step is to plan adding the following global KSM metrics to memory.stat,  such as
ksm_merged, ksm_unmergable, ksm_zero, and ksm_profit. (These represent the
total amount of merged pages, unmergable pages, zero pages merged by KSM, and
the overall profit, respectively.) However, please note that ksm_merging_pages and
ksm_unshared need to be converted to be represented in bytes.”

