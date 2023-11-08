Return-Path: <linux-fsdevel+bounces-2373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C37E5220
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C751B2100F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ED3DDAE;
	Wed,  8 Nov 2023 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdcoBSV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B174D268;
	Wed,  8 Nov 2023 08:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24FBC433C8;
	Wed,  8 Nov 2023 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699433198;
	bh=zBx7ikgDXxddcT5dH5o0JgKPC1ejC+2JW19HaVE8kpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdcoBSV9NoSPU3eh8NvKBahrvuSJDzYpDcnHvNWOmVe5Q9S5aFwQfuvL3RP2A7LXN
	 ZbWnCX6RCKeZBzySaRnkIqdgxM+WFGTWG1tagm7sIehn14eSip5R4G5VWuKvshA5ER
	 9yq/zB9Y8j2HPfhVLS/d9Ot4VcWjzXaQiUTXhOtpJOO9LglxYREEGKOPftFnQely1E
	 VS0IcCmirKxdQCG5LZbXFGoe6IHeNaxylX0B5R8cFHP9sgs+WgAZ7oHuJ60ETWvno1
	 A4+DQQ6Xoc6PN1dWDzzuKF+Z+TKXbRVYA829cMe8PDcCEI8OXcOvs34aLlB0k99F9c
	 hBYjgc3pg5bZQ==
Date: Wed, 8 Nov 2023 09:46:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/18] btrfs: add fs context handling functions
Message-ID: <20231108-ablief-haartracht-a6619aab1077@brauner>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <e6dfe2604e70f50ca96ab03f8bd2c7bb03c8a6ba.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6dfe2604e70f50ca96ab03f8bd2c7bb03c8a6ba.1699308010.git.josef@toxicpanda.com>

On Mon, Nov 06, 2023 at 05:08:18PM -0500, Josef Bacik wrote:
> We are going to use the fs context to hold the mount options, so
> allocate the btrfs_fs_context when we're asked to init the fs context,
> and free it in the free callback.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

