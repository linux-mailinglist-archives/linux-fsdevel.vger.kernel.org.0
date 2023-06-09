Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4972A2FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFITUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFITUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:20:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1961984;
        Fri,  9 Jun 2023 12:20:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so23753941fa.0;
        Fri, 09 Jun 2023 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686338430; x=1688930430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MjNXuRkp+2voguCm3mieDSKwaJkRD2mqDVtlXlkMa4=;
        b=Chk64jTsEHCWvQLrvurD3GQYi5t8L8B4Y86Uc/TLwvEg4SfyoC7+iOI9rI2nP5/jfJ
         Gm11VUtTW10j86LsoZfhbA/TuVbNU3DPG4SnyCHnzLet2FXysB8jD1Ntro9NDHF2ZQRQ
         5UqNqE5nCAt5HPz+ESCDP3BxNHUv8iGaEF/yC47rZJFKDwvHZOb6ISoZSbzRGoFPEtz0
         +4ovBTssHhBSnmgvzp56sEmXkkfgETEbLaq0BB3Bz6UmOWE+GpiQGmez2RuD5fWoC6ai
         k2+ZSBap0tZuYGY0cIZ7lLdpNBOLrashhHRRpY5msZG4XoZOq9XVFr9FfPDsb3Jpam1P
         IYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338430; x=1688930430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MjNXuRkp+2voguCm3mieDSKwaJkRD2mqDVtlXlkMa4=;
        b=FndBtu0uPo/YuyKodD/kkiUaSaVulLKX7uOCn1FQlIQyPY1DiykCnOJSs/PFGdCXAa
         HqpdnaYFyzvsiHkk3QBglvD7SDcRKnrRSSnYCCIRDXjW2PY9PFDQf5j+0Er91CumhMDv
         IIgmHlNDNDuAVOGryiUijQiUvzmZO/yoC8sO1bRWxVFs7zPA5ydYyzD6mfcYJmLCQzQa
         qKu+2WkI9qGqSVAI5TwGnKdyzZBCuTUkuuc/kAXedhOSvxpp5cutR9iuclpZ7s9/JVIl
         7+asXLLCgJGqoLa2Qr/qi5Fr8SsfwCbK4T3dRy8YuXVGuUi3ZZebqWetgc0pROGVRuDA
         MvbA==
X-Gm-Message-State: AC+VfDyf4Zx9oIqsabi6uZaL/lBv7C9Wfw1H3PChabpOkB+8GLF5bSpk
        2RPaFi8rri1DihYQN1SJo7z9Bz5lgYyqg8XSKXB/GKv54spOWw==
X-Google-Smtp-Source: ACHHUZ6GZ2MydmnbPhp1qLIRgfEZiB8qCTBdIqF2k/3ghqYgwSn9k5Po/uLNI7VS9X4HM2ZZuuw7iO1wPMfJiwLaG7w=
X-Received: by 2002:a2e:9c5a:0:b0:2b2:4e86:510b with SMTP id
 t26-20020a2e9c5a000000b002b24e86510bmr225331ljj.13.1686338429385; Fri, 09 Jun
 2023 12:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner> <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com> <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <6896176b44d5e9675899403c88d82b1d1855311f.camel@HansenPartnership.com> <CH0PR11MB529969A40E91169B8CBDDB39CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB529969A40E91169B8CBDDB39CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Fri, 9 Jun 2023 22:20:18 +0300
Message-ID: <CAPDJoNut3-7mbAZCA1Zh4D2ZsCdrjQK5=mAX8GXj0yjVWRBQ+g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
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

Now if I could figure out how to disable "top posting" in gmail...

Regards,
Ariel

On Fri, Jun 9, 2023 at 10:06=E2=80=AFPM Ariel Miculas (amiculas)
<amiculas@cisco.com> wrote:
>
> I did use git send-email for sending this patch series, but I cannot find=
 any setting in the Outlook web client for disabling "top posting" when rep=
lying to emails:
> https://answers.microsoft.com/en-us/outlook_com/forum/all/eliminate-top-p=
osting/5e1e5729-30f8-41e9-84cb-fb5e81229c7c
>
> Regards,
> Ariel
>
> ________________________________________
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Sent: Friday, June 9, 2023 9:43 PM
> To: Ariel Miculas (amiculas); Trilok Soni; Colin Walters; Christian Braun=
er
> Cc: linux-fsdevel@vger.kernel.org; rust-for-linux@vger.kernel.org; linux-=
mm@kvack.org
> Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
>
> On Fri, 2023-06-09 at 17:16 +0000, Ariel Miculas (amiculas) wrote:
> > I could switch to my personal gmail, but last time Miguel Ojeda asked
> > me to use my cisco email when I send commits signed off by
> > amiculas@cisco.com.
> > If this is not a hard requirement, then I could switch.
>
> For sending patches, you can simply use git-send-email.  All you need
> to point it at is the outgoing email server (which should be a config
> setting in whatever tool you are using now).  We have a (reasonably) up
> to date document with some recommendations:
>
> https://www.kernel.org/doc/html/latest/process/email-clients.html
>
> I've successfully used evolution with an exchange server for many
> years, but the interface isn't to everyone's taste and Mozilla
> Thunderbird is also known to connect to it.  Basic outlook has proven
> impossible to configure correctly (which is why it doesn't have an
> entry).
>
> Regards,
>
> James
>
