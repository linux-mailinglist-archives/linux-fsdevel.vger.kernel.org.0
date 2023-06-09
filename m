Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A772A28B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjFIStV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFIStU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:49:20 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2635B3;
        Fri,  9 Jun 2023 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686336558;
        bh=Xp6bMGMnNCcrLEkL1VEMdonV4sFL+HWmR5ndn8Gwgf0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=DqOt/DYHY2CIKZeGTpKSXYjgyaJtL3GcWX9LMZqcrgzZDpYhmrq/Qg1cHdanDG/hW
         N3hFL/rIO/7/dOHVxY7ob8CNqlWu4CZHb1DEtw/7BAkODoTkkLvFHynT892Eiv5Chj
         MVp8BWh7DIZVU7CYSPRHcM8SWJs1TttaMt5aqrY0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3FD201286FB8;
        Fri,  9 Jun 2023 14:49:18 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Teq1qmSxX_CX; Fri,  9 Jun 2023 14:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686336557;
        bh=Xp6bMGMnNCcrLEkL1VEMdonV4sFL+HWmR5ndn8Gwgf0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YphKuLPteXLAwJ3pIvOWK5e+ruAVvE0Eq/w12VUQOFm8ilVBhOjgukE+9xFGsVLFB
         SNL1+i4Wdeb2cuZEhKCAWhdBKfBbNhPFs8xTPvQ8Yb+O3U982QyCZnKCuLD3PmMcXs
         xt+3Qaejkc45D+DBJY0rtNr8I8UmhRWu7oW3nSdQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0F93E1285FC0;
        Fri,  9 Jun 2023 14:49:16 -0400 (EDT)
Message-ID: <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Date:   Fri, 09 Jun 2023 14:49:12 -0400
In-Reply-To: <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
         <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
         <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
         <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
         <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
         <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com>
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

On Fri, 2023-06-09 at 19:41 +0200, Miguel Ojeda wrote:
> On Fri, Jun 9, 2023 at 7:25 PM Ariel Miculas (amiculas)
> <amiculas@cisco.com> wrote:
> > 
> > I could switch to my personal gmail, but last time Miguel Ojeda
> > asked me to use my cisco email when I send commits signed off by
> > amiculas@cisco.com. If this is not a hard requirement, then I could
> > switch.
> 
> For patches, yeah, that is ideal, so that it matches the Git author /
> `From:`.
> 
> But for the other emails, you could use your personal address, if
> that makes things easier.

It's still not a requirement, though.  You can send from your gmail
account and still have

From: Ariel Miculas <amiculas@cisco.com>

As the first line (separated from the commit message by a blank line),
which git am (or b4) will pick up as the author email.  This behaviour
is specifically for people who want the author to be their corporate
email address, but have failed to persuade corporate IT to make it
possible.

Regards,

James

