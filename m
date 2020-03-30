Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5836197C9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgC3NPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 09:15:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46153 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgC3NPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:15:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so21495862wru.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2020 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZQnIrBoKCgs92w3hNfMCsInikuP/bVMcMVhva4azg=;
        b=uvhF8YAYlaWcb+Y+7upihHc8bDD/FpGMOeawBave0BhPERJH5qtiMwvv9QzfUuByC5
         RXZjIrD8OFm32S6i65UVrrq8kTZ1xDt79rxiS1PU9R78mBjqE9IS2XS7G34GiindmcZ1
         0p2aiRYVc9SG7Ifj/TTZqZvz++BLZkIXz6CDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZQnIrBoKCgs92w3hNfMCsInikuP/bVMcMVhva4azg=;
        b=kNW1HMkth8p3Op2ihTMaxI+CTO0Xx6QMROwrSe1ZqsGUVfVPL25EDo4vV+YX27KYpc
         g0WYcQ79pkOMxDMJzlPqym3mj1pJ4gpL0lpAnDtEsK4ORQ5vdJ7u91EPhZlW0uCpwO4t
         BgB78m4Ui1/lP3cpWNcrFWfgC5zm8AEC/oM/kkDsgXLlcjK9XBoZ7eX+dEj6hmEdl3id
         TEZH3aQVTzzdopMAOxRmkuTk4nbqCSZe5kSsiIco0PP4hAEqbcGzHtyhv8j3RCtboPDB
         T0Q2LOkw4s4TyEVW2PVTysqtsFwhYsgxzWU3tmV3j9hnLkfwI7hVQfztDEuA18XAVV7g
         4Ijg==
X-Gm-Message-State: ANhLgQ2gTf4wGJe04wc3HMRH1V+v5a+H6il796ORlzyUZPXTnjqyhw8h
        MAhwlFF0aH7yOAY1RM/kq6GrIA==
X-Google-Smtp-Source: ADFU+vt5jI1y1/93TjThJ3hiaNjyt/yfegQ0yf9I3Lm/dg7PTPfNSBO5dV7JehIJW2ukxFJRU316wg==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr15376642wrn.144.1585574120836;
        Mon, 30 Mar 2020 06:15:20 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id f14sm21135398wmb.3.2020.03.30.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:15:20 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH 0/1] an option to place initramfs in a leaf tmpfs instead of rootfs
Date:   Mon, 30 Mar 2020 14:14:38 +0100
Message-Id: <20200330131439.2405-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reposting [1] with a more verbose commit description

[1]: https://lore.kernel.org/linux-fsdevel/20200305193511.28621-1-ignat@cloudflare.com/

Ignat Korchagin (1):
  mnt: add support for non-rootfs initramfs

 fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.20.1

