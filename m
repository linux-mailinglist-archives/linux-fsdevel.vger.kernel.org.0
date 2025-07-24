Return-Path: <linux-fsdevel+bounces-55939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9CB1058F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D532F165C76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340402594B4;
	Thu, 24 Jul 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="W/4r17Ej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04CF23C4E9;
	Thu, 24 Jul 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348667; cv=pass; b=BHTgyPWJ8ahZE4IWa17mmlbE1qI0zFinOalyTsHZSUr1FMSk67eqc/37zWy/Au2BVfmHzx9e3IUqruIkawTP/tNwzFhWGGnkg/2ZGwo9la3c2GINNQwM/iPCJBm3/2mhYYftE2wVh+qZTA1AlHfeTCCAIGRCKLI8vysUS7lHRpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348667; c=relaxed/simple;
	bh=r4U4AlYanf8+Mm94ORgEbcJcvUtT1nMxCJY2bUMWIp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sma4Wf4OQuoWYpOJYKfojBea+Kje9I3J34HQPdhp+bvlbTxMjiEdpoZ4Ap1brUj+Z4Qz3gmz1nehSJ6bBBeqceoH9wfysT++gujNOSi6GIP3oawk8IhAWNv4Y+B7jxEZ2ufVbZFeFqLQ9YgLk2Pmi+6BpNyFkWrWw95MGf5HlPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=W/4r17Ej; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1753348578; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c59k7OVc6GnzDLuO9f0SYKYKk/ERB/FbkKZ2QN6i8vKWQBq3ToRGQefdKm8z7I8BLAw9ExSwDRqcBQr8ZiuqcB/8Wjqjvk8cohPjySstEP1jRnULr4rGgOw3+znjq/SuUybg0BRGD6jyNFRjvKrKWgFKz8E1yvJcXansaapSwKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753348578; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r4U4AlYanf8+Mm94ORgEbcJcvUtT1nMxCJY2bUMWIp4=; 
	b=eQ3bTifzakzOYvsdfM68sZVfZnObTipoKh7PiIcPRUNoIJe+V7E+jBZUMQ1/OjwayIbbsUcoBlO7Xm+oQYjD/6blKNCXh2zc6ytGF3LO5Z04HK/Q2S2xXB3ISduge4W8MDKqFyB1i3K9wVoX6jvGlkhrQTUSV67KzmOi3v0zNS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753348578;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=r4U4AlYanf8+Mm94ORgEbcJcvUtT1nMxCJY2bUMWIp4=;
	b=W/4r17EjUz7tKHd+Dty3fw+oquEqIMNatmXI2xbx9oovhQ9FcH+JYdYr6SXW3UZr
	44Hab9SNgc+Vyu5V/UwxKePkzp7AtuEF9Ns2E8cc7MW+54gCsY+ZLw3n05ChAnb9Grs
	ZJffpQ33guGJ6BEVSZFZ9UsqOeIkAcpJJZaFp2Nc=
Received: by mx.zohomail.com with SMTPS id 1753348576467207.84736617123485;
	Thu, 24 Jul 2025 02:16:16 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: bhupesh@igalia.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	arnaldo.melo@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	bsegall@google.com,
	david@redhat.com,
	ebiederm@xmission.com,
	jack@suse.cz,
	juri.lelli@redhat.com,
	kees@kernel.org,
	keescook@chromium.org,
	kernel-dev@igalia.com,
	laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lkp@intel.com,
	mathieu.desnoyers@efficios.com,
	mgorman@suse.de,
	mingo@redhat.com,
	mirq-linux@rere.qmqm.pl,
	oliver.sang@intel.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	vschneid@redhat.com,
	willy@infradead.org
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str which is 64 bytes long
Date: Thu, 24 Jul 2025 12:16:04 +0300
Message-ID: <20250724091604.2336532-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716123916.511889-4-bhupesh@igalia.com>
References: <20250716123916.511889-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112277386df9982d4a0a50fd484250000d6cf96b2b2dd89700b60bbfae778d9f00cbe3c5cd847bf7583:zu08011227d3545089dbbe7029f132e8e000006a667f2294f193b7a928dd1a40d92bdd2c006e7a20faa6ebe9:rf0801122cad691eaec5235a908425c52200009ab00d1523b423f07b85d4c3bb9302abf9c739cc073320d82c0c0bbc6e4a:ZohoMail
X-ZohoMailClient: External

> where TASK_COMM_EXT_LEN is 64-bytes.

Why 64? As well as I understand, comm is initialized from executable file name by default. And it is usually limited by 256 (or 255?) bytes. So, please, make limit 256 bytes.

--
Askar Safin

