Return-Path: <linux-fsdevel+bounces-57087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE54B1E9C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D23616BBA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251227CB0A;
	Fri,  8 Aug 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="ZJy+b8A5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4026AC3;
	Fri,  8 Aug 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661682; cv=pass; b=qw4M5s5rynXaLzkZ5muQ9pXU0MnTdqHnGmAU3O2lJB17TsC/RrNBMhFrt0DRvFm+w55ZW6Mcopo+EIfHRNA9KTd6PYrjkIdZNiTSHlriWjhqMqUeTDQu2v0l7K6yqr+5rA5rDmm9BtVTdk3jhLS785XGg9BB9fetpAgWm4JVbSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661682; c=relaxed/simple;
	bh=rT3VzyH6Xn1glT38DkuRT8Gj02/qfEIf4SWBwVJK6uw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FKETRv3cFAPjR4eKvIQ3Zg5lX8h+0f/Mm4FEkMt1oOtKrEfYwXdjYH5l1T7a7YtXryXQY7LAnIWqJxm3UfxAIZlEwcXcgYKjeRWnn9x/VWno4KY2EMy5lTQLyHg0V0fX3FF6NIyX1/Ay3azEgVxgX2QIOIEb7/d2tlWrqo4Pb88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=ZJy+b8A5; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754661646; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F3DH0S9y/LpE8St8iKYkkwyJXdFUODHoXmtvCqlFrZhZnkpG5DJS9ZhZQ46ZSTJH+qM5odKZbN8S6WqUJUZlmTBCbd76sZ3g98zyvY/SHm6M5ochVBHaw5RdTXMv84w2i1E3/tQmrRlyiOSZxDwMUH25nMl1JmPRAua4tMuNMvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754661646; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M7IuwaQDdYjwYVpeTbAcgAwO0y6aDahsOmCDYXaJ2+o=; 
	b=SoD79QwLNYx7W9+bD91y6gLXyT9fSaEh90BSHY4ZrZtLFuOw8qKaGHJRrzDvYJ3oyMP6ZOkuJmghrJTxkR5p+5GS5JX0WvH5lXJPqdId7o+7saHQS2uPrHo715PX4Rz3iW9yvr+I/L+xsNHzXLu77p7b0X78hfAYifwJroPorzU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754661646;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=M7IuwaQDdYjwYVpeTbAcgAwO0y6aDahsOmCDYXaJ2+o=;
	b=ZJy+b8A5Zx6KJGcsPzbG82dCyS9LHI58Avgst6PxWJsswc1F3HcVz1mTypDg2INT
	KoRODugjrc7ivZr7UNxrDtFmeBgXz5TwAJCgwI893qlpOY0diziM9VnZkO3I3NSN6x3
	p3PYBtSKmHvSMJXp0D0h1TZZ6dSXmWKSt1Y3SEus=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754661643941480.67059820000884; Fri, 8 Aug 2025 07:00:43 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Fri, 8 Aug 2025 07:00:43 -0700 (PDT)
Date: Fri, 08 Aug 2025 18:00:43 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alejandro Colomar" <alx@kernel.org>,
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>,
	"G. Branden Robinson" <g.branden.robinson@gmail.com>,
	"linux-man" <linux-man@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <19889fbe690.e80d252e42280.4347614991285137048@zohomail.com>
In-Reply-To: <20250807-new-mount-api-v2-5-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com> <20250807-new-mount-api-v2-5-558a27b8068c@cyphar.com>
Subject: Re: [PATCH v2 05/11] fsconfig.2: document 'new' mount api
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112273483f9e25750bd5e64720e9300000a43eff5e06d646831b4925fdb282f74945ca5395047b5b966:zu08011227295a2319a843661c6004f60f0000f4c6cf4f655d584944e8f69f6a3a421beea4a6b920d39a4d09:rf0801122b8da7ca7ba25404bd0a9fc9bd0000b41b42decbf1c6f1f242aac919400a2b489e22dceb18c04293f4c63600:ZohoMail

Let's consider this example:

           int fsfd, mntfd, nsfd, nsdirfd;

           nsfd = open("/proc/self/ns/pid", O_PATH);
           nsdirfd = open("/proc/1/ns", O_DIRECTORY);

           fsfd = fsopen("proc", FSOPEN_CLOEXEC);
           /* "pidns" changes the value each time. */
           fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "/proc/self/ns/pid", AT_FDCWD);
           fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "pid", NULL, nsdirfd);
           fsconfig(fsfd, FSCONFIG_SET_PATH_EMPTY, "pidns", "", nsfd);
           fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
           fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
           mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
           move_mount(mntfd, "", AT_FDCWD, "/proc", MOVE_MOUNT_F_EMPTY_PATH);

I don't like it. /proc/self/ns/pid is our namespace, which is default anyway.
I. e. setting pidns to /proc/self/ns/pid is no-op (assuming that "pidns" option is implemented in our kernel, of course).
Moreover, if /proc is mounted properly, then /proc/1/ns/pid refers to our namespace, too!
Thus, *all* these fsconfig(FSCONFIG_SET_...) calls are no-op.
Thus it is bad example.

I suggest using, say, /proc/2/ns/pid . It has actual chance to refer to some other namespace.

Also, sentence '"pidns" changes the value each time' is a lie: as I explained, all these calls are no-ops,
they don't really change anything.

--
Askar Safin
https://types.pl/@safinaskar


