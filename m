Return-Path: <linux-fsdevel+bounces-16503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7BE89E64C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DEE1F21011
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3915B122;
	Tue,  9 Apr 2024 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjDaqnqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C8159212;
	Tue,  9 Apr 2024 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706145; cv=none; b=W1Hw2Qo1ENXhjaJnzzHdF7WZXQK0JVSdR5Vrli9YgnIdzoncpwS0D+K5UaH2WlHYe3sgBKYBOEIwhncH1uEuTryhjQd6FrrvGSATxtmT0b60cIx5Id/gEk4enWd9MKxnZJKzNIlqxm09EN1l+4MnwB3dOg9gwkcTpFilBpPnCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706145; c=relaxed/simple;
	bh=M3NTKoz6i/MfH0Y0+kKbB9mYAFxrKaCM+rlSSUxc7M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6zAkG6JtrkirGqaKWvywwES64mNPOcsM/DvzNFSX0kwAaBHFI8mCULAxseCDnuLMPVjLQnqLtN4yxQ/mLAvzeroNfel/U99UQcWcWdQnU9ZariVed2ZQldrsELvBpaR+KSviEUqZVqMoUtdlSAVgbuJOjqcy76Xxt7HKcKbvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjDaqnqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99552C433F1;
	Tue,  9 Apr 2024 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706145;
	bh=M3NTKoz6i/MfH0Y0+kKbB9mYAFxrKaCM+rlSSUxc7M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjDaqnqcuXe8ohv4nh7prZjV0GZFm+gO4dh1m+mCiQfPGPUV52uwKMjcZgV5Vq2u6
	 6IE/rvUfReGjttz3KwGMiiOyXuBO7+4dhIPt/EAsDySKdR6mkq8uAgvr74KYvS7sjz
	 VIdNmhLz6XcZEVpBmTwgnuBhL/G5scU1qYojBAPkl+EIeK7qE4Wk6O37l8O7dFP+rL
	 086vdZPHzxnL13o71EH+IfiqVu5r5ps5oqsj8ZRDkaexR3qvAlyDb9MQqdln33sXs0
	 yI8IpPaAEQxXxjlcXJsK/XIw9hcisOFX0OJOVlVwcE3OEU7VR8mrRoBd/Toubd2RRZ
	 spBW45xqc625A==
Date: Tue, 9 Apr 2024 19:42:22 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v4 00/46] btrfs: add fscrypt support
Message-ID: <20240409234222.GB1609@quark.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>

Hi Josef and Sweet Tea,

On Fri, Dec 01, 2023 at 05:10:57PM -0500, Josef Bacik wrote:
> Hello,
> 
> v3 can be found here
> 
> https://lore.kernel.org/linux-btrfs/cover.1697480198.git.josef@toxicpanda.com/
> 
> There's been a longer delay between versions than I'd like, this was mostly due
> to Plumbers, Holidays, and then uncovering a bunch of new issues with '-o
> test_dummy_encryption'.  I'm still working through some of the btrfs specific
> failures, but the fscrypt side appears to be stable.  I had to add a few changes
> to fscrypt since the last time, but nothing earth shattering, just moving the
> keyring destruction and adding a helper we need for btrfs send to work properly.
> 
> This is passing a good chunk of the fstests, at this point the majority appear
> to be cases where I need to exclude the test when using test_dummy_encryption
> because of various limitations of our tools or other infrastructure related
> things.
> 
> I likely will have a follow-up series with more fixes, but the bulk of this is
> unchanged since the last posting.  There were some bug fixes and such but the
> overall design remains the same.  Thanks,
> 

Is there a plan for someone to keep working on this?  I think it was finally
getting somewhere, but the work on it seems to have stopped.

Thanks,

- Eric

