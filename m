Return-Path: <linux-fsdevel+bounces-60177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E669B4273D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B72318975F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A9309DD2;
	Wed,  3 Sep 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYJFkgGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63D284890;
	Wed,  3 Sep 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917994; cv=none; b=kquSnQVXF0oWhuMiUvAoO2mUVADPbRbjkfogYFnvLMyNVLZp/B/wuBxRbn9jItyE2TaoKyn9IL72nZ8pLmZ7j8MOysO30QRCdUPyMBr9/9heKbSYKGo1poCmPUwfmELi4tcg013B06S3RBEfX0jtDAnUZRGittAqcCOUzR1fd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917994; c=relaxed/simple;
	bh=EdNiLGaF0ZMauav/t6Hrkbl+RAupFeS5umBN7p00M2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLEXrB51KaEEtvjWczrwkQ7myF9elEds9UW8849d0fgBSTig1WlKilRNtIBOOelEo+KY9Z0dJ+HqIckxY8fduH/OJZwZ5tOz/a6Pvd9F6szxQF29txFJDc3Hbo4Ixx9od6pAVzSBLv5V2YBG4dRuh6iDrNyXGZhNvvSw/HzsNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYJFkgGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C474BC4CEE7;
	Wed,  3 Sep 2025 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756917994;
	bh=EdNiLGaF0ZMauav/t6Hrkbl+RAupFeS5umBN7p00M2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYJFkgGMMdD/e0OL4JI0nTs9vwUj6bOLmGxIvBk+sW+wUTSPYZLYXyR/8ssHfAnVl
	 Qp3oVaKGYlyBEwVy39E7gRFDLTjtE5Vlj8qW2UESMG9kX2tpb2o63dkKBMUL39k4qR
	 Bg1U/aJpodahzMsuBXLcBWIrOqeU5UEmhBxb9bO2ymNtNde4MQovFHF9P36HjqiV4z
	 kzhgw2mn832BG6KViFc+g0WVN8d2TtEg4PGij3TIHFnrqj5SJeWq5a2hSa2XTJtUTk
	 f7VngzhnWi9b5fMcQtNpst3pdm3CWOS6H0mpgVp9lRVo4IsrvdwyxMn4TKGMC3zptX
	 ygZ4TlNDqKDhA==
Date: Wed, 3 Sep 2025 11:46:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	pbonzini@redhat.com, laurent.pinchart@ideasonboard.com,
	brauner@kernel.org, conor+dt@kernel.org, linux-xfs@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org, djwong@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
Message-ID: <175691799203.2492867.8315727734115798731.robh@kernel.org>
References: <20250902193822.6349-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902193822.6349-1-vnranganath.20@gmail.com>


On Wed, 03 Sep 2025 01:08:22 +0530, Ranganath V N wrote:
> Corrected a few spelling mistakes to improve the readability.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
>  Documentation/filesystems/iomap/operations.rst           | 2 +-
>  Documentation/virt/kvm/review-checklist.rst              | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


