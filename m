Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77546C99B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 04:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjC0Ctr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 22:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjC0Ctq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:49:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD6444B1;
        Sun, 26 Mar 2023 19:49:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so6366573pjd.1;
        Sun, 26 Mar 2023 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679885384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZcQsaKqPsYODcn7NEdpTeu2skOK0mYpDjHEOBZhZNI=;
        b=QWvKcHXFONWC/e5VNLgEPbSpnj/5r/olSwdrPKXsNpBcLpAxkzvQjL13+lxTSeSAfB
         Qn4vEg/F4y9vVnFM/MkxczLJq8ZocaI2b5V+QNo2QfyA8ppIYBzmID7T0h0lGYwu1PQo
         sUu5HXyYEH2NWK35b5HsE3a+8oG9UcbPvYH0NRzzv+KAp9EmLKeRnNOFBeFuBVGt3X5t
         Td4kWKUdnpOWs6/7HVHls9yPLjR66b3c4IH8AoRSG5ifhUEh7EnzqZ3okP2Xcj8p1hfN
         uII0hhoTLMGXAm+mY1DZpfhdI5bqJ6n97qG3oaagbLSs0/jPpeV0MQm6zDk7yWrQCc7C
         9A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679885384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZcQsaKqPsYODcn7NEdpTeu2skOK0mYpDjHEOBZhZNI=;
        b=HVRYPkLCgtD9bP1hajiVkM5xWOj9XZG6nng/hgNACBMjo2/CMWQyfwlx9xWnrjKVT4
         dtFeeZC0boxfuNgM0zKyt9cEcizXz8uR4DWLnAlA8OhaGvUS94uIZLyo33t3mturapzv
         jw3mlmL1FjTzMg5zPWse6BV3KiYS7obA6Ci55SDVQ47WpT9wIyyCnEN9Pzk7aa2VfKd5
         Lkf63PRGCxKqlWE+HFiictTX3THjj4wWk2CtOsJEX8V6qTDNCqJRm22zCs6avuvRx2V5
         1Sv/FnvPZsoBVJnt62KbXS8CO/Y2Vm+WTjvwQhBEd26mbe9ZWzp6xvJOPjQ/YbsFLUf3
         PkYw==
X-Gm-Message-State: AO0yUKXs2y8syNHU2HvuTBC200sg93lU1mgBsKkqdjucM5c925abGJEA
        j4ZSN1Hol3w4MX2AIX6yjy8=
X-Google-Smtp-Source: AK7set+DNUMpkQrLkhUBJLlg15M2PTfMouOephHlqqbA7x5u77dluG62bi2bdlw4tnJhvrHSDmYRSA==
X-Received: by 2002:a05:6a20:8009:b0:da:4be2:caff with SMTP id e9-20020a056a20800900b000da4be2caffmr8920064pza.56.1679885384570;
        Sun, 26 Mar 2023 19:49:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a17-20020a631a11000000b0051322ab5ccdsm4916477pga.28.2023.03.26.19.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 19:49:43 -0700 (PDT)
From:   ye xingchen <yexingchen116@gmail.com>
X-Google-Original-From: ye xingchen <ye.xingchen@zte.com.cn>
To:     mcgrof@kernel.org
Cc:     akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        hch@infradead.org, keescook@chromium.org, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, willy@infradead.org,
        ye.xingchen@zte.com.cn, yexingchen116@gmail.com, yzaikin@google.com
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own file
Date:   Mon, 27 Mar 2023 02:49:39 +0000
Message-Id: <20230327024939.75976-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZB3n1pJZsOK+E/Zk@bombadil.infradead.org>
References: <ZB3n1pJZsOK+E/Zk@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> >$ ./scripts/bloat-o-meter vmlinux.old vmlinux
>> >add/remove: 1/0 grow/shrink: 1/2 up/down: 346/-350 (-4)
>> >Function                                     old     new   delta
>> >vm_compaction                                  -     320    +320
>> >kcompactd_init                               167     193     +26
>> >proc_dointvec_minmax_warn_RT_change          104      10     -94
>> >vm_table                                    2112    1856    -256
>> >Total: Before=19287558, After=19287554, chg -0.00%
>> >
>> >So I don't think we need to pause this move or others where are have savings.
>> >
>> >Minghao, can you fix the commit log, and explain how you are also saving
>> >4 bytes as per the above bloat-o-meter results?
>> 
>> $ ./scripts/bloat-o-meter vmlinux vmlinux.new
>> add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
>> Function                                     old     new   delta
>> vm_compaction                                  -     320    +320
>> kcompactd_init                               180     210     +30
>> vm_table                                    2112    1856    -256
>> Total: Before=21104198, After=21104292, chg +0.00%
>> 
>> In my environment, kcompactd_init increases by 30 instead of 26.
>> And proc_dointvec_minmax_warn_RT_change No expansion.
>
>How about a defconfig + compaction enabled? Provide that information
>and let Vlastimal ACK/NACK the patch.
I use x86_defconfig and linux-next-20230327 branch
$ make defconfig;make all -j120
CONFIG_COMPACTION=y

add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
Function                                     old     new   delta
vm_compaction                                  -     320    +320
kcompactd_init                               180     210     +30
vm_table                                    2112    1856    -256
Total: Before=21119987, After=21120081, chg +0.00%
