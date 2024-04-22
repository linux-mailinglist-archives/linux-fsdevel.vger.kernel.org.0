Return-Path: <linux-fsdevel+bounces-17440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EE8AD648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 23:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A9C282F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06551C69C;
	Mon, 22 Apr 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="THwxUERf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FA1BC44
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819853; cv=none; b=UnaLHysV4u4Xlqt7crpY+ObfNnxd2sQvFPP6HfeaBpaF8Nbhic831zc7C9VmDhSVSKgTilaK/iLbDMwmDRsRcTYUErC26I+jmzmC3ca9eXw044roSQcgGLr2S+guwdmdiLfH8NShsHu+xaxYn+qe88E4syKLCQohs0u4Aa1x2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819853; c=relaxed/simple;
	bh=i+AsQI7Y8ABqQ8l7E2JUAaUunz9klDfREkVt16QywZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hxDHgQjBccUsEHH3XVlKuw9zV6VCY+SnvvY4ZCF8NEIvwsv/NWvHq4AYOYqCG8eRd+QNRaaGzauDms17n6QE6BbqJ/ktznllmJTMucZS0vN4uGEP1y2k9v8tqHyeAk9ABlT2q0nSYwFRvVCPSS4TKeYuo6aHYzJ33JXeZw2CKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=THwxUERf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Apr 2024 17:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713819849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Iatde8BcB8zqicLv77Cl6Hl7+uMV8vbeql13AWI3gAQ=;
	b=THwxUERfPIWHQGnz0Xs/lDnlanPsXHeby1voz1+KXgJrWm/UBuoBVrMM/H9VOqLkd8pUxD
	ubpZZUy4EgDzf4TleNbs36uEQLm7DljcGwEoq+82r38OMqUeqD19gRoltcyF33h8TF6g+N
	FLF6CBPghhYLo032FVARAo/bDWtUOcA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: weekly bcachefs meeting, 1PM EST
Message-ID: <xeezdsisgeku5sjoqlpgkijgxxsqcy6lu5fz563khmr72armns@xu2jqclpz2rv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Shoot me an email if you'd like to come, and something about what you're
interested in or would like to talk about.

Good topics:
- bugs you're working on, behaviour that needs explaining, or
  better introspection/debug tooling
- short code walkthroughs
- short, focused code review
- design questions for things being actively worked on
- support issues that may need my attention

i.e., let's keep everyone abreast of each other's work and help each
other stay productive.

And as always, the best place to meet and discuss is on IRC. We've now
got two channels:

irc.oftc.net#bcache - the general and oldest channel (hence the name);
this is more user focused - debugging, some support, as users popping up
saying "hey, I noticed something interesting".

#bcachefs-dev - this one is dev focused; it's quieter so that us devs
can say "here's this thing I'm currently banging my head against" and
hopefully get a response :)

Cheers,
Kent

