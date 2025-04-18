Return-Path: <linux-fsdevel+bounces-46693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD01CA93E30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BA83AE06E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB522D4D6;
	Fri, 18 Apr 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbtOo8tc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9821D3EF;
	Fri, 18 Apr 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004484; cv=none; b=Oim2RsoEKaVUkPf2T0qGXjCKXFr7mLAsxhUj5m226aHZPGAa7DcdvgkmYGwDQ0kYzY7pC3/PWLNFHNDuQ3VR7RD5AJmdB5o1z6xVsqWq9TH6Z5a8F6SpjP7iOWpZqhYe9ffUzJrHCV2nnBQovvnxxLp5qP9weZ/Zf904oTOR3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004484; c=relaxed/simple;
	bh=uO4bGsFgiDo9hGv9uHqmKwNnaBmfTXIRQpj+YFlQtns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POsidwSK0ndVNildHgh8OrZ73DD5IEAPRXluIK/6j4kzFj/1eLbCS9Jumd6G9LPCwuETaT6zWW3FRSphNhcEpWat4UulaSJHwhbRUwLQdxJ28Q05NxgNxF2CeiOs2fVp0ojjzFhZyUHUMkH8FJKIe2nRtncLPsXWm19WlXOIfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbtOo8tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C15C4CEE2;
	Fri, 18 Apr 2025 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745004483;
	bh=uO4bGsFgiDo9hGv9uHqmKwNnaBmfTXIRQpj+YFlQtns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbtOo8tc8APFcu6gcBG2FpRw0JycmU8rEZigk0WCx34mW8deiAVK7n6JX/NrM/bMU
	 B0bFK+YqHEbCYej/Ht+u3m77cJym6E5GhnpqBDwM71yeUAKAKFHzpAXob2J2hQSrJu
	 V8gmi3OM8l+yBUrW1r+ylrA9/fc9aNMC1NlmMM5ONpmjrrEYKhsWtck3sa+ug+HrVz
	 KIjTiljCbGW7rAUsErmvmAob7bWMqDilgpeSnqX1Wh6WL4UYIr3YY6LSjaXL6XY4rO
	 jhxBQqs8aa8XTKTn7euGBJ3PHmJ0NwsVpdVsZOPbGwyXXE6iatm0s/jlf31IiGmWlJ
	 r+k9WXXYNAmlg==
Date: Fri, 18 Apr 2025 12:28:02 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, Tso Ted <tytso@mit.edu>,
	kdevops <kdevops@lists.linux.dev>,
	fstests <fstests@vger.kernel.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>
Subject: Re: Automation of parsing of fstests xunit xml to kicdb kernel-ci
Message-ID: <aAKnwgdSPGGj_6aM@bombadil.infradead.org>
References: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>
 <aAEyNxkMyJEVHRhR@bombadil.infradead.org>
 <1964964d3f7.10a86724c62742.5510698901836310404@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1964964d3f7.10a86724c62742.5510698901836310404@collabora.com>

On Fri, Apr 18, 2025 at 11:54:26AM -0300, Gustavo Padovan wrote:
> maybe we could go as far as having an endpoint in the new KCIDB api
> that consumes the xml directly and do the translation internally.

Yeap, that would be better. It can enable different fstests runners as
they likely already collect these. And for the kdevops-ci pipeline
its a simple ansible task for us to do this. It would complete the CI loop
for us.

  Luis

