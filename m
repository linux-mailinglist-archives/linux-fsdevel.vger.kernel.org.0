Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996681DF0B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgEVUqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbgEVUqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 16:46:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9843C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:45:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z13so4587385ljn.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to;
        bh=8TIR1sWB9SP8MtV0Ys5NEARNHcsS3krU7oTDfLaPI0I=;
        b=aTnudMlZ9lJ0isnLRmHEv1+iZIz9zf9W7WSFkz3hDVVkaDRnGr4cGZtl+Sg7IAuGXz
         /r+uMubpbiXCV8n0dKu7Tc5otZl/nzjSzcaEBbQuZA3o8YhK2v0h2ANSkZ0IcG/nDIWu
         4w0k+0kKZhYtIlYwbufsHyni0Fug8lnxT9bL+lMfgzFFB63MXLmVofsZtkOD0pbg8zvd
         8qr1e1Kt3YkDFILauIZDPGz+rTdynvXObUMhhy9U6ZVc51Z04wq/iLJFm28bDQiRpzWo
         r6o7T4UrHVhvHq1C1GPe8eGpROksDNtphrAEOs/mGkJVg3nLhl34zbxPpgqOLMFdIli+
         e5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to;
        bh=8TIR1sWB9SP8MtV0Ys5NEARNHcsS3krU7oTDfLaPI0I=;
        b=FZ9/t1d3t5M45XMqQG44pjO8nS98EfuAUQuvz9Bb2tjj4freI1pcAMUlDifp/0QQBv
         7n5LgvzIaBmHidLKL2JoxHQB7J8gcGko6QVRaq6TFd78Ne0sZBLcjtVeUZ/1MFUhDl+B
         UPX34tFE9Hhk7CcUmxN4aXxACScVmU4ufoL08VxHADtJeXG9f78DIJsYb2BJIbidOlmS
         9+U/wDWbhqdu+ABkX7qGW9iwFebTNPS5Dl0+8pcaBZ00KC3hwjFRvc7KMs3V/fRt7f7Q
         9T1QHagAlcYXd3K6Xbl1q1Mj2g4QroOXoa2jDCRZxHpSTKn0Ofxo/7kVwl+kpLu2sTAZ
         VcaA==
X-Gm-Message-State: AOAM531rqfKrgtthjTMlFRhC8r3M96hjqbxJFOKPMwsszLkZcc5Sp7hc
        vwhXjQYp4rILdA3Olz6cqb8=
X-Google-Smtp-Source: ABdhPJwbZtk5yGaOuo3RXg+Y6d8FEf6ExWBwkE8gswsVjaWhr4dQPaRxlafEsv6ZpsGFifoLe+XkaA==
X-Received: by 2002:a2e:9510:: with SMTP id f16mr8886371ljh.111.1590180354101;
        Fri, 22 May 2020 13:45:54 -0700 (PDT)
Received: from [192.168.1.101] ([196.171.6.27])
        by smtp.gmail.com with ESMTPSA id x28sm2524962ljd.53.2020.05.22.13.45.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 May 2020 13:45:53 -0700 (PDT)
Message-ID: <5ec83a01.1c69fb81.ef070.9996@mx.google.com>
Date:   Fri, 22 May 2020 13:45:53 -0700 (PDT)
From:   "Miss. Amanda Williamson" <gen.amandawilliamson2020@gmail.com>
X-Google-Original-From: "Miss. Amanda Williamson" <patricia009me@gmail.com
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: BE MY FRIEND
To:     Recipients <patricia009me@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
Date: Fri, 22 May 2020 18:46:41 -0200
Reply-To: gen.amandawilliamson2020@gmail.com  


Hello dear

There=E2=80=99s something special about meeting someone for the first time.=
 have i told you how special you are and ofcourse you could be that special=
 person for me. my name is Laura Kareem

Write me
