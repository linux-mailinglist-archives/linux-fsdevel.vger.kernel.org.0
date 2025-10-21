Return-Path: <linux-fsdevel+bounces-64816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D95BF4DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0BCF4FDBF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDB27510E;
	Tue, 21 Oct 2025 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eAvSaztz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54A271441;
	Tue, 21 Oct 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030604; cv=none; b=DKJRyq+CuB3ZZpk5olE8k/LS6J+nl1Auck+ehCNhTjaMC2LlEjsGZxPwmAXsUQhPR9AfIp7YxJwnkQmEFavNNHXU4MAKlxRVCgxvohPICGPTJh9NJEOJbw/1q+4RLK2awrv97/x0ssFSWr58if93BAuqCbTV5Fqoz0XPw4ILkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030604; c=relaxed/simple;
	bh=pfGVVIir2RQOkaum3bBGVZD+n/ql71ATMmo1R7ohuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLwJKInnoP6kDq+eQYqhgDjOYVZtqfj+iObsY7OS6/iSH9pyWBdMOxF1ayCU0J1AwWFSUhJ69cUYaozfb/AaHx8gzu0bYAXtAdn3KwfYgb75cXvZRDUnqh+8sh3B0iUkcRlRohw0NL9l3eVR6ESo+jZemnhotFrJtaqXeK0cEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eAvSaztz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6203C4CEF5;
	Tue, 21 Oct 2025 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761030602;
	bh=pfGVVIir2RQOkaum3bBGVZD+n/ql71ATMmo1R7ohuCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAvSaztzGeTfBspxxIvesQX1/GdT5lnQTk5zVMPl3cEx66VNZTDvO+cEfcSQ2K2YM
	 wNVR7Vb+9h5Eyd+Gi+Fbude3GqJSd7CdsgN/4EkyBpNjGdp1+0lLBVK3B0CaIgi2dL
	 h7Z/Y/X85vKZq+ZcVJHDFdKpUY9kYeKTHEtFiWDg=
Date: Tue, 21 Oct 2025 09:09:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, mmaurer@google.com,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Binary Large Objects for Rust DebugFS
Message-ID: <2025102150-maturely-squiggle-f87e@gregkh>
References: <20251020222722.240473-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020222722.240473-1-dakr@kernel.org>

On Tue, Oct 21, 2025 at 12:26:12AM +0200, Danilo Krummrich wrote:
> This series adds support for exposing binary large objects via Rust debugfs.
> 
> The first two patches extend UserSliceReader and UserSliceWriter with partial
> read/write helpers.
> 
> The series further introduces read_binary_file(), write_binary_file() and
> read_write_binary_file() methods for the Dir and ScopedDir types.
> 
> It also introduces the BinaryWriter and BinaryReader traits, which are used to
> read/write the implementing type's binary representation with the help of the
> backing file operations from/to debugfs.
> 
> Additional to some more generic blanked implementations for the BinaryWriter and
> BinaryReader traits it also provides implementations for common smart pointer
> types.
> 
> Both samples (file-based and scoped) are updated with corresponding examples.
> 
> A branch containing the patches can be found in [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=debugfs_blobs

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

