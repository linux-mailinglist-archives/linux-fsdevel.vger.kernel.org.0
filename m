Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC74DBCE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbiCQCT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 22:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCQCTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:19:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663C1ADBB;
        Wed, 16 Mar 2022 19:18:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gb19so3729234pjb.1;
        Wed, 16 Mar 2022 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=k5/SI47mYCkmTkd+Jtlw5qMaLp/W2C5Pn4N4ppaWA9s=;
        b=UtxNRLaSAiCeSdDwtocXLOJ+R6Zo0CD5IHp8vWaZ8PZWfwN+AzCwQ8P0MW/w6jKNo4
         LoYWI4WyYaxuYNnJdM8A8k+oc8kXDe1OP3T5I7e0nM7EaFR4JP00SohjsPuizUn8/7mY
         rQuQFSa/Ucv5UTUB3EvYb3KVd9jyKTrEH9TrRW83LeIndXehQjvaALzXs6fFLGnq4sWA
         oSTjNRRIz2eDb6BgxE628hX9mOhqQVj9uSFWh2XgIge3vIYIcNTBacZIuZoFKVYfgHb3
         jKPJ8Hbs9qpGBGZeSk2W31Zb2fvT1VOTqtSQh346NWlDQRNPaBVAp4zutlq6SWCDcf8C
         mMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=k5/SI47mYCkmTkd+Jtlw5qMaLp/W2C5Pn4N4ppaWA9s=;
        b=zbW2XuS67fEQnCWjec5yw0tSW/ynY7yc6DZrY/4Amag/wCbDbgXa5+5jI5qZqJv0D2
         se9p6Ovf7mSp5nsM9y+eix6FpKeahE+F/k2t07SGmasTLPcJRk8s7Cu7NxFLPg8gTDm8
         pGnYKjGtX6Gytdg+f9i830qVlw7nHVUifDX7PBJ4h0BHHodeShmnTInI+bAUncWpjv3O
         PyPcbx0i8pWnPwl8i8uc0/RlQPXZjBPo3sZFyujPeSNml6Jvnd6bpdEOrGZkJ0LKT1iX
         f3l6ZeBgDpikzBzZjBmP87RStpgRC32k9YGM8SjnjHXp2FmRFwpJ51927Errc5k7S/1z
         bNMA==
X-Gm-Message-State: AOAM5338FBUdiXIXUcQht5sMRg6NlmeEto3ft+aOsuxFOMls2iFIJqhi
        XQp5A5f5xpuDW/9xev7vSXcrz9X6Xbk=
X-Google-Smtp-Source: ABdhPJzkTj1plz8qCSaAmWgG/0AJT06edV5geQtEmqo54L2We0Ceuv32vzPgPLjWI9kOSRoG/gATtw==
X-Received: by 2002:a17:902:f64d:b0:151:3895:46bf with SMTP id m13-20020a170902f64d00b00151389546bfmr2342537plg.31.1647483485628;
        Wed, 16 Mar 2022 19:18:05 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mt3-20020a17090b230300b001c633aca1e1sm8011609pjb.18.2022.03.16.19.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 19:18:05 -0700 (PDT)
Message-ID: <62329a5d.1c69fb81.13868.4b52@mx.google.com>
X-Google-Original-Message-ID: <20220317021803.GB2135497@cgel.zte@gmail.com>
Date:   Thu, 17 Mar 2022 02:18:03 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjGkRT+ccoZ0ZNDq@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjGkRT+ccoZ0ZNDq@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:48:05AM -0700, Christoph Hellwig wrote:
> > @@ -1035,8 +1035,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
> >  	bio->bi_iter.bi_size += len;
> >  	bio->bi_vcnt++;
> >  
> > -	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
> > -		bio_set_flag(bio, BIO_WORKINGSET);
> > +	if (!bio_flagged(bio, BIO_WORKINGSET_FILE) &&
> > +	    unlikely(PageWorkingset(page)) && !PageSwapBacked(page))
> > +		bio_set_flag(bio, BIO_WORKINGSET_FILE);
> 
> This needs to go out of the block I/O fast path, not grow even more
> checks.

Thanks for your replying.

First, Johannes Weiner had made his state, see:
https://lore.kernel.org/all/Yio17pXawRuuVJFO@cmpxchg.org/

Second, I understand your concern, but actually there seems no better
way to do file pages workingset delay accounting, because this is no
unique function to track file pages submitting, kernel do this in
multiple sub-system.

Thirdly, this patch doesn't make it worse, indeed it reduce unnecessary
psi accounting in submit_bio.
