Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0C14DA2A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiCOSul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCOSul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:50:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A857B04
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 11:49:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h63so4312496iof.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cORsAlIX7zzOarO0bTHYYLV3HdWm+OFM0nlE4vO9J+k=;
        b=H1M9XNpff862ictrDTtA4W+X+AjZlyaxk6dBj7Ob40oacCELaSLRjVnmcXzYZrJMCK
         AtTeT3wY9EGrw1TfxVO4YBxs9zOm4mLL3/EVfWU5bvb4Mpy7q2753WhsPsjNEfqDG9s4
         y0vJ9U6eHFl9kIdeC42yDTYkEgJEkuhxI/Jr/q2INY7Skt7gXo0VdikaQhWinooC/xLB
         yzj4ArKEOynLzJEYvsfH07iepeg2goxr+GUaoC0d5VGT/Rs8TsU8LC2kon9vAp56COpa
         eeIXLtBEBRWCw0rrnd3J7cPsLNYb3Dz9tNtNvJK+URDJxfXSIKxR+wwAnvAQZXtpmhw7
         dEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cORsAlIX7zzOarO0bTHYYLV3HdWm+OFM0nlE4vO9J+k=;
        b=ckOf6M5NzUEibXgy91tBGm+vjPb0Xg+JyFnBZp1VVmxizpylm1OibYabJEACKKY0Ta
         cDsSIDrEncQomS77SOZdYc6gOOuApJvI606j6nDhdLOxpy2eK2uM6VaKi8sOAbMWiUih
         rwOVaJ+7XW4RdsOLZhttMYdO87kweFjPd0oMLh8trQ5R2RV3I6f9abGNHwD+8KTna3/3
         eavx4ijL8xCPNcZlkGX/l8okkZ0bp+oI3WBgcoIMgVsjPQ6RFdd7qpek0NO1WE+noYV5
         1djmbM3IJ6OrbAFyocXB4P9eyeF7NxJkkqFdlUJ1AaReHOSixTq18/bvQ7hfO5x7b36l
         sTuw==
X-Gm-Message-State: AOAM530KUowBqrckGoZ20gsHjTLtpE5+1PMPSoyUIbcNBhmmVHN2vt3g
        HDdrZ1iT1X/rq25lnVbwSLtRWA==
X-Google-Smtp-Source: ABdhPJxwUJgIH3TEDvw6U5it/Vn5hCieZq3WxdugizjyU+4ugaXfEhlmUzKGOXGaMSy/pKVRAGCq6Q==
X-Received: by 2002:a02:9402:0:b0:31a:5a8:81a5 with SMTP id a2-20020a029402000000b0031a05a881a5mr7932751jai.83.1647370167824;
        Tue, 15 Mar 2022 11:49:27 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i11-20020a056e020d8b00b002c79690d56esm5002301ilj.10.2022.03.15.11.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 11:49:27 -0700 (PDT)
Message-ID: <4cfa6143-3082-52ee-6d6d-b127457ac2e4@kernel.dk>
Date:   Tue, 15 Mar 2022 12:49:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
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
 <73adf81b-0bca-324e-9f4f-478171a1f617@acm.org>
 <PH0PR08MB7889A1EB0A223630E8747A53DB109@PH0PR08MB7889.namprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <PH0PR08MB7889A1EB0A223630E8747A53DB109@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/22 12:47 PM, Bean Huo (beanhuo) wrote:
> Micron Confidential
 
> 
> Micron Confidential

Must be very confidential if it needs two?

Please get rid of these useless disclaimers in public emails, they make
ZERO sense.

-- 
Jens Axboe

