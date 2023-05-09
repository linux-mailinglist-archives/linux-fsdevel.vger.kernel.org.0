Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A326FD095
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjEIVMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEIVMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:12:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A6D198A;
        Tue,  9 May 2023 14:12:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64384274895so4589372b3a.2;
        Tue, 09 May 2023 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683666763; x=1686258763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svGV0USSt7ecLCHRTXbLuwPhCwC3JPPXKAzLDLNlRjA=;
        b=UT/piCyqIzYoo+P2gSw+QQSyXT0S06eCT2Xlnjp6RY/huIoizI4Z37OkANO8EOPf0J
         1FKeGRsDcihqTx55Tz1ahXEmVVP6dzwEjVwlk6WuSFffQ0TACXkSe+9wP8UAjcmARF1b
         rDAy/rKtPPCRaLJfJte0zBsCo8pGHosvS/Eijb+xnJLKumBuC5cKSGZu6Mz3hw1Wbk9q
         boLY7gSp3JIuzVYrSGaNiq/uag3s0MLcOIg6J5fO0xdr1qILObJbsId9/hnJcj0mqFHt
         d0SmEg0kkhd/bKibWC3sGGVnEGXfOh31xRyfsI72weVAST/OE5Oko9LHzeSjwMwH3uJN
         54bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683666763; x=1686258763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svGV0USSt7ecLCHRTXbLuwPhCwC3JPPXKAzLDLNlRjA=;
        b=TQWWAfI7Xa5pqRxvTU+genEmeA1Qg239t28coexQDoc5oZwoqxI98y1Ekmd1b13VwW
         GFWpxBTMJRua54X+2HSK/1WzJZRtC6iBTeM29AtewYvDGXfO70tXJRX+3RUDn/v8uAHs
         RkmUsjeUPgPBs5A2e2MMapdF2I/e/lpqa1T5uE57RkUF0lnAqWgXs85nm0saurPFd4Xs
         UoInWL3DRLQy3ALXheVKRNwhS+1gP1xXAVqbPSq6RCNzV6l/SfvOWghae8/308OBTxJb
         zJdalTzGVbSpvALzxYykr/CKc0tj280YUpez1nUTd3yhqIKD8u1Zoi4guGEqkTtMjzWm
         2C9Q==
X-Gm-Message-State: AC+VfDy5FuBYWp5X8u7/UZpmW6bk9M0JykaMzRyPBJCeNihdPf6NxvA6
        NbCKns/wdBqRSo1srY2grQ/QA0BlWoZM2A==
X-Google-Smtp-Source: ACHHUZ5eWk0NpGNLDCVvDwN9Ku5AnbknilcOnjk0aKEKmCzXWCGhqSQlpGyrMrVu7tHz/auQMy6Vfw==
X-Received: by 2002:a17:902:ce8d:b0:1aa:fc8c:8f1f with SMTP id f13-20020a170902ce8d00b001aafc8c8f1fmr19261002plg.50.1683666763082;
        Tue, 09 May 2023 14:12:43 -0700 (PDT)
Received: from localhost ([2001:4958:15a0:30:3c22:a6a6:f3a4:12ce])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001a800e03cf9sm2050041plk.256.2023.05.09.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:12:42 -0700 (PDT)
Date:   Tue, 9 May 2023 14:12:41 -0700
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFq3SdSBJ_LWsOgd@murray>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFqxEWqD19eHe353@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 01:46:09PM -0700, Christoph Hellwig wrote:
> On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> >
> > This is needed for bcachefs, which dynamically generates per-btree node
> > unpack functions.
>
> No, we will never add back a way for random code allocating executable
> memory in kernel space.

Yeah I think I glossed over this aspect a bit as it looks ostensibly like simply
reinstating a helper function because the code is now used in more than one
place (at lsf/mm so a little distracted :)

But it being exported is a problem. Perhaps there's another way of acheving the
same aim without having to do so?
