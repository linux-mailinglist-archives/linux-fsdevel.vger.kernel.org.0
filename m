Return-Path: <linux-fsdevel+bounces-9853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA084554A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8750B1F2B9A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928415B975;
	Thu,  1 Feb 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASRaSyv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD14DA06;
	Thu,  1 Feb 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783228; cv=none; b=oMAihAsEeorfGYoXEX400cKrORK39QvT/EG+QigV2r2VHmQvFQa65g0KcvUAIL8MGAH+h1bx5SSbDaO6YYTnMlKYj7JceFyL4378GOnEzgAzEBcuYsftzRE4VXYOJ/XbUT/gp1vI37lp00nA6C71ESWUiSvcJHvXyk+R7D0I10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783228; c=relaxed/simple;
	bh=3UsOY3a0MJBYjx1CKM7llVFt3Y2NhpbWQILpbMf7aUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDp33Ovld3KIau4qPnNUEe+UGUrIjN4128zNl5igTGoexMSwqDuObPiDBestHRmg2XPlrn+c7kaIM0hvpWf7MXMtjSt4oGmMsFV+xiqNvLYJCc0iszJd8iu47s1KJu5fFhMBCnN86pvx9RwEkjQsVBFwOaqF2fmTaX7xSOQnLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASRaSyv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271CCC43394;
	Thu,  1 Feb 2024 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706783227;
	bh=3UsOY3a0MJBYjx1CKM7llVFt3Y2NhpbWQILpbMf7aUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ASRaSyv2F7P+5wdEo0uEpH7ltxI9DIcfkvm5ymEtkiDuZ7LqV83PW5x1BLoKwxFA8
	 7lP4nsY5zNHfgtl3LGi1/O3MdaXMV+GVDpnaeXy9FlITAVQN+PnEfhPP7VdOZvTysU
	 4d0gr7pnbUsu3pEbTFEo4srfuN9jMjQM4MIkMQMZTlER++VIClUgwJPguqWM+uunWw
	 yAnADqoFqzpANVwimvNAIUzYer7jHOupsBdB/NxbQWLG/UgAzLsORXu0FbKiL0PuGl
	 M7BwxKoK9sBek3BJs+iQaLuAUFX5NWcxdGXQG9fnu/4x2cQxee34q06mEPQ2dUkjUa
	 4ey2dP/DJr/iQ==
Message-ID: <cf04fd5f-d63c-4340-9192-e50974d63c6a@kernel.org>
Date: Thu, 1 Feb 2024 18:27:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/19] fs/f2fs: Restore the whint_mode mount option
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-8-bvanassche@acm.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240130214911.1863909-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 5:48, Bart Van Assche wrote:
> Allow users to control which write hints are passed to the block layer:
> - whint_mode=off - no write hints are passed to the block layer.
> - whint_mode=user-based - write hints are derived from inode->i_write_hint
>    and also from the system.advise xattr information (hot and cold bits).
> - whint_mode=fs-based - F2FS chooses write hints.
> 
> This patch reverts commit 930e2607638d ("f2fs: remove obsolete whint_mode").
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

