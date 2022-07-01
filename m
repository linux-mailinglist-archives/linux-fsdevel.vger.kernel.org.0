Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9224F563C2D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiGAWHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGAWHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:07:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399170ADF
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 15:07:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x4so3651615pfq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ly1ut2lRpC+IHzGVsz5weN3yVyu4EH2Ed8LcwTFmWqw=;
        b=ZyHPGXCqdu7fQCoaV/KyKtchbY/ZfVItOX2KpUl5zmxC8PjfAnM+IZfmjqzStBv/ea
         odNeSws+XeCNNk2GYwk0+VYN6pMY9H9WZ9ru4fF2sDEiUv9ImQDxGToANo0U5ePKdw/g
         re9f3R+UIWnq/PHdMbZ71WqvnrhYTuP8tuTiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ly1ut2lRpC+IHzGVsz5weN3yVyu4EH2Ed8LcwTFmWqw=;
        b=xqEIlJVKSh1tTcxu/GftzGu4phZMuuQ6co7NVHyt3xwiXR8vGoEmW3KIGcMp8fTuFH
         cWa13Ql/zoazyYiqW/XbTdp00Ja0FRqq+oxCEhvQlvJEZ6m5UxlpSb+9n2JYho3y5XQJ
         3XGfQR1UHgD6xFgkVkx1mXlnRBDoT/DP42/UbBTWE+NskKxo7+WuwVD074TvekCd+B2E
         o1ArdKtBT1TPj3wjrSOvAZ+95HDVwCkltKbAau3YqknDUkVAsuVrmI8DzasdJQPo0w0c
         RR6qrJ/kbGXys/rQBkbrxCebGjuH9CjRmMDTSWcYNPxL4BhSDX4ppLb+2Pi+klM0XNxm
         MXVQ==
X-Gm-Message-State: AJIora8h+zCEsJ3NN3NiClwitmsZsHUswAaSdRlJNv5Vzl6lBMssnmXE
        6oUq/R7ah/yX+GVw3BtyNCv+8Z5bEq+ttA==
X-Google-Smtp-Source: AGRyM1scQP8Qr29GMsqOAW4Lua8p/PoMHO4C4Cbve7e9p65mGzYQhSqfW3B0EGlAwEJ8Wzz7RLi+aQ==
X-Received: by 2002:a05:6a00:2304:b0:528:369b:1f14 with SMTP id h4-20020a056a00230400b00528369b1f14mr4227703pfh.3.1656713228346;
        Fri, 01 Jul 2022 15:07:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bd7-20020a056a00278700b0052090076426sm16557467pfb.19.2022.07.01.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 15:07:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     ebiederm@xmission.com, Al Viro <viro@zeniv.linux.org.uk>,
        jiaming@nfschina.com
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Fix a spelling mistake
Date:   Fri,  1 Jul 2022 15:07:00 -0700
Message-Id: <165671321774.2472190.15847040926491629125.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629072932.27506-1-jiaming@nfschina.com>
References: <20220629072932.27506-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022 15:29:32 +0800, Zhang Jiaming wrote:
> Change 'wont't' to 'won't'.

Applied to for-next/execve, thanks!

[1/1] exec: Fix a spelling mistake
      https://git.kernel.org/kees/c/5036793d7dbd

-- 
Kees Cook

