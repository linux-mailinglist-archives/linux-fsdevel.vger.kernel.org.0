Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEF202207
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFTHDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFTHDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:03:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737EC06174E
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 00:02:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id i27so13888966ljb.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=B0NiHxxw0OAeqHRJ/ePPAB9LciJUzcScd6r6BcMvOVM=;
        b=D7HPMzcb/G5roakHUCqBtgtmtwcFpQIIEW0q12FYUI6qC9o3+RiJA70x4TFMPFDnkF
         259cdeULsysaKjC0mEfN6q/ap90vs42tLTRXiuaJPxoBkBe+cXewLkrmPynyKzDjgj4G
         Tw8K0rGvrEnf2Lf8Azcu2B4/lukCduDmZ3KBLfonOEoAnZrEvgCnboLTXc8X0AGDIpoU
         AmPPs4gJpVudG6MIib4Ui8/uP5vqxZhtj+1FoSpHEPiDVbxH/WE0aXovTNyhnxC9eESk
         R+fDQsXf+aD9UP05Xd/OvS+XACXNo87eQZ9GQD3BvRtth8RBsjebLU1YHXS1hu0Ao9iv
         orbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B0NiHxxw0OAeqHRJ/ePPAB9LciJUzcScd6r6BcMvOVM=;
        b=Ek79HXC1GKUrxZspinHXx61hQLar+W2POepi323S0a4or0+ykjAQ4rLLz1b4GdWAZH
         6gNfpAv42XbGDuJChfVfv+uhESUlBJBQbKtUSJFw/Ft5uLUkqPPtsRvSOOmGGFBkUmjb
         k5P8XGV1GaoID2tYBwV3q1Pf8zLbbN8x3VL9/FB0ZI9QeO2g7APbzykdfX5v/CwQ0b8a
         O/K/1E85bHE6JH8Dqqm5BvtyHZrLV4jO+Z6cmLlHMsar7rQFjTD612tQLUWbZCAfaq7g
         XrfrzGAlBHykYZGJvDlDA6Je6RX0NbRKi1b8cCF5xkyU00j+9nW82/4nCF8wauZBLdL9
         m0pA==
X-Gm-Message-State: AOAM533ezMaoMaDEyGdy8/mq6CLN5QJVfeVWz51haj61S9NJnzHnDDp9
        R/jz0hBCxiTMJfJn5/4qCCY3cpPaPICy+wBYwaxm8Kxu
X-Google-Smtp-Source: ABdhPJwWHsaMzTyvF4w+CxF+O5OxuBz9icYR5veObX1qDFtsWTTrc4jjONNXE2FeVy4Hj4rM/HXqi4q+kI0bd2QsBks=
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr3498433ljj.404.1592636576903;
 Sat, 20 Jun 2020 00:02:56 -0700 (PDT)
MIME-Version: 1.0
From:   lampahome <pahome.chen@mirlab.org>
Date:   Sat, 20 Jun 2020 15:02:43 +0800
Message-ID: <CAB3eZfvNYXyyWVan9qSSe92FY1SXcS9xnUJpmB1-sHttYANb6g@mail.gmail.com>
Subject: Any source to know f2fs IO behavior or flowchart?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I read about f2fs thesis and know a basic concept.

But it didn't write about read/write behavior detaily in thesis, is
there any good source to learn about the deep knowledge?
