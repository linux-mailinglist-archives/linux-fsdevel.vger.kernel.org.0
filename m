Return-Path: <linux-fsdevel+bounces-2609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9207E7052
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A891C20CC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97613225D8;
	Thu,  9 Nov 2023 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjzxwYfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC3225D1
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604CAC433C8;
	Thu,  9 Nov 2023 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699551103;
	bh=yw1+dMSHryvzbQOtzOSy0565I5iHkA6GcW4kj0I0PWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjzxwYfswCW/UyuHYD7w3FnWyAkos1I+9BQv0IGzeyFDnG0UklNNhwqoc5WOWsKgt
	 MRPox/NvlvaV5hibTLQM2nmIdPQG1uA7vnj+oXhGPIMGtSBWIjtOFo5SQQeqs7R03c
	 fJO6Fltdzw8761WUss13a2GtCIXv6EiuoID8IGW8XT0MZrP0VioItfgrrph0r7eDIZ
	 SwM5H/aKdPXxuZWWEncPuiRGqFe4zj3dmV9fHM/IccqOHAiOmWQlPjIFpMnl2ED7+N
	 UuwFeFWYx9HRSOBQSRWx1d50ED5y1dXB1CkDdFUJgncSo4vfEYDUxoV/vzfJN056Lh
	 SSIV0qzo5yNrA==
Date: Thu, 9 Nov 2023 18:31:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 20/22] switch select_collect{,2}() to use of
 to_shrink_list()
Message-ID: <20231109-epilog-einmieten-745c51a66e9d@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-20-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:54AM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

