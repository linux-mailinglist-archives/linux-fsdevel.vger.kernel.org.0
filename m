Return-Path: <linux-fsdevel+bounces-72836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E241D02F58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 14:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26C0B3008734
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC53BFE32;
	Thu,  8 Jan 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="peXM7D1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dP7tBLN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BB3BFE29;
	Thu,  8 Jan 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878354; cv=none; b=N65tlFmzY8e3b8b5Gu/xJohBWlsud4WK8PFHAOVjne4toHIz5vY8Y2938BEzHwKSLk5RUb7LrG3DFa9Uyy2Nhi3DK3NFZDTqAYcoFR3gQSgm3YvYPaxZLF+cYv1XZS96ySJR6C+4oeOIGr1D2xbE4JIhnW9q/XKejghdzaf1e9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878354; c=relaxed/simple;
	bh=0QJM7mL+z5gWp4HGQG/yH8EBOnM/5VAwP0A+m2HcDDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjUC93WHgO0CFqjvd0l0CEyeJ/f07Y+Y66PeRmutl/+0vMHH3li44Nmw5rGJ5MBHdoRUBGzGXvH9UWw6mmwtzkb5QVFgDUWb9j4KJy08HgWHk4fKRMVkxiQnDJhFGqUOAuJF3AQXcJAaSuAqkJMnZJj6yiZc9ItJ9RDSnkeVVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=peXM7D1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dP7tBLN9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 10EE5EC010A;
	Thu,  8 Jan 2026 08:19:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 08 Jan 2026 08:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767878351;
	 x=1767964751; bh=PhcbG/AbbCj+faFilsF03kegwa/uxttETs/t9J5Tbug=; b=
	peXM7D1Dzdnzb7NesfLIF8ofEqIIvuvij2o9y0pksmnEl1kTZJWIg+X+jaLLQgGQ
	xkdEJzn9usp83asewAMFV7+Q3ERrleIkrkXgtuVWAwQ59HyBtrbr9AEtOQOZttys
	iZszSnIdxMj4WbtGqGwkfsgpUZTMq5xJzJisByWGAkdaX9FJyGfybEerCPn0OmRH
	jAWME+9t7Pt1j9txk0c4EoNpxhSoGoPMbL8Y5eMNnJ5EgXMBfTg6h79YaYt2mXYg
	BkYiAqRtwAatZo1kj0mpq8LSMjo/V5BXf0jYU1292mb7WO+geFbROxbIqylPbtRh
	MX/qo1yJtEvcMe3XxvS1Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767878351; x=
	1767964751; bh=PhcbG/AbbCj+faFilsF03kegwa/uxttETs/t9J5Tbug=; b=d
	P7tBLN9V8y9t2HVFBPRwpt7ZAdqx4t+YnHnC/IzGwKI/DO1paO+lsL3DMQensrDB
	8pDO9IYmgP9fBLkgLsSkJ7z653KCiYBArrbfTbXIioqUnzWlF4kk5akhTohR5asl
	TdBvp7tBhDKIJ3Ok22I+tElRCZdmVy5eby3ZL9bynZIIkrxHC8AR9TxPP1nFxI9m
	vX4IZBPaGtRxZecm2/wCrEFvXXai8cG04vgnRzqMYd/WSWq4OfvTuLEEQEKy8Nl9
	Gz2p+RjLi8xSFh9x8XRtZo75Xj9sgRmyOiPgG0CxHgaW2f6tB5fHI/Tr6qsNs6Uy
	w8EQ+6FyRaMmkuJ5M4xLA==
X-ME-Sender: <xms:zq5faToR3lZ8HUzYBqVG39_u7fiL5vNpSndgFnpcRkhPxFLS3xIxkQ>
    <xme:zq5faXqPaCKcvNHe5WgBmDrXtkSLugYvTaTo5oYe75Ym5xA7Rxe49r9kWX3WLPOWb
    8U5YMh-ELel1uBEIcE-zw0LHopsIdR0L7UYqYC7TWxe5HY9LF5RRw>
