Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F686F0754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbjD0O0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244055AbjD0O0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:26:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B444BA
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 07:26:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso6635349b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682605590; x=1685197590;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=A5lwNTG69yFzidvl/3XrDDQYHx4VblJWuc968Cm16a7zfcw5sZJkx/IenPGHx4Ru5V
         FD8FN7iwRPlABkyI4umTiFBT/RcVE+2+JnXwn11LiS6E/SEkx0sb/dPOA4T0f8ZAv6em
         KSUwA0DaqCDHjOCE5EFQke3p1Wvw1cCDtepNTwI7HF/dToLnCKi3zSEl9sB5HVKs8sBN
         pJhRBoYNFhkEvfrHRaqE2fyzYfgqKJX6VfLJWkF0lrdgcn51Bn9M+s4TDCS0Rg+xMYex
         uu6QZuVlLxqZLw8oWHSSm/+5TOmVtjkSrx9BvlVHju8eKb4esqTxu7eQiLY3vQ+TGPpH
         H9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605590; x=1685197590;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=HlfsIfOMuMwYgq8zhnaWyHCJutrl8S2A09YGWg9DBbkDLeWekjRCj9TKxM48Lc6H1P
         kK0XCBNNbfW2ign/sJprA8hIhrLvOowJ9dj0oaPPMhDKAaXtkmssrPCrfelqwQvfA7e4
         jh5cN1rq3gw3U5KoIyBa5DnIbCyZm7ZWysTm0J7yDTA6+WoG2rnJEksqJzm5J8ybusLv
         jEmqy9aSJ56arStVIjw/ZIDU8EGPgFY3mLso6a2Y/SFlerV8KcWguBevkIFB/pNI8Drt
         Zwccf8YblTpYPZ4+8MrJX+XQzDkGxuc4ZvnIfSXe2WhRVZpKTGL4nL9DTYrd8A3HdpVe
         4w3g==
X-Gm-Message-State: AC+VfDx6bMyzHfCv4eenEOs7H4VSSOOUxYqpZ9XziwuPwbpo4tFCtyyL
        4XC5v2C4AdTyBBTbTalys0I12Yp8OgF+4Xu20Zc=
X-Google-Smtp-Source: ACHHUZ42P1fbTQRh9tnYZ0ZL3cpnhYbKLObGZXRp6ZlQkJZofiC6CnqxLHlc1i0ROXHKdbXQe/llqsGwWJWVfUkiCNs=
X-Received: by 2002:a17:90a:94c6:b0:247:471:143b with SMTP id
 j6-20020a17090a94c600b002470471143bmr2190753pjw.26.1682605590257; Thu, 27 Apr
 2023 07:26:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2d10:b0:473:2c3b:1f92 with HTTP; Thu, 27 Apr 2023
 07:26:29 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <avasmt002@gmail.com>
Date:   Thu, 27 Apr 2023 07:26:29 -0700
Message-ID: <CAGJq2vv6ia9f6JmN7e6n+9HZ=U2jj+feppo3W9ikhJUv3Jp-Jw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4435]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [avasmt002[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [avasmt002[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
