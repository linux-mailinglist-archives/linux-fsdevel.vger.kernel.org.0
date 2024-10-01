Return-Path: <linux-fsdevel+bounces-30490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8AA98BB0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50124283C61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516241C172E;
	Tue,  1 Oct 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hOqxm6iV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F01C0DE1;
	Tue,  1 Oct 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782155; cv=none; b=WeH+bbPeRSIZPJPMxbwjem1AdCpodzCrxPMYHGt3Cr1pgrAbfyj6LDN7Nb5p24G46YwaHFGSgM7dqsN/71LZYaPEIlDFolII1A5H3QIsEtJBSnWfocQbo7YPolIUxhEISSmxjGE6rMLnNKFKOxqm8EogsISpl1UymJlITosvjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782155; c=relaxed/simple;
	bh=a8WHZ7W3EhQ9PtI7lCDoDsTRkyAHfHKrzoPIXZXeYg8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dX7EH9Q3xifIgTEL4tvV8l38HLrzmtPuVnw5bq7ag0K0+/wGC4u8Gx/Qct0fJe4jkoTWDs0sjEyyFyettZf9mjZ6kxjQFObwlMJMCJBFVrfqUqaT6R18TYxtFle/DLSVprcVM8sghRiBu7t0pB2SaQ+waattwqZe32HM0hhp2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hOqxm6iV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zF9uz8JVM3HISwS+6MEo57XAsK6xXE3AG8qaHZeixt4=; t=1727782153;
	x=1728214153; b=hOqxm6iVo+ojbWG2adXOLDJ0wDk6JQwzE1u9fIzVD8t3wJiVw71ol3u90rAMo
	dlleOVwRhEmNTVb8Zmq147RNb0bE7XOoyyraW/tTHYO5lYAVf1nCzVX1LC5B2bo0Qr3SMym2r8Aii
	Owh3q44AYeqFINNVIm6RzwgfJaEgCtyzS0u+M1EUtA0lYnIQkIOIQQexnExgNcagzY/jYwKmJQNky
	x5KH0mHs0DruFeAjm7PSM33JxcSYar+VcfzLi605pz/NPCFBad0yLYH8vVCRvcp33EoU9U2fpPkO/
	6wzPpULLKsiJImAd9L+hNM4pkF0RPwLcTk4uJb75+0ixvfHA/w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1svb42-00089I-8P; Tue, 01 Oct 2024 13:29:10 +0200
Message-ID: <8196cf54-5783-4905-af00-45a869537f7c@leemhuis.info>
Date: Tue, 1 Oct 2024 13:29:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: yangerkun <yangerkun@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Ma=C5=82ysa?=
 <varqox@gmail.com>
Subject: [regression] getdents() does not list entries created after opening
 the directory
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727782153;5e5fb709;
X-HE-SMSGID: 1svb42-00089I-8P

Hi, Thorsten here, the Linux kernel's regression tracker.

yangerkun, I noticed a report about a regression in bugzilla.kernel.org
that appears to be caused by the following change of yours:

64a7ce76fb901b ("libfs: fix infinite directory reads for offset dir")
[merged via: "Merge tag 'vfs-6.11-rc4.fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs"; v6.11-rc4]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219285:

> below program illustrates the problem. Expected output should include line "entry: after", actual output does not:
> ```
> entry: .
> entry: ..
> entry: before
> ```
> Program:
> 
> ```c
> #include <unistd.h>
> #include <dirent.h>
> #include <stdlib.h>
> #include <sys/stat.h>
> #include <stdio.h>
> #include <fcntl.h>
> 
> int main() {
> 	system("rm -rf /tmp/dirent-problems-test-dir");
> 	if (mkdir("/tmp/dirent-problems-test-dir", 0755)) {
> 		abort();
> 	}
> 
> 	int fd = creat("/tmp/dirent-problems-test-dir/before", 0644);
> 	if (fd < 0) {
> 		abort();
> 	}
> 	close(fd);
> 
> 	DIR* dir = opendir("/tmp/dirent-problems-test-dir");
> 
> 	fd = creat("/tmp/dirent-problems-test-dir/after", 0644);
> 	if (fd < 0) {
> 		abort();
> 	}
> 	close(fd);
> 
> 	struct dirent* entry;
> 	while ((entry = readdir(dir))) {
> 		printf("entry: %s\n", entry->d_name);
> 	}
> 
> 	closedir(dir);
> 	return 0;
> }
> ```
> 
> Affected kernel version: 6.10.10.
> Filesystem: ext4.
> Distribution: Arch Linux.

> On Linux 6.6.51 it works as expected.

> Regression first appeared in 6.10.7, 6.10.6 was good. I will further
> bisect tomorrow.

> 6.11 is still affected.

See the ticket for more details. Reporter ist CCed. I made no judgement
if the code provided is sane, I'm just assumed forwarding the issue was
a good idea.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a
#regzbot title: libfs: getdents() does not list entries created after
opening the directory
#regzbot from: Krzysztof Małysa <varqox@gmail.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219285
#regzbot ignore-activity

