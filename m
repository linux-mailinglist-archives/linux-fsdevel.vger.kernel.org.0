Return-Path: <linux-fsdevel+bounces-40022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76BA1ADE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 01:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C13AE075
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E613D8634A;
	Fri, 24 Jan 2025 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ene-kolla.pt header.i=@ene-kolla.pt header.b="aKW0nrm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ene-kolla.pt (mail.ene-kolla.pt [89.149.207.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B986332
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.149.207.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678238; cv=none; b=PtCPC3/aXZywWz+LlpNl/pEmSIeEvxHe8DOT3PZbs+gnWL8GBLKIaf3TMTIUAVf1lvmNapZ6J8dvHfeS7dgcnxFV2tkjuCK2oIpufJu4Yrw5wt8sijkDCgCaeANTGxWwL9TU4lMQh4ysiBiigg5i/JeRX9hooAU1Oc78ypRxcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678238; c=relaxed/simple;
	bh=6Cz1RoC77WgRsOJMWY05qhxtkmo/QejZ9PVT55bwtTs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpNc4UMab/A2YIxPOeMLU51TwsoQEF2JsKEu6yhgCB3gm07FAv9spjDnOALKYVM6DJ6QX/PpAuPR1GaXTTfCnLSiX40ZUTdl2vhrnC4CycrWuTVYC0rEPjWG6jhgrnGCIxO8wjkEtC0Lhh1l69N6GOaFe1auHkoHhokrfZ8NSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ene-kolla.pt; spf=pass smtp.mailfrom=ene-kolla.pt; dkim=pass (2048-bit key) header.d=ene-kolla.pt header.i=@ene-kolla.pt header.b=aKW0nrm4; arc=none smtp.client-ip=89.149.207.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ene-kolla.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ene-kolla.pt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ene-kolla.pt;
	s=202211; t=1737677695;
	bh=6Cz1RoC77WgRsOJMWY05qhxtkmo/QejZ9PVT55bwtTs=;
	h=Reply-To:From:To:Subject:Date:From;
	b=aKW0nrm48MP0oFdCi+8j8gDH3c69QufJvwpDPELP7s1DAf73nexL74MYUBlHmWM6d
	 gA0xlOgXIxJaQG9Q0V2NVi0VPo5zo4Aonub1StFWvbPjZBoy6BUAaf/VVCx34RmC+9
	 TRVdnpEb1wqGQOm5NBsbx/5IHGtz19jkvolrgmZuvdLKkhXHipQf0p4pmrKJyeG1Ee
	 aqcDA7iQrUl0EuSUfyEM+ecUdRx8hQU6YQvElVfdC10FUd63EZZPMd8XlTotOf7M4M
	 TchW5KIYUQkwSqII4ebEJ2ptzuzdJr+2xqzZ6YMH6tVjE3AU42Lpamk384eokMWDH/
	 XEHb+DcasCisw==
Received: from [103.202.55.136] (unknown [103.202.55.136])
	by mail.ene-kolla.pt (Postfix) with ESMTPSA id AD526F7230
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 00:14:54 +0000 (UTC)
Reply-To: wioleta.raimer@invpolamd.com
From: manuel.rodrigues@ene-kolla.pt
To: linux-fsdevel@vger.kernel.org
Subject: urgent request for a quote
Date: 24 Jan 2025 01:14:54 +0100
Message-ID: <20250124011454.F87A50C18652159A@ene-kolla.pt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,
My name is wioleta. we would like to know if you export to=20
Poland, as We have active
projects that require most products as seen on your website. If
yes, please kindly keep us informed upon your feedback so we can
send our preferred listing for quote. For further information or
have any questions, please do not hesitate to write us.
=20
Sten Arnlund
Purchase Manager
wioleta.raimer@invpolamd.com
a: Vedwalterdige by 2, Holmerskulle, 432 68 Poland.

