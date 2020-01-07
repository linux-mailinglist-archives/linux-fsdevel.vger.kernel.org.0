Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57D8132C62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgAGRAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:00:38 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:34840 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGRAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:00:37 -0500
Received: by mail-il1-f171.google.com with SMTP id g12so198738ild.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe+m8T3k8jYH/7kscAp0JIlhgE2YMV0mW5WuY1zrAhI=;
        b=a7k6fW/w7ITvAmrKffOoRBqw+4FugQSOJR5+eOUnR6gNZ6/TJKozNu04D+6qlUIRrW
         M+xG0kyZSJJIvcifzsNnD+TAvO0KScjpulU4dL2SeZyGTxks9iK1ZrvWqJ6BbiranF+d
         QPkcjGBkBBJ976NX7X2KNiO9SttQFiEf1HHyytbrGkmFYwJA+ANaR3PMG6U61ifv3YTm
         qJ+HHxIHBPlpVnzZVd2j9TUroERYqpn2SSCC/St+WvtfvufVLS7Sax3pUJn20c5dLlUx
         ucrUcnYojAJD/kCBCufBzTHar0pwGuKgM/N0YM1oUmfgR+JGVyljQDa9BNZBL0UTUY6j
         NL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe+m8T3k8jYH/7kscAp0JIlhgE2YMV0mW5WuY1zrAhI=;
        b=Y5ucReGB7MmDYd98u27qOq6xqXaF/024lBZikNmFRAhxH1gGVALG9/RUVaL45OSM0Q
         ONowXk0p3nJ93JmEH4Vr+HukQEdYXIOx1t5OHvodxdWP5O9n+n+mbbctihVHjBDuaZ6Z
         EyiPoGuGlTTSB1ogXGUN+lDGxRYt6Vcy4SDrskeXiKhF3yeqxYgpUmXIHM1nUG9nV2mN
         Sya+Ljvq3p9ip9cMsCAJHA3CdJwDSwWfo+jau5yVuHVr33gwXVA4oq2Pcd23JdO45zOB
         eqOa4NfAZvXHUDI6h4axvBTOy3GuUqCmAWXsx3AMJnafgBiNepb1urATQGTji+Z49Iui
         KPCQ==
X-Gm-Message-State: APjAAAV61/xucdHRDCTOtoDHe96zhrCKdE7FxqRm7xxL6yeyo78GSfdh
        vMN6ad6vP6rAylz1o9hpqrzsuw==
X-Google-Smtp-Source: APXvYqwiDh4VEVA9Y8Fa7FseSW0gACVyp+MWuNAWVvILMQYdCXAyK6EBVTLsPkweX02ZDkmdKmBdPw==
X-Received: by 2002:a92:afc5:: with SMTP id v66mr17764ill.123.1578416436985;
        Tue, 07 Jan 2020 09:00:36 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm42547iln.81.2020.01.07.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:00:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET v2 0/6] io_uring: add support for open/close
Date:   Tue,  7 Jan 2020 10:00:28 -0700
Message-Id: <20200107170034.16165-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sending this out separately, as I rebased it on top of the work.openat2
branch from Al to resolve some of the conflicts with the differences in
how open flags are built.

Al, you had objections on patch 1 in this series. Are you fine with this
version?

-- 
Jens Axboe


