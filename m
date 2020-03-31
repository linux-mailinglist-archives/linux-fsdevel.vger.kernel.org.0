Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A151996B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgCaMkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 08:40:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43805 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgCaMkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:40:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id m11so19854663wrx.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlAnJrkXBGo8I/5PAoNTQvXp1pi40LxDq4eq+SGwqso=;
        b=oV5P06MkBvSrkOT1Aqm/1/YGzWCZRXO78xWc0mNjAoqJ2XAqKXqb3XRPK5hYLreV0p
         XltrDEzuffcHj1sCwWaAVXqTU9YDvMrkNwdRIwa8/R3w7k8fi9c50WAiXPvQPDFdywt4
         Z1A/mphHcYpIrgbtdOlDPFZVQ56TL5Bz+is50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlAnJrkXBGo8I/5PAoNTQvXp1pi40LxDq4eq+SGwqso=;
        b=r6ZJXjiQYEZx/5Evy07Uz4PUtWAKnHJNRMUNQ39mR7PB+mkOHg8zGykwPdDaqZEKA0
         IHjBMSeiHuvEg3AZY5r71C27O9V3qgwnQp+e13PhAVeIayyniw8OdEETZQ0z3TUYOydn
         5hzrspLXvy9hWUwoNAC6Ky+DbnJQG/bYZ4kmGvvHPlVtAcwQ2M4dIltzcHSTmBfPpiQ1
         UpS/6tB5V8u3iokSgmG8EF+mBjjapOFMoWhGkcONa7EResLEY+MimUVSGwiLSr2WNiEt
         8ITh9u/7OlIRD8Dqauh1MA1O9Jt7SeJdi7VNo2KZoO/uobQlhIZwzh6NULxh8wD4FVR1
         UcLQ==
X-Gm-Message-State: ANhLgQ2RoVTCJmVAmYOHwO+xolslXMZZHEZtG26/6WFTTMv5nRikLZ8r
        bTApnPjPArh7OONjGq7n6S2yqA==
X-Google-Smtp-Source: ADFU+vsmRSLCggUdju+RKpUVxA9QIxOsOjyjEAu75BiSJSVqcvKDhC96dQo/67fXjZRLX7J7UDLTcw==
X-Received: by 2002:adf:e492:: with SMTP id i18mr19970031wrm.316.1585658430816;
        Tue, 31 Mar 2020 05:40:30 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id w66sm3819159wma.38.2020.03.31.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:40:30 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 0/1] an option to place initramfs in a leaf tmpfs instead of rootfs
Date:   Tue, 31 Mar 2020 13:40:16 +0100
Message-Id: <20200331124017.2252-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reposting [1] with a more verbose commit description.
Changes from v1:
  * document the flag in kernel-parameters.txt

[1]: https://lore.kernel.org/linux-fsdevel/20200305193511.28621-1-ignat@cloudflare.com/

Ignat Korchagin (1):
  mnt: add support for non-rootfs initramfs

 .../admin-guide/kernel-parameters.txt         |  9 +++-
 fs/namespace.c                                | 47 +++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.20.1

