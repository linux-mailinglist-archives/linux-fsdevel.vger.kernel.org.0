Return-Path: <linux-fsdevel+bounces-59125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A521B34A51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736781A87503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2F304BBF;
	Mon, 25 Aug 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="f8iMl/O/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDB25A2B5;
	Mon, 25 Aug 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146477; cv=pass; b=EXZv3DARzNJdwHgPzw63iZV+p3RSSPYh06sOITPsDi++GvTTG8vNNsddi8eHMb5t2IMlqbHmiLn4Ypb/fzpI7V0y9SuCxN2rwpap7f24NXfTFA3HBr8o2nRk/pCP0C/odh7KogByGwR/2Ess9JjbQ3vT5ttq0LhrzdkaFmXpSSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146477; c=relaxed/simple;
	bh=meEgaTKp6Xdw2PLSai+5PZYRpi9n928iTriksJb8pOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbklceqsfg5H1IZuLMl5sfr8mW12+x2fTlTykKCRF8905unvvE/2K233yn8pMfU5DEwe1wFGeE5B3okieaP8SiBZ9RPqTuMJF4k2ZF5rdphv7h4MuEEe6KOElzX8zWEet3y31SUHIafdVyon2BPKZpakiNr2jaV1CO0AykgRMAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=f8iMl/O/; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756146440; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KAd+cLom/5YBkeqycVaYIXWJ2wWP0/QvPfkIE0axSr2lh8F8dw+bBx7lfUudb7nJichgf5jD3zk+YMpfPZGRWl7IkqyH+UGsIHNc/0HhmQlX0y3C+AMohoWVbkZgifkMrKZUMOQtdsHvTTe7zy6lvRgQ6a6RDSLBXcwnkVfrrDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756146440; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m12lHGWa3KhdTQWlE8Rr94S+wcigP6qe2knefY5rEqg=; 
	b=CNbu37vw/e7iqfj6DNqCQx5erasdloFagoK5qwAUY6FasWcmdFUdSd9qr4jsstRKX7EO8xWO/OL3Mx3oXAc/lPoOrMHBRyYQFEZ0+CWtzY6S8DHhKrquyE9G2nqnpcWMiFy/KsvQBc9v7uhCULxkxmkIFYS6KV/gHdxcF37VGIA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756146440;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=m12lHGWa3KhdTQWlE8Rr94S+wcigP6qe2knefY5rEqg=;
	b=f8iMl/O/Yg9xNAAcmCF2H7ZmkfpD2XuKkKtp/VcG3gUWLjzU47C2XgAIrKxsdtbS
	Us7+C70Pb09n4mdOP1B+xj2XkxtdOoztc5xyzYtjmUVFLoQ0i4eoTms0q2G7LPxjTlf
	Bk3l6XT/fdAi//lSSl45PMRcpBrUdgKRRmh9qosg=
Received: by mx.zohomail.com with SMTPS id 1756146439310997.1212989347032;
	Mon, 25 Aug 2025 11:27:19 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: hch@lst.de
Cc: gregkh@linuxfoundation.org,
	julian.stecklina@cyberus-technology.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH] initrd: support erofs as initrd
Date: Mon, 25 Aug 2025 21:27:13 +0300
Message-ID: <20250825182713.2469206-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321050114.GC1831@lst.de>
References: <20250321050114.GC1831@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270baee35dc5311e33b64052940000252d03bbe4d16dee78348dc27b1e6bf0455e8e1d18fd4a103c:zu08011227f8165d847c5e766d85d9776c00004a796f562a9284a1b19f8ba53791b06519e43ede7488b100a8:rf0801122cb69044e998ad7c93d492d3f70000bfc00a88b96aa5e27a37851e3c823ee70d414282c543039636ff4e7a7a49:ZohoMail
X-ZohoMailClient: External

> We've been trying to kill off initrd in favor of initramfs for about
> two decades.  I don't think adding new file system support to it is
> helpful.

I totally agree.

What prevents us from removing initrd right now?

The only reason is lack of volunteers?

If yes, then may I remove initrd?

--
Askar Safin

