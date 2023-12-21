Return-Path: <linux-fsdevel+bounces-6610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B881ABCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 01:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6769A1C22C48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 00:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8B1864;
	Thu, 21 Dec 2023 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N64Z6/z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95CA5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703118953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/Nsx0uTbT/aeaoVsFzkutbp6qKnM0H++hewV/P3G6o=;
	b=N64Z6/z1VgjrDQWemyr6IRz29Aw//OYIpMu0eEJOkk08x3keAJKwzumoM5sT5OiuN/lKCZ
	JAfYivdig4nATeRRbOhZpDOCD5LVryYDu9rPxjoPut1dnMxg8VaOYOU9itacjNPx56FTV+
	szJIxHQ/NOPmnKK404kI1kT28NsAujU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-UcGWbYbHMi6_P8KqWKeynA-1; Wed, 20 Dec 2023 19:35:52 -0500
X-MC-Unique: UcGWbYbHMi6_P8KqWKeynA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-590caa98510so273284eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 16:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703118950; x=1703723750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/Nsx0uTbT/aeaoVsFzkutbp6qKnM0H++hewV/P3G6o=;
        b=kRoxGukykZyXNSTLBJSqC0yRY8DtdZs64sA8sXwoQGf1wTiuE1XoEBtqK+5ftbN67r
         0yFO5il1DWO2iYyx0FwbGRnsXFXU8toLWH+aTuPl/emYg4n5KBxN+CSrcqS7gytz+CaR
         0kkv+sS93fsthZQaXSXi9mQWNMQ91QsLAHAEb5ymP41mO9gVt1QloMVbyll9mRqBPccN
         +FW2PUJxrV1EmeygrEGEliSQyELh95kK0iNaEbfqxJy7rXOeS9wyJK/33c44Jgw80Yfl
         2BCsGTym4TBM17GuOLOJTX/NIvqNhsnRmcNTTKSAFBi+APk3uoH3QJQmOvUVX34Gm09+
         tcpg==
X-Gm-Message-State: AOJu0Yx8ZRga9iJTRUiNBvvK31GdFE+/1iNJINSMwKmJ6yxZGVyGaEWG
	LIhz6XIKpBGTkyeglI21/Ui8KtRzfK64Yx0ub3XFIBQ9rZBiRE+fP7JzzvdFRB1ZfUUh9iO2R+6
	GluFJFy64EoJULcxVtpGqJ2cM2iRiBg0K8IeQPhg=
X-Received: by 2002:a05:6359:6d87:b0:170:bfb9:fb41 with SMTP id tg7-20020a0563596d8700b00170bfb9fb41mr432992rwb.28.1703118950563;
        Wed, 20 Dec 2023 16:35:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1EuksPrUcRRt6RWMnztC1dmmcfJQ0X2BtZJbZnTmW7Msq/4F8WlD/IQ25nxsZ1dMG/OaPYw==
X-Received: by 2002:a05:6359:6d87:b0:170:bfb9:fb41 with SMTP id tg7-20020a0563596d8700b00170bfb9fb41mr432986rwb.28.1703118950180;
        Wed, 20 Dec 2023 16:35:50 -0800 (PST)
Received: from [10.72.112.86] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jx20-20020a17090b46d400b0028b66796002sm457065pjb.6.2023.12.20.16.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 16:35:49 -0800 (PST)
Message-ID: <aea7344d-6dcf-44dc-8916-56619d9113f2@redhat.com>
Date: Thu, 21 Dec 2023 08:35:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] ceph: d_obtain_{alias,root}(ERR_PTR(...)) will do
 the right thing
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org
References: <20231220051348.GY1674809@ZenIV> <20231220052054.GF1674809@ZenIV>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231220052054.GF1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/20/23 13:20, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/ceph/export.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 726af69d4d62..a79f163ae4ed 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -286,8 +286,6 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
>   		doutc(cl, "%llx.%llx parent %llx hash %x err=%d", vino.ino,
>   		      vino.snap, sfh->parent_ino, sfh->hash, err);
>   	}
> -	if (IS_ERR(inode))
> -		return ERR_CAST(inode);
>   	/* see comments in ceph_get_parent() */
>   	return unlinked ? d_obtain_root(inode) : d_obtain_alias(inode);
>   }

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks!



