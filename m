Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841961FEE43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgFRJDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 05:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgFRJDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:03:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF27C06174E;
        Thu, 18 Jun 2020 02:03:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id y6so4276204edi.3;
        Thu, 18 Jun 2020 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ukJv09R/Qizrp9nFuZZGIBUbvRYEDs5U5DFimRDckes=;
        b=NEKpjfzEQnENYtVnTqsPePe6O8sJTbH7i6p7AN/ITECUpn4yRvjc/PUS4iV1OkpOt+
         5b1kDQFzsaMjlyfGpTAmyUIICcldt7izeU//+EV/uSto3CsDJP/f0lyIX14kUMQ2I0J1
         9anYbaTihYa8TpdTbBqmVbKPjWb7RCHHE6VNSsWWA+nPLCDK/iVW3TWLoGd2Ret4KwdJ
         PGrZ67SXlyxNMudF1w03Cod+i2noYosFmMQB8ULHUy/5ZmgMfDdcvLWFjCSmZYdPfB+y
         j2k69sa7s9R11sgBok/JRrKhWPzgyIjaYgI0MSq7iazYA7G2U+GjWjNAghLjmGDno9le
         58ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ukJv09R/Qizrp9nFuZZGIBUbvRYEDs5U5DFimRDckes=;
        b=kvjcOzmAsNVXJCKpY9s9zPAJ9bZBmvyWnHkCA8T9Q96zw144qUSAZrCbW27diG1or+
         Nlba1Not7WhQGMaxMqeFpafI3Fuz03WQF2bIVlZq2RqQ+sk2ieIJvrHPeSuvpr5lIKPx
         pMulIRs3S72Db/WFivgdaFE24AIn7K584GhC6BGQD4CFd/BI4B2BbcFnLEVvU4bbupbC
         9CrC3tNLJAfQuaMAIKXbcM5cMSNww/lFoiMy/LDuXUH1auwUcCkpkqTagLE85joU9bWb
         wEJrfmxySvvNfyOr2iV2WLackv+9y8G34/D6A1sVIH+ldVs7ZZhsSUOA5JzpaBIQontp
         ywbA==
X-Gm-Message-State: AOAM5311C9xRtn5Xmik+L8ALYQ9cqMCMvqqVIjsQGsmcYzXSC3Zo3+PB
        4yDjsQkEnCpal/Ada/qyGuw1500e+J0vifEafwE=
X-Google-Smtp-Source: ABdhPJycBlQ3+qQ1DL1oyfZO7RFqPWELyy0xVggxryiHLBz+jlmSvWJoZWmo84VBTgDwpavlANjslroUBQKec6ojg8o=
X-Received: by 2002:aa7:c80c:: with SMTP id a12mr3219176edt.140.1592471016410;
 Thu, 18 Jun 2020 02:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200618084543.326605-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200618084543.326605-1-christian.brauner@ubuntu.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 18 Jun 2020 11:03:25 +0200
Message-ID: <CAKgNAkjMmLmZPk08tK=mBjTqPF7X771Of79WD-YYXhN9cB2ULw@mail.gmail.com>
Subject: Re: [PATCH] nsfs: add NS_GET_INIT_PID ioctl
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Serge Hallyn <serge@hallyn.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Jun 2020 at 10:45, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Add an ioctl() to return the PID of the init process/child reaper of a pid
> namespace as seen in the caller's pid namespace.

What are the pros and cons of returning a PID FD instead of a PID?

Thanks,

Michael
