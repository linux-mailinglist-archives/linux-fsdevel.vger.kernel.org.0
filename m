Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8064C7B59AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbjJBR6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjJBR6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:58:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F35AC
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 10:58:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-27758be8a07so47329a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1696269510; x=1696874310; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=USKYQuL0ssRIZCXry55OgQAc3k9+pcQrxUVPXfc364FBtfDsYJSHRmwu+v4PfSi1B9
         zbmYHPxYMxdXazfhCCQa5nljdNbJlqMWb4eOwPXyJjWXDq/M5X2UxZ81EX0J2UpO4RT3
         K1shePhBQzHcSzPSTsU1eMOrYnz1kcmBtqaPHOXqmQB2nsAfd1aSZ4S9kUvTAhatXKTE
         p/P9M2eky7sDaLdPTsgWQEF4iAyTrWaZ6e6r1MGNMrBP1GFUKLeMGFI30r3mWa4Ea05k
         ejLUF7BBUxRHBKD14l3Tt3jBsA274AtZ1moQ3k1///kwdwNa3+KMJvZ3ZslUlxybUPsN
         QDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269510; x=1696874310;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=i7XQzJex44BFCv6/OFG/wlaJLjoaenzjXM6H9XX88G7u5aIxNAPvwldXlXMufzMt7n
         crAkeCbzlu3YrMG3lWCC23t4CHulNruBcdeanmBgwXOgs6qzZZU9PhKIzVQJWwSs09/i
         eZLl7dwTMRFq5yB033TvXyNxqR2PtAhh715DsqrEHAuDA2Eng/Cgzb1Pb86UzkP15s3V
         EUfSDHnHckdtIi7DiFuJYfYVDHwIpXQPZHfeYSDAXya/5XIP1WPWgiboxvaB0FNsDmNG
         Y+bZR/JDVpqwnjM/Sb4+4hWTEjWD2z58HUB3zsV/ZNc4i62xWbKhnNUL/iub3kydWMcl
         R5pQ==
X-Gm-Message-State: AOJu0Ywtmxrkk3p80KjIFk0eRiFkryd55za5s2h8yJE0cgVeaEoL5KOB
        QW5j+wRqOavXhRgF9QRZxqtMmITJsntycvC6azfuHQ==
X-Google-Smtp-Source: AGHT+IGQHjMRZAb7D3/nVzd2/AuO/u/pLs7STuLvMMyCNUSMsKelOauEJxObp6KbnPAWTkuafrQAIqw86pMbVxu6h2k=
X-Received: by 2002:a17:90b:3a85:b0:278:faf8:af9f with SMTP id
 om5-20020a17090b3a8500b00278faf8af9fmr11357020pjb.20.1696269510187; Mon, 02
 Oct 2023 10:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMh3ZMKYnXqAKMHMafqrwYMvNF+vD+Y6GrDNJinYQnAm=e3_Gw@mail.gmail.com>
In-Reply-To: <CAMh3ZMKYnXqAKMHMafqrwYMvNF+vD+Y6GrDNJinYQnAm=e3_Gw@mail.gmail.com>
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 2 Oct 2023 12:58:18 -0500
Message-ID: <CAMh3ZM+8k1J2VKOmeaVVXz6+PJn3fkHbbXxd4fej5yjenVmuRQ@mail.gmail.com>
Subject: Re: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

How you=E2=80=99re doing today? Did you have the chance to review my previo=
us
email with the follow up below request, I am wondering if it actually
reached you.

Kindly let me know your interest on this

Thanks and waiting for your response.

Kind Regards,
Sofia Gonzales
Marketing Coordinator

On Mon, 25 Sept 2023 at 10:14, Sofia Gonzales <sofia@happybizdata.com> wrot=
e:
>
> Hi,
>
> Would you be interested in acquiring the Healthcare Information and
> Management Systems Society Email List?
>
> Number of Contacts: 45,486
> Cost: $1,918
>
> Interested? Email me back; I would love to provide more information on th=
e list.
>
> Kind Regards,
> Sofia Gonzales
> Marketing Coordinator
