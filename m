Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A3872A2E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFITMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFITMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:12:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCAF83;
        Fri,  9 Jun 2023 12:11:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f654d713c0so2338626e87.3;
        Fri, 09 Jun 2023 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686337917; x=1688929917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4HKpwOsTc4sv0/bXFcrY0iH//3+G/maRM0QE7KbfLY=;
        b=FxgTLqTizr2oAxjDJ0i8GZq/T6H3HsroCado6dNiknE3rTbpNyKh5TBP3nX3wQRoCn
         GdBwTrmq+pqmBQOC9cFGkfpSD5ZqOkZX0/UKhO6gqNp8rU4DyW0t+CmP2s/7pZv00Whj
         z6AcYbcrIkrY+XSG/w5+d/SO3KHmED09mn/PgFXwAb/ghCYLsYW7ezDqr51lggAIV5mj
         oObgsgrC25eTFJQeehgfIuOH30kEStwUgIxnowTpTdBm4TMnCZWZCZQEMtvmN1IB4CbJ
         RyoKRxvXyULSXTqrPyTQ81d/ivOlY+2GdtXW1xToe5xiPRwlUo6uPAALz2cBRx3ZozUQ
         2HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337917; x=1688929917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4HKpwOsTc4sv0/bXFcrY0iH//3+G/maRM0QE7KbfLY=;
        b=Sy9nbIdANoVwhJFvqAk1ghVr0FDuMdoSkZEjWV0jajhItwKhAm7teyihM2wPQN/+Ad
         AKtrBdVSa4S1tea7LRvbM/M7NyDHp2XtGLUkdtSq2Qi6ddLcduAqiz1IGRMepMCn9LPT
         +vPWu2sDaSDHiLl9Y3aBUNZaDL0DyIEkL8zMa8NIjiAgvnSqo3GcGhSB4IQpIk92KyAl
         HXCLYfrMwToBJXPlvOOJUxj4RgpyahhaDqWa3p+3f+ebZKR5Ps+viaaYXLXvfFT6VOpQ
         HxoIdF81BGuhYOA9ptQ06xPZIlNtBFVE2uH8qvoT+dKnVpZrVCB1VJZyFQho4WxXtkaq
         b3ng==
X-Gm-Message-State: AC+VfDykX8LYjeGn82Jrl6ZJZ+5tcXnxg65V5kuR3oQYkQDjh8CqfhDW
        vSXmAL6J+7bCn+2bVmVkedG6PCuNQvZQu+/fc8U=
X-Google-Smtp-Source: ACHHUZ7gI3QqUrO8F/vSdZXD2pgSGoWMf0ZZ/2eN5yHbZTTaSiSu077KSrWC3H4Pr3jxFPYy+IURbHccrz/01NicPX8=
X-Received: by 2002:a2e:95d5:0:b0:2b1:a8bb:99ab with SMTP id
 y21-20020a2e95d5000000b002b1a8bb99abmr1608594ljh.19.1686337916962; Fri, 09
 Jun 2023 12:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner> <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com> <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com> <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com>
In-Reply-To: <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Fri, 9 Jun 2023 22:11:45 +0300
Message-ID: <CAPDJoNutb3NwrzuDP=kkLi=kTwG0XZHbUG=F_Bg-zbinzzUcdw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yes, but then how can you be sure that amiculas@cisco.com is the real
author of the commit? I think that's why Miguel Ojeda asked me to send
them from my business email, otherwise some random gmail account could
claim that he is "Ariel Miculas", so he's entitled to sign-off as
amiculas@cisco.com.

Regards,
Ariel

On Fri, Jun 9, 2023 at 10:03=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2023-06-09 at 19:41 +0200, Miguel Ojeda wrote:
> > On Fri, Jun 9, 2023 at 7:25=E2=80=AFPM Ariel Miculas (amiculas)
> > <amiculas@cisco.com> wrote:
> > >
> > > I could switch to my personal gmail, but last time Miguel Ojeda
> > > asked me to use my cisco email when I send commits signed off by
> > > amiculas@cisco.com. If this is not a hard requirement, then I could
> > > switch.
> >
> > For patches, yeah, that is ideal, so that it matches the Git author /
> > `From:`.
> >
> > But for the other emails, you could use your personal address, if
> > that makes things easier.
>
> It's still not a requirement, though.  You can send from your gmail
> account and still have
>
> From: Ariel Miculas <amiculas@cisco.com>
>
> As the first line (separated from the commit message by a blank line),
> which git am (or b4) will pick up as the author email.  This behaviour
> is specifically for people who want the author to be their corporate
> email address, but have failed to persuade corporate IT to make it
> possible.
>
> Regards,
>
> James
>
