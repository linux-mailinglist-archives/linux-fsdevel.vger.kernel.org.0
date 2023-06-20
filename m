Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D891273763C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjFTUnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFTUnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063AAD1;
        Tue, 20 Jun 2023 13:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 791BA611C1;
        Tue, 20 Jun 2023 20:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1B6C433C8;
        Tue, 20 Jun 2023 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687293786;
        bh=+GKm7AfWZk7imJmF+l1VZpt2mG2VQKVZcNY+CGDuwQk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=VQe9AdAxuEPFM73E+RYB29XXizQJv29BxaIFRpr30ZiNRuwtlBWEeo3b3Quc09Qrv
         Lbk7FiN13cGWjbkYU7T+Vvrt2TbYo4n3JUAag+v8I62wbWHqlkfvJZ2ndvcao/LKJN
         IXblNGlYRYX0ZmNb/w4CBlIfaSk3PFk8RmV/792ddJcbzJgiT9yIQ4lXi/CL5Kpjtl
         oEEnY0P/fLRM+QcCudm0anW5iHuDv90kA5u8T4/obTdTaFqUiUAEpQ0vHNfo0qbcyQ
         lJDbdvPDVhIpImS9hjQgEDRhzqN4kHrGm9gh6dhZSc4tRxsC3jN7UTY0/SR6ZhVXPG
         WPjehgJiy1FcA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 60AC127C0054;
        Tue, 20 Jun 2023 16:43:05 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 16:43:05 -0400
X-ME-Sender: <xms:WA-SZGIhlkCOy4gJ05bXlAwIyHMyG6h6dZBbsW56dmjvo3I-Klmx4A>
    <xme:WA-SZOJeOGyLHCr316h2GtjCbhc9G0tPYuBx5MeWj8HTx0FPEEGw6QHMvy8CD25eB
    -V6IOv8y2fPydZB6KY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvveelvdeukedtuefhgeevvdeluefgteeggffggfegteehhfek
    tdffkeeiffetjeenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqd
    hluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:WA-SZGvK9ySKVoi3jwBBUEc5kH9CTW0utMrAW0_UcVNuC6fN_tqQUQ>
    <xmx:WA-SZLa95AYXehTeVVIPWBLvjDcrEGNk4ZEeDm0LtQv92yjVW4jVBA>
    <xmx:WA-SZNYO4mWVXiRPj-BtpvQXSs0KZmPDhuW2ApRxLzqKjuco_kylFA>
    <xmx:WQ-SZKQC4it0RRJaIkIEPbk0Bm7JgNMDm-ifYGmX0uMe1ZVHh-_kdQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D107931A0064; Tue, 20 Jun 2023 16:43:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <ff2006db-cd13-48c4-bc5b-1864f9ec9149@app.fastmail.com>
In-Reply-To: <37d2378e-72de-e474-5e25-656b691384ba@intel.com>
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
Date:   Tue, 20 Jun 2023 13:42:44 -0700
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all-

On Tue, Jun 20, 2023, at 11:48 AM, Dave Hansen wrote:
>>> No, I'm saying your concerns are baseless and too vague to
>>> address.
>> If you don't address them, the NAK will stand forever, or at least
>> until a different group of people take over x86 maintainership.
>> That's fine with me.
>
> I've got a specific concern: I don't see vmalloc_exec() used in this
> series anywhere.  I also don't see any of the actual assembly that's
> being generated, or the glue code that's calling into the generated
> assembly.
>
> I grepped around a bit in your git trees, but I also couldn't find it in
> there.  Any chance you could help a guy out and point us to some of the
> specifics of this new, tiny JIT?
>

So I had a nice discussion with Kent on IRC, and, for the benefit of everyone else reading along, I *think* the JITted code can be replaced by a table-driven approach like this:

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

struct bitblock
{
    u64 source;
    u64 target;
    u64 mask;
    int shift;
};

// out needs to be zeroed first
void unpack(struct uncompressed *out, const u64 *in, const struct bitblock *blocks, int nblocks)
{
    u64 *out_as_words = (u64*)out;
    for (int i = 0; i < nblocks; i++) {
        const struct bitblock *b;
        out_as_words[b->target] |= (in[b->source] & b->mask) << b->shift;
    }
}

void apply_offsets(struct uncompressed *out, const struct uncompressed *offsets)
{
    out->a += offsets->a;
    out->b += offsets->b;
    out->c += offsets->c;
    out->d += offsets->d;
    out->e += offsets->e;
    out->f += offsets->f;
}

Which generates nice code: https://godbolt.org/z/3fEq37hf5

It would need spectre protection in two places, I think, because it's almost most certainly a great gadget if the attacker can speculatively control the 'blocks' table.  This could be mitigated (I think) by hardcoding nblocks as 12 and by masking b->target.

In contrast, the JIT approach needs a retpoline on each call, which could be more expensive than my entire function :)  I haven't benchmarked them lately.
