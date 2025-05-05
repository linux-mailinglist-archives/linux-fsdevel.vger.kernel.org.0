Return-Path: <linux-fsdevel+bounces-48132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E2AA9E2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B473C3A5BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620181C861B;
	Mon,  5 May 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dbUOX+p/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFD16D9C2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480634; cv=none; b=acx1zR4u3N+g9dYN6s5PLZ35hsbGkx/evPrc5CT1k6AGYhhiN01nxTSOpdjr8gdkn0k6q7uG8qttbREIkMXybqicmh1Aqks/Kf/y+EMqK9DlsTeaIu9iMM/RF6LxDmVff5gJ1LpdD1bytuXuNJBWjJRFmoF4laowIRMaEIFlXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480634; c=relaxed/simple;
	bh=IK064DxGL6rd2AXReFr8WLkQruOrkwYNSi+SXBiuUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBmtffoWqAMZib/Gtwy3CHxLTTemgxFUKK0CrXsZQznSA9kaJbUJKOwvUe1qAG/OYEkZ/KIr5vSuTRhWLnejYKH4ouw6AdafIupX/HT+6+zzHc1Y82t2AfI5GXmQsX5+2qo+w+xx2Lk47oHBPTo4d0bJphXN809+880Bj/KDgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dbUOX+p/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 14:30:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746480629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4siW68oDPSIdvipM3gqfjnaQhK22j3W7xRxbXDcucJ0=;
	b=dbUOX+p/WAESDrw8cbIJP2Y64eqW+Hr9gR8/bt/Boxi8WEj/t+D+2V70gZV+YD5owGLCSh
	zj3jVcQGXp+ShoQPg5ujhWsAGJrKWxnoS+P6Qcn0iPjvxt7jQgoDEHUynudXexBbNXh5vF
	ytdXmBB/GN+oSTiX9gl/cnTMEPlHZh4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, david@redhat.com, 
	linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 0/9] support ksm_stat showing at cgroup level
Message-ID: <ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5>
References: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
X-Migadu-Flow: FLOW_OUT

On Thu, May 01, 2025 at 12:08:54PM +0800, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related
> metrics.
> 
> This patch introduces a new interface named ksm_stat
> at the cgroup hierarchy level, enabling users to monitor KSM merging
> statistics specifically for containers where this feature has been
> activated, eliminating the need to manually inspect KSM information for
> each individual process within the cgroup.
> 
> Users can obtain the KSM information of a cgroup just by:
> 
> # cat /sys/fs/cgroup/memory.ksm_stat
> ksm_rmap_items 76800
> ksm_zero_pages 0
> ksm_merging_pages 76800
> ksm_process_profit 309657600
> 
> Current implementation supports both cgroup v2 and cgroup v1.
> 

Before adding these stats to memcg, add global stats for them in
enum node_stat_item and then you can expose them in memcg through
memory.stat instead of a new interface.


