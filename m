Return-Path: <linux-fsdevel+bounces-58610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187FB2F99E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 15:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FCC161959
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787B31E105;
	Thu, 21 Aug 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="AXQ7SPKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A836CDE1;
	Thu, 21 Aug 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781527; cv=pass; b=u6qHI0OGSQlo4vs7DTyaH0tko/H6GViMUn47N9NMipMAN06vJtjK0avJskb5KL5uOrxUVnvKl4XG8bc/gvUrI+3AuL3jYb2QfoQdjv39tuiQgWtEhvqocwvEqXCqBBKYH8QXSJ9cU6k2XmRdU35RjeLZXSx/eRmNHq5A3uzZ+cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781527; c=relaxed/simple;
	bh=+8sGKMRZCJWLdmy/DkF91IGc5BVarEzYoIFTWH7RXXw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LOrFw20DKcbTFWWKGmQKyz14Erss5VwPZYYBW1HwQxAluTsEnlt/ttR6OsciFlEuw+mDJI6cYZpuor1Fyh/Oy3I/wtRcqnEOYeIoeNYCoe/cXqHSLE7DINvnb1nxB81PY8uaPuWZ89IEalWwheRqe/MRJbHu1FYoJ4O/QYKGfng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=AXQ7SPKx; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755781475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i7Wggr5HBYWBGUd1xe6bh1Ol5XBy0xuiYXMGjM/ux/SsG7ULhZMJeq6sOPDK8+C3fImCCbM5Vv8f5XXDM8RcTe0KKF8ROT2alww190aXSohBq9IUNOKu22MshDdjGtaHfq1SpLT9MMeR/qDICFaA7pSaw396lyLv0bfGQVo/RhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755781475; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SYHuj7Wjx5qXUTPgXJD1D8Eca4emv02OFlDqdIAxWXg=; 
	b=La0rFyDmhqKUYNKXoHgy/2RIceLK9RCjNqIdMCFI7uRY8LX9RPJ2eGtKytCGNuhKlyQZ7iSvyO/eL/vE/GEvtKq61b1Nl/YZMP/0tiYalzN+cwnMJaJjCVc04Q831rwtyyKUVZmGH4ZSNtCxx2d4PVlLf7wodS7gumlZs07q+tk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755781475;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=SYHuj7Wjx5qXUTPgXJD1D8Eca4emv02OFlDqdIAxWXg=;
	b=AXQ7SPKxUUopWeIvF7qQBZ7U4g0taKulTETxsoQoPfyom1vx/YMhl6nP5YCcK/zj
	b74nczifLvROCOVksSFURwJTZ3ZGTInNUeJDjCipy7k9oHM2h3DDmi9gQ5QHA1GIQ/4
	If6GaO7AjDGG5/1MAVWnSjteaxHi7J92Pi6jJ8vY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755781473954167.9696619074616; Thu, 21 Aug 2025 06:04:33 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 06:04:33 -0700 (PDT)
Date: Thu, 21 Aug 2025 17:04:33 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Lichen Liu" <lichliu@redhat.com>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"kexec" <kexec@lists.infradead.org>, "rob" <rob@landley.net>,
	"weilongchen" <weilongchen@huawei.com>, "cyphar" <cyphar@cyphar.com>,
	"linux-api" <linux-api@vger.kernel.org>,
	"zohar" <zohar@linux.ibm.com>, "stefanb" <stefanb@linux.ibm.com>,
	"initramfs" <initramfs@vger.kernel.org>, "corbet" <corbet@lwn.net>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"viro" <viro@zeniv.linux.org.uk>, "jack" <jack@suse.cz>
Message-ID: <198ccbb2694.d3fad31887413.1131652624698180933@zohomail.com>
In-Reply-To: <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
References: <20250815121459.3391223-1-lichliu@redhat.com> <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
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
Feedback-ID: rr080112273e22f1786581338e49b7e07e000001104afa9c15ad2a122830cf688da2c59c8afe72e8c650ac99:zu080112272dfa6be1a67c778365ab64e5000011cfac17ec895c53b99647dbd1d7d4ef18c9ec956b108d8a70:rf0801122b9f962294dd4be519c8bf7647000010f904f79ddee4b424b1c5dbfae154f5453192b76d9278235c9b24def2:ZohoMail

 ---- On Thu, 21 Aug 2025 12:24:11 +0400  Christian Brauner <brauner@kernel.org> wrote --- 
 > Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
 > Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Applied version contains this:
> Specify mount options for for the initramfs mount

I. e. "for" two times.

--
Askar Safin
https://types.pl/@safinaskar


