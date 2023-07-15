Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC9754724
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGOG5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 02:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjGOG5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:57:39 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 23:57:37 PDT
Received: from mfwd19.mailplug.co.kr (mfwd19.mailplug.co.kr [14.49.36.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A562D75
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 23:57:36 -0700 (PDT)
Received: (qmail 28081 invoked from network); 15 Jul 2023 15:50:54 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        15 Jul 2023 15:49:54 +0900
Received: (qmail 2310969 invoked from network); 15 Jul 2023 15:49:54 +0900
Received: from unknown (HELO sslauth33) (lsahn@wewakecorp.com@211.252.87.40)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        15 Jul 2023 15:49:54 +0900
Message-ID: <ea5b21e4-78e6-8639-b62f-58100e2bc138@wewakecorp.com>
Date:   Sat, 15 Jul 2023 15:49:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: inode: return proper errno on bmap()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230715060217.1469690-1-lsahn@wewakecorp.com>
 <fa1386fb-04af-8037-2591-781f8723d564@web.de>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <fa1386fb-04af-8037-2591-781f8723d564@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



2023-07-15 오후 3:39에 Markus Elfring 이(가) 쓴 글:
>  > It better returns -EOPNOTSUPP instead of -EINVAL which has meaning of
>  > the argument is an inappropriate value. It doesn't make sense in the
>  > case of that a file system doesn't support bmap operation.
>  >
>  > -EINVAL could make confusion in the userspace perspective.
> 
> Are imperative change descriptions still preferred?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94
> 
> 
> How do you think about to use a subject like “[PATCH v2] fs: inode:
> Return proper error code in bmap()”?
> 
> 
> Please reconsider also the distribution of addresses in recipient lists.
> https://lore.kernel.org/lkml/20230715060217.1469690-1-lsahn@wewakecorp.com/
> 
> Regards,
> Markus

Thank you for the feedback.
I will post v2 patch soon

best regards,
Leesoo
