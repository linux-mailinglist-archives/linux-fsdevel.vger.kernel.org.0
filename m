Return-Path: <linux-fsdevel+bounces-14175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CD878CE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 03:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30575281F86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F2C13C;
	Tue, 12 Mar 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfGb9Gjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26EBE47;
	Tue, 12 Mar 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209590; cv=none; b=ZjSYVdEdd5qFmrMtEz91p3jgujl0Hed4PGvPnq5j9bhusV3tDJZ5EKJQm2mgNuze6Sw7FktBz3SBbg9DbQzp4V8DXZSKdFrbb/hQMkHdJWxCbnL8kaZJ0Lu+f5KbzopSnV0nlkZheOxFP7pm5Kp6Oagt2Y39XP3TlR82x/i15rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209590; c=relaxed/simple;
	bh=M13j/FiOeQLQqYn62WVaTaw1CEpghTNC1+EUk79X6eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaDvJ2S6ZfXjT3IqLMCuXRiqQ7Nid+W3NNIV7nqz5WEiq33pjGXeqTZBZlZTyZGKprwPjwMp+oEW1RcE2XhdnRKjNSQQUSWsTaMFXyhW1/NCKLKqPMsss0EOua7DJuWkNXhzPS1qHbnQaT1Kz5Vum0KaTDwROJZwnE0ld/DJ1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfGb9Gjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B36C433F1;
	Tue, 12 Mar 2024 02:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710209590;
	bh=M13j/FiOeQLQqYn62WVaTaw1CEpghTNC1+EUk79X6eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfGb9GjnsUqVbDazG2+BcDsVSoSxIPPza6GM7U3qpAT9gQZNQnFEPzczM0t2s+J5Q
	 KjtScZOrbjh2nMkg6VTS5l1uwmF/p8M1q2ybCJqJNyanau+y2km7Rwh4504OybAxph
	 JldRAGuflPm+s5U2MxYCDMLA2Yit5IJcWA04eSBQtpZ67PQ7LicCSoRPYT1tA4+PNE
	 0JVuVVG59n1qHDweMwby7Rifq9v0zQrbYUk0HoW3+ZlRYBgE3t1ewklthlzGf9IYW9
	 kk1jM7gSm5jKdutK+s/kERPz9fdfsvGzweNSiUgogxeHjjCKGcwR1+F4+0wAcz+MT6
	 mBq74rhtHN4YQ==
Date: Mon, 11 Mar 2024 19:13:08 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <20240312021308.GA1182@sol.localdomain>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308022914.196982-1-kent.overstreet@linux.dev>

On Thu, Mar 07, 2024 at 09:29:12PM -0500, Kent Overstreet wrote:
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +	__u64	stx_subvol;	/* Subvolume identifier */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */

The /* 0xa0 */ comment needs to be updated (or deleted).

- Eric

