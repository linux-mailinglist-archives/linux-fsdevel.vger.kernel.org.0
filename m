Return-Path: <linux-fsdevel+bounces-38739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF3A0782F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FAD3A41BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E2218AC3;
	Thu,  9 Jan 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uapG9uox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA28472;
	Thu,  9 Jan 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430598; cv=none; b=ezz/nb5cj1o/dYTRYaV+jmZZ+Y/bMh+SHdXNp1aMnfsrZ+eyKK4hkUMKDTw6+Su0ZLyjPxI03IhInU24tVH1ziUuxJmbOvvlpcZDXDkCA/BuOn9DqfnfQwE46kgW74UmVJEDj/oD8sXAJPjAY3oi/62lkNj7S3uck4c1xZiUL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430598; c=relaxed/simple;
	bh=XpMeLtIysxgFw7x5N11dNjJt9Lv/Wg5mqKg4jWUbR6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaAbgPQ2szcJcQnQFVh/Q9hKuQjiqm3Z4vDBiJ+5vHPpE7CT7U/Z987EXqsp/cK4r6Oo3p0kL0dThkrRFtBAQ6S71k8NxgcpoDtjWQaMo+y2ncnrWBL19SpozB+l9didD+Q95Jz5hdT+GAE8Nss1l+7WEqodemcA3QOPHN1ZVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uapG9uox; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EkQXP1UDzlaOfDtfefd5iRK+wBcBT+EX+RVaHgZcXpM=; b=uapG9uoxm1Gxf97kU3XOnveiep
	oIuNAuoR4G0s6pFrkc8MX9bLno2iyUFR9dyodzagXJ0vHsY14kPYffJBrpqunDKlkNJUnaBw/3Hht
	wbVNvMErrEclL6eVECloIIFXZkYy0gwa6FTovG2pkCkokIEfCyYoXjWRFJbS40AXnvXrtDe/sSRaf
	i/cV0FdhhL7AC2mmo71J+woMMUYQZjbNgb4EJZmvbbAkezHPPhzcbhjk19g4GRciA2IQGqm+Rhgt9
	SfcXVjTcESPEWnVp3ZSK4dhx7ZDP0IjPkdzJW9HxhpFPBxCg+uTRMCSErygxLsor2kwRj7vg1yN3l
	qjTbEmbw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tVsTC-00ENuP-Vi; Thu, 09 Jan 2025 13:21:07 +0000
Date: Thu, 9 Jan 2025 14:21:06 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.40.3
Message-ID: <wzdbgtxffvujwnv5oeeutbmeodm5chcmelyhwhhx7yt6dym7lh@j5vdmg3rnm3z>
References: <xw6eivqjw6nc75sbejmi3nkbfssmakkrwpbjpfqtwwbpqxmb4f@rmyrm5gnizln>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xw6eivqjw6nc75sbejmi3nkbfssmakkrwpbjpfqtwwbpqxmb4f@rmyrm5gnizln>
X-Debian-User: zeha

Hi Karel,

* Karel Zak <kzak@redhat.com> [250109 13:54]:
> The util-linux stable maintenance release v2.40.3 is now available at
>       
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.40/

I'm not sure where this comes from, but building the translated
manpages seems to fail:

GEN      ro :  fsck.minix.8
asciidoctor: ERROR: fsck.minix.8.adoc: line 29: dropping cells from incomplete row detected end of table

I haven't dug deeper yet; if someone has an idea upfront that'd be
great.

Thanks,
Chris


