Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062CC5FEFA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJNOER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJNODp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:03:45 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A643306
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 07:02:45 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3573ed7cc15so47239407b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=H3tSqSVP/KWs4VJIPMxxXHRbAAqjUUkTUhdz1EwuOSnAON0G/CIkscOGeexrxPH4gR
         GoyTYsgNLIwpq7I/7X4SX6p225+tDJVS78xZeKAN7jHb2k6NQ9ctvQo+p//1OkQF1mvv
         c4vsHKM7pM/97axn82yiAXHnLhROkLHOQeVSoPSvrx5TS9be+rqPS3b/j9L3f8gifzK5
         25DXwsR9hjzQTF5ugd6rhhwpEOdLcA/owenjyYqMqES1gVSWmH1g/eCAf6gn3vPnsEUY
         5fvJzJ+ifT0e9btI03wxZQkYVIdzZkrzrQ4Z+p89luTjgyuzQFAJLln/h1z6E84m5Ghu
         svog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=dUK0J6bmXPmjCkI+lvWaSr3ePyeNLqZt6sZRdiYRgiYKoX5WxqFVLQqxdqBRHO/DMM
         6M4Gv7AY/RmUF0az0JNwS3ERPz+bU3IGPG8SBNH89jWm+3PBKRWoM2rJHf7LKcFtDhkh
         NXGHTsAz/oTUEgC8xdbgX7udIUEeDZNEgW55XX2XIGuIFc24mQlueppXV3DPMyl76irQ
         Z2eEFrlRh9Wce9GGhL5+XQdZcba0mZd7O7S3mipr1RnbnJmEE/ZrDXCz+TfOiMG5aqMA
         dO1Trd772x6jZWLDURtANlAfwzLMm+lJ1zKyO3MXJpvVFTy6ReiqrnvWZJglGQCuyDky
         +YYQ==
X-Gm-Message-State: ACrzQf1dcL8yRBiRqUUKcZUQnuj6EKm1a3IXtZ6R6aPuSl94YcxRbOr9
        lTz0OvVwe2KlZ98EjQBRX4NgtG77NlhFjTtggBtjiLuG7b0=
X-Google-Smtp-Source: AMsMyM7ZYSR4jYbZB6OIGQLGW7fPEIG2SNZ1I8TbLqhTWODf08GadQ+kfq/mJ73fQUj4334GxDVyzOGNtb/lqmFb1lU=
X-Received: by 2002:a81:9202:0:b0:35e:face:a087 with SMTP id
 j2-20020a819202000000b0035efacea087mr4707194ywg.55.1665756111299; Fri, 14 Oct
 2022 07:01:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:6c05:b0:3c1:5961:57b5 with HTTP; Fri, 14 Oct 2022
 07:01:50 -0700 (PDT)
Reply-To: tatianaarthur72@gmail.com
From:   "Mrs.Tatiana Arthur" <goowjarwq@gmail.com>
Date:   Fri, 14 Oct 2022 16:01:50 +0200
Message-ID: <CAC-x_XHBvNLc2SP-eHhjWUFbY=vQKMZv9nk6yhsEWwd3eTU-YA@mail.gmail.com>
Subject: Did you receive the email I sent you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


