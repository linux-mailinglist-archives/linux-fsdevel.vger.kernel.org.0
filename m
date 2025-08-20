Return-Path: <linux-fsdevel+bounces-58381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69383B2DB63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E921C1C410D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E42E2DFE;
	Wed, 20 Aug 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="cTZR+TYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964221507F;
	Wed, 20 Aug 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689899; cv=pass; b=UVa5y5r3lvoKx1gAfRRrFt7B7aGkzGTCaVA3hPMbEBzku/ZPhngErQiVrUtvmPp0srCbvFc8YJ64xzLi+D+tmqTKSH54XDxTdERjVEf3A7/qfuDMQ9ds2/8HeZ8yyDOuu25JZvMCvqImSkdTd8w8/opzBf7UvNaRTCQzJdf1E5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689899; c=relaxed/simple;
	bh=g29LCrt6I9iuQ+mRsmkNHsNQoUC7jvttrvs/LpDJm30=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qQotO0gmBGP/T4FiYorpCKRw4NdPJ5MJsxb/mtkWgCWDKy8hlfqqeFDDo0XHWQawekrnyh/xAAbGiAT50BKbYuygIr9kasR/rxqIsp/+sEqLI/jyjrjlCblGDowFjxKlV/2qlbykb2YNsw45aEfN2RCsHOwME3Rgvl/cZ/tffX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=cTZR+TYj; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755689864; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fiUSxuIXEAvkyBeRDKI5eNwL4kRxk7JtO9bQ98iWxbRW7AavZm2vPGUcQOZZUH8Q0jLMXtttmwR6FZQGfSrHtUHhfCFxbyA+VT4KBn7lQfOM5enjnD6+Sccx24mwol4jmwlr/Ynh8aL0kZqnJmeumas+uBKGYiSEOTEmY1QPzW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755689864; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6KJpLNHE8T9/L+ViOk7zf44oMaShgdIyIiAQhi0A2B4=; 
	b=fXeBDKpv16YvD8Q7hzm20wcctBbFOMCsTJH+ngrrgQ78f/0KyrqPUPJ2AjRhgiqPGN/AexvEumHigmaXcOBavn4EkyELuxMb5jTrGjluIwmVCPKpWedw6AHVhTCNiQGjolflE4ehjaerZsSETH3UNv0+g5kTvVfzQD4InqssDc8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755689864;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6KJpLNHE8T9/L+ViOk7zf44oMaShgdIyIiAQhi0A2B4=;
	b=cTZR+TYjoTDl+57OvbwHVD49CaFwDolNZNMTku0d5+ncKrLENkYX7tMZqsLNHtex
	wt2nEqjZuh5bS1QpCoA85qsQo7vT3wEEPBJZbwSJ51WevUGK7bS/04dpdOpY6jGoX7b
	B/E9ENtH6Pst4RLcF10rywiqQY6+qj1oAk8kEiao=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755689861589911.7272320752146; Wed, 20 Aug 2025 04:37:41 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 20 Aug 2025 04:37:41 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:37:41 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "alx" <alx@kernel.org>, "brauner" <brauner@kernel.org>,
	"dhowells" <dhowells@redhat.com>,
	"g.branden.robinson" <g.branden.robinson@gmail.com>,
	"jack" <jack@suse.cz>, "linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-man" <linux-man@vger.kernel.org>,
	"mtk.manpages" <mtk.manpages@gmail.com>,
	"viro" <viro@zeniv.linux.org.uk>, "Ian Kent" <raven@themaw.net>,
	"autofs mailing list" <autofs@vger.kernel.org>
Message-ID: <198c74541c8.c835b65275081.1338200284666207736@zohomail.com>
In-Reply-To: <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250817075252.4137628-1-safinaskar@zohomail.com> <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
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
Feedback-ID: rr0801122722203fef96364c25aa50708700005f0cc761d8dc35c664ea4c4b427c2d04b4c9c5032e6c63ba2f:zu0801122710457e0a7019adb7e479e5300000183caa7d52474c868f9c5d2ef286a0e085a41e85ecec44bbd2:rf0801122b8b9f5bd3d1697384d0cd0cd90000ea507d724a1ea2a1f420ecc0e1c1cf7667d361d3371bc826ade74538de:ZohoMail

 ---- On Sun, 17 Aug 2025 20:16:04 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > They are not tested by fstests AFAICS, but that's more of a flaw in
 > fstests (automount requires you to have a running autofs daemon, which
 > probably makes testing it in fstests or selftests impractical) not the
 > feature itself.

I suggest testing automounts in fstests/selftests using "tracing" automount.
This is what I do in my reproducers.

 > The automount behaviour of tracefs is different to the general automount
 > mechanism which is managed by userspace with the autofs daemon.

Yes. But I still was able to write reproducers using "tracing", so this
automount point is totally okay for tests. (At least for some tests,
such as RESOLVE_NO_XDEV.)

--
Askar Safin
https://types.pl/@safinaskar


