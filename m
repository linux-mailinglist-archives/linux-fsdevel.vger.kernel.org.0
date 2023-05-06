Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1865C6F9306
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEFQJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFQJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 12:09:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD5E7E
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 09:09:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-958bb7731a9so536947766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683389374; x=1685981374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkdopV9tsVDAWs0Itz7yur4AzL7aL2hgWVLDq4YdXU4=;
        b=YcszGVdZpJfoMhsEvoab0NNZPQVZCUuN7O16UaXGsv2zRimj0AIrARfGV03+Q3Rj0/
         xZWBqfLLQ5apa603c0iXOg0okZqV5yc6c5/mhWXVNjEVyaW4VPQ1S6NIx2bnIjL1SaIT
         A1Lwd5GlfuDa+lZ7ZlRPDP69Ens6gKXaxHF44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683389374; x=1685981374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkdopV9tsVDAWs0Itz7yur4AzL7aL2hgWVLDq4YdXU4=;
        b=gYRgvKEalP/otoeIGypOiOvJAj6Kay+wvUwYfPwdmtSRId94LeoV6nANFFMqqqktrg
         VNgHwKxcuZpJcPYpJZIRclUSGeS10uk1fjeYAuMl9j9P3X6gdCetOueoxfONTBctB/ab
         yWWRaTRw0Q5XnHRIC1gSsBMi2dTpccCJ4jMQzJdeGoCdEAmEsVEqpO7reuNXNpdaWggn
         qVA/jabNxygkc2P6snJxZnSUbBLAtyup4Hy4DKmnBoIbPcHLHhQX8g0t5hjJ5XKuEKZs
         CaF/Z4MlC8372Bxhg8QvQXWiAr0yiAxHgT6+91u99RqrT2EyvywccU2hoqI/W1eKC6Gd
         w/PQ==
X-Gm-Message-State: AC+VfDxmXIYPLTGo0xrhVZP1uqv5l4UWOLFApcQ49LuSjxIVgKG/sDHh
        lksql5uKMXWvH/Q1FNCdi4jdrSF8IECayN3YPRjFUQ==
X-Google-Smtp-Source: ACHHUZ41lw2feNa0U10iys8OUK0qXiRj/QRHG7BPMn64ZCHy0CJiT3mt1CmJQsPjK2Zc2I+UeZIVww==
X-Received: by 2002:a17:907:3686:b0:94f:6d10:ad9f with SMTP id bi6-20020a170907368600b0094f6d10ad9fmr4174078ejc.42.1683389373890;
        Sat, 06 May 2023 09:09:33 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b00962334bee1bsm2432913ejc.203.2023.05.06.09.09.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 09:09:33 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso5663429a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 09:09:32 -0700 (PDT)
X-Received: by 2002:a17:907:6d22:b0:953:57a1:55e1 with SMTP id
 sa34-20020a1709076d2200b0095357a155e1mr4874760ejc.62.1683389372677; Sat, 06
 May 2023 09:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org>
In-Reply-To: <20230506160415.2992089-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 09:09:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
Message-ID: <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 6, 2023 at 9:04=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Smatch reports that filemap_fault() was missed in the conversion of
> __filemap_get_folio() error returns from NULL to ERR_PTR.

Thanks, applied directly.

            Linus
