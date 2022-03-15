Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606264DA286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 19:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351109AbiCOSlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiCOSlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:41:15 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E975593AA;
        Tue, 15 Mar 2022 11:40:02 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id s11so316186pfu.13;
        Tue, 15 Mar 2022 11:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fXmqodOzVD3PzrxeIkAsl4OXw4c82ENQ5EA9owq38L0=;
        b=0VpSQkZx6Ajc425VJ8XeiHnfRxePm2+9iJaG+YhMm7mCawB83pXD3NVmTUvTmBxo0c
         SK0/CG7CZ/Xbc/ESYB4IT2RUnOBgHrZpdi+WEqAD1wmIOYXwSnOe+WTDT8+x7KR9TQch
         FANPC2cLNxSX9HVCrTmh3Gdmv5O95myfSXrGpttDkQeJkpVFWiU4iyfTn7em2BySLaKs
         1yMxSUl9MEYv91AU28hcRBeoetRNaLum2y6rcfhuhOWHmJiAwJ+tOoauTsC1FP+Oqvxs
         7xEOcHGG3GJiWLoCClOHzSxnWEmZiS+BB5wmwnnWzqmC7+pgcfkMZw/MPkGh/C8tZXdd
         hXxw==
X-Gm-Message-State: AOAM533HygaeJApTYdA3QsnY32HlVBFgtaR6HhyZuTQRpAZsp3etgJDO
        A0YcEIJ2XDK6v9gcVlW2fD8=
X-Google-Smtp-Source: ABdhPJxOj4jzHdGCkwrhZY0cqxLcCMma6VN8i28pG3hVKz0oQKmta3a9GB+885ABV/xO6HRrgjjXYA==
X-Received: by 2002:a65:670a:0:b0:37f:f344:76c1 with SMTP id u10-20020a65670a000000b0037ff34476c1mr25349858pgf.204.1647369601606;
        Tue, 15 Mar 2022 11:40:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:d3f4:bcc8:20ea:11af? ([2620:15c:211:201:d3f4:bcc8:20ea:11af])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090a460600b001bf355e964fsm3827801pjg.0.2022.03.15.11.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 11:40:01 -0700 (PDT)
Message-ID: <73adf81b-0bca-324e-9f4f-478171a1f617@acm.org>
Date:   Tue, 15 Mar 2022 11:39:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <CO3PR08MB7975BCC4FF096DD6190DEF5DDC109@CO3PR08MB7975.namprd08.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CO3PR08MB7975BCC4FF096DD6190DEF5DDC109@CO3PR08MB7975.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/22 11:08, Luca Porzio (lporzio) wrote:
> Can I get invitation?

Hi Luca,

A link to the form to request attendance is available at 
https://lore.kernel.org/all/YherWymi1E%2FhP%2FsS@localhost.localdomain/

Best regards,

Bart.

