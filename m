Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062662BC9B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKVVtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKVVtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:49:04 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD9C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 13:49:04 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so15156386edl.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=YLXnENLXaAogqe9b3Hb38ouaX1qGTuRITv/MInbua1srCC2x7Cl6Z1vWjnLuNDqm1p
         BYoRehp8/1e8FrIyJ4rgiYHb8qsM5y6tRxcdHZgU9lLcPBtVvyOOsZJqyGhcDrqSaDI4
         b+TUc53lAkai+cDWkqJ3ypOb6LDlRazOpn4RcMWS1M7gGnv7TRAgXgxrlurs20i9LKzI
         F671gDAu5Cf1Y6mkfgAfWBPQBcfc/VjSczE/jJPN2Yi+3g/yWtZTBvHS4sQe8+E/hXQt
         9VxzrIu/+O6KXIZALJyO6dWuvvpQnK2USpMCpcmNjyIvRUqkw1YREMJfxY7u4oeEtyi/
         bUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=KWthtLFkqCUUP487bEpLBjjQGTfqEKTbqq1VY3K9nhE6+99gbgWyW3jSyoCddfgAfx
         aOxUMVBEUO+Mj9MsHx+RHwjDt75RjjnFOXC3e7+CUGq7Eu40fG9uAeHL2djO9FnhcBZs
         JLv1HVfagT2pckXfBegOpEjt4XSpWlnKe025aM8CUUHA1kBdrFlSaLcys0Wjf+iBpsxz
         v8HbTOwL0I/AP7EAUUaluntiJMrsgsp13w08IYGzemBQTL/aMm6oGac1L1Zf9miF9tUS
         tNZZGt2zCyYgjNU0qDBjP7X/+QzGnnjsA0U33//g6Dq5/6CxtsUMKaCnpeLMF8bfSVdo
         poXA==
X-Gm-Message-State: AOAM530eeMduUvTBPwGNigccYoK8u/aTBskHvdYWDer1PevQDCOxI4hB
        KwgpacGUM18hBU2BQlO4gnI=
X-Google-Smtp-Source: ABdhPJwUFtTe9ZCKn1TUZeEPtdaRQGprsVpl8OhhQfPkm6fe2d5suWN+lbGwG+nfB+fd3e2RsaEQTg==
X-Received: by 2002:a05:6402:1c0a:: with SMTP id ck10mr5813206edb.266.1606081742776;
        Sun, 22 Nov 2020 13:49:02 -0800 (PST)
Received: from [192.168.43.48] ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id e17sm4016232edc.45.2020.11.22.13.48.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2020 13:49:02 -0800 (PST)
Message-ID: <5fbadcce.1c69fb81.8dfc7.11b4@mx.google.com>
Sender: Baniko Diallo <banidiallo23@gmail.com>
From:   Adelina Zeuki <adelinazeuki@gmail.com>
X-Google-Original-From: "Adelina Zeuki" <  adelinazeuki@gmail.comm >
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello !!
To:     Recipients <adelinazeuki@gmail.comm>
Date:   Sun, 22 Nov 2020 21:48:51 +0000
Reply-To: adelinazeuki@gmail.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi dear,

Can i talk with you ?
