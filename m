Return-Path: <linux-fsdevel+bounces-39703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F33A17132
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73642161692
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6191DE2CC;
	Mon, 20 Jan 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H570/Oyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3417E4;
	Mon, 20 Jan 2025 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393560; cv=none; b=e46gkzAAYWerl6ThtgjiMZ46m4gNQvMDLzA38JsL90NpJUl4q535ztB6EmZXdX6dKHVJpzb6VVy43B4NywqJwLzNvav3Ghj63GmoS5JF5dGubXbgkbfA3Didg2IEhcKxoAvv2Slne06No/xDviRH+KcWnNlp+7mvnGbZKNdpGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393560; c=relaxed/simple;
	bh=Ze3ALp+tm0SlH5jQ/j4EIY0jADnX/Hj/ABHleVKoe64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1e2ZZYYZumMR1kwtqt179sbLq3EIRx2QNFvJtkG+0bLSeRrHF2o3HIgjgzvyRiFEoYnP0NfInxDYMNhJkohIBiCePZa/qddFS6P02KJAXgpIsh2chVyRtCo0PPCnb9TYbrVVC2AqsqHHgHIanHIJmNB+//5YV1UM9dd1IJDv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H570/Oyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED4C4CEDD;
	Mon, 20 Jan 2025 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737393560;
	bh=Ze3ALp+tm0SlH5jQ/j4EIY0jADnX/Hj/ABHleVKoe64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H570/Oyi8xMEfdOsDfaP4IlZvCfnir20o4W0iyWnhN/HFIMY4HavAJVyHwCGxdEWy
	 Mt5i/LJAzzrMgoYH7domiMiRL34LUR6qs0CRcRXjt0QnHdx7MhrZ3wWaNc8u+dWqOc
	 LDBw3QO2JnGsrtL1MM4HVXERvfb+XzGA2pO+SxIcLlZx4ixYvCa3J6ZyACZm+ZwvXC
	 Irsh0TftGQhyqiotArwlj/NKrwZiecG4FJS8HGuucVSKB1dH47Vcu8QY5uWL+1lyI2
	 OlDEPOozxTFvL/TRebo7fR7YGPsoC4FqHxTlc/tcyHd03672FPsrUWNOcHSxVLwQRE
	 9Qzh7BOvEIofA==
Date: Mon, 20 Jan 2025 09:19:18 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, fstests@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Error in generic/397 test script?
Message-ID: <20250120171918.GB1159@sol.localdomain>
References: <1113699.1737376348@warthog.procyon.org.uk>
 <1201003.1737382806@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1201003.1737382806@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 02:20:06PM +0000, David Howells wrote:
> generic/429 can also hang:
> 
> 
> 	show_file_contents()
> 	{
> 		echo "--- Contents of files using plaintext names:"
> 		cat $SCRATCH_MNT/edir/@@@ |& _filter_scratch
> 		cat $SCRATCH_MNT/edir/abcd |& _filter_scratch
> 		echo "--- Contents of files using no-key names:"
> 		cat ${nokey_names[@]} |& _filter_scratch | _filter_nokey_filenames edir
> 	}
> 	...
> 	nokey_names=( $(find $SCRATCH_MNT/edir -mindepth 1 | sort) )
> 	printf '%s\n' "${nokey_names[@]}" | \
> 		_filter_scratch | _filter_nokey_filenames edir
> 	show_file_contents
> 
> on the 'cat ...' at the end of show_file_contents().  A check that
> ${nokey_names[0]} is not nothing might be in order.
> 
> However, in this case (in which I'm running these against ceph), I don't think
> that the find should return nothing, so it's not a bug in the test script per
> se.

Similar to what I explained with generic/397, this can only happen if there is a
kernel bug.  Feel free to send a patch that updates the test to not hang in this
scenario, but the kernel bug (which is presumably in unmerged patches and not
yet upstream) will need to be fixed too.

- Eric

