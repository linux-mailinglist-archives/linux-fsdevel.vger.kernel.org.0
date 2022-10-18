Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F160327C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJRSaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJRSaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:30:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C647A776;
        Tue, 18 Oct 2022 11:30:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 13so34325828ejn.3;
        Tue, 18 Oct 2022 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gjtTt36rDgEeE1qwnrH+mDax42Nw740LJXYKg5XoFA=;
        b=X09aTYUPS7oa3Nm6zUwHk/bG1ogckKdqBEUfmEklQbmAovKHD9h0DrMuzH2yAAGJCJ
         Nr+cxiC+HmAq2i0uU4xVYydP0LSshF6k80ge9txh3Trptlp21Q4XTW5fv3S1I76YbwaN
         bDEyY1L6GHpsV75/GmMDeR58ObCXfQxJ+ZDiw/42ui6zk3KGivFEoBIfVlbPElteneJV
         jE+Nkylaeewm4fY1ALHLXEf5STGlTufsKh9ca4V07Uocb5XEIqUISBtP9/zESEYx92EC
         o5aRNKGWDoJV9pPdz8Yxh+aMnneBVGmtG9jI9Mv3abgGsjWjLLxrX9ppv2sKBkvDHgzC
         kRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gjtTt36rDgEeE1qwnrH+mDax42Nw740LJXYKg5XoFA=;
        b=ei+alaqg+wUbg6MKhsZBOITC5UOp25sHPMYJz8+PYSEaOh0Cv1Ifkxu3hxQMzzzVJB
         oGVO5Q5nrbxqmG8YTVxwq4elT/sdwjYaoOnP4m/2O8iD9+sl6iqThULij1HUFug8yRXh
         ofGLNasSzj91FUZ6HXvF+/Kttp6yv4IqpFEyKHxZd2wtggv/uHVM5sZujM1am4ZiIHrH
         413VW1As2P9NnkqM98u4DdcI+EToHM+DBYmTxt5owd6QsEG/F8csX6B3i5tryscRh78w
         wleHeMpjJBM8cSMwvBLybSno425wTY/FfW6WMEsgIElOZBTIBvVuJVpXowf0kMBYAhm0
         H3Ug==
X-Gm-Message-State: ACrzQf2auWHFH7gkqeiS5eBgn2wBX8nVhnwjAC4q8qdoooHvs/DxStY9
        B6b8k8NTVsKABeKVCGESWH/GYCs551s=
X-Google-Smtp-Source: AMsMyM7CPtYisE8eHY0Rm2IzQvbp+THtEPwXxkLXrddeixQk/L2ke7b2xCUwfVXvX9VGmuBQ9wking==
X-Received: by 2002:a17:907:7f25:b0:78d:e76a:ef18 with SMTP id qf37-20020a1709077f2500b0078de76aef18mr3524035ejc.378.1666117799785;
        Tue, 18 Oct 2022 11:29:59 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906860b00b0078de26ee46dsm7864586ejx.152.2022.10.18.11.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:29:59 -0700 (PDT)
Date:   Tue, 18 Oct 2022 20:29:57 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v10 04/11] landlock: Support file truncation
Message-ID: <Y07wpUT5FxaHcqbp@nuc>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
 <20221018182216.301684-5-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018182216.301684-5-gnoack3000@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To simplify the review - let me highlight the part that is new in V10
and which fixes the bug which Nathan spotted on ARM64.

(The other changes in V10 are only changes to documentation pulled
from Mickaël's -next branch.)

On Tue, Oct 18, 2022 at 08:22:09PM +0200, Günther Noack wrote:
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> ...
> In security/security.c, allocate security blobs at pointer-aligned
> offsets. This fixes the problem where one LSM's security blob can
> shift another LSM's security blob to an unaligned address. (Reported
> by Nathan Chancellor)

The corresponding implementation is:

> diff --git a/security/security.c b/security/security.c
> index b55596958d0c..e0fe4ba39eb9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -185,11 +185,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
>  {
>  	int offset;
>  
> -	if (*need > 0) {
> -		offset = *lbs;
> -		*lbs += *need;
> -		*need = offset;
> -	}
> +	if (*need <= 0)
> +		return;
> +
> +	offset = ALIGN(*lbs, sizeof(void *));
> +	*lbs = offset + *need;
> +	*need = offset;
>  }

(As discussed previously in
https://lore.kernel.org/all/Y07rP%2FYNYxvQzOei@nuc/)

—Günther

-- 
