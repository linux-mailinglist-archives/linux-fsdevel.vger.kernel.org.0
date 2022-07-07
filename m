Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1EA56A5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 16:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiGGOn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiGGOn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:43:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BD261D
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 07:43:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r2so2327741qtx.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=PcivzpIKykDrdH/u5ZxTPbgLMbnsINgsgP1LBrEhQFXUv0uwlr3WMQh27q73ZoQ6tE
         jVu2b2J/sM3RzEayH0pVfDlihpsqk28TbqIDLZO4wGMq+V7aot56eET9QWki2xLcUIZZ
         78OwtQuO65peV378q/qHSWfQ2Q/raV/4N2XnZ7hEnTra9A6nu4TAYVNvXqLQgiMTi/a2
         s0BYANzgskc4Z9vxEbljTNb6d6mRXn8LTSol1IYdfgV0JoNjvbQ8AHtu2yQPJc4VcQr+
         zf6b8+ewJtLpP75OJRnfvjJ8kO5N9mSONg9FalCHbhncQ74stxHRgIsZN9X78GkzJuad
         b66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=zsaID9390MpjMLPu/0mWO28H73Sj+QzqXeYIvwnPygcENO0gQeogpy60a0N+ScaBrG
         4dZPRM0n36POtTg53K2d1zKFEx9AYROkLG8QQmlbPCvG8L43YWOrWiRTWLeGp5tgYc5L
         XlrIt7CTUdKbUUp32tVRa/HnRMJZqxAAEefOkh/lTVXE8+sfEOnqPxeQ9OWLWtn5GSEP
         3gXN+8cSGIdwXktXxEwNPzUwPuAzzzDhz+hCUs9E7WEHxtPdd53W1oHQs3MfE7ZT+jJG
         NEzRmBp9yvI4xgVFNsuEp3s4fcmD4TZJ+seO+knW+1bZ9J0u9B4jURWWk16jjhujTUYj
         BmZA==
X-Gm-Message-State: AJIora+gTsKLPPIEEwm+vKXmaNAZwH442R9ah9UvZthCAU/+TrsrzQDe
        9m9WE8LmSsUghFuuMqEjjGMWo+rXGuNAMNwPdIw=
X-Google-Smtp-Source: AGRyM1s5Hh5GMoFgpNxz8Yx8zr595KnTlyAADb4q/zo2tOcQAUlNg7MeaO3xwm4v2fFKez8lnn3Emexccun5UbGWe04=
X-Received: by 2002:a05:622a:50d:b0:31e:7dcd:891a with SMTP id
 l13-20020a05622a050d00b0031e7dcd891amr15432606qtx.427.1657205005008; Thu, 07
 Jul 2022 07:43:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:5a87:0:0:0:0:0 with HTTP; Thu, 7 Jul 2022 07:43:24 -0700 (PDT)
Reply-To: mohammedsaeeda619@gmail.com
From:   mohammed saeed <thomasrobert1559@gmail.com>
Date:   Thu, 7 Jul 2022 07:43:24 -0700
Message-ID: <CAH=smXyOzKjJO1QUvOw7=hN9N0e=FBG3faSMSAuqpqMz2pjA4w@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 2% ROI per annum. The terms are very flexible and
interesting.Kindly revert back if you have projects that needs funding
for further discussion and negotiation.

Thanks

investment officer
