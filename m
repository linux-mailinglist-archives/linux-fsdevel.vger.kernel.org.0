Return-Path: <linux-fsdevel+bounces-13080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705E86B02D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3385B288D12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C614F98F;
	Wed, 28 Feb 2024 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="IESyS/7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJ5VuRKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F614F987
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126542; cv=none; b=bktP6rPcC7RR7Yv/GJIuMddibmAMCwnt87TOFJN0qwSMWwrnzcfUMNFizbgXrsldJmES/zSITuPEj13cHUMPcMMw1o/WOS6NnR4r8PAjMEEe1PbV//jlzijONE9RHAGNk9uTJZIe4Vos4PzWAEimX+ITtRKzQQDgI7EEy0rG78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126542; c=relaxed/simple;
	bh=pGMcBsbQgESeTum0D8IwZhZjMAVfs6JEOjum9FQRV7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qB3RlLQyAFe02VyXNkV00t2pF3NB1RFxlcDp5TZt7YKYu5gNs/F/tQXBBngLlORmyl/S/BwRhSGzW2zs/0vTLwbW60qRyG0CgSyLaIe8kUeLA4Tzv4HleRSO2SA09qiHoYqmpZpgipL2podtx/dCSi2pV1HbVLE7/1cWA0QU5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=IESyS/7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJ5VuRKr; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 1B3F93200B78;
	Wed, 28 Feb 2024 08:22:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 28 Feb 2024 08:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709126538;
	 x=1709212938; bh=0IFSHlUF5cusLSerz+gRD8MkDI56X7YCLttBaX5ygOU=; b=
	IESyS/7F94+eCEgLdtbfU5dNMVb4XKuPYa1jiGTfjFqM6Ge1pJDcVdWMLFBbPPlu
	bsb6x6Twn4fc2ypTPFBX/0vt27J8OMTxzu4u4AuFGKV/33vfXWOvZo7+0y2T5TUF
	vtjgIZKibT2opXdmCjf1//TdqIZSHJvfENNkbeH7FBn3jMfpQb9paq6847v0/BQS
	wRJeha5sSRafTJ5Vy0hj82CYkC27UQmpTgFjphkqChVzTb53jpGeYSPk+ayC2YPs
	Q+fwXnrib5hycKZDkmREDTicsrdWRzWSb8ETaeKM6eH4dufSPrQaF26HivS0XzsZ
	JAFzGYpCLN9uPii9ol2Xfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709126538; x=
	1709212938; bh=0IFSHlUF5cusLSerz+gRD8MkDI56X7YCLttBaX5ygOU=; b=C
	J5VuRKrzVkvjKbgoFw1WXgIyCF7ufzukEPk+rO1bhE6+F8n7ggSQZF2zfUC+Ms2S
	zKs/cY0oQbwUv2B4jkcJ9k+Zo5ZVaZWdoOKetCxhDbIYKnj5wGUE4BJuMR8hAKMW
	YtUzshKCrqY3QqRUdhjJzd6/v/PatvjNRuYs2Cgd31tuSDKMRw5PeMefObexcA8T
	ZqMvxOFBlGdZAybBLl6govdP0T6W5RchwYMeYYAcI8ExoJwbsqN3DKkT2WFNleyo
	u12auW+GfvlRphaEvtidHH9iuue5l+dny9t/5Nxal96nX253yv4QzsgPkqyRlz2j
	B9fb9O4uIJaFdba9XvQvg==
X-ME-Sender: <xms:iTPfZWCYN2G_SiJ-7ccC61OUoIwFtFixGWgfLsPzq7GVA6KWlE14LQ>
    <xme:iTPfZQg9CFjodCUyQu7UHMeG5-J6ibDK3gKTa882h4DavWJAE0mXwhX7GvjP1OHYe
    WWW6SegVPVVj6xX>
X-ME-Received: <xmr:iTPfZZmEFw0_JrwywEJXUAYwjbfIfOtpNiFrFrLPFuBEPGz8IZbG6-YZL-VxPbK3OtD87cfCMs3RNFAJtmWmqXvKtfO-MECu5LqIw59ckj7xfGiq8j8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:iTPfZUxXFOQb_2pPkUT245xnVgbuMMvC2LXwLVV-WKYA7qq2hdFCEA>
    <xmx:iTPfZbQ3awGJ6TrG6S8JMM6g6UI2w3b-Wq5FE8KJx_w0rfb4GCkENQ>
    <xmx:iTPfZfYLieETGOuWrlQkGI1klwIfc2NBugxkBFb-NaTafaJPnnUFXw>
    <xmx:ijPfZcLmCeEAEXSr1p5Oe3V8X1w1SGbAKYIOZoSL8DXe8QDVbjaiag>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 08:22:16 -0500 (EST)
Message-ID: <a596dc0d-ead3-4123-afa3-7c605990bae3@fastmail.fm>
Date: Wed, 28 Feb 2024 14:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Content-Language: en-US, de-DE, fr
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
 <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 12:14, Miklos Szeredi wrote:
> On Wed, 28 Feb 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:
> 
>> I don't think so, because it will allow unprivileged user to exceed its
>> nested rlimits and hide open files that are invisble to lsof.
> 
> How does io_uring deal with the similar problem of "fixed files"?

Maybe I miss something, but with io_uring the process opens a file
descriptor and then registers that as fixed file? I.e. the open files
are not invisible?

Thanks,
Bernd

