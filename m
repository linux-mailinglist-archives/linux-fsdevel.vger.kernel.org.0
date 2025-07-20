Return-Path: <linux-fsdevel+bounces-55544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6EB0B844
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 23:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CF4172CD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A6226D0A;
	Sun, 20 Jul 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="NGuYvOyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098F2264B7;
	Sun, 20 Jul 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045146; cv=pass; b=RH6wXeTLy0c7/mZ9H3EIT0XO5FvV7HQxPDiU9nliXfsxHwbX7yq3/VZXdQPjrkPBug0KMgHz3VMugEM2uVl9EopaE+m9pbEfyQzshu+N1y6kgZmtZx2L96uVBzj+LbJAxEGgN0jkkekdr9yIPoYaOxhz3c0SWPBS1m8SL7CMphM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045146; c=relaxed/simple;
	bh=/CqFDWX3ltRC3T3uCgwyoDkSy6A157X3LAUK/JbCBis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOCU2YGTe0DTvWR75t8SxDzN0LuohIQcjXmD9qOD5MnVBYHalwsR3cFxtlFmiR2W/H+GptN9YoUs4ybHlGeqgy13c8HJeOxrDYXR02ubgZLbY8MXa7etvyusr1Pb9xCorVAQzgrcxv9Ovajlw8tSXZg+MpP3l1lDsI7BeW2X+mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=NGuYvOyK; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1753045127; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CkaUFh4QX4ZftFDfiWj678Oqc7QtT5gedGKCWV4zFFJUgstZL33pSxlcWZ9wKXjgYcNafNtO+kdKXaYgj+EfSnwkvCITEGZpdd/FqlBJL8nY3I6ijkMTSOAAUEbhhXkOGYbw1+ZPREaBkC1U2v1NarkhT7OzxwboROz/IgIpaZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753045127; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/CqFDWX3ltRC3T3uCgwyoDkSy6A157X3LAUK/JbCBis=; 
	b=Jp8j75+PTE22DGMcI4BupgYz/mzoroVunlEB8iDeoTnvzBZ78rOAlqwV02hcr5wbOMVvHNxsiPP/dY5nZdl/QMAgUW0jt7nkc9i9JZ5TgiavHJ8FrbJgWFCy9trj8FX3rHWqoZF83dNBkWD93i2EnRlD9t2uhbnyPd6dRR3EBUs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753045127;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=/CqFDWX3ltRC3T3uCgwyoDkSy6A157X3LAUK/JbCBis=;
	b=NGuYvOyK2/NJewIxZNic1flrYbpk3vaQ2XXsEGd/X6PQd/2cXSWi+s1sa4kD/JIV
	tPdSfKHq/ZjOE3WhdEPMx9D2gQFlW93k4mqsw9Abdh1mrK02ICv19Or5L4Z1rgGtM0S
	czxvQVw+VHaouTcUdQXaHUALfPk2KnIQlx4D4xdM=
Received: by mx.zohomail.com with SMTPS id 17530451261573.681567831038933;
	Sun, 20 Jul 2025 13:58:46 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: senozhatsky@chromium.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tfiga@chromium.org,
	vincent.guittot@linaro.org
Subject: Re: [PATCHv2 1/2] sched/wait: Add wait_event_state_exclusive()
Date: Sun, 20 Jul 2025 23:58:39 +0300
Message-ID: <20250720205839.2919-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610045321.4030262-1-senozhatsky@chromium.org>
References: <20250610045321.4030262-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227ee1686b54db1c6c590ae89290000ca616dc1aea20be69767ef38ffba0f7c99e32901e7f1609326:zu0801122709d8ceb129b8b11557267ae80000f16242d1eca93fedd3befda2251b594a97482ef41b97f220bb:rf0801122c7821590fd9737fd0c9f973fc00003514f0ff9467287cab3ea0e1f29370acd1b5491d640cb41ab20ab8c96111:ZohoMail
X-ZohoMailClient: External

I just tested this patch on my laptop. It doesn't work!

Here is my setup.

I compiled kernel f0e84022479b4700609e874cf220b5d7d0363403 from branch "for-next" from git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git , which seems to contain this patchset.

I booted into it.

I mounted sshfs filesystem (it is FUSE).

I disabled network.

I did "ls". "ls" hanged, because network is down.

Then I did suspend, and suspend didn't work.

I'm available for further testing.

--
Askar Safin

