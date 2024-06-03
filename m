Return-Path: <linux-fsdevel+bounces-20827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6C78D8455
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C68286C02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB212CDAF;
	Mon,  3 Jun 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="vYOmDLMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOsb+9wY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539712F59B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422520; cv=none; b=tLqCEn4033PvT0eiiDiyWQuEBl9H4pxQb2Vw69uA/CSD2LZO0EtbtL3I3sb0s8X9WGCFK3A7DbTkXHG2hWfa4wSvfrc5R4mOYewFNryD2aw+xaVQXxdrlOT6QjBbGF0Zo1mb8EW1B/vpYI+pYlphm40AJViIFV9RkOzmlezuiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422520; c=relaxed/simple;
	bh=p5UhYnBlxZWL0icuCFNGHgC2app/V6c68wN2EsQUSDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pC2UQ29HSV0+PcBCK9+9ykwrZ6crts47g5HmFUyr5E5K7rHpBPIBVx7ADESuPEgizW0Uz3AFqLeoWqP3QMJuWOv9KPfNoqxmFCGWjHoFdiWv2PkpaMsw4laqk5coPUspUmo9ogIp64P2YOyfoEldkxli9Dh28SF8ZDMTMLd/VMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=vYOmDLMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOsb+9wY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8345713800E2;
	Mon,  3 Jun 2024 09:48:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717422517;
	 x=1717508917; bh=JcwzpvuGQtt9SVsfeZMocQtIPCT5U6gl68YQbwTUvDQ=; b=
	vYOmDLMT4Nh+HASjTStnIlsQy6CVChYczq0xUaaVK9FLJY4un8pzfa/6lpHesYn3
	UkamxaaoXNdVcpm9fv0qFqTkYsDoOAxQjAu4fa3tD+TKAZgoz5sDYJyShRj3eXkC
	ILZ1Iz4PoXXWK9dGiA73yb4jr91mcgi0mLNAeC7NJrxiV4+5rhb48C/ltDYnPh2J
	rnqAmXaU/VqQ6FqydQwCetcfGva+tDmPnjVKFyRfx6MNIo/aWMqrLXA9v/KpAljn
	QnsRtHIuY7OAqirADKoGYejVOZMLEpIm2QqYN/LMGpx+l1zL55Z7VWTiTnxeRGtd
	uVyEc2df/6UI+j7TDBlsgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717422517; x=
	1717508917; bh=JcwzpvuGQtt9SVsfeZMocQtIPCT5U6gl68YQbwTUvDQ=; b=I
	Osb+9wYNv4EQnEJ2dAh3yvSE4+MmK1eGFi/sBqHLomBeRmCcFLUkIuMliUj0eNmn
	BGQvKyCATdpG/aaZEd+5dT5fEwJrvMwr68lsmL/kfcTbvVopd9p7bTQ+mDOzs2hz
	NP6QctaqasfFMzsXt61LUTHCvgBPLWc7/hS6FzgtFe4//6g1nR6Yd6n/kv6YYjCC
	A7sWEF0I9gRJJnnZEY7bqvy9gmDBndY5pWxwbsUE3K9w6+7ZfS3QV3oVgCQjZx42
	trGayDUDj3Q3H/bNj+AC4p8DVyWLIKDCaPFCDql1UCt9H8g08Bog4QrSylcBN5yZ
	jNZ9LXVhZ8JrUcQqEXTOg==
X-ME-Sender: <xms:tcldZpSBJwiBHDi1Tl82QjSh9Tp34xA4Ng9FhoNVf5Q4t-9QXouJHQ>
    <xme:tcldZixAows3bGHT-madWil7zgb1UJ7PdWOfguvBD_ShsHGZSkwGgvY_-i7hb9zM9
    dNnFEvNP1VKamO4>
X-ME-Received: <xmr:tcldZu0yGuiFRORv9E-7G3gcYy-DEOErH7QbSvvTr-upUFyQvAP3LF_C_55uWvtGKVaXXJZEW79d4JNbMLQXumFQTOWXey_PcDFKQbYd_XEkOAWGDnuq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:tcldZhAJSBqKjUuZCRxRnPuovqjGTsucKbqnEPxgT9b5ZkiPTCQSLw>
    <xmx:tcldZigA1F-jdH_msJXbtIeNTQFbZicwzRIydbtdTKOK8icolfGmSg>
    <xmx:tcldZlqdLpsTIKYLqwjz0gIfsqXWRTup53p_xe8wcSmNtEMrRQPdGg>
    <xmx:tcldZthszYHZBUO-8ZFxoLPg5z0c75gvp_NX2quI_NaU3AIYyUPyRw>
    <xmx:tcldZqe-PoodF8ubprFCsY12JPmNWQO_Hn0bE4y9XiUtvOsct5TkfPOq>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 09:48:36 -0400 (EDT)
Message-ID: <321915d5-95ac-468b-a036-7a8a50dd3c48@fastmail.fm>
Date: Mon, 3 Jun 2024 15:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/19] fuse: Add a uring config ioctl
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>
 <CAJfpegs4ATQXyUEEsV+s3Zh_iSfyAEpAOdOfw_5iL=_uNjHQWQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegs4ATQXyUEEsV+s3Zh_iSfyAEpAOdOfw_5iL=_uNjHQWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 15:03, Miklos Szeredi wrote:
> On Wed, 29 May 2024 at 20:01, Bernd Schubert <bschubert@ddn.com> wrote:
> 
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -1079,12 +1079,79 @@ struct fuse_backing_map {
>>         uint64_t        padding;
>>  };
>>
>> +enum fuse_uring_ioctl_cmd {
>> +       /* not correctly initialized when set */
>> +       FUSE_URING_IOCTL_CMD_INVALID    = 0,
>> +
>> +       /* Ioctl to prepare communucation with io-uring */
>> +       FUSE_URING_IOCTL_CMD_RING_CFG   = 1,
>> +
>> +       /* Ring queue configuration ioctl */
>> +       FUSE_URING_IOCTL_CMD_QUEUE_CFG  = 2,
>> +};
> 
> Is there a reason why these cannot be separate ioctl commands?


I just personally didn't like the idea to have multiple ioctl commands
for the same feature. Initially there were also more ioctls. Easy to
change if you prefer that.


Thanks,
Bernd

