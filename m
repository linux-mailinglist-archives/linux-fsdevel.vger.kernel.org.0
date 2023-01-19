Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44419674530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 22:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjASVpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 16:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjASVng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:43:36 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC66A502F
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:32:01 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 129so336835ybb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKQk9nowERhLzd/Vy4NQPgN5VFL7wDftfUE/OhOCZTc=;
        b=YBDmsUlH4GsLjjBcVXCr7sLPszB/R+EtWR+SKoRtYyM6vErTRczUol2G7oP0AGC8fR
         Q3m0l4mQ1aYaCoEaurRc02OwAgEzl/4zqIIfxMvR5E92f9IH+r8oPR0Yo6iaPPSdIDHg
         VnnY0JQcVNC8sScLxLR1GOMt+epBbjq4C07NRtkMStAk284GFRwAZlueIOcBxqxXsAHc
         CGTf7WKysEAFobu1Is8ChyeHf0JwkcwAKAPVfsaQdqKXn02pzdcjaAIfZJj3FEbnXuTU
         BBbK7IB29uB58Z07QZRiLYPKjKzr8y2hNzzEOh/CMvKv0ojCEwdQ6ECZENUtozrBJ3Dr
         lrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKQk9nowERhLzd/Vy4NQPgN5VFL7wDftfUE/OhOCZTc=;
        b=B92RC1q9+9C7Mo882XIdsW+jnZcjWb+GmZLBCOZa/jNODbXxqK6Ldx1y6SCRBY4KcQ
         E+E9rg/WGDT2s+fGKpzSdB8oNhpTBuRf4sityCQRZG+93evatVrPGrAJ8WZSNNx8K4GO
         uDg6kGE689ANQa7BYuY7mMa58tWtC1Dw9qn58A25XQuVrkBTmL3i87SCYAcEyFbtGdgZ
         pUqjPNhqak0ZltXKmN4HPSI0FZA7xB4AEz3I5xnC4g43ftwGdss0ffobzilPyzX5oKVi
         0kElVVgxYpmb7WiFaVGo6BWtuG5Wz5kAvyvB0ydX4MslCUF0oqVoxTRcysgXMmSY2RG/
         qpSQ==
X-Gm-Message-State: AFqh2kqLzKIeUrnmRilaA+EK1HOZ7zO5GTCZkegp0HyHAMMAm12vxmms
        kzGmx4p+Z8Gt7vW9EHN4AmBfbLsZfXNOcToOyy0=
X-Google-Smtp-Source: AMrXdXugQ6esxyjpSfTrfvRrLbK/EQEVqoyFdbYAvS8DflZmQZcmGvWlC+V4ZR45HxSOnzB+f1DRLJjxa8yD9nnbAXE=
X-Received: by 2002:a25:148b:0:b0:7d3:5998:e627 with SMTP id
 133-20020a25148b000000b007d35998e627mr1509382ybu.161.1674163917045; Thu, 19
 Jan 2023 13:31:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:3521:b0:418:24ef:5fef with HTTP; Thu, 19 Jan 2023
 13:31:56 -0800 (PST)
Reply-To: mrs.lorencegonzalez03@yahoo.com
From:   "Mrs.lorence gonzalez" <solankidivyesh123456789@gmail.com>
Date:   Thu, 19 Jan 2023 13:31:56 -0800
Message-ID: <CAK_f_JY_tm+Bvc3wwXyZq_F2gYOhrz9R4b2q=DeoMqGbA+RiPg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how
dealing with Gold Exportation. I Am from Us California
I have a charitable and unfufilment

project that am about to handover to you, if you are interested please
Reply, hope to hear from you.

Please Reply Me with my private Email for Faster Communication

mrs.lorencegonzalez03@yahoo.com

From  Mrs.lorence Gonzalez
