Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B272A3FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFIUBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjFIUBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:01:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6530EC;
        Fri,  9 Jun 2023 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686340883;
        bh=mGI/A86R/RF5GlrZA0epjsAqAk3ttAuz/EDS3qzOt9k=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wrcqnTT9p0S0TO9Tp7pFwyb7LtIgmzNdw+okfaSKiq9XapHNSfkSYS2EgtqPapc96
         P8Z6X2mPeKEhgqNCdz/MNeDaa5FlZd+HKKklTTj9jQ0WMie7dIAXt3ZOC4CAaHwJtk
         AoHZfHRxIRdpVLms6J3RIAMfjpNzI2b98s4bqLnY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7915F1287024;
        Fri,  9 Jun 2023 16:01:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 0gz7BYspJIts; Fri,  9 Jun 2023 16:01:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686340883;
        bh=mGI/A86R/RF5GlrZA0epjsAqAk3ttAuz/EDS3qzOt9k=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wrcqnTT9p0S0TO9Tp7pFwyb7LtIgmzNdw+okfaSKiq9XapHNSfkSYS2EgtqPapc96
         P8Z6X2mPeKEhgqNCdz/MNeDaa5FlZd+HKKklTTj9jQ0WMie7dIAXt3ZOC4CAaHwJtk
         AoHZfHRxIRdpVLms6J3RIAMfjpNzI2b98s4bqLnY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 75D4B1286FB8;
        Fri,  9 Jun 2023 16:01:22 -0400 (EDT)
Message-ID: <85deb8241b61c07a2935996e85c410a5c1127513.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ariel Miculas <ariel.miculas@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Date:   Fri, 09 Jun 2023 16:01:19 -0400
In-Reply-To: <CAPDJoNutb3NwrzuDP=kkLi=kTwG0XZHbUG=F_Bg-zbinzzUcdw@mail.gmail.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
         <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
         <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
         <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
         <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
         <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com>
         <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com>
         <CAPDJoNutb3NwrzuDP=kkLi=kTwG0XZHbUG=F_Bg-zbinzzUcdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-06-09 at 22:11 +0300, Ariel Miculas wrote:
> Yes, but then how can you be sure that amiculas@cisco.com is the real
> author of the commit? I think that's why Miguel Ojeda asked me to
> send them from my business email, otherwise some random gmail account
> could claim that he is "Ariel Miculas", so he's entitled to sign-off
> as amiculas@cisco.com.

Because it's a public list and the real one would observe and repudiate
...

The DCO is an attestation which we basically believe absent any proof
to the contrary.  It's also exhausting and an incredible amount of
pointless admin not to believe anything until it's proved, which is why
we don't.

James

