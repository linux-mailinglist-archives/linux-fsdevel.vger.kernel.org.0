Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3E5A505A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH2Pk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH2Pky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:40:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D06861FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 08:40:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-340f82c77baso89966137b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=j1IB7j4OLRcSZ3g4J8PWmoYtAO/kHfADj7RgXZEk7hqFtG3q70Lteze87nvzQDS+R9
         CL8iucEX5+pUR6GFNM9YhGtkQ/K3YSilHFtT6rgltDxGIvOl9WNWofz15dSno2pvUCu1
         1Bhescdr0s6ryDzQi+7/8n16+XcM1cHIhWF/zqW4grSQ4jgaNHAQGVva5E5CPm2a9nSv
         SACaO/HrWt5OCxmWYkpTIDTp7wOora+01Wom3zQ/aQLMJRMxDkExUHndf/LECmRtuQrW
         XvQR9OR4h0bTOOFoK/XuaduqdLSBZdKhGL15qV2OWEaWokw3wRFRvIVWgLQDBU1NqLPb
         rpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=J8VUMn4huFQeCKx4n2k+aoxfAhJS71Q18utK7EuVlaoKDj5S7ImsZ/IImuHZ3+RI8C
         Beg85/qZmh2ZfjFkIWyi8EQ8jkimpl4I6VcRYTpllUCmxP9FNeEQvZiAifCkbv/hHe8v
         q+MU3mQgqn3dmX78A4v7uAIbJuvlWBRFN4vl5VPWn/EuM3AwfUD9T7rj66DnJX5bpn4O
         qx1tC9FXsVvp6wbhBHCXDPHDqcrLV0i9MKvrBVDmMWYrmd20kpkF1qBpkeWlu9iWdisQ
         0rzVNmgs6v+XmZ6nuBs7/fjIT7Y9HnEM9q/QymcHVNcsKoSr98u7mbaD3gT0MatDxOcB
         h0eg==
X-Gm-Message-State: ACgBeo11vRI7hKw0M7wPfng02mADjCD3e+EXqKp/VuLHTaAaUyw42T4C
        1qNRIfHi3H7N7k/f6V28Aa77Iq+6SrrPCsa+2Mo=
X-Google-Smtp-Source: AA6agR4NTWVWHdEWupBK3yUp5civ1v9UDwj6Vijbz90HGEQyeGFiqExsePn6LGFrPnhq5fQhvylUEZGvwX6EMEDEgyQ=
X-Received: by 2002:a05:6902:1501:b0:697:c614:2079 with SMTP id
 q1-20020a056902150100b00697c6142079mr8689374ybu.389.1661787653000; Mon, 29
 Aug 2022 08:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8a85:0:0:0:0:0 with HTTP; Mon, 29 Aug 2022 08:40:52
 -0700 (PDT)
Reply-To: izzatibrahim724@gmail.com
From:   "Ibrahim I . Hassan" <issad6927@gmail.com>
Date:   Mon, 29 Aug 2022 15:40:52 +0000
Message-ID: <CAKT4aHUraYFxy1fDiAH2JDxUv==nUdCvk56p+w91c2YJe5MOmA@mail.gmail.com>
Subject: Thanks
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4915]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [issad6927[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [issad6927[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [izzatibrahim724[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 TVD_SPACE_RATIO No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


