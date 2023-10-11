Return-Path: <linux-fsdevel+bounces-35-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6907C4AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6D2820F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11481774C;
	Wed, 11 Oct 2023 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmP3IBjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC41798A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:34:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841E9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697006074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIAMyUmlxWrNU8XizAtbyVA/LuGwCus231d845v8K30=;
	b=CmP3IBjhnc9iVzQQiIWQvNTMZBMHOcwm4pz3MueaIuuhdBjIhd7LMV1Qi0btPRxyuV+QDf
	mfcL//2aF3iPjaDOAPwgJGrCnfFOcQdgU6Y6Jjpy5D/QJwBKv+MHF1QXI3vGTBK+ajAg4y
	0r5IqRGLCsbVpey0la1fPMMeUvoFZZU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-_RxGRpLsPAe9l_DJ8eOp1g-1; Wed, 11 Oct 2023 02:34:32 -0400
X-MC-Unique: _RxGRpLsPAe9l_DJ8eOp1g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae7663e604so487065366b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006072; x=1697610872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIAMyUmlxWrNU8XizAtbyVA/LuGwCus231d845v8K30=;
        b=MjTFBPCZmRY/vVMjeeUmdY5zaVjJHWeMMMq/pER2fquOj+MWJ+EKOTF396pw8PZEu9
         eCq/y8JiZyH1r5tCFty2RlqVDoQQ5nGi2kKupw73nkNedUCaIJBXFKz0Pi441ZXSkdri
         eGMWZWCP0j0mUV2UfzYpsO+tFBTli0SvWbRHBFWxn2dSW1qGdulisxTdFXpAhGw5kNiY
         D5dksSeqFCwBLxCtBkWEfknOEg4R4s2U8TuHPFJ+9b0R39BxG4val1fa9YUxJkll/uuJ
         MVskkDXcHqt05vSfUcllZsLLeb8oITtwtpyH4O6jO/xsKCHyX857xgK2sdsWwJi9Lweg
         hmqw==
X-Gm-Message-State: AOJu0Yx+1LntdIHUaWdZhTxbxn7gpKPHUmr762nAR9dtuH7nD2R6gvhn
	Irq75RyNJ4pc/EDDHRcmiIRSxcr0dukSDVb3jc2SBYSl5xSHzUMudVC604780vCVi709o/5Xqv/
	mi421g8bF67ljdCN/YZwiXJsLrQ==
X-Received: by 2002:a17:907:762f:b0:9ae:5898:e278 with SMTP id jy15-20020a170907762f00b009ae5898e278mr18082590ejc.59.1697006071790;
        Tue, 10 Oct 2023 23:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Me0EZixeTyeE4zeSZNFscGp8BuKKX9KKpuFaxePk+Ru3aD5eiRwHnkiENimnGBUZNAB1ow==
X-Received: by 2002:a17:907:762f:b0:9ae:5898:e278 with SMTP id jy15-20020a170907762f00b009ae5898e278mr18082581ejc.59.1697006071530;
        Tue, 10 Oct 2023 23:34:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id pw23-20020a17090720b700b009ae05f9eab3sm9339295ejb.65.2023.10.10.23.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 23:34:30 -0700 (PDT)
Message-ID: <b56b6333-bbea-e451-0ddf-c14622e5a80e@redhat.com>
Date: Wed, 11 Oct 2023 08:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vboxsf: Remove the unused variable out_len
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20231011025302.84651-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231011025302.84651-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/11/23 04:53, Jiapeng Chong wrote:
> Variable out_len is not effectively used, so delete it.
> 
> fs/vboxsf/utils.c:443:9: warning: variable 'out_len' set but not used
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6776
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  fs/vboxsf/utils.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index 72ac9320e6a3..9515bbf0b54c 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -440,7 +440,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -448,7 +447,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  
> @@ -469,7 +467,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  
>  		out += nb;
>  		out_bound_len -= nb;
> -		out_len += nb;
>  	}
>  
>  	*out = 0;


