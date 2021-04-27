Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB28536C9AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhD0QpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhD0QpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:45:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA449C061574;
        Tue, 27 Apr 2021 09:44:26 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n22so5026587qtk.9;
        Tue, 27 Apr 2021 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKoSag9BO5O6gbYrBAuawuVvE4ni44ljfhfDsHdAXdI=;
        b=n+l3uZJ2tiuQ983aJ4y3I3pvSNgVLTDtFvzlqmmcR4qNO/dIeQ5P2nKd8hq4a7HFbR
         9BVqj9lzbeEuvq+ijNhHpltWdUjI7BZqRtUAedtE2StFAk2WlvE2sy4KqgiQZHQNnoR+
         joO9YxS2m+ATs8hS8PPeNjFKhkCbm6Ys/21QC1F73NRs8hF+GWMo3aLIePA3PzmrLGSp
         BbQWt6SVYnBxp/7ZGjpL9p8qY4Y6Ns8BxhxRQrrYBmP8EATRkTrrrY6BW/jVBfTjnnui
         Hm7L2PTM9qjW7ridUVL0hQF1SmnZgTTWo04ClgYCM/blGRo965xLpSL7YlCM7yz8sHn9
         g5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKoSag9BO5O6gbYrBAuawuVvE4ni44ljfhfDsHdAXdI=;
        b=P8sxMEltuPLFKDTtYxoRMEVsxFC/IVLfk5zcS0abozei2DWCxv2+iBo6LO1cDZq8fa
         yYpdHO4VX1Q+sXOecOaQzOYoDjwFa7S3x0Cp3EOT2Ql/6YN2IyqkCWZ5H/BWxMLnLUbB
         FaJhTynifpS1aVqfw3A0Q8VsMZniwBt5Ncp7v8cn9pbsx8fCqmj3v3e9qrrfi9tOhjhY
         iPtP9bk5Java/GNymEAj4qwhWik3xnyBQwoiRbqwFLvxX6CKWdZjpklaT75I2zhZ4gLU
         VCqgrbAehcu+sh6EC8lviHJd9kGfMhhoWK2n3mgHor5BcAd5e7e+E5sSCI3onx84o4yy
         VT4A==
X-Gm-Message-State: AOAM531TveYkT5s/mCJpFj3sEwP2fZ4GIHG3Yvw8quAhozGG3HTftrA6
        2LQiea1GRh0BcI+JMuyrEbZQUFpdHQ2c
X-Google-Smtp-Source: ABdhPJzyNm/cD4ACDfhP2Ld01/5Vn9Ek7JHHNNmBroSjKKAceoCH5K+Kwbim0QPPNKc6kC272Fm4PQ==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr22888494qtx.98.1619541866046;
        Tue, 27 Apr 2021 09:44:26 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l71sm3149163qke.27.2021.04.27.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:44:25 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 0/3] bcachefs support
Date:   Tue, 27 Apr 2021 12:44:16 -0400
Message-Id: <20210427164419.3729180-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A small patch adding bcachefs support, and two other patches for consideration:

Kent Overstreet (3):
  Initial bcachefs support
  Improved .gitignore
  Use --yes option to lvcreate

 .gitignore         |  3 +++
 common/attr        |  6 ++++++
 common/config      |  3 +++
 common/dmlogwrites |  7 +++++++
 common/quota       |  4 ++--
 common/rc          | 31 +++++++++++++++++++++++++++++++
 tests/generic/042  |  3 ++-
 tests/generic/081  |  2 +-
 tests/generic/108  |  2 +-
 tests/generic/425  |  3 +++
 tests/generic/441  |  2 +-
 tests/generic/482  | 27 ++++++++++++++++++++-------
 tests/generic/558  |  2 ++
 13 files changed, 82 insertions(+), 13 deletions(-)

-- 
2.31.1

