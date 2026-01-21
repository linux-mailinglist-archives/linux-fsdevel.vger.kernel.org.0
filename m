Return-Path: <linux-fsdevel+bounces-74770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLHgJ8E+cGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:49:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEAC50064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6370E967E03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D72900A8;
	Wed, 21 Jan 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgPsiK9D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E5343D98
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963478; cv=none; b=o96ytT8t7V2CxQAOdiKP1g+Jok9sBv55+8ZSKEm2QKkPYMWl7paHmqwqNphaEzjsiFwLW26z07cUgnmQQ74INlWeKeWB5yO36vN7ukitBdhz61LxhrzM4I10Kkxncg4wfxOMAUxd+dhk8nWYMjpRXcVh+KiBePHlCFkuY9ys4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963478; c=relaxed/simple;
	bh=7FsvJSNwl9vQqM3jvZJfFGYx3+rBZcB6E7E7CwgTXz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUhL68TLmkHFj0MJkzYKQLI6BOjSxkw2/NnarVb3H/fpPdUC/z3KS7zbCaErHJujiECLKJwiUSdD8cCRHu3dxg5psA3boZdznDUvdYnbsl0QZBWfzQV/HPipNe3TDEH9U9fXp4FS7zwfzpHfew9w3VIh34WVvqmXHOORqzQUWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgPsiK9D; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34b75fba315so3025865a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 18:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768963476; x=1769568276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10L6Vo5U3X0GbtQ/DFHIFQGtYREEbj8suGJdhOatTic=;
        b=jgPsiK9DT230maut87hfht2Cl0qK0LsevqPCrA/vwRf+Cm4SkQNdzmB4xCfc2yQPjw
         n/4yoageno6/l2zZ9Ms+95bihPaObBjkUbR8d7kbX2fENEJRwiT9RMeEt3YZKconKq/h
         6LrJl+jtI5a1QLEe9iF2vSg+vPUlPtX0ACKeXDF7+s4NAVbN/1T7Bn3QgRH0Jvo4y062
         Fc/phhVlKkXBfQHIRCDbbkanaJJ0VyV+7FStrLjIDz89iO3uqwcc7j7inH6iNLKGZotG
         45AUasMG/zUWpBiyQWp2NI4BAuyI+Q/+D/sqIXSYFa0yhhYmolZmnSIY1IJQpiQ/43Lr
         wWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768963476; x=1769568276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10L6Vo5U3X0GbtQ/DFHIFQGtYREEbj8suGJdhOatTic=;
        b=m78SZBdhLXGexHlEdiVpZbN/IZbCW4XVARdEPGy9921HuGYCqdaSxWQGatZAcoUz9G
         LIwSlaJO1O6ZCo7yHPrh4S4UQyOMY5n8Wdk1tQvlXaQ4KybRhv5EwhUdKzVV5mlR3Fo9
         WmECHGqNn0oqAIzKUv264lwk/MNKaD6v1ZOfmQTzadXcQouXnsqo7v6P7suNMatmNygq
         JNSEAhs9y1T8KLRl9eji/tuNY+ZBTZ5FaHeA0dUNkFALDcSfnBv4EzR9HvvDGtKvxNUE
         bEouUV7dX4WMMxyiXIENLOMwx9FHvECIwhuYBYt5yOSdt763pP9FxSUPTCbinxuQRjfR
         orxg==
X-Forwarded-Encrypted: i=1; AJvYcCVM4bCYzgs1268KBk32zM90h1p4vfXXVkTHo2sjbkPo76FQadGwKxmN4PFMh6d+w+ZHgDCkoJijz/3acbHz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+odlgdVPYA2wLt7/GE7Jlr9Yv8dtU3JYxmsPvw7krlcBNBllm
	mW26FwsXvYB0uXNMB/4NIze54zcj+N7XBhCdg5v8Dp+xCjEAnVRXQCon
X-Gm-Gg: AZuq6aKXAIDtsjqJzZbI5Xv2VF2U2x3lkBrHhqn3S8PAGmSrUrN43THjYvpTLDs61ti
	kG0ewJPgCelrOmX00Qy4VbOKcU1U8IGwO/F5DqL61suYeJEkj8S7XRAVCTudydm8NRh5hU2iv94
	gMXLahGZBh8wWFdRyFl5JH/o2FGSoq+JajUVK054yJ53kX7ry7A/Pe7rTqnKPArUMq7om2aoxLR
	7tBEc7uEtjhA68VrkY3y5pNFU7IHqGPHEn1Ydnfv0njO7O9k6+UViQkZvTRSHot7DI25F0jkLKN
	mwLBMGWwK/Oykaf3SmHaLE4fteAd/mE8MfcFdFtdanitupNPnR3RkaIfsGYJBcNT/kxHHiJKhda
	LITQJSl5rV7tLS9rfWwkoz4Njuy113zM8ztdhtMNtFfMJaGXpmZHRI4fW13lAxnRfHBKr62kAT9
	l3
X-Received: by 2002:a17:90b:3148:b0:34d:1d54:8bcf with SMTP id 98e67ed59e1d1-35272f025e0mr14314669a91.9.1768963475722;
        Tue, 20 Jan 2026 18:44:35 -0800 (PST)
