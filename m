Return-Path: <linux-fsdevel+bounces-60994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673CB54217
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F147F5814C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57C270EC1;
	Fri, 12 Sep 2025 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="PCMUx5ZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF71D63F7;
	Fri, 12 Sep 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655300; cv=none; b=FspzMd+qGSk2FcDx9tSiMHhbvu/PNcR1ztkRduYvlfpYKG8VF5SYKbns0Bw/CKX9DbGWMzkt9zBswchhAcOUn1ofFT/FW49QmspjxpceJlXlOTP5WozX730ycSGwjJ5WK9+fVsHckH/t7krG2+jwkHxfxwNrXdTL6g37MnL3Qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655300; c=relaxed/simple;
	bh=YkN4GS1CyJbfXCRhVUC4AipXGms28+xZ3/eh7PBwmZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFhLiYIq7LhFw6uCEYWRau9c37qTQW94M68Hp+ZvcAaoH9xzsgvErTxCrYKLN555FvYcFLe4YF8j7DjIos5JphzAlhHRQ1wdYccIIr3nFYUdUrAMwNbxWvsef0FAdXX/5ttf/rse2sun/beoPVD+tL1uaJAD10SmxXswSWoZ7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=PCMUx5ZC; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=ymWnl9hT2ZJpPN1yvfd4PQoid/jSmJHQlyUPvhZ+LGI=; b=PCMUx5ZCOstaJPzmFU25+JJYMX
	JVT1IFEdvM75B8LimMx+kN0n+ciOCZSn+8vejUMHRqPGz+z23kQa9pNgawM8lQhY0dSThr+U2mULu
	hfRXMNwmmVGe1l9/WvTTVZ6lg1DM7MPKtq2EXk/rdsfxFvKuwU9gRxSP9+hBuaikpqlRFQsHOKK7l
	m30DPgMX1IP+FPUj5JfPRmUGcBZcKg0s0SGvSh1LI/CIoDJsIqTrxSLK1GTjvj0t5Rg+FkDFqiWnt
	RguI6gODVazk/C0xjWNdOzkxkDEaQesGGZS5boEXGw4KMt5yZ8QxW0BeXJfw83nMgssVHWdZR7NH0
	H/6dqA/H8TySxnuF4dMEy+H1JZwKcPr7t3mElxLEVUf/UXg9SiEr7eH2fOeZe1qMi+n5s6p6AxLyb
	I48L5cbzNSaPy0brwOYmN2CeUOEDs9uNGHGmLyqhxFdUF4G27geVMAbegdNuPN9s4sk+9tGtyTPGl
	ALp5FXbCr6c0I2S3UPU8VoPw;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uwwQr-003itc-2t;
	Fri, 12 Sep 2025 05:34:49 +0000
Message-ID: <d3712068-ec74-4adb-9e1b-0f8cd6c39ad5@samba.org>
Date: Fri, 12 Sep 2025 07:34:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] cifs: Clean up declarations
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <20250904211839.1152340-1-dhowells@redhat.com>
 <20250904211839.1152340-3-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250904211839.1152340-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

can you please drop the changes to smbdirect.h?
(This is the only part I really looked at).
They leave strange comments around and will likely
cause conflicts with my current work.

Most or all functions will go soon anyway.

Thanks!
metze

> diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
> index e190cb96486f..6ed6d293824a 100644
> --- a/fs/smb/client/smbdirect.h
> +++ b/fs/smb/client/smbdirect.h
> @@ -114,18 +114,11 @@ struct smbd_connection {
>   };
>   
>   /* Create a SMBDirect session */
> -struct smbd_connection *smbd_get_connection(
> -	struct TCP_Server_Info *server, struct sockaddr *dstaddr);
>   
>   /* Reconnect SMBDirect session */
> -int smbd_reconnect(struct TCP_Server_Info *server);
>   /* Destroy SMBDirect session */
> -void smbd_destroy(struct TCP_Server_Info *server);
>   
>   /* Interface for carrying upper layer I/O through send/recv */
> -int smbd_recv(struct smbd_connection *info, struct msghdr *msg);
> -int smbd_send(struct TCP_Server_Info *server,
> -	int num_rqst, struct smb_rqst *rqst);
>   
>   enum mr_state {
>   	MR_READY,
> @@ -151,12 +144,22 @@ struct smbd_mr {
>   };
>   
>   /* Interfaces to register and deregister MR for RDMA read/write */
> -struct smbd_mr *smbd_register_mr(
> -	struct smbd_connection *info, struct iov_iter *iter,
> -	bool writing, bool need_invalidate);
> -int smbd_deregister_mr(struct smbd_mr *mr);
>   
> -/* PROTOTYPES */
> +
> +/*
> + * smbdirect.c
> + */
> +void smbd_destroy(struct TCP_Server_Info *server);
> +int smbd_reconnect(struct TCP_Server_Info *server);
> +struct smbd_connection *smbd_get_connection(
> +	struct TCP_Server_Info *server, struct sockaddr *dstaddr);
> +int smbd_recv(struct smbd_connection *info, struct msghdr *msg);
> +int smbd_send(struct TCP_Server_Info *server,
> +	int num_rqst, struct smb_rqst *rqst_array);
> +struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
> +				 struct iov_iter *iter,
> +				 bool writing, bool need_invalidate);
> +int smbd_deregister_mr(struct smbd_mr *smbdirect_mr);
>   
>   #else
>   #define cifs_rdma_enabled(server)	0
> 



