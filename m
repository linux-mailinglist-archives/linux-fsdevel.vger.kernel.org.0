Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCD709B17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjESPSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjESPSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:18:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38619B;
        Fri, 19 May 2023 08:18:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2467d640so2040251b3a.1;
        Fri, 19 May 2023 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684509525; x=1687101525;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=woNEX4BlaBInqJPgAQu+oJGnsoQ5fC0AFJQ7tdrMYfo=;
        b=f7N2cQXXLecmeIMSLFFIHnAOa4Y1phtQMlU6+0wQve37572xDiggUBMKHoxEUiLUlt
         xZdPxEy3SvAfx5s4CgyogCs1kr/voR83VOKVQwjWWnkeVfywvf69lbvQJK9ZxtBbAkhl
         /yi8SXIAq6KoNv+4Pt+0V5myubLCiH7u1QQWlQqAql/TOfwgydppzVUH76o0gYxBao3A
         Ao737Qgmu1yR8kvAtDEX3bCTnMMju6LzbrEkk8y3ev3hWdlqoDTMMjYeCpwx8vbDla1P
         fU9YKP33qswa6wuGAhimmWnUaJRQn9cQS7LpnFGRTNBzlTP2ruJeLGi3QVQ4gHiyNL7/
         0URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509525; x=1687101525;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woNEX4BlaBInqJPgAQu+oJGnsoQ5fC0AFJQ7tdrMYfo=;
        b=QpKTM+sOQll1EQlhMgcFJ7W/SpXvM2n9fqHIiPKhleh76Qn76GZ3bo0+84PU3wA3R9
         fxBLq+ipf+NR79Sqi626cEaV9e7v9xLRa6XEKcWoNVn2U47j0oS3qq4S/19F6opWnW4i
         /H4tyu7njZPxmwcMwHgtayFX/w5VwanjmltSeW6CYUMnikaNYv9+6RuoRykUid2NiLZ7
         h6iZei4xifM/rHt5DPR5BWV3qiM80MNawLe1ohWriN+1lkuLHZXGXmXF2y0QWRJF9xlW
         QRcso2mFSFPv4I32357KZ4o0UKruTZ05s5B/HDEeBqpEWX2iu7gZQCQX0zmffFmBxTIx
         NYLg==
X-Gm-Message-State: AC+VfDzLPWIUGXZtOiR6VmWkjjnFy7W2tgo4ELSc2CcVGOExeS87B4Fw
        v79t5JjdXmzanp7b3+0RW8g=
X-Google-Smtp-Source: ACHHUZ674LSuLHP6OWl98pOdCyHkxPlpZHqFYv/unWO8pOUwzAEyD+E87KqXev7OhfgIGW9OWzxyRQ==
X-Received: by 2002:a05:6a00:134c:b0:64d:2b06:5949 with SMTP id k12-20020a056a00134c00b0064d2b065949mr3877772pfu.8.1684509524848;
        Fri, 19 May 2023 08:18:44 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7874e000000b0063f2e729127sm3218551pfo.144.2023.05.19.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:18:44 -0700 (PDT)
Date:   Fri, 19 May 2023 20:48:37 +0530
Message-Id: <875y8owdrm.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 4/5] iomap: Allocate iop in ->write_begin() early
In-Reply-To: <ZGXD8T1Kv4NafQmO@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, May 08, 2023 at 12:57:59AM +0530, Ritesh Harjani (IBM) wrote:
>> Earlier when the folio is uptodate, we only allocate iop at writeback
>
> s/Earlier/Currently/ ?
>
>> time (in iomap_writepage_map()). This is ok until now, but when we are
>> going to add support for per-block dirty state bitmap in iop, this
>> could cause some performance degradation. The reason is that if we don't
>> allocate iop during ->write_begin(), then we will never mark the
>> necessary dirty bits in ->write_end() call. And we will have to mark all
>> the bits as dirty at the writeback time, that could cause the same write
>> amplification and performance problems as it is now.
>>
>> However, for all the writes with (pos, len) which completely overlaps
>> the given folio, there is no need to allocate an iop during
>> ->write_begin(). So skip those cases.
>
> This reads a bit backwards, I'd suggest to mention early
> allocation only happens for sub-page writes before going into the
> details.
>

sub-page is a bit confusing here. Because we can have a large folio too
with blocks within that folio. So we decided to go with per-block
terminology [1].

[1]: https://lore.kernel.org/linux-xfs/ZFR%2FGuVca5nFlLYF@casper.infradead.org/

I am guessing you would like to me to re-write the above para. Is this better?

"We dont need to allocate an iop in ->write_begin() for writes where the
position and length completely overlap with the given folio.
Therefore, such cases are skipped."

> The changes themselves looks good to me.

Sure. Thanks!

-ritesh
