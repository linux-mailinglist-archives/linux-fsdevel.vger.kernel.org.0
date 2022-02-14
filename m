Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFA4B5CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiBNVYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 16:24:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiBNVYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:24:50 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81253B1501
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 13:24:41 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id j20so6551446vsg.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUA5XLVzUwl5PsPpBT4GOMiYMi4Ipd6X1OagX6wrzqc=;
        b=Ri2IA/U4wrZN62NwG1Q3k8sTvxHXPtOqj+KOMSwLllDqeSg6aSU4ryXBDWs6Z8K7Qr
         Y9bR8gwyC83dLv1ouPA0/Jo5V3yQfMvvD4fSAxa5AhxfItw1mko0fhMjwGCXYkf591vr
         6Zw0ICoctwU3ZVnVTVLHebfXhWTM0NNbrHGyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUA5XLVzUwl5PsPpBT4GOMiYMi4Ipd6X1OagX6wrzqc=;
        b=G4qTUfCY4zo/3NrM8Bv0QyhMV4ZZ9bPClM1ld/kMh3MdQpkBnSGUyj24/iZrc3PmZs
         qVsE6j5DkZRFMfQMyjkcQeyEnLCBihAEaM4faaCUJ3LTYG3sIjRPOz0s5Q0R94YUC/wi
         Ke2PjaPPHzzSw/ZycPButa6yWccbUPJex2Frx6IBk6y/M/SkkZcYr6AtXq4t/maWxryC
         WFvhoPLrL5d11S+Y8N1xLJDRKw1x7tqILJDI731Pd+tuIE97qulaY8cwcpoXUg+mtgCe
         4JNylc5cRnOgOj7na/Reu/4oEb5j1TB2gT3SdXVeQeb2O9b4rAdXzEn5mlxhemncAXfk
         LOJw==
X-Gm-Message-State: AOAM530COge3s9yW0aPY1B8EZQJblBBq/bItXdhAeURpqHBfra8fT8D1
        oPKSjL/WnGePSPAzHCtdy3HhvpKioZM4OA==
X-Google-Smtp-Source: ABdhPJyTNUqLjr0QN/j055iQchlM/5AM3dl2qg42GOgBLXoTvD0Xm0NeQedaV23se5OBGDWW2Cmu+Q==
X-Received: by 2002:a05:6a00:2183:: with SMTP id h3mr422183pfi.12.1644867117937;
        Mon, 14 Feb 2022 11:31:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8sm20515052pfv.168.2022.02.14.11.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:31:57 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     viro@zeniv.linux.org.uk, trix@redhat.com, ebiederm@xmission.com
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: cleanup comments
Date:   Mon, 14 Feb 2022 11:31:49 -0800
Message-Id: <164486710836.287496.5467210321357577186.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211160940.2516243-1-trix@redhat.com>
References: <20220211160940.2516243-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Feb 2022 08:09:40 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'from'.
> Replace 'backwords' with 'backwards'.
> Replace 'visibile' with 'visible'.
> 
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] exec: cleanup comments
      https://git.kernel.org/kees/c/92eec5b2f7b8

-- 
Kees Cook

