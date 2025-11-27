Return-Path: <linux-fsdevel+bounces-69938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7FC8C721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAB3B5332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D732459D4;
	Thu, 27 Nov 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQSpBsN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367EC2264C9;
	Thu, 27 Nov 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204205; cv=none; b=UKA1bvsp/gNp7iOMlQN8aiBLwF4wRSCydugSebcs/YDcVAdhVPfUUStfMOrIA6w2VmAL/EAgIqJL9nQBXKZrdaEVg7vQ17WqVDoQutR5LoPTu1VnZTUZRwuQ+MG4RS60sWYq748Jc+AlTxFM9v9Q8qZkBWbdiCjU6ijjP6NQDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204205; c=relaxed/simple;
	bh=p0cQffAgeqn04pmVrzqv8oKE43c+8yPWU6W/r/neGLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cvw8n2obsR0r0CgxluM4qTU9evtcGgwZw5qPNkD0eQj19sN9CzQi8hRPhFcW9xZTiIxCaSs71RvebNXx587fPEzfv3yxh5MeLGo/tw9JXiOi60Jzk77tI7/3gXqvN+nvPM5K4keQeBtRXf6Sli5aMRfKg3ujifMx/PCGYAzmU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQSpBsN+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cPJ4G5W9hFdphDEZet67Q1C8w5VwSXADPtmrpnzwleQ=; b=cQSpBsN+CIIE0fSpqd11LNecWG
	cTh9BfwrCNc4XpGM4Id+qKw09EDAHCniPjmUm8CfxnwgDpkd4KsYiimgCuP/CAp6srx2I93XwOQ94
	3rkxUgvaEu4An6pvX0ZKBYMn+tVGAkVWJ8euTxX+869gxd1TBCUDmmzjI+Ax0MSvi6M//k0zTfpxK
	8yXjyvnBeBluLSz1F/ECqr9dhsWKKtC4IcE9vtkF/Exogz+gnZazWTdah68eNMSKx6EwQVotj65hi
	1zlx9M+3gMQa4OnkRTot8g6/uFEHq9FFAXchpSHNdSRJ3agd+0e7E36ge+Sab/h4d2xOjll5CotOb
	T1xXKhZA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOQ6R-0000000Fo95-2ld6;
	Thu, 27 Nov 2025 00:43:19 +0000
Message-ID: <371a9942-f0f6-49e0-a505-3b60f89a0530@infradead.org>
Date: Wed, 26 Nov 2025 16:43:19 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] Documentation: dax: Demote "Enabling DAX on xfs and
 ext4" subsections
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux AFS <linux-afs@lists.infradead.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
 <20251126025511.25188-4-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251126025511.25188-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/25 6:55 PM, Bagas Sanjaya wrote:
> Subsections of "Enabling DAX on xfs and ext4" section (both "Summary"
> and "Details") are marked up as section heading instead, which makes
> their way to filesystems toctree entry. Demote them.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/dax.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

-- 
~Randy

