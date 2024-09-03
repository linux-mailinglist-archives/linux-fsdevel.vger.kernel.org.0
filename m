Return-Path: <linux-fsdevel+bounces-28449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BA96A7E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 21:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661411C24326
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6EB1DC731;
	Tue,  3 Sep 2024 19:55:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CC1DC738;
	Tue,  3 Sep 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393327; cv=none; b=TAxmxRuSPrjs90l/qrrDjLMx9p1nc12VjE26ncn8D+aGD9HuF6skv04Pvo+wk1Ub3ob2kDSwgJ9RuopvTzS9f4Iu7STv9DgcLGAQS5VYGCJtsZRsPNX7JOY9iG6+3XxSEPspnCwPnvVAgK8sMZUjbIy691ZrzCqPcBgjXXX1mSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393327; c=relaxed/simple;
	bh=9wA9y60lgB2l86VTfcLvh24CGNDEFnyf4UUGnOXbhQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9WkyeG2j1DDfDwQn19rnR2W9yVpc8uMIl6z/Vpn3T0pYhanc15WkSwecYIRMN3btgCMfiMNFeUKIpX2VP2yXeDjJ7VauaZ14bxsdseIOaeEA0cJUtAbv/Br60DIZE6F6NZBbVCFltSJmwkEDg2zQk2i3DmcPayHbHcOnrm41Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E965C4CEC4;
	Tue,  3 Sep 2024 19:55:26 +0000 (UTC)
Date: Tue, 3 Sep 2024 15:56:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <muchun.song@linux.dev>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
 <david@fromorbit.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 1/2] hugetlbfs: support tracepoint
Message-ID: <20240903155623.62615be8@gandalf.local.home>
In-Reply-To: <20240829064110.67884-2-lihongbo22@huawei.com>
References: <20240829064110.67884-1-lihongbo22@huawei.com>
	<20240829064110.67884-2-lihongbo22@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:41:09 +0800
Hongbo Li <lihongbo22@huawei.com> wrote:

> Add basic tracepoints for {alloc, evict, free}_inode, setattr and
> fallocate. These can help users to debug hugetlbfs more conveniently.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Pretty basic trace events.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

