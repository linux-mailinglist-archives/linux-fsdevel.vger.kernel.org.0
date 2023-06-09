Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0072A283
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFISna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 14:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFISn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:43:29 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D396198C;
        Fri,  9 Jun 2023 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686336206;
        bh=rsFydjz1uMceq9Bo+MgjkB0rzPbYAE2VNuG1F6Mcs8s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=uZgzpeR1HvCTq3XmW/O7zDwdB15dW8ui3kGpo4GropWQyGJ1v3YcPsDqAUOWuuAgK
         LHSJPP7RPD/QeHaW+y0faY8it3z+t2KqtV9AF84Qmo30aYsUw9ndcvyHgs4X0sia/z
         TdATBdURF39zSbPisMezT3oAdT84gqBCwCvSGhmo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3328E1285DE0;
        Fri,  9 Jun 2023 14:43:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Cia29PZovCY1; Fri,  9 Jun 2023 14:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686336205;
        bh=rsFydjz1uMceq9Bo+MgjkB0rzPbYAE2VNuG1F6Mcs8s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pUlaklQuE+5H4wyesIzZsHyXdHSW6LBGbCdCrVTjBdQGnoSZh38XcODn7hqArSCsU
         Q0Hb6V5vjjA85DUalhwif0lcM5pOklWh/9Ztp383YglK5nSVmAMPcKjqgmMI7yGqv3
         RLBwVLtjjEevZJeN6bOW98Vb5PavUahy/5N4cKa0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DC72C1281ED0;
        Fri,  9 Jun 2023 14:43:24 -0400 (EDT)
Message-ID: <6896176b44d5e9675899403c88d82b1d1855311f.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Date:   Fri, 09 Jun 2023 14:43:22 -0400
In-Reply-To: <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
         <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
         <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
         <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
         <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
         <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-06-09 at 17:16 +0000, Ariel Miculas (amiculas) wrote:
> I could switch to my personal gmail, but last time Miguel Ojeda asked
> me to use my cisco email when I send commits signed off by
> amiculas@cisco.com.
> If this is not a hard requirement, then I could switch.

For sending patches, you can simply use git-send-email.  All you need
to point it at is the outgoing email server (which should be a config
setting in whatever tool you are using now).  We have a (reasonably) up
to date document with some recommendations:

https://www.kernel.org/doc/html/latest/process/email-clients.html

I've successfully used evolution with an exchange server for many
years, but the interface isn't to everyone's taste and Mozilla
Thunderbird is also known to connect to it.  Basic outlook has proven
impossible to configure correctly (which is why it doesn't have an
entry).

Regards,

James

