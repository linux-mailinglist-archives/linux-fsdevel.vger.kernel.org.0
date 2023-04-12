Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544386DFD32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjDLSCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDLSCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:02:52 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A26A6F;
        Wed, 12 Apr 2023 11:02:51 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id eh14so2152164qvb.4;
        Wed, 12 Apr 2023 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681322570; x=1683914570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bj+WHwYRaSOWy/jxqxEvSkKK3zkuh2PLzDdn/N6ZB5o=;
        b=e4Flr5W8ZM5rvPXPYV6NDWVeYteQl85OAv9RIKCE9CJDNvvDHBftt2TuG00x5FGTAi
         iSsIXX3ZxVvsA69VKJSnlBHm4tbW64eKeoA1R0rma9Qg9KEP6PKx9BcUSso0S+0bquIX
         nN38b/OIGHZ7h6EdwzX1zgt7N78T9SI60+TOeKmMDiJ3GzXO1rnBljjOGIkvb4SPUfbT
         e/u7IdRty3275mr36xlG4GFTEf+HYwLhZPXAPgkIgpM+0ZudpR69t+vSU/CtMabqClo9
         K/VE4YKalNRiYZDAZJPN2gs64pVYHS9MhuTqq+chrSv1zFliHdy62lZnIq+uXSoqS0NN
         BeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322570; x=1683914570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj+WHwYRaSOWy/jxqxEvSkKK3zkuh2PLzDdn/N6ZB5o=;
        b=WyV0+vkiSF/338hXuvUiz2Osc9sUOYB23DlvRStjVhdt8pwy+ykpOv3+01NWkWfvfD
         KxAGGH8/cNU/u++8wFXLuVrp5vvkt/1yl6M6AQq2ypYItf7FVLsmTokMnfRV8kijy5J/
         ijBM5kkwjlCdcXGuNCk8ISepswZMbPJ8oq5BMLLyvpLivlgiNOZmVe/MBM/0Z+oAD6rN
         MDNYNjepyyzy2Chay+lXnhPHoi8rjaoSInXPNG8g3lXM257Y9IDlGVOJGoDteKlxk+5g
         jj1nCUgo/bsyzbYySmH7A/po7hdFbdikNmj2NmCvvtIeDVVkhZtin9DrQDvUNSn01uFR
         frzg==
X-Gm-Message-State: AAQBX9fVV0eZ8q5jXr/0sGTroIjq/o0dxCQQzywitrW1kigEzpEIfgvY
        Z08w8e16UMuMUnc41DUXPBI=
X-Google-Smtp-Source: AKy350bdb5jZNKNfQr0JPCaR08JaOgiVRlbVurZ1uqXmnMzXjZivdLkajDZMqHfFqSs3mcE62K6zqA==
X-Received: by 2002:a05:6214:f2f:b0:5e6:aa6a:1b with SMTP id iw15-20020a0562140f2f00b005e6aa6a001bmr29430546qvb.49.1681322570085;
        Wed, 12 Apr 2023 11:02:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x12-20020a0cff2c000000b005dd8b93459asm1901771qvt.50.2023.04.12.11.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 11:02:49 -0700 (PDT)
Message-ID: <64c4df35-6ecd-b1de-c2d9-f8acf1485488@gmail.com>
Date:   Wed, 12 Apr 2023 11:02:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] GDB VFS utils
Content-Language: en-US
To:     Glenn Washburn <development@efficientek.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <cover.1677631565.git.development@efficientek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <cover.1677631565.git.development@efficientek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/23 16:53, Glenn Washburn wrote:
> Hi all,
> 
> I've created a couple GDB convenience functions that I found useful when
> debugging some VFS issues and figure others might find them useful. For
> instance, they are useful in setting conditional breakpoints on VFS
> functions where you only care if the dentry path is a certain value. I
> took the opportunity to create a new "vfs" python module to give VFS
> related utilities a home.

Andrew, any chance you could pick up those two patches from Glenn:

https://lore.kernel.org/all/7bba4c065a8c2c47f1fc5b03a7278005b04db251.1677631565.git.development@efficientek.com/
https://lore.kernel.org/all/c9a5ad8efbfbd2cc6559e082734eed7628f43a16.1677631565.git.development@efficientek.com/

Thanks!
-- 
Florian

