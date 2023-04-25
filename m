Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C356EE81A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 21:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjDYTQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 15:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjDYTQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:16:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA813C28
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 12:16:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f3df30043so978421166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682450184; x=1685042184;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnKFL26C96VIgV6J+JP4Ljyq4pSmVr5ajTDLJ4C8iVQ=;
        b=AqwZ7OSMZLog3qGGpsBlXBUOiczpKZvSHve+rhm++l/798NXu2n0/2gufjv6jKoygI
         /zqG/eo1p9/Y+p38YQpEFzpWZW1iooCak7LQJlSv2O+F2N2UjDX1gatwDtUjwlBhfefE
         g2Fg/CjDjjgcsetvCM48P6k0xLyiQ8DZ0nB83GzcvsAFRY3VIWH2/rFkopWUKJfy7Iha
         xViIUEGSTeCs3mNd7497EihLNZsx94gkFmb6vIlI83aeoRbLO1Wc5Z8sbVmSgBRvqujV
         FnKeBmv0mtRnHlpsCpR24p0SEUTloEGz8EDymoEGhHUkJ8C2my/6629OkE/EJi+TBMQh
         cIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450184; x=1685042184;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnKFL26C96VIgV6J+JP4Ljyq4pSmVr5ajTDLJ4C8iVQ=;
        b=j1BO9ztKO8ezEuou71M4ENsvOSW8hCEboY5gqKBNA7QJ8+2/ZTk6HdhidRItrAacqq
         6tIrmNn3imYPhuJxaLbBLcEoQDUOsumZSsLAFZ63gOe4X1zfjTfi4XWfj6aUrI3g/841
         b7QYeNaKSa08IBnn5FC1ZgbtyvB/4LnRGJ+OqgGn3TFxw91rY8VP2wjBUHVAIJO5e78F
         l9GN0tzlHDX7FoHwEIDPrtQ9xM7aVAVH0AiA7Nbe2eFZD3Mbz/mz59zmEchfDEF432uB
         NWOTMJZ+yV+qGoojUeGoHQvyq1Pv/1UnPyJagkNJaoAyj/fmcBpgUxKV3xSeLTHjCdMe
         yHcg==
X-Gm-Message-State: AAQBX9ec29pqfjtkWCUTcxaZ93OHoYt2YRZraLM1Zs0AGxq3KGrtiTE+
        nNq031JfRHI+30Ncl+Q7kyCzXgoiLEPqLawiK6U=
X-Google-Smtp-Source: AKy350Y5V5U+kqSEmeE4/wcbrt9LiSgJFXXGjEwbpiOzCLlizN+d4W6KaK9f7qD65Me7MKA9+Vc67cPGONiCs0B4byI=
X-Received: by 2002:a17:906:34c8:b0:94f:2249:61d4 with SMTP id
 h8-20020a17090634c800b0094f224961d4mr14704304ejb.34.1682450183864; Tue, 25
 Apr 2023 12:16:23 -0700 (PDT)
MIME-Version: 1.0
Sender: munniralhassanmunniralhassan@gmail.com
Received: by 2002:a05:7208:c04f:b0:68:3a3f:3968 with HTTP; Tue, 25 Apr 2023
 12:16:23 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 25 Apr 2023 13:16:23 -0600
X-Google-Sender-Auth: cG4zKUgZzxjjHbGgrZF6EKMT0p4
Message-ID: <CALefQgPp1drfWu-ELiojkJJGwRbtbtaMj8W+r4s23KLFk1nOtw@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Regard
