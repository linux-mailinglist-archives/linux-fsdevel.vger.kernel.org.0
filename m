Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38656737784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFTWdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFTWdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B25DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 15:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808D661325
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 22:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB3DC433C0;
        Tue, 20 Jun 2023 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687300386;
        bh=mEiuO2xX0IcJgMZ94z/fc+Jrradl7/CxlLfkUtw2y1E=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=tvndQS3uhZqBswgoY1XA7Qfh5Sey24q8t6TjRf2B5zwlNh+rwH3tIJfgFx0qGJWkX
         3WjG9HFulvVfaE2N/xUJ2p4y+NFA2ltwGoGYddI95dcUwk9N1dLLCtqDkowd3fUhm5
         UKhyaR74TbmgOos8ltUljKwjvql6N3AdKPW/Y9/5SligmSXG1OCcEwoEFmwIp/06gk
         kNpgp9EgIKc7IIklkDHSQ2lXnzaDQzTw28eBqk2r8tn4dF64hzce/IAkqAAtws7ZGl
         GiQu5qQqBfc5jf5LWXa7cUkgLs2e8L+WUalFd8IVk9MvrNpS8s61RzcO6p7gdbOILT
         RiQliq4abJ3Rw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 564CF27C005B;
        Tue, 20 Jun 2023 18:33:05 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 18:33:05 -0400
X-ME-Sender: <xms:ICmSZPR2AiA-SDkdnK2QWRsE3MLcR9cVYbuD7hQ9wXgfpTmH4KiMtw>
    <xme:ICmSZAz60WC4Wt0Qabp12w_ukwWGHT8n5bwNX7HY8Qphv2v_qTT5dPy-jgFQ_joAb
    7in41cAu6KUmg3Vs4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdevledvueektdeuhfegvedvleeugfetgefggffggeethefhkedt
    ffekieffteejnecuffhomhgrihhnpehgohgusgholhhtrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:ICmSZE2XfsK3AIbZzP47XHEbw5KJfQ9lyuPrIoGW2dMpLXFykffvyA>
    <xmx:ICmSZPAFtRHnfa176WZklEX_UqN1nCzkD2R5mJQxCCxLZjfurNqNSQ>
    <xmx:ICmSZIjr7AIvS4BK2HySgP3zUTA8u6LZlVYKiJ8xQ5T1nh7Jcq8Lzg>
    <xmx:ISmSZNZvBeJg6g_7R-VqIjUB2juLkheFsHZvWxvGfdwdFIZPLyzG7A>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AAE1A31A0063; Tue, 20 Jun 2023 18:33:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <bf22d1d1-ed6b-422d-9ea8-f778be841d8d@app.fastmail.com>
In-Reply-To: <ff2006db-cd13-48c4-bc5b-1864f9ec9149@app.fastmail.com>
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
Date:   Tue, 20 Jun 2023 15:32:44 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Kent Overstreet" <kent.overstreet@linux.dev>
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>, linux-mm@kvack.org,
        "Kees Cook" <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, Jun 20, 2023, at 1:42 PM, Andy Lutomirski wrote:
> Hi all-
>
> On Tue, Jun 20, 2023, at 11:48 AM, Dave Hansen wrote:
>>>> No, I'm saying your concerns are baseless and too vague to
>>>> address.
>>> If you don't address them, the NAK will stand forever, or at least
>>> until a different group of people take over x86 maintainership.
>>> That's fine with me.
>>
>> I've got a specific concern: I don't see vmalloc_exec() used in this
>> series anywhere.  I also don't see any of the actual assembly that's
>> being generated, or the glue code that's calling into the generated
>> assembly.
>>
>> I grepped around a bit in your git trees, but I also couldn't find it in
>> there.  Any chance you could help a guy out and point us to some of the
>> specifics of this new, tiny JIT?
>>
>
> So I had a nice discussion with Kent on IRC, and, for the benefit of 
> everyone else reading along, I *think* the JITted code can be replaced 
> by a table-driven approach like this:
>
> typedef unsigned int u32;
> typedef unsigned long u64;
>
> struct uncompressed
> {
>     u32 a;
>     u32 b;
>     u64 c;
>     u64 d;
>     u64 e;
>     u64 f;
> };
>
> struct bitblock
> {
>     u64 source;
>     u64 target;
>     u64 mask;
>     int shift;
> };
>
> // out needs to be zeroed first
> void unpack(struct uncompressed *out, const u64 *in, const struct 
> bitblock *blocks, int nblocks)
> {
>     u64 *out_as_words = (u64*)out;
>     for (int i = 0; i < nblocks; i++) {
>         const struct bitblock *b;
>         out_as_words[b->target] |= (in[b->source] & b->mask) << 
> b->shift;
>     }
> }
>
> void apply_offsets(struct uncompressed *out, const struct uncompressed *offsets)
> {
>     out->a += offsets->a;
>     out->b += offsets->b;
>     out->c += offsets->c;
>     out->d += offsets->d;
>     out->e += offsets->e;
>     out->f += offsets->f;
> }
>
> Which generates nice code: https://godbolt.org/z/3fEq37hf5

Thinking about this a bit more, I think the only real performance issue with my code is that it does 12 read-xor-write operations in memory, which all depend on each other in horrible ways.

If it's reversed so the stores are all in order, then this issue would go away.

typedef unsigned int u32;
typedef unsigned long u64;

struct uncompressed
{
    u32 a;
    u32 b;
    u64 c;
    u64 d;
    u64 e;
    u64 f;
};

struct field_piece {
    int source;
    int shift;
    u64 mask;
};

struct field_pieces {
    struct field_piece pieces[2];
    u64 offset;
};

u64 unpack_one(const u64 *in, const struct field_pieces *pieces)
{
    const struct field_piece *p = pieces->pieces;
    return (((in[p[0].source] & p[0].mask) << p[0].shift) |
        ((in[p[1].source] & p[1].mask) << p[1].shift)) +
        pieces->offset;
}

struct encoding {
    struct field_pieces a, b, c, d, e, f;
};

void unpack(struct uncompressed *out, const u64 *in, const struct encoding *encoding)
{
    out->a = unpack_one(in, &encoding->a);
    out->b = unpack_one(in, &encoding->b);
    out->c = unpack_one(in, &encoding->c);
    out->d = unpack_one(in, &encoding->d);
    out->e = unpack_one(in, &encoding->e);
    out->f = unpack_one(in, &encoding->f);
}

https://godbolt.org/z/srsfcGK4j

Could be faster.  Probably worth testing.
