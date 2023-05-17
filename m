Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6EB706066
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQGq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQGq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 02:46:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5AE4;
        Tue, 16 May 2023 23:46:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64395e741fcso334546b3a.2;
        Tue, 16 May 2023 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684305985; x=1686897985;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FPHixe8a57Z56CXMJx/dB4Z/ixMlZuaiWC2ESfIzmQk=;
        b=jhzcOM9YxiKVOkHZYC+sZS1l4fpdFpiYJ6tNLNMezIDPyuFPrZtw0nGgmik6GT4+1u
         +vDoSp/bfinXKa9fMObRs9UelvAewwK/+C5DMbywuMPbo8E8vgVxZSp+pDjT7C1SwPts
         4MIii/J2t4FcJBsyeabZoZukhQnHcjFul9ViWCKo5mGMGekmZj2N/AEipZNBywf7lvLq
         HbdIgxWnDcL+1Fk818nAVRilqUSrR9ADMcAFxqIVV/l34oHeN0qsQVC2oOEPSRQbjvr9
         suq5i9UeCwi/fD34QIgcbjLK1rcsr1wanL4FlMhskTSqaWgaMN4ZfLksCi89m4Qpzd32
         atew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684305985; x=1686897985;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPHixe8a57Z56CXMJx/dB4Z/ixMlZuaiWC2ESfIzmQk=;
        b=HFB+fWB9dkTcuREyXWxvcqu0yjdVU0wue29y4iGfFejN9qCxd5Vqul49wulldviZKY
         tMRF9psj7ro+JMPZJ1xribEX12DOWsps7TqairRWpB7vpAHim12DftB6Q/m/EXScSkuT
         kw1kyZJQzPL7BKQr5R61NrXw+KuGtpp0Tqsylxv1Be7kT5vwtEiQZGeY1itVphGiJykw
         435VP0/jhgyFCjZmzDLDfe1X7dxpUivmRqji+o6uPvYBlgKT6GlRIWEtuToEiJFULGfd
         hUUhElVv17Mu8xSzv9gqg57TZnqrXypI2+t68hcCq1w4XUBCFdcfmjn8HaoDiWeCbYOZ
         8YJA==
X-Gm-Message-State: AC+VfDzyx47vLQ62m2OTWhUkIQmJb2+ZY3cpV2bE5QJ2Qz62jrWZU7Sb
        g37w0/wcVFPULGZsc2tiw+jkZj/Hmrs=
X-Google-Smtp-Source: ACHHUZ4ryyc5t7PSM9uc9vuDzeDU2rEt5AytFccVZ3LuLgtaAeYW8x/g3LaW7R/OD9F7DPtdIvvgHw==
X-Received: by 2002:a05:6a00:17a3:b0:636:f5f4:5308 with SMTP id s35-20020a056a0017a300b00636f5f45308mr55631513pfg.7.1684305984832;
        Tue, 16 May 2023 23:46:24 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id c19-20020aa781d3000000b0064ca1fa8442sm5155622pfn.178.2023.05.16.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:46:24 -0700 (PDT)
Date:   Wed, 17 May 2023 12:15:38 +0530
Message-Id: <878rdn5uct.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/5] ext4: Call fsverity_verify_folio()
In-Reply-To: <20230516192713.1070469-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> Now that fsverity supports working on entire folios, call
> fsverity_verify_folio() instead of fsverity_verify_page()

Thanks for catching it.

>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/readpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I agree that we could use fsverity_verify_folio() instead of
fsverity_verify_page() here.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 6f46823fba61..3e7d160f543f 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -334,7 +334,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
>  				if (ext4_need_verity(inode, folio->index) &&
> -				    !fsverity_verify_page(&folio->page))
> +				    !fsverity_verify_folio(folio))
>  					goto set_error_page;
>  				folio_mark_uptodate(folio);
>  				folio_unlock(folio);
> --
> 2.39.2
