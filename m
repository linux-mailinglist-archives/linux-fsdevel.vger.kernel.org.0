Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6C5E8FA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiIXU0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIXUZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 16:25:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C73AE7B
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 13:25:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso2135428otq.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=m7KtlTRQ/940R7kWNpP3Vz5Bs4+fmR2cZz2mXb6ruwc=;
        b=o/j6TYB0hLCyOCwHzpUw/Hx4WFeL4LjHBvDhaTRxy9nD5L9Yj5MY6N/S5xXVTz9Ca+
         qp/aCH97Mro/J3JLa5sAUX7LR3H0y5Acotuh0v1QpM9vpyAa0/9In5kBDrokKy3xmTG8
         szZSroRthPVEHP0X9LuZ3BLZaEqhwjL3w12FmEY8xgW4OBRutjtOaifcQdn4QIykPu1l
         JNC5uDB+dPiW4X3vdK8emHl5q/HgAlWHlpfhRrtrOxrMoh+d/83RsCd79+65336W20h+
         xFDm2i6ZIFdNiREg3eBOxB62f/4TmeTQjzPllYmkg3wFDnl1iQjmjeVerlqMqhYd6Hpu
         d1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=m7KtlTRQ/940R7kWNpP3Vz5Bs4+fmR2cZz2mXb6ruwc=;
        b=7bi7HPFa2msrnPfOtLmQUvzT0hZGpDmEqWzZrr+wmxb0A0fjqLpbVIIXTi4qKUF0Oh
         UJY7VGQQK0zAIE2XLwkQaAiegmc/IgpwXDPMBm+nsKLZfqSnt+/XbvdNRUBFm6XmcWpA
         0/DyMfa+DGGY6af3yqbtPpO82oWtTCYLLU50cg8UPhrYMY2mwxLzVoG+MFOZ6QPhCE2S
         0nC6hkessxdLZ6orteXe/GhlbqudZDCy0pv3MXtuFa8N9InsWrr+kQWfep/ocRy06SlH
         /9n6NdnyR1Snn+2bbqibUWse5Oa1I8jOGGX52YbZ5Ark6ksI86ZXfKBacz6UGQ02EZ8D
         1RfQ==
X-Gm-Message-State: ACrzQf3ot1hnqwAgKdoSI5GF2uYLOqcOMtmPipA77sQz7T7I9NzJu6OT
        kCGtWHXG/MMxNKJRicwM8xSbEFfd2KBhD/c3v0g=
X-Google-Smtp-Source: AMsMyM6z51yFXoEklRool/IqRRMiGtlU3wa3BoMhOtLoHawAZv7ySC98Y2CXOkjdMuUTD+uAtdX7/C5OuhlEU68beUc=
X-Received: by 2002:a9d:7d81:0:b0:655:d419:54f1 with SMTP id
 j1-20020a9d7d81000000b00655d41954f1mr6734330otn.177.1664051156968; Sat, 24
 Sep 2022 13:25:56 -0700 (PDT)
MIME-Version: 1.0
Sender: anitaabdallae2017@gmail.com
Received: by 2002:a05:6820:1620:0:0:0:0 with HTTP; Sat, 24 Sep 2022 13:25:56
 -0700 (PDT)
From:   Monica Karim <monicakarima38@gmail.com>
Date:   Sat, 24 Sep 2022 21:25:56 +0100
X-Google-Sender-Auth: M8R9IfuH1a2dr9wfueHCFNfAvTw
Message-ID: <CALrj+s9ER815OAHKR8TATZJFKZPk15BNbVkG40UbsBtgKK9M4Q@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

How are you? I am Monica a Nurse from Netherlands .What about you?I
need to discuss very important thing with you.
