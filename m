Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0352508D1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380506AbiDTQYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 12:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356606AbiDTQX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:23:59 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABEA387A8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 09:21:12 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id z139so2055076vsz.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=Gt+3HEzk/xvBarhdpNribBGRdr6xq/6kFLKSufe8SEvSrTAFvfEo35Ki8UV6UJQkgG
         xbzkw235nT77WJGBbF/dVeO80wXSK7o63p/E6zpslV5o48LvKe6JxzNwSzVzML86vWzi
         sSQIjdr9wywVlzRTNQcWD75U5k1c8XAPeqbgQQCKdr8FlW3mknBwUqvJRMub8osCfl5w
         uI8Uq8BhO0sS5xvJ/9XNUtQ7UPKGaWmJ5n97WzWvQeioPfucuAwVNLl6GMxd3FE/sjiu
         my624c0ClaFD8gA70hnw8BFOyJFuYBYTgvar7Qld/tXc5rTl5KrI3QjN8fEhgPenC63k
         B3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=yTIL1ElbYrnC7rrOHeCv9rd7SPRZaKfhtRIo5J6Vr8+DrLeBWRsrivAIA/K5/LxUVT
         QLzmekjkwIkXbF/XXVgAmc67DQ/LpcOw0MusQWA+jXOutuaGwoecPVOvyPkbq35EOgNI
         ckvrDiEofqr5/Y/eHfIB0JCJ4Dc/aReFkbb7EkVisVGHI3ryvC8t3VT0CMnyep/kbKbm
         ujVmYC7nnca27KxVcVEQPNx6XW20bOfSYX6X4JIjBZv9LTJUwst2VB4CEy539Q4NMoit
         Xh6iGPN/XeSMa9i3035s9GUfIT8/NAzJEybSXwfOMsYdz4bVKrZeSZaW3oCb4ootlgo+
         KHkQ==
X-Gm-Message-State: AOAM530x/6aWaEBe66Hzyw5KCRkWXLMQGRvmZwcgC1qToWy/VRXcNtnI
        3PRcJQ/6zJxFmjX/QHzHob6y4C9p9YY34z+1inHXZrgZvXE=
X-Google-Smtp-Source: ABdhPJzkKhzHdR3rgPrZBzd6ssGfFbHF2I9wlLELrpt8ngqjZG6732W1c0pau5yDxvMEzXuypI+Ab/qkjjoYjvWqwHc=
X-Received: by 2002:a05:6122:118f:b0:348:f961:5814 with SMTP id
 x15-20020a056122118f00b00348f9615814mr6690781vkn.14.1650471660375; Wed, 20
 Apr 2022 09:21:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:c215:0:0:0:0:0 with HTTP; Wed, 20 Apr 2022 09:20:59
 -0700 (PDT)
Reply-To: mariam002musa@gmail.com
From:   "Miss. Mariam Musa" <mr.akpeprosper@gmail.com>
Date:   Wed, 20 Apr 2022 09:20:59 -0700
Message-ID: <CADZ5QHnxWLiDtVy3C1VOKME3DqG-AXFsJC-ejp=5bdcXf0p7Tg@mail.gmail.com>
Subject: Please I need your help my name is Mariam.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.akpeprosper[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good day,

Can I write you here? I have urgent information for you here, With
utmost good faith?, as you know that my country have been in deep
crisis due to the war,

Miss. Mariam Musa.
