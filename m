Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0644DB41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhKKRv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhKKRvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:51:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53761C061767
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 09:48:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n29so11096343wra.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CuWEymX5xt6zjmYESOk0bUe+rAc8grM/AjSTsJ8fdkI=;
        b=nhmt4hxnLvhLA6o/IjSCUNvoaXYKwfnkl/uccNCXw7YHpInfzxqFyEN3UwYAde1Hyl
         7LIJdZg0o5tDBnoHe6xCKZ2V0vX3aq1VcrHSeHmSRHffiQuN2A7iiGKgYeaBlUtrTsEU
         V1AapG0l30CJ6qoYTrEntOtxWnR8xy9gNWLrcCfC1apNeZhg9wj5Uc4FsNs4kT+f64lT
         pMm1jdgVNn5i84v1tBc/pJZmGgZZWL1qLcAN/7CCLqlzYUjCY4F8BwKzH2xBxwprf2s4
         uh4XP3qwBGKGTfufZJIKn8bDSyxC5MonaOPOb5Mugcmn4GVaaOpWoW8pj7zRSxuOo6io
         e5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CuWEymX5xt6zjmYESOk0bUe+rAc8grM/AjSTsJ8fdkI=;
        b=kUo/ljEDBLAwIcidgSOFe+NBrhcX1t6TWnhEmwCJ/+DF8OR7hMc5NRaHf6iSQ7gKRY
         sOyEgBRFb95uOls68rJgudOC0VUhcwyQCzNNepWSN1OUqgunRonehZ3oG7y3I7TpuBgg
         gw33od/tbME5R0Effymtdu8f4MZ/nj3PgcqARoEDkK6vOA1Y+fVB/cBKhP/fIvkH+f/3
         fh0QPz/AAX4p4QNxLj39lyMyOts26yD0l0CU5hf01CRTuCycn2Pf1cVEOVenVMqKaRVm
         7mR6dCmLhpoFXt7BANCSxhqbknCBHqGj//fLt4oCr8AGMTM+VNY0xhtCb9VKI1Wc/qkd
         HNIA==
X-Gm-Message-State: AOAM533PDarzr683I81pekhfwZXzdooXCKeKPFgHIUBox56UtBkKtd0c
        ok0MAf/OHAmWkeKKObOk2CHHAVakJXDn2kgW0e0=
X-Google-Smtp-Source: ABdhPJzcv87jawubfxhLoXCJZw51pybJoSJ9yu4FT3IqyFTkd7xwmipdBHvC1ztLeL4vj57MfhyAhc+MgEsL5mGz39U=
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr11196517wrs.266.1636652914877;
 Thu, 11 Nov 2021 09:48:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:18c7:0:0:0:0 with HTTP; Thu, 11 Nov 2021 09:48:34
 -0800 (PST)
Reply-To: alimaanwari48@gmail.com
From:   Alima Anwari <khuntamar5@gmail.com>
Date:   Thu, 11 Nov 2021 18:48:34 +0100
Message-ID: <CAOdLAAJ+ayea0C0L0YZPvTA+yAxj-kPCtyC5hVpJARh0TyanQA@mail.gmail.com>
Subject: =?UTF-8?B?0J/QoNCY0JLQldCi0KHQotCS0KPQrg==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0YHRgtCy0YPQudGC0LUsINC00L7RgNC+0LPQvtC5INC00YDRg9CzLCDR
jyDQkNC70LjQvNCwINCQ0L3QstCw0YDQuCDQuNC3INCQ0YTQs9Cw0L3QuNGB0YLQsNC90LAsINC/
0L7QttCw0LvRg9C50YHRgtCwLCDQvtGC0LLQtdGC0YzRgtC1DQrQstC10YDQvdGD0YLRjNGB0Y8g
0LrQviDQvNC90LUsINGDINC80LXQvdGPINGB0YDQvtGH0L3QsNGPINC/0YDQvtCx0LvQtdC80LAs
INC60L7RgtC+0YDQvtC5INGPINGF0L7Rh9GDINGBINCy0LDQvNC4DQrQv9C+0LTQtdC70LjRgtGM
0YHRjy4g0Y8g0LHRg9C00YMg0LbQtNCw0YLRjA0K0LfQsCDQstCw0Ygg0L7RgtCy0LXRgi4NCtCh
0L/QsNGB0LjQsdC+Lg0K0JDQu9C40LzQsC4NCg==
