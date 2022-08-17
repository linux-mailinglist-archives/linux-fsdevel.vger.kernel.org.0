Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15C3597714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 21:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbiHQTvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQTvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:51:13 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3A33372;
        Wed, 17 Aug 2022 12:51:13 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g16so8967116qkl.11;
        Wed, 17 Aug 2022 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc;
        bh=v60uqYnukgjgZARXe5JJGms8uUUgUv8wpc53hUaJ67A=;
        b=JpefC9piThWn37ij83JUtU+fue08Tl6ykry7XnZ14DBKoDxePAQOK80AdrWAJ279px
         kcgkEXwRKcLiaoyNzJ+EI8n/tRYjvAaM9OA7ppJ7pFSusEicOlrDJYE3QaNMH8MqGMvR
         CWn5MzWzsDJ2Dxxk7lgkhTfQgInX9V3QLa6O79NTCAJjFXUFZQ0sMrsDc7E4fMJXjUDq
         WlAoyYbgC0IwfQBba7Lm7EukhyIjpr69eObpAhLbBvLWU1D5n6EBBus9KJmVX+aUmzFc
         +cP1U8QaRpaFqJEb4LRC7qIqK8SklFDGaEWG0AtZ2Jo3D7A18NK3Go4b1h7/xMs89cKr
         o/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc;
        bh=v60uqYnukgjgZARXe5JJGms8uUUgUv8wpc53hUaJ67A=;
        b=ISpvETzHxxVIsLoeHRMBpoxAYlmNAJzmXZ5TrxrZBFGt9/ahtgbcb6nVjP9Jgfr2fn
         9ed65MmJl8eiHnWOsc1h55uz5RN4+pL4vi8OffOTUxqKM68TsmL54do4m4L5E/CtiWJV
         6ZZfQT2aIKfN2p7LbG1BFuWYoz/ooqbnyzDhiTrbqIQW69FZDxWLHqwHDa4S70cevP+M
         9VKt48UDZVYkbKTQHXFdvGIlB9MhSVm8+WHnNEosgkFlGWAFf1ZuqnJ8uvo0KzCDmHKh
         FkGRSPYY40A6Htk4R9gzPC5ZPE6uTJ61UckmmJGcu8in1JWyaZn9PrAgqdnzfdPmMjQV
         YRFQ==
X-Gm-Message-State: ACgBeo325+r1gvaKoCg7gN91V6mrtNc+77f9L17E/UEb0MvZRu2pAIaQ
        j3SPzykYwesj0qSLCUIIFCo=
X-Google-Smtp-Source: AA6agR4wb0hTyertW8x0U44XlUWC9UESZJzGxucrMzv60iW2eQI+SjAZa4eaPq87PCkVEUq6UypKmw==
X-Received: by 2002:a05:620a:1a9a:b0:69c:4a99:ea50 with SMTP id bl26-20020a05620a1a9a00b0069c4a99ea50mr20031342qkb.632.1660765871901;
        Wed, 17 Aug 2022 12:51:11 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b8-20020ae9eb08000000b006b8f4ade2c9sm13759099qkg.19.2022.08.17.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:51:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9E9A927C0054;
        Wed, 17 Aug 2022 15:51:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 17 Aug 2022 15:51:10 -0400
X-ME-Sender: <xms:rUb9YsjrhBwDWi1UcrlAJOSkZoFWbWs6Wdyq53p-l3svLt4Dz3MJOg>
    <xme:rUb9YlAwxKSMQtAbCkoqL17OQVtDsxn4hUE3TCkIIXBk51zOdJqH6vyLX7CB_i9bj
    qs7DmA59stT6eK2IA>
X-ME-Received: <xmr:rUb9YkHKEExDeF-dyv87VUyFyglJNclBfoaZqBtFoE7LzDhOVbXTkXzS7qRGgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:rUb9YtTvq4_U7rRBDZGD4vov0GhVMjm2hdDkcfaE3JuV_ojE4i1hbw>
    <xmx:rUb9YpxZYdET6Anm_xf7p8yk0S_-KxS3CQS2Ouu871PFBPYVw-csxw>
    <xmx:rUb9Yr7rqwGEm3ttZTIYuBBl_eIwK6JjFF_lJ4X-FpeKbm1GWzwghw>
    <xmx:rkb9YgnF-q5Xcc8LmyDfUczZkU66iqh3omlThgZCPB8wDNsRqegbzA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 15:51:09 -0400 (EDT)
Date:   Wed, 17 Aug 2022 12:50:50 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v9 03/27] kallsyms: add static relationship between
 `KSYM_NAME_LEN{,_BUFFER}`
Message-ID: <Yv1GmvZlpMopwZTi@boqun-archlinux>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-4-ojeda@kernel.org>
 <202208171238.80053F8C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208171238.80053F8C@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:39:48PM -0700, Kees Cook wrote:
> On Fri, Aug 05, 2022 at 05:41:48PM +0200, Miguel Ojeda wrote:
> > This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
> > gets updated when `KSYM_NAME_LEN` changes.
> > 
> > The relationship used is one that keeps the new size (512+1)
> > close to the original buffer size (500).
> > 
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  scripts/kallsyms.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index f3c5a2623f71..f543b1c4f99f 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -33,7 +33,11 @@
> >  #define KSYM_NAME_LEN		128
> >  
> >  /* A substantially bigger size than the current maximum. */
> > -#define KSYM_NAME_LEN_BUFFER	499
> > +#define KSYM_NAME_LEN_BUFFER	512
> > +_Static_assert(
> > +	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> > +	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> > +);
> 
> Why not just make this define:
> 
> #define KSYM_NAME_LEN_BUFFER (KSYM_NAME_LEN * 4)
> 
> ? If there's a good reason not it, please put it in the commit log.
> 

Because KSYM_NAME_LEN_BUFFER is used as a string by stringify() in
fscanf(), defining it as (KSYM_NAME_LEN * 4) will produce a string

	"128 * 4"

after stringify() and that doesn't work with fscanf().

Miguel, maybe we can add something below in the commit log?

`KSYM_NAME_LEN_BUFFER` cannot be defined as an expression, because it
gets stringified in the fscanf() format. Therefore a _Static_assert() is
needed.

Thoughts?

Regards,
Boqun

> -Kees
> 
> -- 
> Kees Cook
