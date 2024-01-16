Return-Path: <linux-fsdevel+bounces-8053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248882EDBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DA01F24441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211AD1B812;
	Tue, 16 Jan 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6ulxtos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844381B7F3;
	Tue, 16 Jan 2024 11:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3342C433C7;
	Tue, 16 Jan 2024 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705404665;
	bh=vMXrSx4Nwi3vxadj/00+0r1snv5SIOyd7UNE/keErUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6ulxtosPZDLXQfq7ZLtVa2oAUTeFS+XSpqns4C/59N+hsLl6Ik4FqYUwln2OejAL
	 aJG7JXNux7JxFa6kYvXxBBXulmqGj9pP4Z0Fs39kABNXplkuLhpjiY4/7M7SVya6Vx
	 MV8Rqg3mTHVnth1HKu8o9ocl58v4I0hKFkf2BBpZWytxsmuRMdnrUM9Du5Gqpr0gva
	 rDNqfhG/vTqWp7nJ2+3QznBVxEqc/ynJdwmLVZtSQi729X5bugG0lBfhqnkuSexyw/
	 6K5a1sc38srQhS6DB6fjgRrvsZoT4bryFmdeuOaJcNqy37eZmDFbWW8q5oJx6MB4O8
	 pfqU+lfOSqilQ==
Date: Tue, 16 Jan 2024 06:31:03 -0500
From: Sasha Levin <sashal@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>, Ian Kent <raven@themaw.net>,
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 12/14] add unique mount ID
Message-ID: <ZaZo98YNJNilBSVI@sashalap>
References: <20240115232611.209265-1-sashal@kernel.org>
 <20240115232611.209265-12-sashal@kernel.org>
 <CAOQ4uxgGY1949dr0-rt5wuNu-LH=DiRSZrJnamD9bgUtGM9hKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgGY1949dr0-rt5wuNu-LH=DiRSZrJnamD9bgUtGM9hKQ@mail.gmail.com>

On Tue, Jan 16, 2024 at 11:04:12AM +0200, Amir Goldstein wrote:
>On Tue, Jan 16, 2024 at 1:46 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Miklos Szeredi <mszeredi@redhat.com>
>>
>> [ Upstream commit 98d2b43081972abeb5bb5a087bc3e3197531c46e ]
>>
>> If a mount is released then its mnt_id can immediately be reused.  This is
>> bad news for user interfaces that want to uniquely identify a mount.
>>
>
>Sasha,
>
>This is a new API, not a bug fix.
>Maybe AUTOSEL was triggered by the words "This is bad news for user...."?
>
>You have also selected this to other 6.*.y kernels.

Ack, I'll drop it from everywhere. Thanks!

-- 
Thanks,
Sasha

