Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16441641745
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLCOZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Dec 2022 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCOZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:25:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CD1F2EF
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Dec 2022 06:25:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c1so11694271lfi.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Dec 2022 06:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cua4r7M2iWUXz4dM6KZW/PMHNsBLKROyyYRDtjKr7nU=;
        b=hEkUd/tJwP1NX5TbUWT6ZHbjctEqtdC1SfgdVKL6JHWx4E6B5j7XbNmIu+gq475tHq
         KL2l0NClla2vazVIilm1wE3u4FhcuDmrkwTyVJ/HgTBEh0XEJ+urAdoQJygYyvtn2Q0z
         Dz4uS3y6ayShqI5KkrdaUtnqu3WWiJhFr3wYSoFw5Bjsg9EPgxVohkpKx4t+scn/b+f1
         SPSgP7uVFkpTsi+Fb1ZP23vp3jFo3RhboHl7txKa5U8LY3zUOyiQ3so67nI6PaVDqbyz
         oLpx3c9WOutpsxFXGgYwU6QgbkpXX1jtKf7qdJBE/bUJQcflBdp0JPAaWvyze33GZOyt
         JTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cua4r7M2iWUXz4dM6KZW/PMHNsBLKROyyYRDtjKr7nU=;
        b=S08OMhdNql47N15muIGxWhXBGmkSSrRX7zGSDJnB/0o4TtlE+Mh3joKMTnX/SC0MBw
         Its0qVIZ81lZR0CnrvKcU3KJc7F3aPb0OEuSIWSH8zVd4I/tCz8X7JI9xbr967FMPBKr
         HEY4jxV/ehIx2k1NmCKznmExnGuZSo8aUSXbRK2BZ2Bpx5X2rDRu+azSyg3mp7w2/+Vs
         b8a81iLtcBW47rJd1/FGZUntJ/F8yYMTQTPEO6BuDcn7sqIMOIRFJGC63IcahSdhmreK
         4oA3ErWsAJYB6GCHX20CBDfro0MLRxdh9W1LM2kQ1CEgZjvw2a+cthuhHP+8by207mPB
         zXVg==
X-Gm-Message-State: ANoB5pn1HW0qGs13Z00UpNU3PbpLVePdMBiUx5ujfoixtSaNqWa/PUwM
        +CTutK5zV5dG1bS3ZpAYmjakWlrrUjDDGVgQ/Eo=
X-Google-Smtp-Source: AA0mqf78pjacTrrYNmKFrtteESRARpJ229Rm1YSwooQr7AY6AFyWvEddoRMZ6NwKgCn4PYQ0wo0h/D0/veHuv2x22l8=
X-Received: by 2002:a05:6512:6c7:b0:4b5:5ba1:25c8 with SMTP id
 u7-20020a05651206c700b004b55ba125c8mr1229573lff.358.1670077530110; Sat, 03
 Dec 2022 06:25:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:25d6:b0:22f:2dde:6e8 with HTTP; Sat, 3 Dec 2022
 06:25:29 -0800 (PST)
From:   Wang Chen <wangc6084@gmail.com>
Date:   Sat, 3 Dec 2022 03:25:29 -1100
Message-ID: <CALuFy5FAsrJsp18395J8D71QhNagJXdrAX5NV-iTcnXR=0qAfg@mail.gmail.com>
Subject: Hello My Dear.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wangc6084[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wangc6084[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 How are you? We are writing you from the (World Health
Organization-Palliative Center) to inform you that you have been
Chosen as our Representative in your Country, to distribute the total
sum of ($600,000. US Dollars) For the
yearly Empowerment  Donation in order to help the poor people and Old
people in your Country.

If you receive this message kindly send your CV/your Personal
Details  to ( Dr James Edmond ) through this Email:
(drjames1890@yahoo.com) for more information,Thanks
