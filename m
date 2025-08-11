Return-Path: <linux-fsdevel+bounces-57377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41258B20D26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFAD1907773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CB8243968;
	Mon, 11 Aug 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSkIOWZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF026A8D2;
	Mon, 11 Aug 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924943; cv=none; b=WCcctqupjB2Xt+G3+nGLzN7AgeckrsE/iOGWC/rJ1GAtC7YB9WWNDRT6wzPQlWUdsjTxVA8cFwg7KkGuLC9JreQ9vQ2E9MXy+nqG42svSykZ4Snz3dBc27pZ/mXo1tI+0YfbOLm5NDkIDg3+sqhoJsT6goQuJ/eCGiB6CvVVGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924943; c=relaxed/simple;
	bh=Fos2Bc+psd2wDnxAA9C+5WvzOAyECbjI1HOkUcLQeFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7KN4WeZeXrrIxXZZZU3dkcur+XdhmMGW4fTXvZinh+BgIwsfXXEpY4g3f1KXyivf9bu2PClEJQNVK9/fl4Oj45SFGE+nPc3u25g/7nElTRGS91O/zFkwKFLjrtPnLfETOBRK7ALtfUNn3ptUgsFTKsAgxiGaaQWYY+y97Goqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSkIOWZQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754924942; x=1786460942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fos2Bc+psd2wDnxAA9C+5WvzOAyECbjI1HOkUcLQeFQ=;
  b=OSkIOWZQdF4WtXR4yJZiaP3h23HctK9rnOKF1o7Qb3VJCkjDNp/sVvlh
   0/5dws5yWSHVGIlTmDvk9g+G0tIVp0+7DW8vhnG1euLCaeveL/HavAhA5
   rAWmFjC/varyuoQ+1WIuxEw2pZKeeQZXWOKVjkULo5DoNDAgjEJyjLcwW
   1f56TEmT8wZ1OGAhBYt2i4sfmimZDpjKGT+KqDXv3Wn2rICJZyJj8XOJq
   UMKkIWh3SzlN3plekBzSoBNO9L3BgnG+s0jr4Xc6F/ElYXZXbHEfPltiW
   bykYBad6lQosEIFYLL0+hazpPvwJcBqzsVVVn3Z3evaFfs0qezrr0hLuI
   w==;
X-CSE-ConnectionGUID: mSaDRsO4SlSBuZuzlSp5ig==
X-CSE-MsgGUID: 7HHEZe00QPukYZVI0tIWUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56209114"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56209114"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:09:01 -0700
X-CSE-ConnectionGUID: 6HXLT3G1QeCd5htSdOz7vw==
X-CSE-MsgGUID: viOw19WfRZm7kbZL2ZA/7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165831059"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2025 08:08:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D6F1B94; Mon, 11 Aug 2025 17:08:52 +0200 (CEST)
Date: Mon, 11 Aug 2025 17:08:52 +0200
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
Subject: Re: [PATCH v7 4/4] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <aJoHhDIL6T0Zo-nB@black.igk.intel.com>
References: <20250811064609.918593-1-bhupesh@igalia.com>
 <20250811064609.918593-5-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811064609.918593-5-bhupesh@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 11, 2025 at 12:16:09PM +0530, Bhupesh wrote:
> As Linus mentioned in [1], currently we have several memcpy() use-cases
> which use 'current->comm' to copy the task name over to local copies.
> For an example:
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  ...
> 
> These should be rather calling a wrappper like "get_task_array()",
> which is implemented as:
> 
>    static __always_inline void
>        __cstr_array_copy(char *dst,
>             const char *src, __kernel_size_t size)
>    {
>         memcpy(dst, src, size);
>         dst[size] = 0;
>    }
> 
>    #define get_task_array(dst,src) \
>       __cstr_array_copy(dst, src, __must_be_array(dst))
> 
> The relevant 'memcpy()' users were identified using the following search
> pattern:
>  $ git grep 'memcpy.*->comm\>'

> [1]. https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>

Same suggestion, make it a Link tag.

-- 
With Best Regards,
Andy Shevchenko



