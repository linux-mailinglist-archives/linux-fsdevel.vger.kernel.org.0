Return-Path: <linux-fsdevel+bounces-33044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7727B9B2ACE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 09:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AEC1F2214D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B024192D61;
	Mon, 28 Oct 2024 08:55:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15784155C97;
	Mon, 28 Oct 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105719; cv=none; b=FhYINCNgx9Yth9G4GVkOSbriNAIlCDE2UiF1Y+1MOz11MG9+HMtFV/NTmXWiCoYEmCxjjADPGknVvA67NFqOQVvMQlWcHn20MQtw3bcWnxTcxcpF9iYj0ZLUWZdxTZtXj+IBh72J7z1ucMGyUQP5R5vBEpQa08Wz2nZX5JbZ6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105719; c=relaxed/simple;
	bh=kLA/lkXLwzdki11fHwX8/rZ3POKVHr3Ht5GY11Putvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9S7fjagStJnEOBeDFE8TTv0SAbtlC90sL+66KqPEWXiujnsF3cj8hfWfDmxYve0huAdCuRBLolLrpfKWbcmjZPbLgJEfcwwu+e/iz3M+ZKpL4Yzi004wsLwO1YfEEooscAZHWkwc/ubrliXCU/d1HOgA6yukOFpuWYeoOX+JLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE52868BEB; Mon, 28 Oct 2024 09:55:06 +0100 (CET)
Date: Mon, 28 Oct 2024 09:55:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hugh Dickins <hughd@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if
 KMAP_LOCAL_FORCE_MAP
Message-ID: <20241028085506.GA27771@lst.de>
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Oct 27, 2024 at 03:23:23PM -0700, Hugh Dickins wrote:
> generic/077 on x86_32 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y with highmem,
> on huge=always tmpfs, issues a warning and then hangs (interruptibly):

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


