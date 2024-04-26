Return-Path: <linux-fsdevel+bounces-17921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BF8B3CA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09050B27C0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426115623A;
	Fri, 26 Apr 2024 16:18:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFE153821
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148301; cv=none; b=iXS6IfZKVlT44Lcvp4s/HhWNvqZ5BnBooifF+FAChbmZ8yzVd3o3x74Rg4ljebPzhgQ2NjoBYroSmO8l3RiCF/bf6wyLHYjedPP0n5ZrzUA7iM/6UUqriYAERB4kQerjGyn97nl4ocZsjZACF0sdZyF2J/MgZ5L+UBK8I3SzQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148301; c=relaxed/simple;
	bh=E13vkk8Wylxtrx2GZMlWBZpdQJkZYRqSZzekhA1a5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hO6kXZT0gBn3+n8RS5Woh154kN2yfa7LY3nERB5TBXEOeK3iaxrU9yJOQh64L5gtsX4yjdlq3nrbjsczdrTe/G/jsM0EAGmf5H8lfSsv10cEbcK36wgluqfOoUEWt866I0dH5c8b2rsxhtZNXeD2B4RrujgKLGACuUExv/jGbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a524ecaf215so299015866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 09:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148295; x=1714753095;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vRPQ007+0Ug0wf3jA0wyyrp5RmZwKhgbSR1V0jprYM=;
        b=dtGvtDbFA06705x/J2w69wM0BHJ+QG55EDybrXPTZ76yQUx6YYNO4x8GD8HsL43QET
         YnYGASPQNH6abeZb405JsmUR6uHYfS+Cg2on9TRPmQKo/23R5WZnTO8Eyim7h8IvkJK7
         zV+xRwCc3tTuXkcnykfEuoRI1r6YzX6EMChdjbq+5LcMCcFKaQhLYFJHbNUDUo9u5tmK
         TGKZ4MCsH8RK2M9LIxE02tNxImp6xpYihnUb5HbOfKjf6h3u0fhm2A9JX9mLt0KFMzKA
         e6VbCseb3a4Xbkp+dRXXxtiVR3yA6s7eHmRPZB9ZJr7gfboKDGuxdaYViY+583NQFWwB
         9NPg==
X-Gm-Message-State: AOJu0Yzy46YweWeYEDYRgGVSK4CeMRwE6bJul4IuFKt0G1HxDBqrqYoT
	32FFwEmor3R/rF8T9OUHGOPOD+B1ACTmGLMqBJLAD9oiU5ejg1o6SQ6T6g==
X-Google-Smtp-Source: AGHT+IF25EE8Etv03VH763SPZ6VaESRPcIP3f9vAlqzlZU6CFlqX++J6T9BnWLYwo06Jdinacphodg==
X-Received: by 2002:a17:906:3102:b0:a52:42ce:7da6 with SMTP id 2-20020a170906310200b00a5242ce7da6mr2280036ejx.10.1714148294513;
        Fri, 26 Apr 2024 09:18:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id bt15-20020a170906b14f00b00a51eed4f0d7sm10774020ejb.130.2024.04.26.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:18:14 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:17:17 -0700
From: Breno Leitao <leitao@debian.org>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: KCSAN in fuse (fuse_request_end <-> fuse_request_end)
Message-ID: <ZivTjbq+bLypnkPc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am running Linus' upstream kernel[1] with KCSAN enabled, and KCSAN
complains about a possible data race condition in fuse.

	BUG: KCSAN: data-race in fuse_readahead [fuse] / fuse_request_end [fuse]

	read-write to 0xffff8883a6666598 of 4 bytes by task 113809 on cpu 39:
	fuse_request_end (fs/fuse/dev.c:318) fuse
	fuse_dev_do_write (fs/fuse/dev.c:?) fuse
	fuse_dev_write (fs/fuse/dev.c:?) fuse
	do_iter_readv_writev (fs/read_write.c:742)
	vfs_writev (fs/read_write.c:971)
	do_writev (fs/read_write.c:1018)
	__x64_sys_writev (fs/read_write.c:1088)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	read to 0xffff8883a6666598 of 4 bytes by task 113787 on cpu 8:
	fuse_readahead (fs/fuse/file.c:1005) fuse
	read_pages (mm/readahead.c:166)
	page_cache_ra_unbounded (mm/readahead.c:?)
	page_cache_ra_order (mm/readahead.c:540)
	ondemand_readahead (mm/readahead.c:662)
	page_cache_sync_ra (mm/readahead.c:689)
	filemap_get_pages (mm/filemap.c:2507)
	filemap_read (mm/filemap.c:2601)
	generic_file_read_iter (mm/filemap.c:?)
	fuse_file_read_iter (fs/fuse/file.c:? fs/fuse/file.c:1709) fuse
	vfs_read (fs/read_write.c:396 fs/read_write.c:476)

	value changed: 0x00000001 -> 0x00000000

Looking at the code, this happens when two parallel data pathes touch
fuse_conn->num_background potentially at the same time.

fuse_request_end() reads and writes to ->num_background while holding
the bg_lock, but fuse_readahead() does not hold any lock before reading
->num_background.  That is what KCSAN seems to be complaining about. 

Should we get ->bg_lock before reading ->num_background?

Thanks!

[1] 13a2e429f644 ("Merge tag 'perf-tools-fixes-for-v6.9-2024-04-19' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")

