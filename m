Return-Path: <linux-fsdevel+bounces-6357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C8816BC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 12:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7AD284098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783A199B0;
	Mon, 18 Dec 2023 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQnL1DHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B419440;
	Mon, 18 Dec 2023 11:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F148C433C8;
	Mon, 18 Dec 2023 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702897296;
	bh=Kb6dYG/ryhyP0hvdGEBkTmdwpexNT9Kowt2FvETFB3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQnL1DHJE4666k/m9RL5F1l1h5zanWZZ+BcB8sPv9VUMeR1xgPJ4zm3+wQkXRaQUO
	 cgOVKbAmfenSSlfcAeFP2t86gXhRn70xcsNq2GxuCJwH9n2Nvfhxnn8MhRJAEuK8a/
	 mtHMiXsD9/sII1Ood8zKtviH5xOzooFZyauSv1Dfy87BFDGyqTYvG1pkRJroVh8qrj
	 bOl5emrifOhwEJkaHPejiIQjT8FRsthuuk9EpWyh8uQ9R0Gc4Ry+m7hpvT6l0fmvVm
	 SzM2uqWai9dsqwAefixvEvMjLhAaPkNoQHTT8IdZHBaTaJUkuqhasSfJln6+/BIqZU
	 j4noVi4MqKPZg==
Date: Mon, 18 Dec 2023 12:01:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com
Subject: Re: [PATCH 41/50] uidgid: Split out uidgid_types.h
Message-ID: <20231218-vorfinanzieren-portrait-cb624574b1aa@brauner>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-9-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231216033300.3553457-9-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:32:47PM -0500, Kent Overstreet wrote:
> More sched.h dependency pruning.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

