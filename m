Return-Path: <linux-fsdevel+bounces-57175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A880BB1F512
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E073B3411
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863D277800;
	Sat,  9 Aug 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="REifcxqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703B2868A1;
	Sat,  9 Aug 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754751877; cv=pass; b=sR+QlTK+fweDwQul8CBNllu0av/iQ2oKIHC6ZvCpLIoXwgoxFCb//zp+dRaq+PUhyubo49TxROH88l2d5Q27XJlX6ViXInX7wUzArpq5MJCCa2K25VMWjw39hYNIJyRwVGNpKPbowEmtipVQYKhkihWQd8yFSa0ekuD0CWdotJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754751877; c=relaxed/simple;
	bh=9SInk7XBl0PU26m9kuyot0Wcgz/WCj8xKaCGWJ3wrDI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qrsrL9NJRKfx3aamDJappMzLnX/WUWynfNc1rwbQGt+43YtlLDiDmV7L1oQmmWsw2+qTNrxVTckXou0Uu9nPWseThBZy5AcUmmZC8ie8uAhzWVQN30xzeVvSF932Eyd5uIS54abR3erW0QxeL2DDVS3T73FE4cXEkJQhcJILSg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=REifcxqn; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754751847; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=chTIJMNPVGOw+HKN7JHbsOZC8lRWRBvyD2kxDyziIEolwgakSVtLFYLpCITO542IjUpoD9g1kfCh7qhebcv0BLas/5otcruOL8lCs0NLaanZYPveaFxmSzOfX0vyd+uVH4wW69M4BMkHe4L7ZF8rvbU9d18/JD4UycGQUAGHS3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754751847; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9SInk7XBl0PU26m9kuyot0Wcgz/WCj8xKaCGWJ3wrDI=; 
	b=VxBMjlMSu2chidgHLMyXPcCdrbKMC32F5JJhqdUoqPIUHEtl17O9PJWci45IqY8MDeJPPHN7f+TeZxK/Qd+zAt2I4kON2vb4DKab4CXC8XpGF6YPDmAzUJNAJH+/4k7TnbTAghtXPB+O+JlaHgxwbwLW5GLqq+I+TX1Jk68D1TI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754751847;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=9SInk7XBl0PU26m9kuyot0Wcgz/WCj8xKaCGWJ3wrDI=;
	b=REifcxqnmtYNpz0wF4GubBC8nS5/0CPimGdly+ddpXZXA9EQaRNvUyLEpCsXQve6
	VDypYt/W6jt5n8Q2YrSgvtdEGCX3NVO79jTJEH8pWcu9w1gsuNxZpzEgflujgTg9wIr
	WlYRNMPbrvyZBsfhYbjOfQsYOqlFsbkeiIZsYg1Q=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754751846652344.24688580782697; Sat, 9 Aug 2025 08:04:06 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Sat, 9 Aug 2025 08:04:06 -0700 (PDT)
Date: Sat, 09 Aug 2025 19:04:06 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>, "Alejandro Colomar" <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>,
	"G. Branden Robinson" <g.branden.robinson@gmail.com>,
	"linux-man" <linux-man@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
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
Feedback-ID: rr0801122767838548632ee7156d99845d0000f2981edb0e0187e4a4b2b81610de22d3cbf787a147ddc02bc1:zu0801122777075560cf48c082acbf16d200009c4d429677047108011ff5ac1348024664759804a63ad210ea:rf0801122b163779dcc3392054649eaff80000a3d5ddcb7f3241b52139eb169685ed62b3ad79c11a70921a4d8f513d87:ZohoMail

I plan to do a lot of testing of "new" mount API on my computer.
It is quiet possible that I will find some bugs in these manpages during testing.
(I already found some, but I'm not sure.)
I think this will take 3-7 days.
So, Alejandro Colomar, please, don't merge this patchset until then.

--
Askar Safin
https://types.pl/@safinaskar


