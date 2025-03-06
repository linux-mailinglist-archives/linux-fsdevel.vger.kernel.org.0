Return-Path: <linux-fsdevel+bounces-43378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD89A55427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCE117AF19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3526B08B;
	Thu,  6 Mar 2025 18:05:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DC26AA92
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284306; cv=none; b=WzZtFUdQ/lT6hJ6gbH0VS/ku8rS9TlBYWrRCI/Xkyy4WVXqFlALPnWWg76l+kolGt34WkoQRMMwrnIbWNlJS+8dMDCS2Uaoz6rultkyK7OCX1ULnwyLGgR3J0ZIeIjuf9Xvk+vpR5OpDRozSLqdWFv+3t6DH2IuyTpTgejzFQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284306; c=relaxed/simple;
	bh=HnOiXdIEGgi0ajA46Ao4q0OHXUgw4cbdKL3Zt6BVsoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UupQXXjDoIVvTm/7Emr6236ZA9GsqaBP1OmmN42qr4Dq4QeDDVsSfZ+ioZ64RFbiQHjZByZ0mGeCQkEsNe2ONpD0MI57dDhT6gtE0j2IFHjnV9LRMq5fqkB5mxfEh55S91+2wVF6W4zAk4ocsTNCaOZFhF8iUoGROuGrdVlmdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 526I4Rql015568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 13:04:27 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 419262E010B; Thu, 06 Mar 2025 13:04:27 -0500 (EST)
Date: Thu, 6 Mar 2025 13:04:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Sven Peter <sven@svenpeter.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "ernesto@corellium.com" <ernesto@corellium.com>
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <20250306180427.GB279274@mit.edu>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
 <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
 <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>

On Wed, Mar 05, 2025 at 07:23:55AM +0000, Aditya Garg wrote:
> 
> This driver tbh will not ‘really’ be helpful as far as T2 Macs are
> concerned.
> 
> On these Macs, the T2 Security Chip encrypts all the APFS partitions
> on the internal SSD, and the key is in the T2 Chip. Even proprietary
> APFS drivers cannot read these partitions.  I dunno how it works in
> Apple Silicon Macs.

How this workings on Apple Silicon Macs is described in this article:

   https://eclecticlight.co/2022/04/23/explainer-filevault/

It appears such a driver will also be useful if there are external
SSD's using APFS.  (Although I suspect many external SSD's would end
up using some other file system that might be more portable like VFS.)

In terms of making it work with the internal SSD, it sounds like Linux
would need to talk to the secure enclave on the T2 Security Chip and
convince it to upload the encryption key into the hardware in-line
encryption engine.  I don't know if presenting the user's password is
sufficient, or if there is a requirement that the OS prove that it is
"approved" software that was loaded via a certified boot chain, which
various secure enclaves (such as TPM) are wont to do.

	       		      	      - Ted

