Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470761893C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 02:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgCRBnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 21:43:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33614 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRBnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:43:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id d22so19441684qtn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0b5WLsdgfiR/hAFOY1sB2eFKdHn+83f5OZv1AD8it0=;
        b=qgSndENZddrIR2I4cydy7JaMW73b0CxPToIjxG1ZE0TTzbN2xWQkQgAB/xpbnei++o
         8+ebYrUn4HIId2ID/7hF/AT+Py0Cc51GHAs1RWc1vIiTAdFv8daz1CDkgCdfuRTLAEJJ
         vSbTLizg2KByfTFCtEKLzEypie6jjTJfLM3jP7Y8Cafouwlpj7hsDhIZCqGGCaMmccqU
         uJGQ+Xaj1pDqnqXaCVL8fQiVRKzSrFa50cCMrZuLfYEOuyvk5B6cYrQDbc4pqZniw/G7
         bflk1ORZkn5pn4F5zVGX1og+bhSnpOoc/FHNp8IKXCqmP21ru52ngcV3/jJRP7h3Pbek
         BNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0b5WLsdgfiR/hAFOY1sB2eFKdHn+83f5OZv1AD8it0=;
        b=Y2+4bJsdKZepTKvccoOMlE2Tgm4SDR21a1KnAn0QStl6ZBEV3OizZn9L5fdYnvcq/K
         dpDW1dU0c/IOVfG/Pd90su1yX1iBMY2ZZFDag9TSst4HwxBgft1QIb1uG2/TNUtozoiS
         0IBcvyw+GQpTduReXWABqvipZs/mmeT+G1lWc/kTbwhEMW/jS9LDzx88JtiXnBZDz7nm
         IoZVP6tr6AqDhxvqakk9vHHoTewTU9MmEV4ItyAxhhV+mgY5CMrVSB4/SmHSLUsC+mRG
         +XEzlbYv8I0QgiFOn47uf9NMN6k8Rtf27HMUJWP/QY7xQYkrwitDOPn/LqkMCaBx8occ
         6CBA==
X-Gm-Message-State: ANhLgQ2oUyXvN+wCZ45LbzGgdaAMXc3RrSRp8h/PjDSQYV9qyruf91Ox
        wLzoPaD4203bkYbwEeZEwfxD8A==
X-Google-Smtp-Source: ADFU+vt4qdtqYNp0md5miZ5EokE2sD2apk116S3hvJDV9bEIEBdSJqnmsCcM5zkMCg2rdg2MlKSUKA==
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr2212557qtd.268.1584495786865;
        Tue, 17 Mar 2020 18:43:06 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id m1sm3740883qtm.22.2020.03.17.18.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:43:06 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH 0/2] xarrary: Fix warnings reported by checkpatch
Date:   Tue, 17 Mar 2020 22:43:01 -0300
Message-Id: <cover.1584494902.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series fixes checkpatch warnings in xarray.h:

 * Add identifier names for function definition arguments;
 * Add missing blank line after declaration;

Vitor Massaru Iha (2):
  xarray: Add identifier names for function definition arguments
  xarray: Add missing blank line after declaration

 include/linux/xarray.h | 88 +++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

-- 
2.21.1

