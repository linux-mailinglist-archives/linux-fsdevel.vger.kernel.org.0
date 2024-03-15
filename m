Return-Path: <linux-fsdevel+bounces-14453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2787CE18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CBC2824BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC92C28E31;
	Fri, 15 Mar 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuuIXcWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB20376E6;
	Fri, 15 Mar 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509365; cv=none; b=HEurv0IAUwKm1NwsoEJGumBghN5LjZws7Wd5j+h2vSqjOi1BJWgXVj8Jme9mfeJrMN9tT9w7pnHghBqy09E/m+yfgsmf0mPhnRnmPG8ZbZESA64wCcf2Uya1jf952OxOUiq1JajQqhbeGUlhdqWP41QpCXlUErIQEJCSxOKRh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509365; c=relaxed/simple;
	bh=Vb6QoET5XlbVi8dY8PNk86MFBYpawiqOsxptI1/cIE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb+JFPb+tiKOs5e0KalibMd77zDkzr13FNpFStm/7iX4g9Fa4mwnF7FZYHBBZwHFXeekHPvrBbSjjpSyx4E80U/tmfFwszTx9XTDQLcvCZVb18l3+ZwiScbBUKdyd+3axg/t3HSOFjidFtVKjAbvfudo/nM3UuXSeUWrtjXBTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuuIXcWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6122CC433F1;
	Fri, 15 Mar 2024 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710509364;
	bh=Vb6QoET5XlbVi8dY8PNk86MFBYpawiqOsxptI1/cIE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuuIXcWdjVgqawPveKoDdoZZQGM7YiX17835SOPCU4pqi2cRrbHDlcQEGm5ZyyE0a
	 wpy82qGfmG/5dNwQ9PmDOaLTFQ3RvoyCQirpcuRrhMjlg+x6vkdUNiTDLNO6VU52vl
	 a2hnVKTy1b4VcfPqaCkEUN/aEK1i+0xFXvRXpbEVJeFfGxohMFB8n1F//nHNg0lf3P
	 PhWvMP0ZeelNw8cVsrpXwEeFzKLlg8KrWODtEGN0haPrSFKRju9lrRelW4X4F14Itq
	 yFTXodGlXL1IZEYa7A261KVUgLmDWUxN5Qv9z6/hTgumIb9xMCAzM+jZrVysm6hq2o
	 dKkSL4C1vscUw==
Date: Fri, 15 Mar 2024 14:29:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Aleksandr Nogikh <nogikh@google.com>, 
	syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>, axboe@kernel.dk, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
Message-ID: <20240315-zugerechnet-abserviert-36a416bde350@brauner>
References: <000000000000fcfb4a05ffe48213@google.com>
 <0000000000009e1b00060ea5df51@google.com>
 <20240111092147.ywwuk4vopsml3plk@quack3>
 <bbeeb617-6730-4159-80b1-182841925cce@I-love.SAKURA.ne.jp>
 <20240314155417.aysvaktvvqxc34zb@quack3>
 <CANp29Y6uevNW1SmXi_5muEeruP0TVh9Y9xwhgKO==J3fh8oa=w@mail.gmail.com>
 <20240314172731.vj4tspj6yudztmxu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240314172731.vj4tspj6yudztmxu@quack3>

On Thu, Mar 14, 2024 at 06:27:31PM +0100, Jan Kara wrote:
> Hi Aleksandr,
> 
> On Thu 14-03-24 17:21:30, Aleksandr Nogikh wrote:
> > Yes, the CONFIG_BLK_DEV_WRITE_MOUNTED=n change did indeed break our C
> > executor code (and therefore our C reproducers). I posted a fix[1]
> > soon afterwards, but the problem is that syzbot will keep on using old
> > reproducers for old bugs. Syzkaller descriptions change over time, so
> > during bisection and patch testing we have to use the exact syzkaller
> > revision that detected the original bug. All older syzkaller revisions
> > now neither find nor reproduce fs bugs on newer Linux kernel revisions
> > with CONFIG_BLK_DEV_WRITE_MOUNTED=n.
> 
> I see, thanks for explanation!
> 
> > If the stream of such bisection results is already bothering you and
> > other fs people, a very quick fix could be to ban this commit from the
> > possible bisection results (it's just a one line change in the syzbot
> > config). Then such bugs would just get gradually obsoleted by syzbot
> > without any noise.
> 
> It isn't bothering me as such but it results in
> CONFIG_BLK_DEV_WRITE_MOUNTED=n breaking all fs-related reproducers and thus
> making it difficult to evaluate whether the reproducer was somehow
> corrupting the fs image or not. Practically it means closing most
> fs-related syzbot bugs and (somewhat needlessly) starting over from scratch
> with search for reproducers. I'm OK with that although it is a bit
> unfortunate... But I'm pretty sure within a few months syzbot will deliver
> a healthy portion of new issues :)

Fwiw, my take on this is that if an active subsystem (responsive to
syzbot bugs and whatnot) is not able to fix a bug within months given a
reproducer then it's likely that the reproducer is not all that useful.

So by closing that issue and we're hopefully getting a better
reproducer.

