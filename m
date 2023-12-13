Return-Path: <linux-fsdevel+bounces-5779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B23810775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 02:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BC61F219D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C71ECA;
	Wed, 13 Dec 2023 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Ze0PwEh2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Pu5VDvJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED391;
	Tue, 12 Dec 2023 17:13:39 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CE0295C01D7;
	Tue, 12 Dec 2023 20:13:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Dec 2023 20:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702430016;
	 x=1702516416; bh=q1SPQYQRBWl7bFrY5/lVAS8dc6PpLJdw7+EOXaZGVW4=; b=
	Ze0PwEh2S3szHV/ysnl1BX0zv1/CfSBmMStu4vXojWR8sKZ/+ev5W6PpgP4i1la5
	INWsbQWMZOhPOPz0Ss3v6hx3aLl+r3+O7DNtSkjQ4k8b0BSpKudqERUpkdFcwWrC
	u5Hb9hQrPiUyBnGaK0Mx2qM5oHX/QOJyk1ltkecAlXM1w18/xSMNTkSNkMkIcha3
	aBigpGgHNFrD9s/99NM2EPyaZSFJofrufVllgbTDQD3x8agFx+uWv937VPj4yQov
	LDZ61yro2+0ViZyt44dv6aTAIDLwVaw48rU/G/CIczeS5MKuaFTaaici99+Hb0r9
	xLoEXdf5gQQQHJmIiOrHvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702430016; x=
	1702516416; bh=q1SPQYQRBWl7bFrY5/lVAS8dc6PpLJdw7+EOXaZGVW4=; b=2
	Pu5VDvJxB+hNgOzbQS8onyFPjDTA5005w70yUaUEx6sY6LH9thUWrT74U/eM3n7i
	8sPvzZT5BraMUnai4Oiurvmrz7CyvxK/uFWVESLJ0aNxBcLpSUF3XDmk7aP2wSFe
	LNZXNSS1TYD3y8iPrKxqQjisH5lHYJCXCy6x+x0N/zMRlDWw8x9C5TcFU4DM+/tH
	PndYo4EQezv+W1RekQUeHg0M/6/qxChKcZJEOev1fsqcH93x1yG6i8O6KdSKFZMA
	nLbYJEO7M/CxVv+30+imA2niTK7g/I3Aly/SsLJKWaZb/pE3rxn0XKizH3RhgSob
	DxC3cAqIgfb7dAt4xiphw==
X-ME-Sender: <xms:QAV5ZRIw5On9QW0y7o6Ul7WYC95gZvbm6hihF-O9wUrp-PGyDMD6HA>
    <xme:QAV5ZdK_5s2opw-6uCV1kCIQx46sRcMBypw3gLpcD7HE35nLl3hULiu6sXYOaXpN_
    ZyllZX2zFDk>
X-ME-Received: <xmr:QAV5ZZuwjuTmuMj4OMA7_e0i4S95DUpHf4Ysaq_UTSJUn60SCTOW4D8yoO_EnYoCzsxQHjMPS_DXmTxXGep8YXKVwmmF3BBqm0q6r0Hnl8aNQMoXVlNP9wVp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epjeegkedvhfekueejgeefieejtdevledvtdelieevveekffejfedtvdehkeefjeeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:QAV5ZSbgMwE2_u77Z8MoHnF27nYycdpWY0RRWzUOfmrk6ss9z_Eamg>
    <xmx:QAV5ZYZYxPE3hna1elh9v4ee5S2enWN29NIEYEMtLslwwM9dTX1xpQ>
    <xmx:QAV5ZWCxkKiPwJLK-uCMpon65xjSsrGJjmnR0QNkJuVingcClDau5A>
    <xmx:QAV5ZeP1hoNmo0aMVPbxZam7Mv1J6KDTSoqYOX4TUpMd2PbUytH4sQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 20:13:32 -0500 (EST)
Message-ID: <eab9dee1-a542-b079-7c49-7f3cb2974e47@themaw.net>
Date: Wed, 13 Dec 2023 09:13:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Arnd Bergmann <arnd@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <mszeredi@redhat.com>,
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
 Dave Chinner <dchinner@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231212214819.247611-1-arnd@kernel.org>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] statmount: reduce runtime stack usage
In-Reply-To: <20231212214819.247611-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/23 05:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
> and copies it into the local variable on the stack of its caller. Because
> of the size of this structure, this ends up overflowing the limit for
> a single function's stack frame when prepare_kstatmount() gets inlined
> and both copies are on the same frame without the compiler being able
> to collapse them into one:
>
> fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
>   4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>
> Mark the inner function as noinline_for_stack so the second copy is
> freed before calling do_statmount() enters filesystem specific code.
> The extra copy of the structure is a bit inefficient, but this
> system call should not be performance critical.

Are you sure this is not performance sensitive, or is the performance

critical comment not related to the system call being called many times?


It's going to be a while (if ever) before callers change there ways.


Consider what happens when a bunch of mounts are being mounted.


First there are a lot of events and making the getting of mount info.

more efficient means more of those events get processed (itself an issue

that's going to need notification sub-system improvement) resulting in

the system call being called even more.


There are 3 or 4 common programs that monitor the mounts, systemd is

one of those, it usually has 3 processes concurrently listening for

mount table events and every one of these processes grabs the entire

table. Thing is systemd is actually quite good at handling events and

can process a lot of them if they are being occuring.


So this system call will be called a lot.


Ian

>
> Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/namespace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d036196f949c..e22fb5c4a9bb 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4950,7 +4950,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
>   	return true;
>   }
>   
> -static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
> +static int noinline_for_stack
> +prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>   			      struct statmount __user *buf, size_t bufsize,
>   			      size_t seq_size)
>   {

