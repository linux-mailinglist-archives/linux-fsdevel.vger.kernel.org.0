Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612415FF2F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJNRZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiJNRZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:25:17 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F85A284F;
        Fri, 14 Oct 2022 10:25:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i9so3669901qvu.1;
        Fri, 14 Oct 2022 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5mETzZW4qi8h2MOU+Aq/FDewrEbvdbUnDP9+oZX3LE=;
        b=M+MFRjOZBw7pP9qNfSxH6RYLByFi4618Vx1xmCU6DBOxbp0CGuwThPJ/QHDXvQieNx
         py3vjfkAFEc8lgp57SpggVmQxwmAXn/EtBAeF2DkPCxBwoRmO35mDh2jCWip8DZAlada
         cIDCTt7cg93QAIu2NZeVUChSmqbHzja9DhjI3J4k9AoSmp2y+MEWYSjn3avRd+FhFeC1
         zIM/zQywKourHIbAVcKSEHZuDruO98eXf03xtpjnwh95QhhjXtCv8IsElHBHn7D6KSkw
         /c60IiP8/5bmcNqeL/08WEa8xWxh8cum/mvL6j8/4GBr1nzn6oyY58Etap2fV5sm+ReX
         neDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5mETzZW4qi8h2MOU+Aq/FDewrEbvdbUnDP9+oZX3LE=;
        b=6g7gCK+7GBZkLvy9SAf76aZMtVO4OTBOcFEukBtm98EWNKLft+HOeLixxCcYaf/YoX
         0YsTheZM+BnpcK/amIvyBPWXZ5p3DwIWVAglp+6LGg3y8Lpl/7yAUjxPMy75QBJXnpq7
         n/JaF+EqHshqREOohICQmWg5o7Q4cCNtwgXwFE9AE1Le2iB/pw3eACQhId7M6Zpoz1yR
         hbxANAD9aWvekydw+HFBIR83dg5pc4UeU2RiU89T5UIHyGxgPB/QPcd1G4vwDZimWjqy
         7R36YT8QPqEWzQ4c9mNWjO40smPWYe0i9biq/Tiole7pwqMfJRii6DSz3K1S+3B6qfNm
         6hJw==
X-Gm-Message-State: ACrzQf07aj8T8rkmLM9Hvl/ktc4XmFBQadXe8xlFaSJM6twt+1vAvxAb
        bsFVCmuYR2PXz78fhgiLnG4=
X-Google-Smtp-Source: AMsMyM6vzOmjscSaz+0L/oK2o1egx03i7La+iIFeSPzVcerbkw24bbYrplGqrTn0ZWVxPBl1DiUXgg==
X-Received: by 2002:a05:6214:224b:b0:4af:b412:2269 with SMTP id c11-20020a056214224b00b004afb4122269mr5051092qvc.54.1665768309175;
        Fri, 14 Oct 2022 10:25:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i9-20020a05620a404900b006bc192d277csm3032331qko.10.2022.10.14.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:25:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1A05127C0054;
        Fri, 14 Oct 2022 13:25:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 14 Oct 2022 13:25:07 -0400
X-ME-Sender: <xms:cZtJY6NbMUovjM3p7x_Bia7ochkxR7z3F0iFbzK1oQTOlcTarRgNUw>
    <xme:cZtJY4-SkgtC3i3jozNDZ70AA-s6CAnZ0li2p4YIPXyS8_n4KCDMoMx_h9EYmiKUz
    IYWYwlhpzqyVxM6Gw>
X-ME-Received: <xmr:cZtJYxQ5SbI_JyLMkdi-8MOOty45xlx-XEvrz4c6300zXpshbsSH8JR_icM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:cZtJY6uxyO2N3MM019RcwoFiN7kGclBCv6ZBsQrmGdpHsluYHOTixw>
    <xmx:cZtJYycM-91rGo4cuDNkFF0lT4Q2szO-QrUFJK-8MmwkYhZktxuzQA>
    <xmx:cZtJY-3SqZeaFppzAhZdlGX9tSD9pWP9FURoWZulryWd-nM1nR8gVQ>
    <xmx:cptJYzs1xnaT3qN1tlkewsEN9sa43RdcbG3Ws43FHOqLVm-cuwMsxw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Oct 2022 13:25:05 -0400 (EDT)
Date:   Fri, 14 Oct 2022 10:25:04 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
Message-ID: <Y0mbcEuR7GhJncSE@Boquns-Mac-mini.local>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
 <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <Y0Ujm6a6bV3+FWM3@hirez.programming.kicks-ass.net>
 <CANiq72nggG_z28Pne7wD=CQfKX3bTUah9vMhvJoWB8Y=uA4j+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nggG_z28Pne7wD=CQfKX3bTUah9vMhvJoWB8Y=uA4j+w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 07:23:18PM +0200, Miguel Ojeda wrote:
> On Tue, Oct 11, 2022 at 10:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Right; so where does that leave us? Are we going to force disable rust
> > when kCFI is selected ?
> 
> Constraining it via `depends on !...` or similar as needed for the
> moment is fine, we have a few others too.
> 

Right, and Peter, we actually need your help to figure out which configs
are related ;-)

Regards,
Boqun

> Cheers,
> Miguel
