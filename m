Return-Path: <linux-fsdevel+bounces-58893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E91B33004
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C274C17C7CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563A72DA779;
	Sun, 24 Aug 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="JtbhmZls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EFC226173;
	Sun, 24 Aug 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756040861; cv=pass; b=IvoTSR/GOwzRmBkUYzeoM6NuVvtEkjex3mVP4zETm9vwYNEeeg40RVlelffX6l7F3Lvl0AROwjy42cMG2VEHagSEtZpbQGJi6BgQRRB1LYXCFLv/SXK8JY2tWobAV0NWixr0A/5ae+1PZWwElxwVfJD7/yMD20XVe0hyzKcg0kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756040861; c=relaxed/simple;
	bh=H9hClQ8Nar7tBu2U4P6ItIAC5BBpDs4PmF0j0LlVJQo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fziW3bBcEOA5JI5vKsjWb9EQPB2qGfMHOjClmEJr9J3SFQev05uuJkw1DJxseng7oj8ynw3KzGCxCujeZPVF9arLUty2l1GzrtfhZcGFayG/qzDTvfCpGR6Bi9+AOEyvahU+lIY1018bt34jaK2o/aMLfk7aYj1hxsLMNj3DfFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=JtbhmZls; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756040824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AfD4IANLtgS3jtkxpPyo288UNvEALXDHcdnNxbufCzK7kBGpBzGHPiBiKhgLSIklpRGtczrahQnnh7sneaLEw9mUwdAwgOPw/7UQ9oKFjV8dxbEBGPdZlM3PcK0ioVRfLp6eBpKmalUq6eAdS5MbGYHXPM7chFdpaI9TX+sfAGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756040824; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jPyLTfpk8y5n/JPo0lVTSrid0kvP418FWRR/ZUXvspg=; 
	b=mLbn5sfgh/irxjYAdplSQATm/A0yznU14K4AbjmXiuOhhBdFKrI3TvibgwmFA8Mgk3rvF+upVboBEsnbwTc3wcWchq1daYsTuaISa4U9TRTn/UaoJhe//Ki+/81w+LgRzVxvEbmTdn+yRbaItJOuQLxT11GAYzkqShr9CDI2RO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756040824;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=jPyLTfpk8y5n/JPo0lVTSrid0kvP418FWRR/ZUXvspg=;
	b=JtbhmZlsbEJ3SxN55fROun8g7agiNQ0rQQPUeDRi69xaezo7ZLaNN7u82ndQl21B
	+OxXj36h8h5v9aK/xuMorJW8oJ46OWcUsD8ikEPW0M+H5jRyjqsBzf7jqqfV+hfVis+
	V5b4+wJGMwu8mQW0cejIxLm+5Z3Jg86mcO79SH+w=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756040822584266.10291600463563; Sun, 24 Aug 2025 06:07:02 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Sun, 24 Aug 2025 06:07:02 -0700 (PDT)
Date: Sun, 24 Aug 2025 17:07:02 +0400
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
Message-ID: <198dc307f2a.cf48ca5e17032.4424087610632367131@zohomail.com>
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
Feedback-ID: rr08011227c87104b8d3650149d3e24884000002f5dd6d0709eedc24788bd4853a2c2e4f40e78b79f1d3ed2d:zu08011227dacd83ef1b3a3c1e07597d020000e2c3b86dbb82a5aa13d206c0d71d8979f3e22bddb481016be7:rf0801122ccf55173632d8227c7ddef9650000933801dc10498a2fc46bf3c9cc2805a7abb6a34a51d56330a91944eb4c44:ZohoMail

 ---- On Sat, 09 Aug 2025 00:39:44 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > Back in 2019, the new mount API was merged[1]. David Howells then set

I finished my experiments!

--
Askar Safin
https://types.pl/@safinaskar


