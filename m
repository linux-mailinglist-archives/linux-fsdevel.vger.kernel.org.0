Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8840721050A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGAH3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGAH3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:29:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0EC061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2020 00:29:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n26so9490781ejx.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=yKBymbnEVYaJ+BpP1tl1mFyUc1PplNpwA8h+JDr8C4Y=;
        b=BFns64B7WGypbIvNoaxR3S3WoJBql/qPx0o2JPCsXj3jxFilnzqV4zGcGuThE4aS2m
         +R014aP8myYqseQ0K3tg2tFEhIPxx7ocpky4pEpxIK4QxDUtv/wYOPE62SlqNHpctHCO
         /2aU9vt28t3Oydba1PBwFngjjx+iSFwlJ3oCIyzSHOcx64YXpCUE0edOClvs1DNC091L
         dvsxARV8gam5anevYnq75sxkfdXmkj9HbFEB485RRegN99MDKy2z977GkQtHAZyCT0R4
         pdawrelJIIYF1ywDycMv0zZiJxfNdFigN7dc/VYGIA7qqf1eD6W5xNv2xHTgttM1a7EE
         sJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yKBymbnEVYaJ+BpP1tl1mFyUc1PplNpwA8h+JDr8C4Y=;
        b=nl4hM2SYg1NwYQt4cgSrB6Z4nLHVNo6qb6Lnkw+VsqdVcVyx6TH2Rs6D9Hc8rtMyRA
         gCwsQanXqi/uHf88DZLSyzPMBIP9PBVvp6qZ8yzI2KYsGSEesT7PeunnvQCS7jOPHhYr
         i84T76fEhAuen43WKtjhIZ9ln0Av/GREphpCYoBlt/pdpQExYh61XECNz5iwPHlbNYFK
         /Qrhr7i7wmjN+yFViz3nVofhfJzr5wtsW1lZv4NvfF7LzDvAnTrxlO6KCBt34c7qqXjL
         d4lE5FeyAqNcwDF32TUzQ5NHzDiyUFGieCkntcciHbuZQEe8DRGf+Ker72GyDMA0fawB
         nESQ==
X-Gm-Message-State: AOAM530uqaYYDCJJyD9Fbcq2wXcd1K0Y6hDcNO86zfMpLCoGfRN8MX4b
        AsVDwK9PT4OjYs13lbxCDLHk8G/zT02si0y8XjL4nHzV
X-Google-Smtp-Source: ABdhPJyg6Xczws14o+ifS7M/7EXe3erwzDbFRUWuXDTMbjcaE/T/l+FzkLsctKWiqrjK0mQTh1G2YGmrjm/Qh9e1FJw=
X-Received: by 2002:a17:906:5006:: with SMTP id s6mr21094963ejj.294.1593588592802;
 Wed, 01 Jul 2020 00:29:52 -0700 (PDT)
MIME-Version: 1.0
From:   lampahome <pahome.chen@mirlab.org>
Date:   Wed, 1 Jul 2020 15:29:41 +0800
Message-ID: <CAB3eZfsO0ZN_79oaFpooJ32WNZwwyaS4GBb+W6jR=buU-VczAA@mail.gmail.com>
Subject: Any tools of f2fs to inspect infos?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As title

Any tools of f2fs to inspect like allocated segments, hot/warm/cold
ratio, or gc is running?

thx
