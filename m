Return-Path: <linux-fsdevel+bounces-52164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA1AE0024
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350EB3BC319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F5264F9C;
	Thu, 19 Jun 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTEn//C6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138A824166E;
	Thu, 19 Jun 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322638; cv=none; b=EngLfIcY90T2ey/xSRoCHRy/n3xF7QsKyJ05xIo6Ajq0Mc1eBIdNu/ZHwuW0NCwG9ym03gFHLJ5S+4tsD05Fih6wdS5+YIQ2K+oc+K1UD6CPjle9qCKwsS4QnqeJW2h9xD2pbZdKmhhMbpyXGC72FxEDaO6EDWkiuom9Tzd0Rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322638; c=relaxed/simple;
	bh=7E7ww+LoobyNdSelS1odl2gtbJ2ZRBYhmgqDhaQPSSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSs8OcGkKRwet16mNOQQtecotV9d7vsw7NrfM7qEf89LWdS+PDzZq6Bo5ZnyCCxicVY+5vFRt9LUYU+fxWTTP5oQlbrV5eL1OKAZ/pNJBvKz4EIx6S5G7QbKWcdN3a3tBfL5iXkh+wZoCxkIyEED8eHmSI85rn0ZfZ46OZdcLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTEn//C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203D9C4CEEA;
	Thu, 19 Jun 2025 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750322637;
	bh=7E7ww+LoobyNdSelS1odl2gtbJ2ZRBYhmgqDhaQPSSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTEn//C66rmj2Hdt8gRRwMH+AcarNL9jQSyEkOdrH9QKnvmDi1EYn2jXdn0mS2B9C
	 UaNUZjW99OGCp7LEO5cpX3DuioAFbRUAW8isH8ha10ze/iNotjcfK0D41+lNlTQ/7U
	 CuHKxJnTuhZAp1edLn1Nk0nPWH6F4xaPqxii602C99ojA7Tc6wxrj40DDLMPaIhzxX
	 iZ9V7wTLkLpNfNtJI4FjkCEkAW7J4672Kjd8ywEFPT5nMYroETTZNlc0HfBWROhgen
	 F9cWU3iWKq1oNNlOio3xJP4XQPy409vU0GagzqYX6/uouI7aIWsuE1hUVeOCrqJHGo
	 3eRAIydRNuVBg==
Date: Thu, 19 Jun 2025 10:43:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <christianvanbrauner@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [brauner-vfs:work.pidfs.xattr] [pidfs]  e3bfecb731:
 WARNING:possible_irq_lock_inversion_dependency_detected
Message-ID: <20250619-rennpferd-annexion-f24c89ba6088@brauner>
References: <202506191555.448b188b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202506191555.448b188b-lkp@intel.com>

On Thu, Jun 19, 2025 at 03:27:28PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:possible_irq_lock_inversion_dependency_detected" on:
> 
> commit: e3bfecb7310ade68457392f0e7d4c4ec22d0a401 ("pidfs: keep pidfs dentry stashed once created")
> https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.pidfs.xattr
> 
> in testcase: boot
> 
> config: x86_64-randconfig-078-20250618
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

The branch is irrelevant. I can delete it so it doesn't trigger kbuild.

