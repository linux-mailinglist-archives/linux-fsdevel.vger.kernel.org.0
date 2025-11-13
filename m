Return-Path: <linux-fsdevel+bounces-68213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56CC576FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2675234DBFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B834DCFE;
	Thu, 13 Nov 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOp/uNGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782435979;
	Thu, 13 Nov 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037269; cv=none; b=ND73IWODeRgk/0JnrsLoTalqAwXjAZZW12uMREkITrKiqglrZn+qZCVTMMIEi1fWhVFrcPfb5Gmzynruq1u+wpcaa7HjDR7H8WqEejJLGAMTm20qJFe+IYn1eMRJgNcgQ5CFjEc+520YquoEAdetjT2m29pEmPvLxBuan1mxQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037269; c=relaxed/simple;
	bh=y1FfFIuMb0svp4ymlKmSDs7EFvaJvR5A3gJ3lpcq8Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ7k2dnf6qFEtUZrvWCDqqivuKl4+p+2tTs8xewhXErHgK/qsFoksVQBp+eDiJfeu6ouBcb/8rwNRQ/BdEApqF3Ps/x/yHnaP6v+WurXjyzKlBUs8JqVEv/38D9guXzZ8KCEMnNy/PwqL/RbOPEJs3GLN5emUO6KdKUT80ujDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOp/uNGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A64C4CEF8;
	Thu, 13 Nov 2025 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037269;
	bh=y1FfFIuMb0svp4ymlKmSDs7EFvaJvR5A3gJ3lpcq8Uk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EOp/uNGLEJX2/o1A0Oqqre+Il30QU6+REZ6YFDPWH0Meu5sP92HduOMkUe8kYKDAB
	 VdMLglbLi+06rRrPRmZtPa85qJJEDgpngLeHOzUgN1sNS8CURZ8cVUCHj7//ChyqxF
	 VuOuLY62yswpDC7bqM25vTrSPw6RUWv/LeQgStQLbLM2OrQuNcrt/3iInfvUmER6AV
	 Nc+T6QelxZUkCLsxA1HPvQevv9ZkT7AKrzBRgRHmpmiBzB/hsqvjQmmfHqp2ZR80oO
	 H3l+CR6hjebnQdqloBIy7TOa2FcbeyT4jGxT7OutE15lQOo+L85dtISsLNkHoQJUIp
	 agdcL9uWkwFxQ==
Message-ID: <13db54a4-5f02-4b57-8ff9-6298c2c4b8d3@kernel.org>
Date: Thu, 13 Nov 2025 13:34:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
To: Matthew Wilcox <willy@infradead.org>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
 ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
 dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
 nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com>
 <aRSuH82gM-8BzPCU@casper.infradead.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aRSuH82gM-8BzPCU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.25 16:56, Matthew Wilcox wrote:
> On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> From: John Garry <john.g.garry@oracle.com>
>>
>> Add page flag PG_atomic, meaning that a folio needs to be written back
>> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> in upcoming patches.
> 
> Page flags are a precious resource.  I'm not thrilled about allocating one
> to this rather niche usecase.

Fully agreed.

-- 
Cheers

David

