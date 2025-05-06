Return-Path: <linux-fsdevel+bounces-48172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EADAABA8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083117AE9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6B288C26;
	Tue,  6 May 2025 05:09:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D81A0B08;
	Tue,  6 May 2025 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508184; cv=none; b=XSVUjK+0vtkvJgux5E1cE0uktBJC2XYPVoyZsSU+qpR24pscvZPbQdSn1bCe8Fi8pPn7xmWAa5F4fgMPRcOiAv7VHeDADYnuizeQGKazEvJswAdStrJoy+EP8C0e4Tm8gsZW+7NarqBX4BO+ChLQoR/NYHQqDAM8caZUO+gklLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508184; c=relaxed/simple;
	bh=Iy/AZKcSHU+KhWBWnvXil0TW7vTOtLm5IboPLW2DxdU=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=YGEMi4/TJN+T8wTKFJy8KmkIuCwHjzjtOFwHWV1j0VmOfUDNgA3A70NwTObPnT2bXH7CKfRcrd3hastwISUvv/hDN/2oUYrCZCNpyoDGMWfA1Fx6UQS4aVZBqeNbXEsc2kUTlvhDAtG3ARX5sYXcitRr3X0yNcxifc+FOzHfcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Zs5zX2C74z4x5rs;
	Tue,  6 May 2025 13:09:28 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 54659NaT042159;
	Tue, 6 May 2025 13:09:23 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 6 May 2025 13:09:25 +0800 (CST)
Date: Tue, 6 May 2025 13:09:25 +0800 (CST)
X-Zmail-TransId: 2afb68199985284-2afe3
X-Mailer: Zmail v1.0
Message-ID: <20250506130925568unpXQ7vLOEaRX4iDWSow2@zte.com.cn>
In-Reply-To: <ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5>
References: 20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn,ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5
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
X-MAIL:mse-fl1.zte.com.cn 54659NaT042159
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68199988.000/4Zs5zX2C74z4x5rs

> > Users can obtain the KSM information of a cgroup just by:
> > 
> > # cat /sys/fs/cgroup/memory.ksm_stat
> > ksm_rmap_items 76800
> > ksm_zero_pages 0
> > ksm_merging_pages 76800
> > ksm_process_profit 309657600
> > 
> > Current implementation supports both cgroup v2 and cgroup v1.
> > 
> 
> Before adding these stats to memcg, add global stats for them in
> enum node_stat_item and then you can expose them in memcg through
> memory.stat instead of a new interface.

Dear shakeel.butt,

If adding these ksm-related items to enum node_stat_item and bringing extra counters-updating
code like __lruvec_stat_add_folio()... embedded into KSM procudure, it increases extra
CPU-consuming while normal KSM procedures happen. Or, we can just traversal all processes of
this memcg and sum their ksm'counters like the current patche set implmentation.

If only including a single "KSM merged pages" entry in memory.stat, I think it is reasonable as
it reflects this memcg's KSM page count. However, adding the other three KSM-related metrics is
less advisable since they are strongly coupled with KSM internals and would primarily interest
users monitoring KSM-specific behavior.

Last but not least, the rationale for adding a ksm_stat entry to memcg also lies in maintaining
structural consistency with the existing /proc/<pid>/ksm_stat interface.

