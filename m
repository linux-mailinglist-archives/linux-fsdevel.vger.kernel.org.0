Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28BB6E8629
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDTAFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 20:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDTAFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:05:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5146BD
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 17:05:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so1582971fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681949112; x=1684541112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYAe4DL6BBolNtAJv/zYI4HfX4uQZVgW355DYethIwg=;
        b=dBzr5xpyjc9j8TPlxomJFYXi3EtDUrcV3l4m0E/FYCM3P0Ett9qzAJcqieGXVH/w5N
         w4P4ushMTZmxt4ROas12399eaY0qUve0WiF2qlAfdnY5nhFt4X4obbGget7MJtz63DEZ
         S84OC73yiqCVxkKuXIn2CCPY8dYYZZTc7nb6jLRW/dKxpowiNCnSDiwCQ5NutKGtUhad
         bhEsFW5JkS9nAvvPNXDVD3q84fizQSsSYrfihCLFP1N3Xib0WzfG2acK4+pcHc/AFlRW
         imEtkHgiO2FjTF+98fG42vUslnwg0/4+0fxGg24MnKfpV7hG3j6y2iKssEV5A7ua7z36
         aqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681949112; x=1684541112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYAe4DL6BBolNtAJv/zYI4HfX4uQZVgW355DYethIwg=;
        b=gELWOPS7mxKoIvPprQcj6Gg1McahfcedeUsa9rNu/3ybWrM3q2bOq8KoYKhZA4CtPJ
         gCMS50H2uPyV4278WhUjmCjE+7Rpeebxa1ES6KC8/f60WP+AvTS3pQFYNGniVMgtv4F+
         cGaWLDMNhDkpls8lYU57GW0ThpjnNKuXGw1XfmuYmsPe9hOPdsiTuc2IUYhQcwwsBGXG
         hE3vwEH0Jy2MJd7ztMJiyI6Mws1s+ZGLsxrLSBGvaiAzW2yMbgrwiUIBF5EctPLs+Dnu
         2Csh386zjQyu/odoTzIA8x+YZipYOnGmh8ayhYyO9PmaTXUfpY5kjklc/ZZvv5aFeLy0
         P2mA==
X-Gm-Message-State: AAQBX9cZM6mqTJ5bzvDEe93vZe7SzDBfDbiwNS2cIM1xmi0rSDt6K6M8
        apOdzUqmGCJn3iVkYe7v/c7seCKCArTD5afIpAI=
X-Google-Smtp-Source: AKy350bNrpKMcQsFr1Mdex7DQUsH2Nl/bCJfLYSaaeMzyLjSV49Hl/9/kEpp1/XNHHqNP+SO4n63iFcuF6z4fhpJCJM=
X-Received: by 2002:ac2:54b9:0:b0:4ec:7967:9e92 with SMTP id
 w25-20020ac254b9000000b004ec79679e92mr4844283lfk.3.1681949111704; Wed, 19 Apr
 2023 17:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:203:b0:2a9:b6fc:4808 with HTTP; Wed, 19 Apr 2023
 17:05:11 -0700 (PDT)
From:   "Aim Express Securities Inc." <aim.expresssecurities@gmail.com>
Date:   Wed, 19 Apr 2023 17:05:11 -0700
Message-ID: <CADw8qP1red+pVT63ne2x835TnD6c544PDUbNe3zLEr7uTBX5iA@mail.gmail.com>
Subject: Good Business Proposal.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

STRICTLY CONFIDENTIAL

TRANSFER OF US$35,500.000.00

We are making this contact with you after satisfactory information
gathered from the Nigerian Chamber of Commerce. Based on this, we are
convinced that you will provide us with a solution to effect
remittance of the sum of $35,500.000.00 resulting from over costing of
job/services done for the Nigerian National Petroleum Corporation
(NNPC), by foreign companies.

We are top officials of NNPC. We evaluate and secure approvals for
payment of contracts executed for NNPC. We have tactfully raised
values to a foreign company for onward disbursement among ourselves
the Director of Accounts/Finance and Director of Audit. This
transaction is 100% safe. We are seeking your assistance and
permission to remit this amount into your account.

We have agreed to give you 25% of the total value, while our share
will be70%. The remaining 5% will be used as refund by both sides to
off set the cost that must be incurred in the areas of public
relations, engaging of legal practitioner as attorney, taxation and
other incidentals in the course of securing the legitimate release of
the fund into your account.

Please indicate your acceptance to carry out this transaction urgently
on receipt of this letter. I shall in turn inform you of the
modalities for a formal application to secure the necessary approvals
for the immediate legitimate release of this fund into your account.

Please understand that this transaction must be held in absolute
privacy and confidentiality.Please respond if you are

interested through my alternative address:


Thanks for your co-operations.


Yours faithfully,
Mr.Lambert Gwazo
