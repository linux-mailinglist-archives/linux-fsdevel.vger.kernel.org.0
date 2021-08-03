Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C113DE76E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhHCHqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 03:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234137AbhHCHq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627976777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnfVPSk/HizDyO3JxuKbaXMtEKJY0iQR8Nsy47TDxzw=;
        b=Bpsu45Ybojy5IW/zbVw51aw0UoshLyYz/zslIIq47NQmWavNeHmSuU1B820LIGExiovOGC
        H/Bzs/5A0ZEyoNceeH0zK7XzWJnl7KeNXqu+OpjsIPcRtKzhUnNPQNeX9Otx6M+xFyQeOw
        7deMkja8Slm0OpuvQ3css35pKR0QCPY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-b059cAWeNJW5ayAKAHF6jg-1; Tue, 03 Aug 2021 03:46:14 -0400
X-MC-Unique: b059cAWeNJW5ayAKAHF6jg-1
Received: by mail-pl1-f199.google.com with SMTP id i7-20020a17090332c7b0290124e63feb68so15911427plr.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GnfVPSk/HizDyO3JxuKbaXMtEKJY0iQR8Nsy47TDxzw=;
        b=j1RKIt9g5WdaO/w/8ayPZwETsi0P+W0CdVs47f4kvl+dAuL+KSbh0mPv+xvmuKgDEo
         3lRh2guyZpWn1+yJ7YH3rEf99Rvv1+rEy3Nl6TBjOq8ahkV7TCr8CSG4GCqFkCPXvdE4
         b/5CZKP3RhY/oazT45XS9vssnFRiQlqu7yvWmu93mjgMr54GV7insEuSl6XcQTjRx5LY
         vhcbAf+mhMhva3egbgix5ezwDl5hzsuf5K3LpULtyGYKETNYmwOaCGPboe+YeNGO5yfA
         /SV1tswFr9vWf4IXT2y6hed3l0X0VDwvJ/UA4ARYBGboH9j+a0X4NfiB+HbWL4Jaegk1
         Y6XA==
X-Gm-Message-State: AOAM530dw13eEwmVoLq9qUv80qOZY89WSZqKoRtvWBgVcfU560Ouk7F7
        Ol4AE5i1BMEAMdjF9y9lpkP97tdVVljxqVihgwDZzQ3odK7b6ttzsZcD2dRmUxaQ5AbR7sfqN4y
        nXem4zXDyNe+Wxz1fBTh152pNfQ==
X-Received: by 2002:a17:90a:7065:: with SMTP id f92mr3190626pjk.16.1627976773309;
        Tue, 03 Aug 2021 00:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEvOW/oPitztnM44QtOEHatfCeA16JROutkQDb3a25VjV+JgBNuHrwDZ3buALcITz8Iapu0g==
X-Received: by 2002:a17:90a:7065:: with SMTP id f92mr3190595pjk.16.1627976773095;
        Tue, 03 Aug 2021 00:46:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f1sm7278948pfk.115.2021.08.03.00.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:46:12 -0700 (PDT)
Subject: Re: [PATCH v10 02/17] file: Export receive_fd() to modules
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a0ab081a-db06-6b7a-b22e-4ace96a5c7db@redhat.com>
Date:   Tue, 3 Aug 2021 15:45:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-3-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/7/29 ÏÂÎç3:34, Xie Yongji Ð´µÀ:
> Export receive_fd() so that some modules can use
> it to pass file descriptor between processes without
> missing any security stuffs.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   fs/file.c            | 6 ++++++
>   include/linux/file.h | 7 +++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 86dc9956af32..210e540672aa 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1134,6 +1134,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>   	return new_fd;
>   }
>   
> +int receive_fd(struct file *file, unsigned int o_flags)
> +{
> +	return __receive_fd(file, NULL, o_flags);


Any reason that receive_fd_user() can live in the file.h?

Thanks


> +}
> +EXPORT_SYMBOL_GPL(receive_fd);
> +
>   static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
>   {
>   	int err = -EBADF;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 2de2e4613d7b..51e830b4fe3a 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
>   
>   extern int __receive_fd(struct file *file, int __user *ufd,
>   			unsigned int o_flags);
> +
> +extern int receive_fd(struct file *file, unsigned int o_flags);
> +
>   static inline int receive_fd_user(struct file *file, int __user *ufd,
>   				  unsigned int o_flags)
>   {
> @@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
>   		return -EFAULT;
>   	return __receive_fd(file, ufd, o_flags);
>   }
> -static inline int receive_fd(struct file *file, unsigned int o_flags)
> -{
> -	return __receive_fd(file, NULL, o_flags);
> -}
>   int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
>   
>   extern void flush_delayed_fput(void);

