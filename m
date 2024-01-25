Return-Path: <linux-fsdevel+bounces-8991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626F583C96F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CEB1C25809
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D8130E25;
	Thu, 25 Jan 2024 17:01:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE6130E35;
	Thu, 25 Jan 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202080; cv=none; b=lPzUD4hx0gF5xRlxmqtVH8sHWt6S5XW5Zx7mtk6yNPJZlHosB+WQ+TMMHIzP0ricMAY/fTHo8QsMNaKs/N3Y/ASU7qSsp54czPEPzLywkG7IkyzGQXOSl2dyyTeXFWz1xPqsIjdbMuLdkWzcVubHm9P3JadTZMZSLbzt66mbJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202080; c=relaxed/simple;
	bh=/0GrOda2JSMiMrDqGGsVJYdEJkS4Qaosx5QqAE9plV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn99o9D/DK/zGSUF2oLBNCB2mr+IKe7Alb+rltZ1kGdydqi0KxSOTaEbgMV9906CCaakswR3Mqd/72EOXsNhTfmfS02rSElZ/gk/uQr0OU3s7FGC4gDeX6f32BvwiQPH5eE9WYM0BHGGs3rt2Uck3aTWDcFISuGh/FhLRsqOJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FFBC433C7;
	Thu, 25 Jan 2024 17:01:15 +0000 (UTC)
Date: Thu, 25 Jan 2024 12:01:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com,
 steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com,
 hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 00/35] Add support for arm64 MTE dynamic tag
 storage reuse
Message-ID: <20240125120116.21200fc7@gandalf.local.home>
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:42:21 +0000
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

>  include/trace/events/cma.h                    |  59 ++
>  include/trace/events/mmflags.h                |   5 +-

I know others like being Cc'd on every patch in a series, but I'm not about
to trudge through 35 patches to review trace events, having no idea which
patch they are in.

-- Steve

