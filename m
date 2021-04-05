Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6343546ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhDETGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 15:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDETGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:06:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D401C061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Apr 2021 12:06:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r14-20020a05600c35ceb029010fe0f81519so4598724wmq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Apr 2021 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=Zin/IPV7KWKUC0YXPQDB+PNcmXweBu1J9venza8R4CYFclZr/l7WPyNsJzl0ivhw6f
         G2tjsr9Jbn0NIZmDWmhFXCvCCpEBWSU/T2PhCNZDqRxOkH1Of8RQXi/ACCzSXfdXNWQC
         zzELUCEmGsXn739wUO0K3Gli/rRzuo1CHxIm7rS+BUx2V+bc24n6GrIZWuwV1ruXMOsU
         F3MBn5s726cJTGc5I3DLLKr5flZV+azs6dkOiF2M/3KYRf1KCqwCVK9tA9w8dXJGafEE
         8WzXZeOo6PuCxeGB1x7LPuUQpoSb2VrFkt/IbZhBLS9nYqwz5147EiuyiICo6XR+ZVoK
         0weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=mJe92R9RQvj3zFGEOuYgdlH1Kx67A4Ce2eCE6vR+irqRguLg5od80kxd85nQGDQxA3
         f/zN+z6iRBu+aa2UO32fevWtdQ79o5e6jpvYjLTPpjutaJ703LSHRVpgjW7RP6Hz/Vxp
         yYR3vwWJAGGn0gOoruswUNt1AC3+pJuBV2NyoRGeOvzxuqSS7XhTrIPUYRUpHEY8yKuh
         dynUlKNxd/QfgCyV5C7mxBxSvt0koC49ILO8B5A+3M65l7cdkdUqMwqp+RoJWIYXcDlm
         bUkD8n/bis8BH0bniWtniQ/aQJtkb8lLp9cOkfIap6OwyogJwIuqFYfskHuVeABoVoy5
         2xtw==
X-Gm-Message-State: AOAM531umUnZf2KisgaoXEiwzPMMDRQVMbPxFWOTSvBadv4zF+JS12d3
        +dlJjpLMuCqJ0cEuk7TMl4I=
X-Google-Smtp-Source: ABdhPJxl2dLXntXBOaciOX3zypjzXDPi2KODuWlURJju/OOiC3vRD+QBF7YVt7UMWuW3feYosPc0jA==
X-Received: by 2002:a1c:e245:: with SMTP id z66mr509005wmg.50.1617649567168;
        Mon, 05 Apr 2021 12:06:07 -0700 (PDT)
Received: from [192.168.1.152] ([102.64.185.200])
        by smtp.gmail.com with ESMTPSA id j26sm29384267wrh.57.2021.04.05.12.06.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 05 Apr 2021 12:06:06 -0700 (PDT)
Message-ID: <606b5f9e.1c69fb81.96d16.a09e@mx.google.com>
From:   Vanina curt <akoelekouevidjin95@gmail.com>
X-Google-Original-From: Vanina curt
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: HI,
To:     Recipients <Vanina@vger.kernel.org>
Date:   Mon, 05 Apr 2021 19:05:58 +0000
Reply-To: curtisvani9008@gmail.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

How are you? I'm Vanina. I picked interest in you and I would like to know =
more about you and establish relationship with you. i will wait for your re=
sponse. thank you.
