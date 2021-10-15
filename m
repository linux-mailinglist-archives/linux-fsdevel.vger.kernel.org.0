Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0542EF30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhJOK61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 06:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhJOK60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:58:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12E8C061753
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 03:56:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u21so36780939lff.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7+SfLV/gGuCk+NKYPgbulTG/eW9OW7URIc6MmhKWJDE=;
        b=Z20Ybvpa72eX8BAMBDhZWdAfkMk+ZNx6Fz9HK1qkls7f0CGNbza2ClY6i1xj24grD3
         XQ+doi7DVPfXWDicpy/K6ldrgOz9C14pTF01Wtr7fw2L1ChAKw4i/Lj/MDhNaiMcKPtv
         z3Vdxbi+p53ssiht0O8ELoEsAyJwqOMoXV/ojn+Wicsq0PUpf0qz90OBuqx+NmNsdboP
         sg2qvYKwLlqVolTYOAZJBFcKEIVB+UC/Onyzm+jhjgsQMqhSfQL5Gtx/UxntKIWlPIIC
         nFHMuO4M/0xPKVqaZV+ZHxNmlt9deBuF0etHvSsZregzdxg6aNhE7W2YizE10b0IDw9y
         DPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=7+SfLV/gGuCk+NKYPgbulTG/eW9OW7URIc6MmhKWJDE=;
        b=sj5NLoB3mF78fbaYzcUHKMlyEYl5uOwUXoYTRiXtg4Z0sIeqOzOOxy3prPR/VraQ+N
         qXeOx2CwVSRu8EBhzfME+Apn8ZeSM8P3lh9aq3PPiIcbN2OveHuT2ULfxFQMCDHQK+sQ
         BfNU57oILAsLrsBWwl+tD5xWPGp9kjYPLbqD6dlfyZ1ygrr2XLUHDPXOZl0yhqbUs6VP
         LF4l6LQx2HKGre1ef4KXeRpnrJamfor09E/x0RaOss+OXJRd9ZdpBfGKqu/K6Casho0M
         2tPNPemQJ0CRbvzkVZ572fNmCApLY4ztZZ4qN6sgz5QpLny3MB4eQckgf6a9tkEWNj+K
         KpCQ==
X-Gm-Message-State: AOAM533D8WMnXJcirZ6qvP/rlLSwaJ9kYgZAwO44usRJpIBrgLFy4XCZ
        vbmYQRy/8JRWM98wLxQ/lW4efUYLIm1EohzUdVM=
X-Google-Smtp-Source: ABdhPJysKb4fgYKrxFT7Q4blcpn+X/lQKoHHzgdPpY9et2D9enhrq4f/Ui4UI5CfrhsJvQTZdfOSOtg61VOUf4Dp+Vc=
X-Received: by 2002:ac2:54a4:: with SMTP id w4mr10779909lfk.534.1634295378420;
 Fri, 15 Oct 2021 03:56:18 -0700 (PDT)
MIME-Version: 1.0
Sender: amuvalentin@gmail.com
Received: by 2002:a05:6504:3c4:0:0:0:0 with HTTP; Fri, 15 Oct 2021 03:56:18
 -0700 (PDT)
From:   David <Nguyenrose247@gmail.com>
Date:   Fri, 15 Oct 2021 11:56:18 +0100
X-Google-Sender-Auth: _ndOXB3x4IiXegM3nGryiJWqyA4
Message-ID: <CALoTmgeA3k4dZGZujs=VvZ0Su-KOnumSqCx+ZsrfRvVYyZ2X0g@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SEksDQpHb29kIGRheS4NCktpbmRseSBjb25maXJtIHRvIG1lIGlmIHRoaXMgaXMgeW91ciBjb3Jy
ZWN0IGVtYWlsIEFkZHJlc3MgYW5kIGdldA0KYmFjayB0byBtZSBmb3Igb3VyIGludGVyZXN0Lg0K
U2luY2VyZWx5LA0KRGF2aWRzDQoNCg0K7JWI64WV7ZWY7IS47JqULA0K7JWI64WV7ZWY7IS47JqU
Lg0K7J206rKD7J20IOq3gO2VmOydmCDsnbTrqZTsnbwg7KO87IaM6rCAIOygle2Zle2VnOyngCDt
mZXsnbjtlZjqs6Ag7Jqw66as7J2YIOq0gOyLrOydhCDsnITtlbQg7KCA7JeQ6rKMIO2ajOyLoO2V
tCDso7zsi63si5zsmKQuDQrqsJDsgqztlanri4jri6QsDQrrjbDsnbTruZcNCg==
