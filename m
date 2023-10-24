Return-Path: <linux-fsdevel+bounces-1024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E77D4FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A192819BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36E273D0;
	Tue, 24 Oct 2023 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="CffzsZ6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mOHIELjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656D273CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:36:50 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D790
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 05:36:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 0A38D5C004B;
	Tue, 24 Oct 2023 08:36:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 08:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1698151006; x=1698237406; bh=YSn8MxaYd7nom13gBkcN/oadC+WVcRkpsdr
	FkWoASSA=; b=CffzsZ6YqnqFcFET9LQsTULKZGgbJQgYD4YZVfW+QgS//GLq478
	BjceoyGYvM0l1ssYiYGM0wRLe6RXsA9BsUAngc2ixVFaw5TPif3ZYaAb8JfDI2Bg
	vv62t0JYw5IZ7RIp8BBXoh56emAehV5DUOzf3srIG1fR2f9jiaCZDvEmcSa0dCKH
	/prJEStByg2X8IDoQC+bVZHPA1Fa9JoFk5h58m7Ht3D1B+mKlAhYogP4WHReSHZT
	sqyHYhJt4guotk9eWE70wy3fr8xqcTEe4eFxxrkYB+hfHChAeX9I3aX+Boe3+Oz+
	gQ5X20SJcBzVoIeZmkEv4UNQChwe3b4QaNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698151006; x=1698237406; bh=YSn8MxaYd7nom13gBkcN/oadC+WVcRkpsdr
	FkWoASSA=; b=mOHIELjh6a5y3MnsrpInzAfHWCDoTZ86KbGQGkzrgFd1UiYnxGo
	NIbOjXgRujUtVMBiCdpjNUSthHIVk34DYHKBgYLh6GG3vStrUsrhG8yB6jPYRbqs
	bxny36dN+b3RwbrUeF8kAyRdi/i2tR4kpuyf0/xHKYHQ6CmWwFFJsWQWuejtGm9j
	pAX1g746QXbeTrYfsNh3Kz4Pjs2AJNWC09pfIwDhyvWWpyBCICEzGNc7nMqsiF72
	BROl4eaXVYd4/6MqVbjp+K2vMe1e9kL8zXpydXxkuqwVabjOxrCzS8odaUw/JcYK
	kcVYprsKhnO96E3jqIvSbc2m+v7d3tHnIZw==
X-ME-Sender: <xms:Xbo3ZVad-Hnvzgio8aCmH9cl2horkCeov5W2bkvaNekK5SuNWkO_JQ>
    <xme:Xbo3ZcZddDNq9hUdmjF4Kqav3nv6VdJTbGRljouNcSGd2Xnltcj0n3NAvqvbP4-DQ
    NCyrFTs0iBe_3hp>
X-ME-Received: <xmr:Xbo3ZX8ptJJlu1v1IGon8fFEQGzeptjtFOWdfGacoyory8iV1rlWOkMjicscX9d3Bc2QMpOBRbXsrxAzTvDZTMUZxY2YrGZJiD4SEDvyuqm_Z2EHN4x8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:Xbo3ZTox9fvCFZRo5G4xsMSrQfaJriJlpXYZF6jJySTSd23WMcH9mg>
    <xmx:Xbo3ZQrWW3u0GYappby7lI4Rvu0ha4bNizkRhu-bDb-o8zKHslA8wg>
    <xmx:Xbo3ZZS6hYa_GLTrxF__AcIBD-KoNYVPU7R9aJYlMjqmsMYpRwHlHQ>
    <xmx:Xro3ZcdvTE1W2ZGySUJ8bVeyNQ4PYFlWbkeaBg9fb5b_ZxfbGXimKA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 08:36:44 -0400 (EDT)
Message-ID: <89d180e6-65c5-47f8-82ad-cc5a4b2e1e63@fastmail.fm>
Date: Tue, 24 Oct 2023 14:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/8] fuse: introduce atomic open
To: Yuan Yao <yuanyaogoog@chromium.org>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
 Horst Birthelmer <hbirthelmer@ddn.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Keiichi Watanabe <keiichiw@chromium.org>, Takaya Saeki <takayas@chromium.org>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-3-bschubert@ddn.com>
 <CAOJyEHZUq0xWBaMet8s1O5Bpz-M-pR39wWCfwFtm66rySzm6vg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOJyEHZUq0xWBaMet8s1O5Bpz-M-pR39wWCfwFtm66rySzm6vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/23 12:12, Yuan Yao wrote:
> Thank you for addressing the symbolic link problems!
> Additionally, I found an incompatibility with the no_open feature.
> When the FUSE server has the no_open feature enabled, the atomic_open
> FUSE request returns a d_entry with an empty file handler and open
> option FOPEN_KEEP_CACHE (for files) or FOPEN_CACHE_DIR (for
> directories). With this situation, if we can set fc->no_open = 1 or
> fc->no_opendir = 1 after receiving the such FUSE reply, as follows,
> will make the atomic_open compatible with no_open feature:
> +       if (!inode) {
> +               flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
> +               fuse_sync_release(NULL, ff, flags);
> +               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +               err = -ENOMEM;
> +               goto out_err;
> +       }
> +
> + if(ff->fh == 0) {
> +        if(ff->open_flags & FOPEN_KEEP_CACHE)
> +            fc->no_open = 1;
> +        if(ff->open_flags & FOPEN_CACHE_DIR)
> +          fc->no_opendir = 1;
> +       }
> +
> +       /* prevent racing/parallel lookup on a negative hashed */
> 

Thanks again for your review!

Hmm, are you sure atomic open needs to handle no-open? fuse_file_open 
sets no-open / no-opendir on -ENOSYS. _fuse_atomic_open has a handler 
for -ENOSYS and falls back to the existing create_open. So why does 
atomic open need a no-open handling?


Thanks,
Bernd





