Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD46AAEAE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 10:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCEJGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCEJGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 04:06:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C30AF950;
        Sun,  5 Mar 2023 01:06:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x7so1973964pff.7;
        Sun, 05 Mar 2023 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0qn27wortR5n80eOokZIxYrmOzWXCZ95FBjfPH9GkUo=;
        b=e2h6N1+RP4sy6q6km6NUr3+eYJNgp2fpDd79GWPh3Pi0cMPVGAQF9lRsbWHyub1ifW
         G+wKWz45sImTw8VlA+Nu+go1+oml/dbYQkxlHd95jfWk7x4cVvrMnxKF8wVsxYxww/Hx
         TDQe70XjPgXIlzhLPNJvJgZG3ppooX77PYPTPpC1myxuSbfE30ow0Tgh4ndaE/UeYyfm
         95VYPG+eDxCG3Tu2aZqdda7fSSi7cQxnkR6rIQPU8CXzz4zS+uCyUeRJjw5Jz6YNmAq6
         ZTB7IhK+km4LhTwJe3kBNpTxYxYUlFohqmMM2PLkAF0VgjfwqHcfEQ/4bJJP7gA/wf0N
         HzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qn27wortR5n80eOokZIxYrmOzWXCZ95FBjfPH9GkUo=;
        b=Hc3HYgBiQG/5dbGttDqZbLpEwTZxWFD4OkZCav6On6JRm3CKOezmEjKoZI1eBFtHLr
         /iho2KFzVYhPSh9pBKCnmNpy9i8Z+U/2j1Ib8ZLUQoc1IDOZ4555SYQdTkjqfMhTa9mY
         5Ktz3kW5rTFgODCWHeXLHeXcrNj5jZFWg41iwSJcYiZem+XWZXIHfSyi7SNAJ+XgPuTA
         VLmQXvQ5OuG3YxovZhlavKUT33HK19y2IC31r4vPkUaIsDEJ1OdWHeLr/uIfSvJNFEwA
         UFbTSR+lcWxWzXN9tMKboOvHAMWLNW9goWcsw7LRKGxQp6gMpVodw1a2mxuI7GvNh+Eg
         PHqw==
X-Gm-Message-State: AO0yUKU7axNwxZxnppisR56mSVirZtUlehkBTkwY+jIKkgo2tdZo9xF9
        WQH4/hF7BfwdkGQ6EOyILVUl4MGMM4rZPA==
X-Google-Smtp-Source: AK7set/JtUEIbHi9ex1SBRpf56/KIeSgpn3Hsr66OTnZP6Al08U7W9XRc0EDd0q7QHsIOvkoyHhzEQ==
X-Received: by 2002:aa7:956b:0:b0:619:d5c2:e97 with SMTP id x11-20020aa7956b000000b00619d5c20e97mr3038099pfq.2.1678007195058;
        Sun, 05 Mar 2023 01:06:35 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b005a851e6d2b5sm4255818pfa.161.2023.03.05.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 01:06:34 -0800 (PST)
Date:   Sun, 05 Mar 2023 14:36:28 +0530
Message-Id: <87jzzvmusr.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
In-Reply-To: <20230126202415.1682629-3-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
> and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/fscrypt.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Straight forward conversion. IIUC, even after this patchset we haven't
killed fscrypt_is_bounce_page() and fscrypt_pagecache_folio(), because
there are other users of this in f2fs and fscrypt.

Looks good to me. Please feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


-ritesh

>
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 4f5f8a651213..c2c07d36fb3a 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -273,6 +273,16 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
>  	return (struct page *)page_private(bounce_page);
>  }
>
> +static inline bool fscrypt_is_bounce_folio(struct folio *folio)
> +{
> +	return folio->mapping == NULL;
> +}
> +
> +static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
> +{
> +	return bounce_folio->private;
> +}
> +
>  void fscrypt_free_bounce_page(struct page *bounce_page);
>
>  /* policy.c */
> @@ -448,6 +458,17 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
>  	return ERR_PTR(-EINVAL);
>  }
>
> +static inline bool fscrypt_is_bounce_folio(struct folio *folio)
> +{
> +	return false;
> +}
> +
> +static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
> +{
> +	WARN_ON_ONCE(1);
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static inline void fscrypt_free_bounce_page(struct page *bounce_page)
>  {
>  }
> --
> 2.35.1
