Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98639354829
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhDEVbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 17:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhDEVbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:31:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F018EC061756;
        Mon,  5 Apr 2021 14:30:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so18706215ejr.5;
        Mon, 05 Apr 2021 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=34NFUBk25VvjYcWfoAtVI1m5zfwXqsP9qgra7lNibf4=;
        b=LLrG/jNsRoOR2DH4sCa8kseJgoYa2QTuwzrjT6oobivDbrt7RJLSBBNtKsEz9VP5UX
         pRg38FyhJOh1zA9LszAJqPzCO5+FMZ6dbiMo3YF3XfTBEq8hIiT34ReI9deJUZEg0Bb5
         VFQopJzRoTwUsLHpTHGFxLlNvd58NbcVcLy5pGrI0nhqTUNnNdQzLS7QMiofwdBLrcG2
         PEDIzxrAU/IgqvslSohsFTHExNnsZr8+Eq5zQeKi4SfdR5gZ1Z7mxXxZOYdD1/XtJWRL
         XL4LGVIRj673GGG+z0ibOM8m+Y0xbUZ/HaTZfVdRil3DuOGyXq7PIrH2NVnHnhFwbb6f
         sGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=34NFUBk25VvjYcWfoAtVI1m5zfwXqsP9qgra7lNibf4=;
        b=gX8ZDUDWYGFQoLhyeUBb4N6w9ehX3sPpQ++R6Nh0c8OoJexaU69X+Lb3Jq1PavN5WD
         lK5xU0cHoGQtf+BF8rbFm7Nf2DKb5pqPHvBh59aiHTwujub6lJ/y9sb+1oksvooPXANF
         hIYSClUGtL8mGS+3NrdxRaX4vulmwPx1ai5PrDGlWYaAeIb3gKUgMpyO291ykEHBd+Jt
         83EfX9bE+HuAdgSNPGcCYuocrhB771PEgqG02RoFcHCUGa530pwc5CZ0i+VWPHHipHOS
         bmps5Q7CfSR0jaGnNqwL0cqZaS20P6dDq6AMCqehZ8zAYVGPOUq6dl1oej5nG7sVDZYY
         fwsA==
X-Gm-Message-State: AOAM5329idUvQOrMMqiKqk9w5PgB9KD0nrOujpdvDmZaa030sW4G1b4g
        FcMWL/i/GXej1idLxdKU/ovrXrztXMEB9ijzJA==
X-Google-Smtp-Source: ABdhPJzrSggt0mGvMxuKzU7ILHmDzivWyIbZq9+YXnQiaTCRuzprZ4t+1CUqHSw+8CSEN3+vFpvxq4m6RFdqACusUOs=
X-Received: by 2002:a17:906:6dc9:: with SMTP id j9mr12863755ejt.188.1617658257333;
 Mon, 05 Apr 2021 14:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvhUQEqXQmrz5KKbTCFaeS5ejZBGysaeQVC_ESSc-snuw@mail.gmail.com>
In-Reply-To: <CAH2r5mvhUQEqXQmrz5KKbTCFaeS5ejZBGysaeQVC_ESSc-snuw@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Mon, 5 Apr 2021 14:30:46 -0700
Message-ID: <CAKywueQ8NZWhrau94JNurYYgtq3kN-avcdgLOpb3wMmMLgSDQw@mail.gmail.com>
Subject: Re: [PATCH][CIFS] Insert and Collapse range
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Great progress!
--
Best regards,
Pavel Shilovsky

=D1=87=D1=82, 1 =D0=B0=D0=BF=D1=80. 2021 =D0=B3. =D0=B2 11:31, Steve French=
 via samba-technical
<samba-technical@lists.samba.org>:
>
> Updated version of Ronnie's patch for FALLOC_FL_INSERT_RANGE and
> FALLOC_FL_COLLAPSE_RANGE attached (cleaned up the two redundant length
> checks noticed out by Aurelien, and fixed the endian check warnings
> pointed out by sparse).
>
> They fix at least six xfstests (but still more xfstests to work
> through that seem to have other new feature dependencies beyond
> fcollapse)
>
> # ./check -cifs generic/072 generic/145 generic/147 generic/153
> generic/351 generic/458
> FSTYP         -- cifs
> PLATFORM      -- Linux/x86_64 smfrench-Virtual-Machine
> 5.12.0-051200rc4-generic #202103212230 SMP Sun Mar 21 22:33:27 UTC
> 2021
>
> generic/072 7s ...  6s
> generic/145 0s ...  1s
> generic/147 1s ...  0s
> generic/153 0s ...  1s
> generic/351 5s ...  3s
> generic/458 1s ...  1s
> Ran: generic/072 generic/145 generic/147 generic/153 generic/351 generic/=
458
> Passed all 6 tests
> --
> Thanks,
>
> Steve
