Return-Path: <linux-fsdevel+bounces-39323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A7AA12B07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F057C3A07E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A61D618E;
	Wed, 15 Jan 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="dWzU7QKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F35161321
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966146; cv=none; b=ml4WAO3dBjRaDaI3ZD0TVTumhg5YJV2O2KmOS6SOQ3LAQCg5QAM1Gk3goZWd71Zxn/jWDuH4GBAL6sYCUUHCFblUvS3ZCTcfRP78Wv+tWj5U+t2bb8lci3JAVX0QBrbG/bEpXfIxs3q62u0/S96n/HbGDCxkVx56OUvD/T46S6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966146; c=relaxed/simple;
	bh=YQzhU0LGIpiuVbXsBdPlOdSuK5f92F3C63tTVl42Q5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmDQx36wVzUAN3vNyZPk+eX1olM4dAkygUjX3BWE30/cltZ66xaBU6/dTOaE+uq4YJN9nIpOa6KFFuZ4JK2I4ETdBBrGemASrJOp7HO7nWd5S8Wwk+6NbU6DhLryaNwHtP9g49p4bIos0OBJzrfHg+LA6bKwIrDZmjJSivBtHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=dWzU7QKv; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=++zTkSlMUdFFC5DhjGp1l1yspqyG8TtFJXmr3yHg8qo=; b=dWzU7QKvgoDEXplZxazzV1Z+bR
	CI8WUuXnPLglWTiGwMOenFAMFZrwBLc+s5daykkAM1kLGF5PGpK8H9+pYj8q1dx6VvrMx8acbhyZu
	b4r3hkfQzJloJuVOxvDiWhBafDUeGB4HR2IbvAiiXZzUuXX3AHCQoUeX9juCMVzsEgepteltkXD+4
	5VSMMPckeXxLZ8CRRvD7yl6NqJAOm3cAJ1qaDv8LA2a4s3WgP2UoqCOe8U8kNg/Hp3cqOD8LvoJrO
	Ci7QFFDyEkDlE0bY0g0pDZB1GQBvirSZdbP5LSMBRr4EeCKtM6LPJ7iBTotzgKoCAcUcszwOPUspZ
	CLdNfZLQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tY80I-002Yu8-1c;
	Wed, 15 Jan 2025 12:20:34 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fix a file reference leak in drivers/misc/ntsync.c
Date: Wed, 15 Jan 2025 12:20:34 -0600
Message-ID: <12598856.O9o76ZdvQC@camazotz>
In-Reply-To: <20250115025002.GA1977892@ZenIV>
References: <20250115025002.GA1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 14 January 2025 20:50:02 CST Al Viro wrote:
> 	struct ntsync_obj contains a reference to struct file
> and that reference contributes to refcount - ntsync_alloc_obj()
> grabs it.  Normally the object is destroyed (and reference
> to obj->file dropped) in ntsync_obj_release().  However, in
> case of ntsync_obj_get_fd() failure the object is destroyed
> directly by its creator.
> 
> 	That case should also drop obj->file; plain kfree(obj)
> is not enough there - it ends up leaking struct file * reference.
> 
> 	Take that logics into a helper (ntsync_free_obj()) and
> use it in both codepaths that destroy ntsync_obj instances.
> 
> Fixes: b46271ec40a05 "ntsync: Introduce NTSYNC_IOC_CREATE_SEM"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>


---

Thanks for catching this. There's a similar problem with the other newly introduced object types in the char-misc-next tree (and this patch doesn't apply cleanly there anyway). I'll send a similar patch for those, unless you have one already.



