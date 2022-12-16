Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDE64E5AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiLPBgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 20:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPBgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:36:51 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D843862
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 17:36:50 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b48b139b46so14326707b3.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 17:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3j6IemJNFtv64Re31+0lccJ4egbtGN/aOrC7Lh6BALY=;
        b=Vau5FMHKVZF2WUhCHt6uc+gU7tEE0JiHAVkkuHiBz6tfDEjsFM9uOiPEuPlRPLJyIl
         SBxxsvzbrjvCO4hcAwiEJWdx+RbqRL6RCbcanhBRZjQDOo+ukMqgBew2einb/5dk/ukE
         S7NzSlvOKk+sO9wGGqNogzKYg+1qI11PlQKC5pQ0SYB9GTqxobEBexl7oEIDHy2LmChB
         +01wbeHop48a5bavn1wYKTF9C1mOQ9BOGcuX9OwX3pIvwtQEpc+tRoAkQ6b6cvqj7UeF
         +Z3OktJnbo9+lxkQRs74X33AWxQM5n0G2jBrLlFGTK6VolQed+QHL74TCz+6tbh6tM5m
         GRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3j6IemJNFtv64Re31+0lccJ4egbtGN/aOrC7Lh6BALY=;
        b=XNMA7yXDWtQWa3uYubSdlUQ+MbWhuKbKBI5L1MHF07v54OD0P9+wNkXOCO2kaCKKed
         eGkWbsARoVPM5Ud3Hw7NCe2JxUIYEvpFQ3Q53U33E/eIn3gVPrDNhiidtw0dIrD030Us
         J6GUD5ckfQKCi148vf9ZPc8O1CczSiC/KpSjU1ZvlTjXm/KMBER6FxtxZFQg+LUN2Ch5
         OF/JzHWAi5mEfnDSyIWO5njyX8TnsGYWX+R/JKf77FvFlVFg4YaaoSsHsuD6bw++BJT7
         ByprKrhm1DAdB0fIg7/t0vCMl+7ChgfF9jttffh9aitkEQb6NXqfuxmqBtnCXQ66v/kw
         G5xg==
X-Gm-Message-State: ANoB5pkPxPpWot9xvLUqs0PzF4PjdS0KVQ9M3riJyblrQg2fvjZ9ydR/
        FyP+Rd0q/waDZxuLxRX2LoSlQomV1tcChJMJdSc=
X-Google-Smtp-Source: AA0mqf4ROYkj0LR7631e8plnEQ2wB3HwsQbowt0tlp5eWaC0PRaoM2uoFdo5oJrEtUu2mZAuW2P4e+0I+ETWld9+pS8=
X-Received: by 2002:a81:951:0:b0:352:5ccb:2273 with SMTP id
 78-20020a810951000000b003525ccb2273mr28281681ywj.315.1671154609724; Thu, 15
 Dec 2022 17:36:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:504a:b0:250:fd85:e71a with HTTP; Thu, 15 Dec 2022
 17:36:49 -0800 (PST)
Reply-To: michelgbagbola@aol.com
From:   Michel Gbagbo <kingballer895@gmail.com>
Date:   Thu, 15 Dec 2022 17:36:49 -0800
Message-ID: <CAAOGKMQuC9-h_MvHtCxEg+XdVX+6YEwoo0OQARdpY+8fJRLn6w@mail.gmail.com>
Subject: Communication
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi
I would like to have an important discussion with you. It=E2=80=99s private
and Urgent for more details, please kindly Contacts me on my
email:(michelgbagbola@aol.com). Michel Gbagbo Laurent. Thanks
