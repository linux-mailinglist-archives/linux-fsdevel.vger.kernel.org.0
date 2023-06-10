Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1D72AAAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFJJfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:35:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE8269A;
        Sat, 10 Jun 2023 02:35:11 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba82059ef0bso2497415276.1;
        Sat, 10 Jun 2023 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686389710; x=1688981710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDlR5W7WhiqKe4ABMw1yDlKmz9hspUwvZuyNaAkAMMg=;
        b=mzmtbYTgA8shyGYl+TZQTn57FI0UJiGdmhMuIfBwGKBBJ/HnD5JoHtBIl/rHBsXutN
         GjyEKsLC+wjQA3wqlZsecxHP9DY8K3eLvdByxtn5nBZu1w0t0CUJET8BCki0iS+fp9AJ
         OqDI+wOHUfWguj/sAaXLcyAKu5BkS96+ruh7TFhL+kOwV+jfR5QUyWhFySUODglLjyPF
         vfRoAhvRDerJUE9tOZJkgAOnSgQpddIQV/W31TQsfwegszAHwe7CWW67n0u8p2QuMHSZ
         gPq4scPGxVj/p4AVUDNOuQCrqC5yUiX0Twh0BUNgaystsER6p1Ut6FTeghkkSxB6piBj
         5cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686389710; x=1688981710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDlR5W7WhiqKe4ABMw1yDlKmz9hspUwvZuyNaAkAMMg=;
        b=I4WCYMCgTOE5aVtSwBkf7R3l3UvvnRNFrZ1pJyZWM/A0aQFSiymMdu7Q2SfSjzjADO
         Buap2G/oiTSk5wniO9vqhyDEH/lWC4HutP62zZquwNnePw2ut+Y5SUE+BcUU3wWqzVQd
         8u5KvfpEY17N1XaW4x/VImfC0av59pnLXHqFWKCwz3vKAvYqFWhzqBO0K9CGxhEfqIKA
         i6j3MEWIFAceOepxZz6Fqc4prOQlKOQyGH7CUnM9GNxvDcPENblb5id3PWyHuo9/It7J
         PSdkYUe1E6b6h6GofcZjfLwHVL5taw5sIFKrhNiWsnnb2ukLsmMBlUFc/V/xI4bSkk0w
         WdpQ==
X-Gm-Message-State: AC+VfDxZHcaiA4URArYSRhQXFDRNHSgSXyT83PqkrI7bbdVIDQtDea1r
        CO9kMNYJE6ECo9BJ58A5oyxq/ksofja+Yw+VK/E=
X-Google-Smtp-Source: ACHHUZ77SZ8a9ppj9TPbq7gyNcqfqng/HEgRY7CLgaplSmyd2pm8lLA8rfxB2qP0qZlIgNqdfIotb8t5G6r0YxeZv+4=
X-Received: by 2002:a25:d18c:0:b0:ba8:7f98:4afa with SMTP id
 i134-20020a25d18c000000b00ba87f984afamr3203080ybg.26.1686389710319; Sat, 10
 Jun 2023 02:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner> <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com> <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com>
 <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com> <CAPDJoNutb3NwrzuDP=kkLi=kTwG0XZHbUG=F_Bg-zbinzzUcdw@mail.gmail.com>
In-Reply-To: <CAPDJoNutb3NwrzuDP=kkLi=kTwG0XZHbUG=F_Bg-zbinzzUcdw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 10 Jun 2023 11:34:59 +0200
Message-ID: <CANiq72=e5Sqd+iqDhR1QfmJEcWbSFQTChW8psX7Y0+XJx707JA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     Ariel Miculas <ariel.miculas@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
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

On Fri, Jun 9, 2023 at 9:11=E2=80=AFPM Ariel Miculas <ariel.miculas@gmail.c=
om> wrote:
>
> Yes, but then how can you be sure that amiculas@cisco.com is the real
> author of the commit? I think that's why Miguel Ojeda asked me to send
> them from my business email, otherwise some random gmail account could
> claim that he is "Ariel Miculas", so he's entitled to sign-off as
> amiculas@cisco.com.

Yeah, that was the main thing; and by asking that, if you managed to
send that original patch from the corporate one, then there was no
need for the `From:` to begin with :)

Cheers,
Miguel
