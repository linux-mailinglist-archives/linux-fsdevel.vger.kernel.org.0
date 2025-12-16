Return-Path: <linux-fsdevel+bounces-71496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A594BCC54C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 23:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8E98300FE0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992633ADAE;
	Tue, 16 Dec 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="MVAeESDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F4139579;
	Tue, 16 Dec 2025 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922755; cv=none; b=ibuBGEtYw9Mio/oEm/gtTRimo2uAbPFv88Z6Mt9yam+dz6hnIX4XXt3sIlo2UyldCRvnJp9S0o0B3YGan00eQFTgjjTbh00Qsn93rj+JkYy3Mj6J73Qe8VQgZyGFiZAAP/4aSBWsMr+Xb6dZCAXokDSUV+ekINyyZhnHty47IyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922755; c=relaxed/simple;
	bh=KKYQolnNqjo7Mny+RH2MXQizQmTGoGiHiiH2Ze55tR0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=SfK+AGIPRGh8LBnsmj6wyWU7jWkzWt4hqNf5RVDnHFyXsJcUGhrcF1bi8cSuwjexQxiAr1fNZuWTU9SRwwCFZ0I2XUrIcqntDxVt4k14gAn9nppvccYFZMMdUri6yaYOhM15Uaj6arRbB3a+K0sAc773yjzEKxfdLLlBCBsHEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=MVAeESDM; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KKYQolnNqjo7Mny+RH2MXQizQmTGoGiHiiH2Ze55tR0=; b=MVAeESDMcv7xYRF3/z4Dbv0ar9
	RnC/S9WcVhhoesayHLb1eAca9/A6seBmgEQ7ypd6vjVNTowbxTp0vCUUjMITwksWYpc5tL9L3OmBv
	rx5DY/70AiEXRcZKmiaaKasU9jIKyi/EvGfnZW/GaslpT/LMrNhSRItVnucbH3wxrR9ONUZ2Ubhx+
	VCrZynOetB/W69fWljziiACJ8YxEZ9P4H9M4dZaNYZdxvSFhp27vaOThTt4N7c3ftWaicnAXtd6Ak
	thYjsauAAvvDBCOAH14EChcaW+MJ/0Y24hhTnL2vqUdQA3VLlyYKRN6+uuZcDp9veOSdIB5Iu+IoB
	pHi1TJmw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99)
	id 1vVd3J-00000000jt4-2RUj;
	Tue, 16 Dec 2025 18:57:53 -0300
Message-ID: <dc7873860a14c8e476a60f3254731b3f@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>, Enzo Matsumiya
 <ematsumiya@suse.de>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] cifs: Scripted header file cleanup
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Date: Tue, 16 Dec 2025 18:57:53 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LGTM.

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

