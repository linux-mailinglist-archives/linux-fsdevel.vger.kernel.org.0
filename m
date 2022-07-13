Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5978573D2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiGMTda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbiGMTd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:33:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C22DAA2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 12:33:26 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id x125so9067660vsb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CAIH/48VCAZZUEhRpfaRPTSaBdpuCbyHyIV69iiJf1M=;
        b=aM1IhBunUxE23qoS04VXLKhmfEzv0G+rIPuL+tw7ecWQpkkV/VIRfagQrgSyOoTIAm
         AZWPXQE2ns7ZNMtu2h9VrGRckGYmFXAYncydcobmDBiRLde8BCgwi2hlvMDHXzYgqMkQ
         SeJxIk0u87w3y3HvNwB5qYF3cTerdoWv2b9mV8jFDizIJX8stbEHhwQnKSILH4q0Huup
         hTOO9Jx4LSsJcLZc09WMxCsF4ciSzvQTXVpvt0KUlX7r0Y8qXhkOofhAjq9rhr7n0O3a
         0Nz5Fyl2IiFFXOdqA4nMId1341Np8datpnUgsVwvaqGydn6uB0z1+35u/mxwEULjiUxM
         xCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CAIH/48VCAZZUEhRpfaRPTSaBdpuCbyHyIV69iiJf1M=;
        b=OlSAe0HjUGBayyeaTqf/UGea9IT6KvTU6GvHxysISJ1WDgSk33WY6ImHjiyznB4y8t
         y3UOBEAVDWTxN9LHiq/6P+ElBOxBEpOHeJ7u4YLFjshdulfVAPWgF2v4xfFfd7B9m1wB
         KPxFC7nFsFCAXQgJFV0oVxP6QmtICydGF4VzReY94K8/vfYikQHplaZ7Dngi19kosB2t
         IfUOsAZxCLegSlN1u/8DKvq3BioDpiFncPfPzeMvw7k5Pc01gKfHbrOgKw/VXEJY+vAg
         Wqsxtcb2uzjiLh1tlYBMFowmBnvdx2zsLekg1eprTIMreU1QqwkUACxGm6JIU4TM7lcU
         Wy9g==
X-Gm-Message-State: AJIora+adyL1GRV4qzPZ6X3Vd7tDoXNiVwGuI3mMIA+xaQCazBwCVHqv
        LpU++4X/9G/m0mhkH3TRsALaD0tApxV/3e+QERY=
X-Google-Smtp-Source: AGRyM1sJxaHNFmNllzWTe6lcXJtKq+jpeM0H1VbICZMt0N2iL7xjj1CQ/iGumgoql0QuMbeebjAgPClviShoH8saaK0=
X-Received: by 2002:a67:a449:0:b0:357:3407:9f60 with SMTP id
 p9-20020a67a449000000b0035734079f60mr2391818vsh.17.1657740805145; Wed, 13 Jul
 2022 12:33:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:e05b:0:0:0:0:0 with HTTP; Wed, 13 Jul 2022 12:33:24
 -0700 (PDT)
Reply-To: pstefanopessina80@gmail.com
From:   STEFANO PESSINA <awabuts49@gmail.com>
Date:   Wed, 13 Jul 2022 22:33:24 +0300
Message-ID: <CABqU-Kt960=z5WPCBXkW7U+2SM=criymhoesJ=oQD7uhrCaFLQ@mail.gmail.com>
Subject: donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4889]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [awabuts49[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [pstefanopessina80[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [awabuts49[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20

Congratulations!
The sum of =E2=82=AC1,500,000.00 has been donated to you by STEFANO PESSINA=
.
Kindly get back for more info via pstefanopessina80@gmail.com
