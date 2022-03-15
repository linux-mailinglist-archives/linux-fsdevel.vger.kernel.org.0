Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1C4DA416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351749AbiCOUjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbiCOUjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:39:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715A48380
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:38:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n2so124241plf.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0PXvpBAI7/DW+fJu3pbEZOUlJ/4SdG6ZAKTeGmtp3So=;
        b=HL3Ie/jzOr8LVpOzIk2zbFiAcibtqGsB5AUriKAXbr7MnzX1HJX+UpCnvWjRShdnL5
         aUFLUt0/3KUPvrbdB9BeVD/5qT7804C9lE58c9QkdeUDaW/3QT4WeO6z1SircgEvZT38
         6YfJltCv0mEgHzCWqIJlWAjfyE4bf0Lb4saBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0PXvpBAI7/DW+fJu3pbEZOUlJ/4SdG6ZAKTeGmtp3So=;
        b=qzCAIH+wwmp369oXerL0Jl2ZXBHQWJ0waWVx3Na/M6BGvpz9LPP7vstI+rn4cO+E+C
         uITlUJ95cbqDjdduvAvOiCd3z7UZpCNGM7xS/AAs3sIpwOmoehfdmySCfLdQelOUPCEM
         VCLVyDnBgt6oEMXoqPPUWRnWhw0Hel2+H4zjAXj/cgNrC/1cSrboKKP05zx9KDMzkGRA
         o/XHJqTihVEoQPH6+JyJqvhSmarAC+tE/RLTrn08uyyuHcNYFQoNgUzx1Zw+JUqJv1jt
         FoxVL2Ut/bPL2zulo2q3Cn1HleMAN2820vNJwXawSDi6F3G+iyMyUY+aZDuAO0vUgZtW
         fWZA==
X-Gm-Message-State: AOAM533/FWDgaxB83YTB82aVG5pvPT3lAlYW7IkpkeSk3wOAFgD+35BM
        Dg+OrLe7r8uoT+TJOYE4f6Rm3w==
X-Google-Smtp-Source: ABdhPJwnnGRPECTkm96Rui9haiXKcgnV1r+NCUJl4/YDDBGXIDH18HC1rDpSVEtoRcRpl7wUqyxdkw==
X-Received: by 2002:a17:90a:6405:b0:1c6:5605:cd1c with SMTP id g5-20020a17090a640500b001c65605cd1cmr1838149pjj.80.1647376711458;
        Tue, 15 Mar 2022 13:38:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15-20020a63af4f000000b0037c8875108dsm114409pgo.45.2022.03.15.13.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:38:31 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:38:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86: Improve formatting of user_regset arrays
Message-ID: <202203151338.13B0505C9@keescook>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
 <20220315201706.7576-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315201706.7576-3-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:17:05PM -0700, Rick Edgecombe wrote:
> Back in 2018, Ingo Molnar suggested[0] to improve the formatting of the
> struct user_regset arrays. They have multiple member initializations per
> line and some lines exceed 100 chars. Reformat them like he suggested.
> 
> [0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/
> 
> Suggested-by: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Much easier to read; yes!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
