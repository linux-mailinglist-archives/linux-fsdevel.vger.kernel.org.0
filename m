Return-Path: <linux-fsdevel+bounces-6611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6181ABDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 01:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2263F1F23850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 00:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDF17FD;
	Thu, 21 Dec 2023 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1wTj2As"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE84EDE
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703119528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0mAFvrG1uLVuIDPupMM8tYALPgi3XmxPECK7F99iME=;
	b=h1wTj2AsXCGNE/fcjHTE5Hy5ciFNmYC3lMUPuo4CioXAV9K8aMYimJgHeaXC4ZwpnbJ4Lj
	5hmTz2PS9yB0P/4UZXcV1t2N0oS0b/JbUSYFj0yY5Msa1vZAxFzWAtY8sECI+j12Qo/xFF
	yEY+uXSu7PVTvyUC1vSSazH3JX96EVc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-deWBWKmUMvyLWuN7s5P-5w-1; Wed, 20 Dec 2023 19:45:25 -0500
X-MC-Unique: deWBWKmUMvyLWuN7s5P-5w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9f111c18dso283223b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 16:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703119524; x=1703724324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0mAFvrG1uLVuIDPupMM8tYALPgi3XmxPECK7F99iME=;
        b=HCdDtY1QiPOQx1kJctV5joMe5nXsov8J7S7H43Yl/mYpAnR98LI9jSvwSPacBEEqNP
         8XvKnYzmLMh2Jr7khkqp6kGMsY2FQjelJCornpfnRb+tjL58EEU/d5hJX1ETF2Xaz3AR
         3EvjpkxULSNEdtT0sVfpvdbRMR5yFttiKr1Ad2kLjtTWlmHEYJipfjjCkRwRqncuZ9Ez
         /3RV59amMnxh+n+7DsJKUnnYOVaZPzRzeYtThrU3KtI+xosZip4jWohBRkkFVYP2jO8I
         Lr9Tv+RPOQ7lBv8f6nK9cqeTAV38ZPvK5fBwfG+lp6QLs+m/q2gppndF1HG4bCfHGut5
         9/SA==
X-Gm-Message-State: AOJu0YzrS2ncv/iixq3YWxk9O+CY+JNPlwVrqDTQuuzAFja4unQbqMVM
	tFSocgxVwKZJznq9k6lSh/9nnILbHh5y7gAUZMMmRcThW/QUo6ZYOaUI0PN5hIa0oWJHLGlpFxF
	zlTBalaKZ14N7Y1A7wFTwC7nNt0+5JbU1LNBP
X-Received: by 2002:a05:6808:648b:b0:3ba:5dd:946c with SMTP id fh11-20020a056808648b00b003ba05dd946cmr25906785oib.4.1703119524739;
        Wed, 20 Dec 2023 16:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH88GeAzWTs3T0ANaUjp2q9gM56UgqBh7hPQqiwagA2y0hyuTaKXwA4Rso3qJ8CgP+v1mSTKA==
X-Received: by 2002:a05:6808:648b:b0:3ba:5dd:946c with SMTP id fh11-20020a056808648b00b003ba05dd946cmr25906770oib.4.1703119524435;
        Wed, 20 Dec 2023 16:45:24 -0800 (PST)
Received: from [10.72.112.86] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001d398889d4dsm317411plz.127.2023.12.20.16.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 16:45:23 -0800 (PST)
Message-ID: <446cf570-4d3d-4bdb-978c-a61d801a8c32@redhat.com>
Date: Thu, 21 Dec 2023 08:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] get rid of passing callbacks to ceph
 __dentry_leases_walk()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org
References: <20231220051348.GY1674809@ZenIV> <20231220052925.GP1674809@ZenIV>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231220052925.GP1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/20/23 13:29, Al Viro wrote:
> __dentry_leases_walk() is gets a callback and calls it for
> a bunch of denties; there are exactly two callers and
> we already have a flag telling them apart - lwc->dir_lease.
>
> Seeing that indirect calls are costly these days, let's
> get rid of the callback and just call the right function
> directly.  Has a side benefit of saner signatures...
>
> Signed-off-by Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/ceph/dir.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 91709934c8b1..768158743750 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1593,10 +1593,12 @@ struct ceph_lease_walk_control {
>   	unsigned long dir_lease_ttl;
>   };
>   
> +static int __dir_lease_check(const struct dentry *, struct ceph_lease_walk_control *);
> +static int __dentry_lease_check(const struct dentry *);
> +
>   static unsigned long
>   __dentry_leases_walk(struct ceph_mds_client *mdsc,
> -		     struct ceph_lease_walk_control *lwc,
> -		     int (*check)(struct dentry*, void*))
> +		     struct ceph_lease_walk_control *lwc)
>   {
>   	struct ceph_dentry_info *di, *tmp;
>   	struct dentry *dentry, *last = NULL;
> @@ -1624,7 +1626,10 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
>   			goto next;
>   		}
>   
> -		ret = check(dentry, lwc);
> +		if (lwc->dir_lease)
> +			ret = __dir_lease_check(dentry, lwc);
> +		else
> +			ret = __dentry_lease_check(dentry);
>   		if (ret & TOUCH) {
>   			/* move it into tail of dir lease list */
>   			__dentry_dir_lease_touch(mdsc, di);
> @@ -1681,7 +1686,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
>   	return freed;
>   }
>   
> -static int __dentry_lease_check(struct dentry *dentry, void *arg)
> +static int __dentry_lease_check(const struct dentry *dentry)
>   {
>   	struct ceph_dentry_info *di = ceph_dentry(dentry);
>   	int ret;
> @@ -1696,9 +1701,9 @@ static int __dentry_lease_check(struct dentry *dentry, void *arg)
>   	return DELETE;
>   }
>   
> -static int __dir_lease_check(struct dentry *dentry, void *arg)
> +static int __dir_lease_check(const struct dentry *dentry,
> +			     struct ceph_lease_walk_control *lwc)
>   {
> -	struct ceph_lease_walk_control *lwc = arg;
>   	struct ceph_dentry_info *di = ceph_dentry(dentry);
>   
>   	int ret = __dir_lease_try_check(dentry);
> @@ -1737,7 +1742,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
>   
>   	lwc.dir_lease = false;
>   	lwc.nr_to_scan  = CEPH_CAPS_PER_RELEASE * 2;
> -	freed = __dentry_leases_walk(mdsc, &lwc, __dentry_lease_check);
> +	freed = __dentry_leases_walk(mdsc, &lwc);
>   	if (!lwc.nr_to_scan) /* more invalid leases */
>   		return -EAGAIN;
>   
> @@ -1747,7 +1752,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
>   	lwc.dir_lease = true;
>   	lwc.expire_dir_lease = freed < count;
>   	lwc.dir_lease_ttl = mdsc->fsc->mount_options->caps_wanted_delay_max * HZ;
> -	freed +=__dentry_leases_walk(mdsc, &lwc, __dir_lease_check);
> +	freed +=__dentry_leases_walk(mdsc, &lwc);
>   	if (!lwc.nr_to_scan) /* more to check */
>   		return -EAGAIN;
>   

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Al,

I think these two ceph patches won't be dependent by your following 
patches,  right ?

If so we can apply them to ceph-client tree and run more tests.


Thanks!



