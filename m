Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA462CF87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 01:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKQA0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 19:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKQA0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:26:12 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE061BBB
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 16:26:12 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-13bd2aea61bso481971fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 16:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1mFOWLvu7xivc1Hajn5plCHpYGUJWrREigRyDv4+GU=;
        b=CWlX3yxxuvE2VCNLNAyDYfn2oenXH1MUH98Xh9Re/ZGcABfiv9yfDDHLXbBD5OnWDb
         Tz4CpBgAF3GntpYDKYDGLzAtyy8tScN1Vw3i889yXoBT3gZZusnV2TV0Z8aDD7TBfeHW
         2euuhLb1GU3+3he05TrAmev+9T91Ud2xDExCMOAIhHhmxsJ64/pDw18WTrpM0Dz9P3g8
         E9YsdwMpK2Be9l1sofYANgXKEo/PSYzDxjOROwAZpKKAmxo6grdp9qwjTLRwTD921kgM
         +WvONrUgXVMpozY2y5NVZe5979Svf8QpxjPVVEQZOobn6Ie73YOsP9Zf5YAAGOzNI7sJ
         5HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1mFOWLvu7xivc1Hajn5plCHpYGUJWrREigRyDv4+GU=;
        b=r0DFGksGa/IlopWDHnNXqwx8+rtRLC3Kdjv1DVFosdQnt9SJJHW8KKFvMm6NYTXKkl
         06WgvJlp6U0UNmpPy9dxami1nAEvkD3F4MuL8ZFrpZbLm1vwLhwpRsvrs3X8xUXhGt4a
         YjBEOF7+8RiwNRTGCLP03i16O04wLo2Vx8GFTIlHrg6ixPC3ojfm4qeuoc0leJKmwlpA
         kLz8hozb5OR3+qBjbBWxAmxGgwt4dG3RokhajWak4mhvAr5GTnBcNU6hRLzYtcVpfnD5
         mYiP7z7iCzJGx67Nr6mlgKQM0HBRbdqxS2ElalYv4R8Lrh9CeDtsMxCCJYMCrkzcf/mt
         RxmQ==
X-Gm-Message-State: ANoB5pmSXcUPL6wRD4gXz7L007Xedkdzrnn5gHUqP9tjUg4Cf7nvchDc
        c36uP7fF5X8anbXE5kcZp8DywHo7URKpwbWEJDE=
X-Google-Smtp-Source: AA0mqf495/673iOZ/TByNMFOHkh+VoJiRT7f1pb+xDGhTBh1R6I0xlqWI94QXblurxqwtwYPJga/iHCbY2p/WlXtgJU=
X-Received: by 2002:a05:6871:4211:b0:132:354d:71ac with SMTP id
 li17-20020a056871421100b00132354d71acmr3194834oab.107.1668644771184; Wed, 16
 Nov 2022 16:26:11 -0800 (PST)
MIME-Version: 1.0
Sender: mrs.anna.brunn41@gmail.com
Received: by 2002:a05:6358:44ca:b0:cd:e868:f2ce with HTTP; Wed, 16 Nov 2022
 16:26:10 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Wed, 16 Nov 2022 12:26:10 -1200
X-Google-Sender-Auth: jH8UYr403zqQ4iG8fsFqAkKjBlw
Message-ID: <CAPxZUqFaNsTggrGmWYo=-LKk0t_h-UpapgyXXqNVKjoqDb6phQ@mail.gmail.com>
Subject: My beloved friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9013]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.anna.brunn41[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.anna.brunn41[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Assalamu alaikum,I came across your e-mail contact prior to a private
search while in need of a trusted person. My name is Mrs. Aisha
Gaddafi, a single Mother and a Widow with three Children. I am the
only biological Daughter of the late Libyan President (Late Colonel
Muammar Gaddafi)I have a business Proposal for you worth $27.5 Million
dollars and I need mutual respect, trust, honesty and transparency,
adequate support and assistance, Hope to hear from you for further
details.
Mrs Aisha Gaddafi