X-ME-Received: <xmr:zq5faW1BI9BjwfrnTxWjl3SZ6QMUPG2zknjBw27O9dhcQtVY1qj_JFCHsuE0Cj8KUOqiCW59iElooXK88mTUNRmX351OsKYPCDbiobD_5bJMwuuUOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeitdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejffdutdeghfffgffgjeehteejueekieetieehveehteeuiefgieeuleek
    jeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    horghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepiihhrghnghht
    ihgrnhgtihdrudelleejsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgihivgihohhnghhjihes
    sgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopeiihhhujhhirgdriihjsegshihtvg
    gurghntggvrdgtohhmpdhrtghpthhtohepiihhrghnghhjihgrtghhvghnrdhjrgihtggv
    vgessgihthgvuggrnhgtvgdrtghomh
X-ME-Proxy: <xmx:zq5faVHH_gJ1k067kqp-BmB9e1mWf0gpjdEhinr4YSkSZwQ5weAqiQ>
    <xmx:zq5faRH0_KyyF7Tk8hBO0OhU2fugADz3oiFYEhiQXEPlg0OXwRhzCQ>
    <xmx:zq5faY4RW9vNvPUUs1U6kp-12cjVjqG43JtomDaF1ny3gVs-IEQG2w>
    <xmx:zq5faWzikREy9e17XUxR_Iz7ZHdQx0id464YOPwvYExArsuX42Uo8g>
    <xmx:z65faS69G3Q3sZyBzLcdp1NMRm_ooY08BvBpVwjrXUvR7m7vxYvtA1SA>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 08:19:09 -0500 (EST)
Message-ID: <7cd19bb7-2aa8-4950-b0e0-c52d59f37f7d@bsbernd.com>
Date: Thu, 8 Jan 2026 14:19:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] fuse: add hang check in
 request_wait_answer()
To: Joanne Koong <joannelkoong@gmail.com>,
 Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
 zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
 <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
 <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
 <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
 <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com>
 <CAP4dvsdRtO6BX6A-LdJDyakVucLskTvOViZRGonoMsK0eNtM1g@mail.gmail.com>
 <CAJnrk1Zt=zS7UYbryE0S+-1qBqYaowgCGa5Eq=gK7ynnk+ybTA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1Zt=zS7UYbryE0S+-1qBqYaowgCGa5Eq=gK7ynnk+ybTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 1/8/26 01:00, Joanne Koong wrote:
> On Tue, Jan 6, 2026 at 6:43 PM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
>>
>> Hi Joanne，
>>
>>> imo it's possible to check whether the kernel itself is affected just
>>> purely through libfuse changes to fuse_lowlevel.c where the request
>>> communication with the kernel happens. The number of requests ready by
>>> the kernel is exposed to userspace through sysfs, so if the daemon is
>>> deadlocked or cannot read fuse requests, that scenario is detectable
>>> by userspace.
> 
> Hi Tianci,
> 
>>
>> Yes, checking in libfuse/fuse_lowlevel.c is feasible, but it depends on
>> the running state of FUSEDaemon(if FUSEDaemon is in a process exit state,
>> this check cannot be performed), I think we do need this approach,
>> but it cannot fully cover all scenarios. Therefore, I believe it
>> should coexist with this patch.
>>
>> The content of the /sys/fs/fuse/connections/${devid}/waiting interface
>> is inaccurate;
>> it cannot distinguish between normal waiting and requests that have been hanging
>> for a period of time.
> 
> I think if the fusedaemon is in a process exit state (by "process exit
> state", I think you're talking about the state where
> fuse_session_exit() has been called but the daemon is stuck/hanging
> before actual process exit?), this can still be detected in libfuse.
> For example one idea could be libfuse spinning up a watchdog monitor
> thread that has logic checking if the session's mt_exited has been set
> with no progress on /sys/fs/fuse/.../waiting requests being fulfilled.

I added one kernel connection watchdog last week

https://github.com/libfuse/libfuse/commit/6278995cca991978abd25ebb2c20ebd3fc9e8a13

Thanks,
Bernd

