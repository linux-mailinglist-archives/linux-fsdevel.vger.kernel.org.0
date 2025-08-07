Return-Path: <linux-fsdevel+bounces-56961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C99B1D21B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 07:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4EB3A56F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D8214813;
	Thu,  7 Aug 2025 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="3BCO6v/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08988212B28;
	Thu,  7 Aug 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754545211; cv=none; b=fH0WexBcNcVDd2uzzjKyiQyrgKkAjJSY0qWxI4s2CqF/opSwxd1daC5uxhHBhCidUXrp/aO3/ydwGzD9uolK5q+X2V5q61PyPvgfBsZV0x6iDFTQqQkJyXJtaFb1R/WoZ5jQ5w77QZwrtrYu6liA7Pa1xsLoKm+vjfV+fTBqR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754545211; c=relaxed/simple;
	bh=ymIalFb0o88HlIxUxHGCi2idWfUAPFM4APNrQlaofa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUgWec/gux8e8/kao+mf3kmWE4vC9U8R3/L7ysJ2ayMNKpBXxkF+LpS1x59JcyBTn4P2L497D8UNvfA8nB1DEdF3m8QPxq6oH0vsnKytELm4MsDPlRdznTHkCMckd7MM2EEIYeJIj5llK4F2YdmZUmVg5v1zM92o2AJErhcaFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=3BCO6v/6; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=ymIalFb0o88HlIxUxHGCi2idWfUAPFM4APNrQlaofa0=; b=3BCO6v/6UTpcn9Tlz9DvO2N0EO
	ucdQhih4FmNanlKTYtx4K/tJTHtAjiqvb29fS32iruJgo/byKpickN+XzxdpLt/af0hyw9FERT5aw
	hliFT5QKKPYuLMaMPo0L9yg4J4XUZcWc5PA3eYDS7QpumSDQTMoLKHv8CvbqmkQNh/Lgoe4m7R2g+
	YvYS8tDh/F2H1b5tkCwDcF6pA+jXkMsHkcYdgXFkaaU33b8UPC5iBxY+n7AHFajLBbYUAmaHXLhvt
	mWhmMW1ktqL+pA0+tSZI8RjpK/EJ1WvKufbHbA5X85R2EYeClAwnPCF6gvBItQVPjCs0Zwyb8rGlv
	ifdSm2k2/VZdvinjLbZSdPevdXMGFtmgx6RqX+9Q0e2USdv2FJy2GVrON8xhxDag+WAvOi4ievTF6
	wT/lLNeNNspN9VA1wYhr7Bo8WiHEvadrFLsNNQPc2egObR7cxI0UupfJplsn9NMnHFoD3ErKVmpYb
	bAmHi5ERxi0D8Zemaod578p1;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1ujtMD-001UQx-2F;
	Thu, 07 Aug 2025 05:40:05 +0000
Message-ID: <1b3e0ed3-35c5-46ce-932d-02de9ba17ab6@samba.org>
Date: Thu, 7 Aug 2025 07:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/31] cifs: Rewrite base TCP transmission
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Shyam Prasad N
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Wang Zhaolong <wangzhaolong@huaweicloud.com>,
 Mina Almasry <almasrymina@google.com>, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <20250806203705.2560493-1-dhowells@redhat.com>
 <20250806203705.2560493-17-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250806203705.2560493-17-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 06.08.25 um 22:36 schrieb David Howells:
> +int smb_sendmsg(struct TCP_Server_Info *server, struct msghdr *smb_msg,
> + size_t *sent)
> +{
> + int rc = 0;
> + int retries = 0;
> + struct socket *ssocket = server->ssocket;
> +
> + *sent = 0;
> +
> + if (server->noblocksnd)
> + smb_msg->msg_flags = MSG_DONTWAIT + MSG_NOSIGNAL;
> + else
> + smb_msg->msg_flags = MSG_NOSIGNAL;
> + smb_msg->msg_flags = MSG_SPLICE_PAGES;
> +

I guess you want '|=' instead of '=' in all 3 lines?

I also think msghdr should be setup in the caller completely
or it should be a local variable in smb_sendmsg() and the caller
only passes struct iov_iter.

metze

