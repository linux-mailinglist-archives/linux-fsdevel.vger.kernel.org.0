Return-Path: <linux-fsdevel+bounces-57375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E246B20D13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53A43B628A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7462DECA5;
	Mon, 11 Aug 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDoBwKKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE041B041A;
	Mon, 11 Aug 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924748; cv=none; b=K/JSuhBFysyMinjn7svvbO/U2Ep8F6yTI5JiCP5Axb7G5Q+xQtxSJ+jpDDaESvSczbypiXZ2tfC3yQv377uVTd49yYU+XsBM+AVl5hkmEcmze5kU00KX9Yumv2c0jv7uuVEgIe9VjfT43J1L3LJQIvBtaiENiNeBiveCH7FtT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924748; c=relaxed/simple;
	bh=i/ALEUiI1jcKPez1nkMbsZV3bmmUIaCULP31iZ/ovAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSJC7F2h5/kNTDLqKBEsqMd6+19LLTS3sQTEIZNCU+6R+TJb5pu8KlRK8d6rv1PXzJYq6hh8+q6fl6FKpR54mFrtL5GAZE+4LRjYArz9RRxY5cSm+7wg66tbkgz/LIkMEZdpKouaQG2+/OkPlVxVTZZqdwOMbeHmlqdpbU4sbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDoBwKKF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754924744; x=1786460744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/ALEUiI1jcKPez1nkMbsZV3bmmUIaCULP31iZ/ovAw=;
  b=eDoBwKKFTOUnjUhPoxEG7MQKe0xagBusWNZY1RVcsffuhRVRsWANru5E
   N/LypkBnwCODWzQ7uIumVwB3oIQviYxjLZhOef6i0YmP4siCDOsRXIXMJ
   gIfZaS8ZzG7XQj50nc2/jGzi+bLgaLeqwvArTU1fxwmd4ytN48Y8me9Hl
   xYTMbE65VKZi88cMLuOyLnk2YuUG0+j1zri3IIVXfI1b3ruy1Xg693Um1
   1RxYacXyVOaiM3ZrJTt9u5KOfenF21N8+h+8O5paAtoqGO6kiDllMPMHz
   tEs0QpJk9ujC0BJLfZKKGpGdjl4BVlX3/4DVA0df89VrnY1LmA5+qARGx
   w==;
X-CSE-ConnectionGUID: ztqBbe78TYqntgBlkG12bA==
X-CSE-MsgGUID: 1g6tCo+aTNiKPveI7kHbsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56208639"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56208639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:05:43 -0700
X-CSE-ConnectionGUID: nOIz8zmnS3q0/SNtukrWfQ==
X-CSE-MsgGUID: jQdLgscnT9ud1YMXf+61aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165571264"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 11 Aug 2025 08:05:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CAC0494; Mon, 11 Aug 2025 17:05:34 +0200 (CEST)
Date: Mon, 11 Aug 2025 17:05:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org, kees@kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Message-ID: <aJoGvv5TEfl1liSm@black.igk.intel.com>
References: <20250811064609.918593-1-bhupesh@igalia.com>
 <20250811064609.918593-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811064609.918593-4-bhupesh@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 11, 2025 at 12:16:08PM +0530, Bhupesh wrote:
> As Linus mentioned in [1], we should get rid of 'get_task_comm()'
> entirely and replace it with 'strscpy_pad()' implementation.
> 
> 'strscpy_pad()' will already make sure comm is NUL-terminated, so
> we won't need the explicit final byte termination done in
> 'get_task_comm()'.
> 
> The relevant 'get_task_comm()' users were identified using the
> following search pattern:
>  $ git grep 'get_task_comm*'

> [1]. https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>

Make that a Link tag?

  Link: https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/ #1
  Signed-off-by: Bhupesh <bhupesh@igalia.com>

-- 
With Best Regards,
Andy Shevchenko



