Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87E7378B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 03:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjFUB1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 21:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjFUB13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD110F9;
        Tue, 20 Jun 2023 18:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1803361236;
        Wed, 21 Jun 2023 01:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2637EC433CA;
        Wed, 21 Jun 2023 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687310846;
        bh=1otvnE5+wHePKnvvLsl/wIH5ilQt0tl8E7t6o0z9JvU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=idkFXeEyGpeDCjbeK9q/lEYwkPL0bPEmfzHxWY8qunk+b6R7WmjsARsmDIwy2fYJE
         DYsTtIwM3ddhdbgNOFUQH7Ojtrrb/WQ2200GSJUvZauRsV29B85/EOTofs7oXFvNtW
         iFUFo9RShIk9mZhb2ergNJqVuaISFV4KGBkdSMbbp2ysd9xKW6IQ0YaodC3aUqfimJ
         NNylsxJhJKADtiHV3PlH8oIfL7f5QUVRBl6lfcTi+mpmiFB/mtGjG/dOrEUIYz+/Fp
         t7BfECvUu1d4Nlku3sT3DKy7x3Yiqyf6nEEcyKL5loJWGistZj5lYmWKsA6Qa1srY2
         fTElDlnCHkdmw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 035FC27C0054;
        Tue, 20 Jun 2023 21:27:24 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 21:27:25 -0400
X-ME-Sender: <xms:_FGSZPDkrGj6KJ54W-LQ3OcSabGeozUznZ4bL8PsjJHKrGxbvtoQ1g>
    <xme:_FGSZFg2g1x-YWVhNI9DSGoAGNjDwN2-7yUGI6qtFhwDMT7cm29bSLu1hI0-Dr1Z5
    sKng8aRDt04u_Ri4FI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeelleehueeuudegjefglefftddtieetudduuefgveejhedtgfel
    leeggfegjeejjeenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqd
    hluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:_FGSZKmLMaeis2ZeB6Le_ohOQQxQ9ywaHp-_thH-P31Gb24Lug5JbA>
    <xmx:_FGSZBy5QUbkUNrShhejJHyRy75hU8KvDS_HhzSL-KIhXK5W6w-2Zw>
    <xmx:_FGSZES9XiDZH7pop7T6VgY60AwZqoK5RZMXQo7vUpnPPEIwBU4hXA>
    <xmx:_FGSZIZ67W4YpR0YHK55gXBHRNU1de6feBykXbCGN6s-weJtrcX6jA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A20531A0063; Tue, 20 Jun 2023 21:27:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <1be708d5-638c-40ff-bd52-b6b88c93d132@app.fastmail.com>
In-Reply-To: <E6B85BE5-10E8-4532-B599-1ACB83097A62@gmail.com>
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
 <E6B85BE5-10E8-4532-B599-1ACB83097A62@gmail.com>
Date:   Tue, 20 Jun 2023 18:27:04 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nadav Amit" <nadav.amit@gmail.com>
Cc:     "Dave Hansen" <dave.hansen@intel.com>,
        "Kent Overstreet" <kent.overstreet@linux.dev>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "Kees Cook" <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, Jun 20, 2023, at 3:43 PM, Nadav Amit wrote:
>> On Jun 20, 2023, at 3:32 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>> // out needs to be zeroed first
>>> void unpack(struct uncompressed *out, const u64 *in, const struct=20
>>> bitblock *blocks, int nblocks)
>>> {
>>>    u64 *out_as_words =3D (u64*)out;
>>>    for (int i =3D 0; i < nblocks; i++) {
>>>        const struct bitblock *b;
>>>        out_as_words[b->target] |=3D (in[b->source] & b->mask) <<=20
>>> b->shift;
>>>    }
>>> }
>>>=20
>>> void apply_offsets(struct uncompressed *out, const struct uncompress=
ed *offsets)
>>> {
>>>    out->a +=3D offsets->a;
>>>    out->b +=3D offsets->b;
>>>    out->c +=3D offsets->c;
>>>    out->d +=3D offsets->d;
>>>    out->e +=3D offsets->e;
>>>    out->f +=3D offsets->f;
>>> }
>>>=20
>>> Which generates nice code: https://godbolt.org/z/3fEq37hf5
>>=20
>> Thinking about this a bit more, I think the only real performance iss=
ue with my code is that it does 12 read-xor-write operations in memory, =
which all depend on each other in horrible ways.
>
> If you compare the generated code, just notice that you forgot to=20
> initialize b in unpack() in this version.
>
> I presume you wanted it to say "b =3D &blocks[i]=E2=80=9D.

Indeed.  I also didn't notice that -Wall wasn't set.  Oops.
