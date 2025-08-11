Return-Path: <linux-fsdevel+bounces-57378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82873B20D32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD57A188400E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B62DFA3B;
	Mon, 11 Aug 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lubqyM0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A32DECA1;
	Mon, 11 Aug 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925016; cv=none; b=Jf4XLMLCLk7lG9rPrTjDR3x/lOciNhmYCz6HExoWa96T6gqz5DOE323fLwnNIDKzsP2FTVAN6IBGHTxKAbR53HelJnzAYtK7z1LwlJyIrldhePtQFza5tdbsxVjQAdy6nzCFB2lOMLRDAc9weqzdmdmEo+ZcK1eyC/UGggGeQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925016; c=relaxed/simple;
	bh=5zT1AiufQmdFoxK3k4uUGhgeuApkAvlocyRFSIML/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBtbenPHhK8GaCMytd7Xhrme3iEf6KPxacF/2PR0vcWwSPpPNkQVCliMPjRqUZTWDJW7OoTJPJMc345OM3//VcPv5/XQldVde30FncqGlpZRwWgOT3L6KgXTkoJt7BG3wfAYUyQiBGwTelHjDQGqP91lfPgm0ewgWLQbghdtKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lubqyM0K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754925014; x=1786461014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5zT1AiufQmdFoxK3k4uUGhgeuApkAvlocyRFSIML/z4=;
  b=lubqyM0KlyyjmZVNC30EW66JOTrX7NyvDT+kb0ECsynZxrEZ7DicDVP3
   K8PzZD4UPJMyi4oUFnjvt1Not0/4+oZPksjcn2CZ1yQFhS5F9JrQ2F6cC
   iV/h/lwTwWtnU5fFb4sQWwYaQ9ThYMAQy7A0G6gNYROTH8MLUsnAodF4d
   IHGjzQdejyuhbINvfKz8n9MULGX3ddRE7KasFCdhG1TlboCxqSepp7Tab
   tNrep54xj/48c4BkL66xNOoIsessnt37Pu5S/3RuUC5/xjYz213Gd0d9t
   /NHPwLqX7vsSLSzgMbwe2RAOl7HrwL8RG7fBIFfFOZzVOryRDgIG0HuQf
   g==;
X-CSE-ConnectionGUID: izh6LzfZTVikTHurpwkHAw==
X-CSE-MsgGUID: y/sdhqaMSFy62tOumpV65g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="79750521"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="79750521"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:10:14 -0700
X-CSE-ConnectionGUID: e80qHBrnQ3+4tIioB2Gvuw==
X-CSE-MsgGUID: gQ9FGlJyQies9g8Zki86eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171290349"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 11 Aug 2025 08:10:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7E14494; Mon, 11 Aug 2025 17:10:05 +0200 (CEST)
Date: Mon, 11 Aug 2025 17:10:05 +0200
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
Subject: Re: [PATCH v7 2/4] include: Set tsk->comm length to 64 bytes
Message-ID: <aJoHzTKO9xw2CANn@black.igk.intel.com>
References: <20250811064609.918593-1-bhupesh@igalia.com>
 <20250811064609.918593-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811064609.918593-3-bhupesh@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 11, 2025 at 12:16:07PM +0530, Bhupesh wrote:
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> 
> To fix the same, we now use a 64-byte TASK_COMM_EXT_LEN and
> set the comm element inside 'task_struct' to the same length:
>        struct task_struct {
> 	       .....
>                char    comm[TASK_COMM_EXT_LEN];
> 	       .....
>        };
> 
>        where TASK_COMM_EXT_LEN is 64-bytes.
> 
> Note, that the existing users have not been modified to migrate to
> 'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
> dealing with only a 'TASK_COMM_LEN' long 'tsk->comm'.

...

> -	BUILD_BUG_ON(sizeof(from) != TASK_COMM_LEN);	\
> +	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\

Wondering if we may convert this to static_assert().
(rather in a separate patch)

-- 
With Best Regards,
Andy Shevchenko



