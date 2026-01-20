Return-Path: <linux-fsdevel+bounces-74590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE164D3C32B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2209600478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4B3B8BDF;
	Tue, 20 Jan 2026 08:46:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913333FE04;
	Tue, 20 Jan 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=221.12.31.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898763; cv=none; b=PtYrMsdzSMwgsrEU8JQi6M3405UKDkNFZBNyfSHN0XnxbjtNI6BkVfGOa9IFinsu9ojCclHRMnhvLdTyp8BuaR0czLweua1BkQjqibgdkZ4/r+BRWx0knqjsMtJNiZXdqLPziN9ghg8E3hL/jSb5DfygV9ku6V993WuZX6lDmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898763; c=relaxed/simple;
	bh=4cqaPbRRCcn6xGvj/IYrBX4g4UX2zALJj13n/6jHJyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0xoAYqptjSe7LJp6SnA/Brr1F4clKALYkERDvlXjsyCfnnQelLVqVyPKKFAsyOBwlnBaQyWhgwp9Hn4NTs7OkZNz0gD+AaoSYxCqbwoKMLLwa1bCTKw1jj7NJblCa2VwipMSE31/LfZue9QcSvjHhoqSnsJnKRPzAmDBK+M9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=221.12.31.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 60K7LVMA002512;
	Tue, 20 Jan 2026 15:21:31 +0800 (+08)
	(envelope-from ning.le@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 60K7LBNb001080;
	Tue, 20 Jan 2026 15:21:11 +0800 (+08)
	(envelope-from ning.le@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id 6A6382011864;
	Tue, 20 Jan 2026 15:30:37 +0800 (CST)
Received: from localhost.localdomain (10.114.186.44) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 20 Jan 2026 15:21:10 +0800
From: ningle <ning.le@h3c.com>
To: <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ning.le@h3c.com>,
        <zhang.chunA@h3c.com>
Subject: Re: [PATCH] proc/stat: document uptime-based CPU utilization calculation
Date: Tue, 20 Jan 2026 15:20:18 +0800
Message-ID: <20260120072018.3139470-1-ning.le@h3c.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251226043409.1063711-1-ning.le@h3c.com>
References: <20251226043409.1063711-1-ning.le@h3c.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 60K7LVMA002512

Hi,

Gentle ping on this documentation patch.

The main motivation is to describe how userspace can compute more stable
CPU utilization on systems that already enable NOHZ and virtual CPU
accounting (CONFIG_VIRT_CPU_ACCOUNTING_*), where idle time in /proc/stat
is already accurate.

In this context, improving observability is often easier by providing a
better time reference for these existing counters (e.g. a timestamp
field in /proc/stat), rather than enabling additional options like
CONFIG_CONTEXT_TRACKING_USER_FORCE, which may be too heavy for many
production environments.

If this direction is acceptable, I can adjust the text or placement as
you prefer.

Thanks,
ning le

