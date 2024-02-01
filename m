Return-Path: <linux-fsdevel+bounces-9854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A0845550
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171071C294FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD4F15B977;
	Thu,  1 Feb 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJUCT4N+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB415AAC4;
	Thu,  1 Feb 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783259; cv=none; b=dbH58xxQSPlwfo6Z1mUNGKpuZWS7go8Eu2nPleQt54TdQNWLJ26ChSVYXJBbEJFer57IpSBDd1loq9f2Vb8oKI8KdZ9TnGTUE+684JTfHOaKb1dgPXSrNrWcqrOOUZfO5dMs7kS/QsxDVSFZ6S1pQKRXxXPqjnIBUhBJw7mff2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783259; c=relaxed/simple;
	bh=Ja61sSGoZwqA+IWDDY3U5LhiD9rMbqKjVh16oqMotWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO/AtbGce+HCmW7mMUTRx9/4BEmcVTMrFKi8gJtwJL6xP8m/rTcg6OspYoIc8bDyvplT4sho1ACHbbFOwWzLfGfnhj1CQzhskcgC2x75UNgy6qYHqOzW6DvHysKAFIyiYWqgXzQCzrSSlP1WuwrQCkJQ1Y85D4DA2azn9Qkfmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJUCT4N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1FDC433F1;
	Thu,  1 Feb 2024 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706783258;
	bh=Ja61sSGoZwqA+IWDDY3U5LhiD9rMbqKjVh16oqMotWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJUCT4N+kH1vAAGH8WhlNhVmmZuBulWi8/3qp35XqQhS4lwBio+k3jLKxs4XmxnRM
	 9hyvqPQZCbjcmvf3Ww4ZLN7+tK3ODK/0wrL8Xuh7arpnTf0SpZFxSU324KWCj/bwmO
	 C0ToEcbLczjfYgBi872k4Wp75zKIDe1VPpqQEjQL8AHU3jp8xQeliZjD9cxxsxm3yw
	 cFgYXBbKSmH6a2A9WFDY0azU3098qfdQ9XmJWlzx+A5t33i77rbDbEAzgiZEZdIve2
	 qN+nFU8gWyOC1HrVIxekOiGtR3RMZTvG00k/ZQcuRhhJKYkMkMIexWzO3BEGqbUkEz
	 iXtriJilD8R2g==
Message-ID: <86af03db-80bf-42a1-9f47-f8e0f185f8fc@kernel.org>
Date: Thu, 1 Feb 2024 18:27:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/19] fs/f2fs: Restore support for tracing data
 lifetimes
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-9-bvanassche@acm.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240130214911.1863909-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 5:48, Bart Van Assche wrote:
> This patch restores code that was removed by commit 41d36a9f3e53 ("fs:
> remove kiocb.ki_hint").
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

