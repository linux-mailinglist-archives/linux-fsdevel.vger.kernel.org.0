Return-Path: <linux-fsdevel+bounces-46416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F6A88EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2133AF4E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEE51F3D5D;
	Mon, 14 Apr 2025 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVxIp3rR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3EE571;
	Mon, 14 Apr 2025 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668899; cv=none; b=AGUoGMX6cH6/J4Hl33VUf9JNG8VkIwwqoZOnus0LnRlizVAvy2b4n+jkiLSN0c33ItVvN4PtA31GKZ9cweUy8bF4FME1U6/S8AdyaIXY6tr2LhEt00y9NtY9JbhjKYk/mfN7zttHpjzUVRvMkaPxs2k0uaRqbBI+uKZA9EUgxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668899; c=relaxed/simple;
	bh=xzDcJCfrEuyLCwWRwe6LNiMevTZTMXv32nG+rwlxAAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQFBD8UElGjZHTY7lQPhrbxEgaoPafHJ814tzNnVAGnk2OkSncWEtXmpKAGrJFCZ3qVKxZmQ3KsuP+hFNS/TT59e+fxuVpavCTUPOJtIbOrPQ1SPgnhs2w2Mf+tqUFGJmmhMzGZYxrvvmx1SjQ5zDn2PbA+reIfr3cCdmTn8ld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVxIp3rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E893DC4CEE2;
	Mon, 14 Apr 2025 22:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744668898;
	bh=xzDcJCfrEuyLCwWRwe6LNiMevTZTMXv32nG+rwlxAAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVxIp3rRBDeeaPJtjJSRFDCrF7TRvAM8n+N3gTMnvH4fFDR5e4NdmEhvKiaxQks4l
	 N5meZND17goiYnKB51OkxzPS0lApeoNBHEnkVp4HoAzj7B8v/LBUZN97kSYuVWO1QH
	 NnIa77MW9EsLtMDbupY3hYlB0lPGhWLmhCLDIPDgPKJ7YtBngzMt320oKzv37hXJhb
	 V32vyL2uzyJ+yn5fw9QjltW7vlRvjxiqBX6x0LwmoT/YaDvu2ILmo2OybFKY2NMMaK
	 yGePwyXu7UleNAzB5mj21EW3Yl25UxgWA0xNHysewfi7XFa5t8RaoTmjbUKSck9Q2U
	 uVlepqwNxBdbw==
Date: Mon, 14 Apr 2025 15:14:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation: iomap: Add missing flags
 description
Message-ID: <20250414221457.GB25675@frogsfrogsfrogs>
References: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>

On Sat, Apr 12, 2025 at 10:06:34AM +0530, Ritesh Harjani (IBM) wrote:
> Let's document the use of these flags in iomap design doc where other
> flags are defined too -
> 
> - IOMAP_F_BOUNDARY was added by XFS to prevent merging of I/O and I/O
>   completions across RTG boundaries.
> - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
>   for filesystems to inform the iomap that it needs HW-offload based
>   mechanism for torn-write protection.
> 
> While we are at it, let's also fix the description of IOMAP_F_PRIVATE
> flag after a recent:
> commit 923936efeb74b3 ("iomap: Fix conflicting values of iomap flags")
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reads fine to me now :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/iomap/design.rst | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index e29651a42eec..f2df9b6df988 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -243,13 +243,25 @@ The fields are as follows:
>       regular file data.
>       This is only useful for FIEMAP.
> 
> -   * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> -     be set by the filesystem for its own purposes.
> +   * **IOMAP_F_BOUNDARY**: This indicates I/O and its completion must not be
> +     merged with any other I/O or completion. Filesystems must use this when
> +     submitting I/O to devices that cannot handle I/O crossing certain LBAs
> +     (e.g. ZNS devices). This flag applies only to buffered I/O writeback; all
> +     other functions ignore it.
> +
> +   * **IOMAP_F_PRIVATE**: This flag is reserved for filesystem private use.
> 
>     * **IOMAP_F_ANON_WRITE**: Indicates that (write) I/O does not have a target
>       block assigned to it yet and the file system will do that in the bio
>       submission handler, splitting the I/O as needed.
> 
> +   * **IOMAP_F_ATOMIC_BIO**: This indicates write I/O must be submitted with the
> +     ``REQ_ATOMIC`` flag set in the bio. Filesystems need to set this flag to
> +     inform iomap that the write I/O operation requires torn-write protection
> +     based on HW-offload mechanism. They must also ensure that mapping updates
> +     upon the completion of the I/O must be performed in a single metadata
> +     update.
> +
>     These flags can be set by iomap itself during file operations.
>     The filesystem should supply an ``->iomap_end`` function if it needs
>     to observe these flags:
> --
> 2.48.1
> 
> 