Received: from localhost ([2a12:a305:4::4074])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527313c2a9sm13354589a91.17.2026.01.20.18.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 18:44:35 -0800 (PST)
Date: Wed, 21 Jan 2026 10:44:31 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com" <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
Message-ID: <aXA9j9oQLHAHPP46@ndev>
References: <20260113081952.2431735-1-wangjinchao600@gmail.com>
 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
 <aWcHhTiUrDppotRg@ndev>
 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
 <aWhgNujuXujxSg3E@ndev>
 <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>
 <aWnybRfDcsUAtsol@ndev>
 <0349430786e4553845c30490e19b08451c8b999f.camel@ibm.com>
 <aW7Vy_RpxseBC4UQ@ndev>
 <3a5b428754b6e006025c462f37e610b5a5e361a5.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5b428754b6e006025c462f37e610b5a5e361a5.camel@ibm.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74770-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangjinchao600@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1e3ff4b07c16ca0f6fe2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0CEAC50064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:51:06PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-01-20 at 09:09 +0800, Jinchao Wang wrote:
> > 
> 
> <skipped>
> 
> > > 
> > > Firs of all, I've tried to check the syzbot report that you are mentioning in
> > > the patch. And I was confused because it was report for FAT. So, I don't see the
> > > way how I can reproduce the issue on my side.
> > > 
> > > Secondly, I need to see the real call trace of the issue. This discussion
> > > doesn't make sense without the reproduction path and the call trace(s) of the
> > > issue.
> > > 
> > > Thanks,
> > > Slava.
> > There are many crash in the syz report page, please follow the specified time and version.
> > 
> > Syzbot report: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2  
> > 
> > For this version:
> > > time             |  kernel    | Commit       | Syzkaller |
> > > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
> > 
> > The full call trace can be found in the crash log of "2025/12/20 17:03", which url is:
> > 
> > Crash log: https://syzkaller.appspot.com/text?tag=CrashLog&x=12909b1a580000  
> 
> This call trace is dedicated to flushing inode's dirty pages in page cache, as
> far as I can see:
> 
> [  504.401993][   T31] INFO: task kworker/u8:1:13 blocked for more than 143
> seconds.
> [  504.434587][   T31]       Not tainted syzkaller #0
> [  504.441437][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  504.451145][   T31] task:kworker/u8:1    state:D stack:22792 pid:13   
> tgid:13    ppid:2      task_flags:0x4208060 flags:0x00080000
> [  504.463591][   T31] Workqueue: writeback wb_workfn (flush-7:4)
> [  504.471997][   T31] Call Trace:
> [  504.475502][   T31]  <TASK>
> ...
> [  504.805695][   T31]  </TASK>
> 
> And this call trace is dedicated to superblock commit: 
> 
> [  505.186758][   T31] INFO: task kworker/1:4:5971 blocked for more than 144
> seconds.
> [  505.194752][ T8014] Bluetooth: hci37: command tx timeout
> [  505.210267][   T31]       Not tainted syzkaller #0
> [  505.215260][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  505.273687][   T31] task:kworker/1:4     state:D stack:24152 pid:5971 
> tgid:5971  ppid:2      task_flags:0x4208060 flags:0x00080000
> [  505.287569][   T31] Workqueue: events_long flush_mdb
> [  505.293762][   T31] Call Trace:
> [  505.297607][   T31]  <TASK>
> ...
> [  505.570372][   T31]  </TASK>
> 
> I don't see any relation between folios in inode's page cache and HFS_SB(sb)-
> >mdb_bh because they cannot share the same folio. 
What you pasted are not the right tasks. Please see this analysis which I sent before
and focus on the task id 8009 and 8010.

Analysis
========
In the crash log, the lockdep information requires adjustment based on the call stack.
After adjustment, a deadlock is identified:

** task syz.1.1902:8009 **
- held &disk->open_mutex
- held foio lock
- wait lock_buffer(bh)
Partial call trace:
->blkdev_writepages()
        ->writeback_iter()
                ->writeback_get_folio()
                        ->folio_lock(folio)
        ->block_write_full_folio()
                __block_write_full_folio()
                        ->lock_buffer(bh)

task syz.0.1904:8010
- held &type->s_umount_key#66 down_read
- held lock_buffer(HFS_SB(sb)->mdb_bh);
- wait folio
Partial call trace:
hfs_mdb_commit
        ->lock_buffer(HFS_SB(sb)->mdb_bh);
        ->bh = sb_bread(sb, block);
                ...->folio_lock(folio)


Other hung tasks are secondary effects of this deadlock. The issue
is reproducible in my local environment usuing the syz-reproducer.

> I still don't see from your
> explanation how the issue could happen. I don't see how lock_buffer(HFS_SB(sb)-
> >mdb_bh) can be responsible for the issue. 

> Oppositely, if we follow to your
> logic, then we never can be able to mount any HFS volume. But xfstests works for
> HFS file systems (of course, multiple tests fail) and I cannot see the deadlock
> for common situation. So, you need to explain which particular use-case can
> reproduce the issue and what is mechanism of deadlock happening.
> 

Please follow what I sent and do the reproduce. 
Have you ever try the specified time and version in the syz report page?

| time             |  kernel    | Commit       | Syzkaller |
| 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |

-- 
Thanks,
Jinchao

