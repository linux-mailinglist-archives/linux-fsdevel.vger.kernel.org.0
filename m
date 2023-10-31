Return-Path: <linux-fsdevel+bounces-1605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BCB7DC423
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7712815B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A64ED6;
	Tue, 31 Oct 2023 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="e3T0PjQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMuRs8Lw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B4A54
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 02:04:54 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A5DD;
	Mon, 30 Oct 2023 19:04:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B6725C022E;
	Mon, 30 Oct 2023 22:04:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 30 Oct 2023 22:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698717892; x=1698804292; bh=6SRwuuaQtBql/DwgOJChmCueYyS35e3b/jt
	us9sC3J8=; b=e3T0PjQtKslc8Os29u952dUfrBBZL6eJexD9wvTdOOMI72YbsDj
	CQIo3tH0dz37rCoj3qRG3UUuUT3ZHrXP0hVvNCYYZHJjk7mNcTF9qj9UnklxVGl+
	Ga1KJTaPxgISSQesGIWWJSO9auSFxUJEx2CprfLPUZF9Jy+U98+8+5oeP7Minx4S
	odEoS4l6PgN1SHIxqjVJzj35BP4U2DhY1rSibsfU6T6C39podT7wAiWKdX+Bcrgv
	yliadZZ03CV/OWCjrNHCq3A/avRFYKh3ITIUI0+4Yaq40BR4TR3PQ2LpdRkSUOpO
	29jhF82QMOCrrEJALwhWYGvtxwPDoS+iIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698717892; x=1698804292; bh=6SRwuuaQtBql/DwgOJChmCueYyS35e3b/jt
	us9sC3J8=; b=EMuRs8Lw2XEejmmmB4Bes6qOlBcuFTOjvy90kLQHhWsNLG4vytf
	DFckINB7DG2vGT/gzguEyCMBKsqxXLeSKFv7n72s4ne/ZOn5TDvuGiPeqADIA85j
	Z2P8TSFgNv0BrtPH/xFnxzzWv9ZWEYJHWug+FMO2qPjb24M6nY/b+iBe6uCBDtkc
	WrzAn/JfaRqBa/6+Vg9XRSzRjslgjvO8BVx/LPw6Z2UXcjYaZNpG0q4VAErqdMys
	8bEoiTdhEPgfYp7Mvsv9ws85y6WJDQv478jgLeKjRjiLXQFjl4gglFJsUDTQSJMM
	okRJ9fYNnKu7O8UszHs++Qjewg8Mv1You7Q==
X-ME-Sender: <xms:xGBAZWDly1onoav3iYa1rATmbq-BklB6RFJNXa5frNW0me34AnyZLQ>
    <xme:xGBAZQgGW9XCm6u7iaVtDUzrEIYccoDVPA7KOVLbShquF3UN6aE-dhYuMHS5L1LA6
    tylCyhaPiP2>
X-ME-Received: <xmr:xGBAZZkZ7RXRtfsO5Vj7B-ATHm-xmL55sWl6edEdXfBXBLf9zMJK1W01urh7OE7BTxBSjMbV5MGelzkis1HdhrplUmzOwzFONwpjRrKfn37fxqZ-wmgLCHWi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epjeegkedvhfekueejgeefieejtdevledvtdelieevveekffejfedtvdehkeefjeeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:xGBAZUzI4ubKaahSykCWM-5QpAd5SmLLtA5ydEpkYmJtCYmnXZjSYA>
    <xmx:xGBAZbRU19hnhToxziIR2j9GjUmeF1sKBSTR-h2YhGiqKMxjHoSfzQ>
    <xmx:xGBAZfZkn3gIoPGDWRiS6wFUdaFgGvdKen5aiIS0YI4yOAwikGiQlw>
    <xmx:xGBAZWfELHjpy6HGIFynl3KsKUBjOWrrxVjSPXmpfHktwaz6LUptTw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 22:04:50 -0400 (EDT)
Message-ID: <fa1e43f4-c703-762e-1b65-bd2c30e0cd3e@themaw.net>
Date: Tue, 31 Oct 2023 10:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bill O'Donnell <bodonnel@redhat.com>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
 <20231030-imponieren-tierzucht-1d1ef70bce3f@brauner>
From: Ian Kent <raven@themaw.net>
Subject: Re: [GIT PULL for v6.7] autofs updates
In-Reply-To: <20231030-imponieren-tierzucht-1d1ef70bce3f@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/23 18:24, Christian Brauner wrote:
> On Sun, Oct 29, 2023 at 03:54:52PM +0800, Ian Kent wrote:
>> On 27/10/23 22:33, Christian Brauner wrote:
>>> Hey Linus,
>>>
>>> /* Summary */
>>> This ports autofs to the new mount api. The patchset has existed for
>>> quite a while but never made it upstream. Ian picked it back up.
>>>
>>> This also fixes a bug where fs_param_is_fd() was passed a garbage
>>> param->dirfd but it expected it to be set to the fd that was used to set
>>> param->file otherwise result->uint_32 contains nonsense. So make sure
>>> it's set.
>>>
>>> One less filesystem using the old mount api. We're getting there, albeit
>>> rather slow. The last remaining major filesystem that hasn't converted
>>> is btrfs. Patches exist - I even wrote them - but so far they haven't
>>> made it upstream.
>> Yes, looks like about 39 still to be converted.
>>
>>
>> Just for information, excluding btrfs, what would you like to see as the
>>
>> priority for conversion (in case me or any of my colleagues get a chance
>>
>> to spend a bit more time on it)?
> I think one way to prioritize them is by how likely they are to have
> (more than a couple) active users.
>
> So recently I've done overlayfs because aside from btrfs that was
> probably one of the really actively used filesystems that hadn't yet
> been converted. And that did surface some regression
>
> So 9p, fat, devpts, f2fs, zonefs, ext2 are pretty obvious targets.
> Judging from experience, the more mount options a filesystem has the
> bigger the conversion patch will usually be.
>
> Another way is by function. For example, we expose mount_bdev() which is
> basically the legacy version of get_tree_bdev(). And they sort of are
> almost copies of each other. So converting all callers to the new mount
> api means we can get rid of mount_bdev(). But that's like 25 of the
> remaining 39.
>
> But in the end any filesystem that is converted is great.

Thanks Christian, I know Bill was considering spending a bit of time on

this and I may have some cycles myself in the not too distant future. But

things change all too quickly so we'll need to see how it goes, ;)


Ian


I'll


