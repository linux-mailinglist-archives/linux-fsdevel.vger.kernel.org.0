Return-Path: <linux-fsdevel+bounces-48617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C3AB16E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA4D1B62989
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A0293728;
	Fri,  9 May 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b="aZMFedu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.fastemail60.com (mail.fastemail60.com [102.222.20.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8F28F536
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=102.222.20.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799904; cv=none; b=oIliTO8KvTtsi/3Kfy3TEeO8MyLBjq0cQ5glRRKVeIrMCjTnQ5zUYVFdpRtQUamGfKo44R+cCe6PcWqsOq94loTT23dSBhOAeTxShELrAg8iJtXQDLX0L0DOmQgIMpZl00UiLg7ulsdpyPE5ufDXDAUEfHmF0nmwxZ5R3ztrTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799904; c=relaxed/simple;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZoGcDZZBuevM5dz8Myqf7oIQLyGfNX8lbHenuBpu0jI8wkrZ0uvckOu+cUYcDIxqwudluIWfuhTpL41d9vmDQdMpaqQktMl4nUVx20jaVGyBJNfSQYt2XmXk2EA1FkIaSZjfp91VOxYYnkM28s2P2OcbK6XDrPOgFGipHIXCAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com; spf=none smtp.mailfrom=fastemail60.com; dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b=aZMFedu6; arc=none smtp.client-ip=102.222.20.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fastemail60.com
Received: from fastemail60.com (unknown [194.156.79.202])
	by mail.fastemail60.com (Postfix) with ESMTPA id AA20D87C087
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 15:55:37 +0200 (SAST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.fastemail60.com AA20D87C087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastemail60.com;
	s=202501; t=1746798939;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=Reply-To:From:To:Subject:Date:From;
	b=aZMFedu6aslpHerp69Ka7lfB1Ktifu5sZMEZexNmWWU6dNj0NRENKlIeZ3NFinAIB
	 iYQ6PonZAi9eNpFyHSI99aP/0hdzqFcn+ZrIpEvNrqECXLNhy0daYzKZGCdZmA0XN7
	 oxCa9TI/HoT8J4Zsi5Mm9dtYDAwdrnqJTU7LqKr/Uax2XdKUe18DCv2TUNDfSyMPhQ
	 +WokNAYLL8ggvOjEjwhgPEk8mMuJHm/MmnR2DXRM/TcMgc2CnnxMIBG6ZR7zuGBso5
	 qJlJGV6ZjyVBFT9h0QGRaR1OjHoqq/V+UFTXwWJ792RDFDgXBgyzlmz+DppBuz1t2S
	 FN/un0+8mQuzg==
Reply-To: import@herragontradegroup.cz
From: Philip Burchett<info@fastemail60.com>
To: linux-fsdevel@vger.kernel.org
Subject: Inquiry
Date: 09 May 2025 09:55:37 -0400
Message-ID: <20250509095535.AA791E45A8F011CA@fastemail60.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.fastemail60.com [0.0.0.0]); Fri, 09 May 2025 15:55:39 +0200 (SAST)

Greetings, Supplier.

Please give us your most recent catalog; we would want to order=20
from you.

I look forward to your feedback.


Philip Burchett

