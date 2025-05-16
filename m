Return-Path: <linux-fsdevel+bounces-49255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E5AB9C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A183E17F4B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0BB23FC42;
	Fri, 16 May 2025 12:44:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317B23F42A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399462; cv=none; b=EJ9piRrZldoSZLr800AevSKAGX9i044G2djK+S5KrUlMSr7Wsdw3csOH5kjXaQ/4jNVWdllADZFAMXzSchXH9gX/sXo3R4MQLnMXK2mtFKodgB1WWboBnn3/3tjY+n51MTKLoprwOU3ZRnOwDdtVyF6mjrSKQHW2hJkWWQ9CY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399462; c=relaxed/simple;
	bh=2u25kwkrDYfiWB/3PyBVzLYBOEWZXpsDAyW72cjMLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHBdO3kuUQn8caLUC/vSupheS3f7ErySzdF9LNNQaBYzzOa/1AhqfmS7S/xrARhIc5Y8vRiswT6i64CtgZ1IGZV8cktiQQaoYqvNKOFsyUT2Y4WqRK/REMKJJQfs1Z8AiQgRokw26yZxB3yR/o6JuqinbORAHRpB6IsjXgjOZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54GCi5VK016245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 08:44:05 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C4C982E00DC; Fri, 16 May 2025 08:19:38 -0400 (EDT)
Date: Fri, 16 May 2025 08:19:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
Message-ID: <20250516121938.GA7158@mit.edu>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>

On Fri, May 16, 2025 at 09:55:09AM +0100, John Garry wrote:
> 
> Or move this file to a common location, and have separate sections for ext4
> and xfs? This would save having scattered files for instructions.

What is the current outook for the xfs changes landing in the next
merge window?  I haven't been tracking the latest rounds of reviews
for the xfs atomic writes patchset.

If the xfs atomic writes patchset aren't going to land this window,
then we can land them as ext4 specific documentation, and when the xfs
patches land, we can reorganize the documentation at that point.  Does
that make sense?

					- Ted

