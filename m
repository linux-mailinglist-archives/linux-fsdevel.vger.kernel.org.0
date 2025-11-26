Return-Path: <linux-fsdevel+bounces-69860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA3C880C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 05:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8113B0ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 04:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33D30EF81;
	Wed, 26 Nov 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaSWrsMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8D301027;
	Wed, 26 Nov 2025 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130923; cv=none; b=GuliZ+kLEB1TVeLIK5aToPP06hyTOVNkdDwlSrxYiwQC+qSgYGKoYoYH+iOv8tnXFK0gby4EP4Ly6hhqzVaAX32hcM+17uYl+gB8EtUHsssP+LenQO0kRI5MLCmfJ9Mz6K4Uughu07XorHddyb3NxoAPImVi2ocscC18QbGeUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130923; c=relaxed/simple;
	bh=LThOhqZA/QQ36ZCiGJgFmEpTD+Ky9UM3ciKNHeiS8y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXCnTKtt9SVBe+BJIdNqcqVuXVj6HNcU0UbhYHsjuXCFG3LPY4vC821yX7CGkKXKmvSZ68HmzCYXsqeHQ7SFnjIPCSkEKIBN/sEl+1AQJFcPobtxE85AjrHXxZ2it5hqXCtreivkIpGShIdcyu8hu2rYQAKJ3Q/TBt6CUlwABPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaSWrsMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F21C113D0;
	Wed, 26 Nov 2025 04:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764130922;
	bh=LThOhqZA/QQ36ZCiGJgFmEpTD+Ky9UM3ciKNHeiS8y8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XaSWrsMIKhpBSKe8RAnSQzFxfX4ExXRY7Cjxj0swCA/H8IkUNSpGAw3oGoCjupYLq
	 /S2UCswh5efUvqttCJypKggxnB/4MseByvtcfqYyeB91aCj/LSGMIulRMeooVPTuIR
	 uZsG+yYXbzCmX8Mgp9Q+Ac2HtiyaQTtxSO80xujgX4eK6KxiSSh/kWoh1kQZ6RFT8p
	 daLIhHCZ9XVd0yl5P8SomEdg0Bxe+SkQd2Zr5219t5RFvo7+HUL/RyiaNa7BOnCsXE
	 szWjL1oG4OlP52cS7fwsWthlyhJwlwe4m6aHQXFcLrnapP1h/s24TXPJyHsxycOK2W
	 8TCnSTrbTHIPQ==
Message-ID: <148d8a58-a3c0-4ca5-9b25-30002eb214ae@kernel.org>
Date: Wed, 26 Nov 2025 13:17:49 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] Documentation: zonefs: Separate mount options list
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux AFS <linux-afs@lists.infradead.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jonathan Corbet <corbet@lwn.net>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
 <20251126025511.25188-5-bagasdotme@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251126025511.25188-5-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 11:55 AM, Bagas Sanjaya wrote:
> Mount options list is rendered in htmldocs output as combined with
> preceding paragraph due to missing separator between them. Add it.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for fixing this.

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

