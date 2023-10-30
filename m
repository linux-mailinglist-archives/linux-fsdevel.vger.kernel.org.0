Return-Path: <linux-fsdevel+bounces-1518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC87DB212
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 03:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ABD2814B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8941383;
	Mon, 30 Oct 2023 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWS0xJWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824110FE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 02:30:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B5C0
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698633012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HpUXC3JPrBrGax2FnC82K3XfMYa1e9s8tOjT5ZffiY=;
	b=AWS0xJWYDLnvuE5oei7urt3M+eVMUJqyA0jpJqQKTbHdIpns+lIK+FdU+XSE1KAzWpoHpq
	6BSW20Z2TTTp3Y7Xkm7tkyYJLJaMAYiWVDbU0BNiuTXc2KYjZ77sHIfLPxG7DKuUeWAZvV
	CtJS4SnxC1cqeAb30/o9CeS0/LFDP4s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-wyx4kY74PrS0evcIjDx-1A-1; Sun, 29 Oct 2023 22:30:01 -0400
X-MC-Unique: wyx4kY74PrS0evcIjDx-1A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28043db47ebso440434a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 19:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698633000; x=1699237800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HpUXC3JPrBrGax2FnC82K3XfMYa1e9s8tOjT5ZffiY=;
        b=VZI8fZoEu3fFqw4CYPL+L+rt3vKK0D6yN7qmx1+dYKBkID9Iw+OylcOug/VbZTOBac
         S7i4mfSEPBQBETWO6Nm4RT1HbzhB2/NvES0pHNeIghWb1v5RAY6KsItUZmg8euK/2lSC
         /URfX0OFQS/+EZEaNOMKzr2iZVNKhxKQHFZAOgDwmoXSAzEqzjQ7TIRS6IVpDEz04Vbd
         lVjMP069ScNy4dtJb+rpIpNc8HGGdYXeAlhZzm/Hec0V1b6cVD51epkn0SC74553SNxw
         T/WLpAFbl5F66RxJTcCIhYgw0Vey0BDLxNsFyh7VogeDufa5s1OveNBjnCVtveCh+fMK
         kGqQ==
X-Gm-Message-State: AOJu0Yw1yDDo3+QNqxW2bGLsQOvk/WFJLMx1N37vsfUtzB2DXuAz7HKY
	CVmxR0E2Dh/QqqLvdmAFVWZTpgPVyzTnttGiDO23ytkvchimWIgir0dvwGct4//IpupLiP66rGc
	FoBC5qVIW3fwg631LJO1IjW2EkA==
X-Received: by 2002:a17:90b:38c6:b0:280:1df1:cbc7 with SMTP id nn6-20020a17090b38c600b002801df1cbc7mr3226195pjb.19.1698633000475;
        Sun, 29 Oct 2023 19:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0oU7E/0LQcG9ncujTjZpkf0rLEVN6z1PkBcPgrCwMikCgvLJ4kdha+NU745fBGfA6qDJ76w==
X-Received: by 2002:a17:90b:38c6:b0:280:1df1:cbc7 with SMTP id nn6-20020a17090b38c600b002801df1cbc7mr3226183pjb.19.1698633000110;
        Sun, 29 Oct 2023 19:30:00 -0700 (PDT)
Received: from [10.72.112.142] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm1-20020a17090b3c4100b002805740d668sm1136675pjb.4.2023.10.29.19.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 19:29:59 -0700 (PDT)
Message-ID: <209b187c-f471-6921-4cda-7293e362d729@redhat.com>
Date: Mon, 30 Oct 2023 10:29:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph_wait_on_conflict_unlink(): grab reference before
 dropping ->d_lock
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20231026022115.GK800259@ZenIV>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231026022115.GK800259@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/26/23 10:21, Al Viro wrote:
> [at the moment in viro/vfs.git#fixes]
> Use of dget() after we'd dropped ->d_lock is too late - dentry might
> be gone by that point.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/ceph/mds_client.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 615db141b6c4..293b93182955 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -861,8 +861,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
>   		if (!d_same_name(udentry, pdentry, &dname))
>   			goto next;
>   
> +		found = dget_dlock(udentry);
>   		spin_unlock(&udentry->d_lock);
> -		found = dget(udentry);
>   		break;
>   next:
>   		spin_unlock(&udentry->d_lock);

Good catch.

Thanks Al.

- Xiubo



