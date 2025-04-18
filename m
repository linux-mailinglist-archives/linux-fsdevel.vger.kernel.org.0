Return-Path: <linux-fsdevel+bounces-46674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF40A938F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B02119E7F94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F21D63E8;
	Fri, 18 Apr 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="eO5PJr1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4ACEEC8;
	Fri, 18 Apr 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988079; cv=pass; b=SZIuGNYIzlCzN+tFUlNWq7zVIw8+UtS9Jrojf3AV9MGcY5JyAPTy/snyb48Q+Xc66AjEOaslg2chXTJSmu+Gh+5H7IF5x5IsMwgfG7TnwAbXtNWNp+VNImFi64h8UUlk3hbFHDNspFbUXldVTPcdhjRv5ZvIgJFvltCCsQU+ZEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988079; c=relaxed/simple;
	bh=WggftEIK2mvt4u75qp2O03tHBXothXB+itpeElo6ZYs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=puZe5tNSLCEoNpSD103yZ2+b8umHwWftSJBX5KCpyJSA9bihk95XTEFGyF7xZEIkct1ZVvt1J8xJBnAyl2b+hcTvjYv3f+v2Xq9LCJXLy3nvBhWb/rqmDAWQfXqjuKn/MpE1cIYJByTPWqKGkVLSh9Q8ZK8S67g5nuJbbYcJl40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=eO5PJr1C; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744988069; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nGiifR6RnL7JVLdQrl4WbShTC6W/w1YaBpJQVmovhKNOUyw2SxNAlYRauud1S8YzylvC1HpUgkKkI+ubqFrp1IQVj2JPWsoQ3ZMX7COHLACqAjbW1PRw95Suw1DJ9+WfpdwDhcezXC/Hg8+ldeUtW8+CXoUkx5JzygF8Qy4vdwk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744988069; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BSd3sz8Qz860VcIh/f0YXhtMUJ/XA/IsbbFc//H4pQA=; 
	b=Tbvbd4rPctmwQz3yn0s8Qr1rn+VYk27F0jJeL+4+RV5L6DgmxdAQcNAfnsyLEXGofYq9aYQK/KP0W8SoetfnP4yqOJswuE0U/Uik+6E1K9P2ResZIVppQ2ZEyeqmbuQcCeuShFghc9msrrGxYV4Rg5vRsnWs1jmqhPUOkbOxmWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744988069;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BSd3sz8Qz860VcIh/f0YXhtMUJ/XA/IsbbFc//H4pQA=;
	b=eO5PJr1C64JuEDfPqoFinkyRjDPX8yQnqZ7sD0npe3iv5xgc3lMRghKsasNQXQtx
	6Q0xWNoPWEvMjp2/z6XF0OygWjYp3nK1bprblJHiuBVvUlsDB7+87Q2GyRnhasw1ezB
	9e7Qg7bIKBI0P7LmOXQ9+dsJrtVAN7qBT5L/IpgE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1744988066829910.0793453823826; Fri, 18 Apr 2025 07:54:26 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:54:26 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Luis Chamberlain" <mcgrof@kernel.org>
Cc: "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
	"Tso Ted" <tytso@mit.edu>, "kdevops" <kdevops@lists.linux.dev>,
	"fstests" <fstests@vger.kernel.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>
Message-ID: <1964964d3f7.10a86724c62742.5510698901836310404@collabora.com>
In-Reply-To: <aAEyNxkMyJEVHRhR@bombadil.infradead.org>
References: <aAEp8Z6VIXBluMbB@bombadil.infradead.org> <aAEyNxkMyJEVHRhR@bombadil.infradead.org>
Subject: Re: Automation of parsing of fstests xunit xml to kicdb kernel-ci
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



---- On Thu, 17 Apr 2025 13:54:15 -0300 Luis Chamberlain <mcgrof@kernel.org> wrote ---

 > On Thu, Apr 17, 2025 at 09:18:57AM -0700, Luis Chamberlain wrote: 
 > > We're at the point that we're going to start enablish automatic push 
 > > of tests for a few filesystems with kdevops. We now have automatic 
 > > collection of results, parsing of them, etc. And so the last step 
 > > really, is to just send results out to kicdb [0]. 
 > > 
 > > Since we have the xml file, I figured I'd ask if anyone has already 
 > > done the processing of this file to kicdb, because it would be easier 
 > > to share the same code rather than re-invent. We then just need to 
 > > describe the source, kdevops, version, etc. 
 > > 
 > > If no one has done this yet, we can give it a shot and we can post 
 > > here the code once ready. 
 > > 
 > > [0] https://docs.kernelci.org/kcidb/submitter_guide/ 
 
From KernelCI side, we are not aware of anyone who created that xml->kcidb
processing.

It is a good time to discuss that though as we are making some fundamental
changes in KCIDB to improve performance and  allow it to be more agile in
how we deal with the various needs we are seeing from the community.

In a nutshell, we are creating a new interface to publish the data to KCIDB and
also allow easier local dev env for people to try it out. Thinking about your
need here, maybe we could go as far as having an endpoint in the new KCIDB api
that consumes the xml directly and do the translation internally. We should 
also look if the schema is enough for you or new additions may be needed.

For context, for those not aware with the new KernelCI infra. KCIDB data
is the backend of our https://dashboard.kernelci.org/ and https://kci.dev/ cmdline.
Mind you that both project are quite new and will grow more and more functionality
over the years. We'd be happy to collect your usecases and see how we can evolve
our infra, dashboard, etc.

Best,

- Gus



