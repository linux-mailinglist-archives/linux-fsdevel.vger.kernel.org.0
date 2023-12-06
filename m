Return-Path: <linux-fsdevel+bounces-5007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B4807521
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467E12815C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1647776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDXiuI0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C6D66
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701874628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OFoWfYFGMSLMRLvALUTTuwv5k+YKBuVNmioBwfoMXs=;
	b=PDXiuI0LpFFvIc6iMUmPnMbU+h1KUTIOZfmlF81wzw9JpZ9Skn6YrZwsr9+sSKTh0zWqT7
	ujGXie4Gb5T/11ck6FZktxLkCQuOjMK4lgxAJa+5uigeO3wMRGVw8ji4ABIebAzTyPflze
	qUNEGPSdw+BZosP3uvINUgesBvHOjBs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-PiIINLWsMKKKEqtbSCMzqw-1; Wed, 06 Dec 2023 09:57:06 -0500
X-MC-Unique: PiIINLWsMKKKEqtbSCMzqw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d7df84935so54366966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 06:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874625; x=1702479425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OFoWfYFGMSLMRLvALUTTuwv5k+YKBuVNmioBwfoMXs=;
        b=Hpox5oChgngJ/CAYVR76ULNkh7/+WdOVfmmCJY+njOFaVPKG6dy+QysPYwRpKiiaBw
         MM5EFEFmNa6epfxi7DUMB234XtSEuafDL15b6Up0wELND2YQEDNsnf6v3xCNSxPgZbMN
         E5TSn7Q6kJbgKN/YI/AZrseRrfjvnbPK/S/TP/XNQeYyuggasGRb50epyi6nYmuX+F1l
         EFr/upVW+CfL7zAcmWEhJj2rwhTp3XDJ/7ZEyONn0bnmYPyXGVxdu3Npc3avpsOP7iS3
         wJDUUKz4T++A3mv5l/oWOPv6p6AOixHwts8YYQpFq9Vvrzj5b5lJ46igYHq/FOIhIJV4
         rdKw==
X-Gm-Message-State: AOJu0YyWYcRtj9AlNzeVUrSyBCHAT90+HZ6RDf+34ioWmRvAjK5uM5EK
	rXHtxneAiHLhYmVRrE2vZxsgBk973NwB4gQc9fLYYI7kH2QXfkup6xQ/vqx8DR+bTbqLmF7JGTV
	pdEmJlaFYEYEk+BIgOa1Zs2j7sl4ua/uLbg==
X-Received: by 2002:a17:906:3407:b0:9b2:982e:339a with SMTP id c7-20020a170906340700b009b2982e339amr473742ejb.22.1701874624968;
        Wed, 06 Dec 2023 06:57:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3EjnTlF5V6i6d2h8RSMaCMmK9q3J7E1svf8LgCXo2RHIzrmXFr0whTNHFjjJZDxkOGNTeEw==
X-Received: by 2002:a17:906:3407:b0:9b2:982e:339a with SMTP id c7-20020a170906340700b009b2982e339amr473738ejb.22.1701874624662;
        Wed, 06 Dec 2023 06:57:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id br20-20020a170906d15400b00a1dcfd8f95csm27081ejb.37.2023.12.06.06.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:57:04 -0800 (PST)
Message-ID: <0fb8fe4f-cb5d-4c74-9bdc-34ff04024f62@redhat.com>
Date: Wed, 6 Dec 2023 15:57:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: vboxsf: fix a kernel-doc warning
To: Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20231206025355.31814-1-rdunlap@infradead.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231206025355.31814-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Randy,

On 12/6/23 03:53, Randy Dunlap wrote:
> Fix function parameters to prevent kernel-doc warnings.
> 
> vboxsf_wrappers.c:132: warning: Function parameter or member 'create_parms' not described in 'vboxsf_create'
> vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

vboxsf is not really undergoing any active development,
can this be merged through the Documentation tree?

Regards,

Hans





> ---
>  fs/vboxsf/vboxsf_wrappers.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
> --- a/fs/vboxsf/vboxsf_wrappers.c
> +++ b/fs/vboxsf/vboxsf_wrappers.c
> @@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
>   * vboxsf_create - Create a new file or folder
>   * @root:         Root of the shared folder in which to create the file
>   * @parsed_path:  The path of the file or folder relative to the shared folder
> - * @param:        create_parms Parameters for file/folder creation.
> + * @create_parms: Parameters for file/folder creation.
>   *
>   * Create a new file or folder or open an existing one in a shared folder.
>   * Note this function always returns 0 / success unless an exceptional condition
> 


