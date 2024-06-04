Return-Path: <linux-fsdevel+bounces-20955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F48FB4F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19EA1C21B03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF15F860;
	Tue,  4 Jun 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="LnI1lWQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6QFe6mY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C439851;
	Tue,  4 Jun 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510411; cv=none; b=C604MlTht4us+m+Czw5PJhCk/lTdhXeJxh24ehZGatq55HzVQ2JBGbFMsWdxAnUGpnO+AiqCyE+28TLBAh81t5BWijx21CE7K1PE08DUuv9M99PRuFP0PG7OCtHO0p1nIBYKhZ/E+JaUSx9592XeBbf2O1SP2oQL6myInlKKWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510411; c=relaxed/simple;
	bh=pHj9l9kQFVZFehRR9CxhpyoLan7FS/CeDWnrGomxTEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/xv2hdl44yVHifyDhobMUIhEnnEbiGUZ8RitEXqZExeASZIopQotOopEFeEVqkTjHrr0S6BKmUntemjccSl5lDovJde1HxQAWR7D2cX8cPE9BIex5I5PxatPrMeRZ++SXPZmtaoGXNPHV6DqKoBZGt0MJqUR/dzVxQCZC6ov64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=LnI1lWQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6QFe6mY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 28417138008E;
	Tue,  4 Jun 2024 10:13:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 10:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717510409;
	 x=1717596809; bh=bJi9vz7z4EpKqStQ/qCCfjVPwNnCLYGxaXBygPSxRPs=; b=
	LnI1lWQYJtuFz9P4HtDVK8ExuCGoD8ouuMKe1wg4L3qcgf/TdhQ3xZNC+TVXe420
	ZcL4xA1F60aBc4AgFHNMiMSFzS/UyGlzZl+E4t6DqsbiJvhJHS7DxwsVgDFT1uQT
	Xih3S+oIXadAPxxO6BqJK+Of9DAJvuI7FFYjKVA34/rQX2JHRXBuO/nHmYDBQAFU
	KPsv8i/SEn/Io5I6y3e1pbZC7csYJfW7rKA2LVo72IAxBqQVwsHFvmYJEu0Wk5fx
	duJB1Jwiyyqs6LbajPE70hEGrhxr/6xFRoEUPpPUvMtKozrvq7yzBf4+BzySsoYR
	Jwtm+LusCfMsb6sXbsXqww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717510409; x=
	1717596809; bh=bJi9vz7z4EpKqStQ/qCCfjVPwNnCLYGxaXBygPSxRPs=; b=K
	6QFe6mYDipWGIJpnzI46+v3KCBt01QX+rKTNS6Bw42gXW/fuZwRLMIhCYPND562v
	XQYuIC0+VlnM5w8IboGtAKG7i1h9EHGIveTzERqbjFl3MnMm/6vb6iy/kZKVZRcP
	COBdE0hhDAtMmJ0HcCBffSaBrqFzf7rnRR2Ep/1I8C4f9mN8XI3nxHN7JnWj0GWW
	SD9xa9RHpcvA0AMvK5xN0J2mVwFsWxqz9Z7KMxXiVgB7bb+RNINr2yGiqFELs7Pp
	qRR+yPeGrOfJrcCydJJL6qLPbCfBFYfHVzmF0fTahCACZO2F0oL9mR5zDtOGQCE3
	xCHd50vVz+KI7WxAYBRgA==
X-ME-Sender: <xms:ByFfZnPZKeaxEveE2H2b48RN31IAOBVaugey2gRLNfV2iNQ3oTXiPA>
    <xme:ByFfZh8EKRGkbOY2eJmxuTPUn3dNnpAepuEvfI0MDvFUrtTKxe7tUqIpqAPMvyNbc
    dicifMXUX4Oh0_H>
X-ME-Received: <xmr:ByFfZmTzHs647IA5nggdjS5uHWv9VCzB02CBbL6MrOUb49x47Jf2Wte6ey57ENR3aE_GUFIcIGhGdz6cJBS_Yoml3FcSdW9D-wq-i-yKklPkcCSzOn5D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:ByFfZrvl7O67NN4u6BJyLQE9O3APIugDH4qjtxVPQpN2luh4HJIdFg>
    <xmx:ByFfZveW678kYRubf_J4OKAAQ-6UB7beVE8NK38e_RlGdnvGT7s-yA>
    <xmx:ByFfZn3Niz_-NfyBQyhWoL35hP3LtSID2TN3koay5iUvTqqggQZOtA>
    <xmx:ByFfZr9d_vAzPa3L9YzPPaeSTK-xm_MJD9a-9RkT9Bo2DnAh0yKYnQ>
    <xmx:CSFfZhvU5x2dBWiKgKVqt3VT9Rakrl1kwx3DBpUuYhcOo9-L87iAyhgm>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 10:13:26 -0400 (EDT)
Message-ID: <21741978-a604-4054-8af9-793085925c82@fastmail.fm>
Date: Tue, 4 Jun 2024 16:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 12:02, Miklos Szeredi wrote:
> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>> Back to the background for the copy, so it copies pages to avoid
>> blocking on memory reclaim. With that allocation it in fact increases
>> memory pressure even more. Isn't the right solution to mark those pages
>> as not reclaimable and to avoid blocking on it? Which is what the tmp
>> pages do, just not in beautiful way.
> 
> Copying to the tmp page is the same as marking the pages as
> non-reclaimable and non-syncable.
> 
> Conceptually it would be nice to only copy when there's something
> actually waiting for writeback on the page.
> 
> Note: normally the WRITE request would be copied to userspace along
> with the contents of the pages very soon after starting writeback.
> After this the contents of the page no longer matter, and we can just
> clear writeback without doing the copy.
> 
> But if the request gets stuck in the input queue before being copied
> to userspace, then deadlock can still happen if the server blocks on
> direct reclaim and won't continue with processing the queue.   And
> sync(2) will also block in that case.>
> So we'd somehow need to handle stuck WRITE requests.   I don't see an
> easy way to do this "on demand", when something actually starts
> waiting on PG_writeback.  Alternatively the page copy could be done
> after a timeout, which is ugly, but much easier to implement.

I think the timeout method would only work if we have already allocated
the pages, under memory pressure page allocation might not work well.
But then this still seems to be a workaround, because we don't take any
less memory with these copied pages.
I'm going to look into mm/ if there isn't a better solution.

> 
> Also splice from the fuse dev would need to copy those pages, but that
> shouldn't be a problem, since it's just moving the copy from one place
> to another.

Ok, at least I need to keep an eye on it that it doesn't break when I
write a patch.


Thanks,
Bernd

