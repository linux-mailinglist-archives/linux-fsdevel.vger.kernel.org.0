Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1158D73778E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 00:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjFTWnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFTWnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:43:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24010F4;
        Tue, 20 Jun 2023 15:43:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so2576040a12.0;
        Tue, 20 Jun 2023 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687300995; x=1689892995;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaYNclQnysW8nQnar7C7SNLx+8CEj4DfdAfuicOOpRI=;
        b=pU1baukBRjTQQYBYuAPLDBi9RVpOsHukczl2Ko8po1D4gQBMI0/cOfoaiNwcnEpfWh
         bDbuAjk0QZ2Vk76QXFAoH5Tk3W4uLsT9ofwXrbUXeUyStOdqNLgEXtQ5GV/UNz4dxwjk
         YJjsnZa+UdaznDag0Q8AmQDqOlv+fzYe3M47LPBmBUaNiItAyJLrbbJ47gGJxFMjzMNJ
         wCzeKf+/KIlPTVos5YnwVnjNAjwdR60eeKUjL5dOr59EJ80yvJF/yECtOlFCJyahyyuc
         DDHLe8WOkzJshBC6Ci8bo9LR0vrRAfdTDJNEGxuehRtDew27gSVsIyD5Svu+Gy2Cgk9z
         5Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300995; x=1689892995;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaYNclQnysW8nQnar7C7SNLx+8CEj4DfdAfuicOOpRI=;
        b=cANFj38cHFW2kK2nNvI2cgJf+OPmbKeI46Uv94dpkan8BNFzHL7UO7rEKt8BC/5tQf
         QWZ1rUefm/zsQ7KUPdyBGYtPWR0jVrAyEzsdc12B60Xw/JLppL0fw03X4pa21Y0xS9+S
         UrCCTTUv98u7eTGRhY9cPgzrHNNyzcSLB2Zic/8G+MJl79Z7jFQYV97qTxJYwFoW6sgZ
         nWCFSRxooackI0d0Y2iES+F7sZt7TFBOeoTdmFSvSp3JxszY4dFQm2NQgl5qAeClq85a
         XQC+hcL3CoV7479S4WN2cC1mMutR6tx1yCPkpXuVXvO9bYRPMrIFm/zv37in/HNAsmhN
         18tg==
X-Gm-Message-State: AC+VfDx2JPpiyScKpu42+FNCwukTmUrKR3GrkXjDd2LMexDbwjmwSmeu
        dYEB6d2udEDcbIIKR6XMerk=
X-Google-Smtp-Source: ACHHUZ6PT3wFSpXI54qDT4ka+RjCbfE7gmAYYq8N9vr80n2sSwbgap4WDNDBvflyXbo3TigjY3kbiQ==
X-Received: by 2002:a17:90a:d90b:b0:256:dbfb:9b5e with SMTP id c11-20020a17090ad90b00b00256dbfb9b5emr8004910pjv.29.1687300994854;
        Tue, 20 Jun 2023 15:43:14 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id il8-20020a17090b164800b0025b83c6227asm1956348pjb.3.2023.06.20.15.43.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2023 15:43:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <bf22d1d1-ed6b-422d-9ea8-f778be841d8d@app.fastmail.com>
Date:   Tue, 20 Jun 2023 15:43:02 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-mm <linux-mm@kvack.org>, Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6B85BE5-10E8-4532-B599-1ACB83097A62@gmail.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
 <20230619191740.2qmlza3inwycljih@moria.home.lan>
 <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
 <20230620180839.oodfav5cz234pph7@moria.home.lan>
 <dcf8648b-c367-47a5-a2b6-94fb07a68904@app.fastmail.com>
 <37d2378e-72de-e474-5e25-656b691384ba@intel.com>
 <ff2006db-cd13-48c4-bc5b-1864f9ec9149@app.fastmail.com>
 <bf22d1d1-ed6b-422d-9ea8-f778be841d8d@app.fastmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Jun 20, 2023, at 3:32 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
>> // out needs to be zeroed first
>> void unpack(struct uncompressed *out, const u64 *in, const struct=20
>> bitblock *blocks, int nblocks)
>> {
>>    u64 *out_as_words =3D (u64*)out;
>>    for (int i =3D 0; i < nblocks; i++) {
>>        const struct bitblock *b;
>>        out_as_words[b->target] |=3D (in[b->source] & b->mask) <<=20
>> b->shift;
>>    }
>> }
>>=20
>> void apply_offsets(struct uncompressed *out, const struct =
uncompressed *offsets)
>> {
>>    out->a +=3D offsets->a;
>>    out->b +=3D offsets->b;
>>    out->c +=3D offsets->c;
>>    out->d +=3D offsets->d;
>>    out->e +=3D offsets->e;
>>    out->f +=3D offsets->f;
>> }
>>=20
>> Which generates nice code: https://godbolt.org/z/3fEq37hf5
>=20
> Thinking about this a bit more, I think the only real performance =
issue with my code is that it does 12 read-xor-write operations in =
memory, which all depend on each other in horrible ways.

If you compare the generated code, just notice that you forgot to =
initialize b in unpack() in this version.

I presume you wanted it to say "b =3D &blocks[i]=E2=80=9D.

