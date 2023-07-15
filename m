Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333F77548BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGON2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGON23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:28:29 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 06:28:27 PDT
Received: from mfwd26.mailplug.co.kr (mfwd26.mailplug.co.kr [14.49.37.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86C26AF
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 06:28:27 -0700 (PDT)
Received: (qmail 5945 invoked from network); 15 Jul 2023 22:21:44 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        15 Jul 2023 22:20:44 +0900
Received: (qmail 2918930 invoked from network); 15 Jul 2023 22:20:44 +0900
Received: from unknown (HELO sslauth16) (lsahn@wewakecorp.com@211.253.39.90)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        15 Jul 2023 22:20:44 +0900
Message-ID: <ff0d7038-8a53-f183-fc3a-d69143e801a2@wewakecorp.com>
Date:   Sat, 15 Jul 2023 22:20:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] fs: inode: return proper error code in bmap()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Leesoo Ahn <lsahn@ooseel.net>, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230715082204.1598206-1-lsahn@wewakecorp.com>
 <cca223c5-b512-3913-a796-fa15341927ff@web.de>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <cca223c5-b512-3913-a796-fa15341927ff@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-15 오후 9:50에 Markus Elfring 이(가) 쓴 글:
> 
> * How do you think about to add the tag “Fixes”?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n591I think the description is enough, but still open to listen for that 
from others.

> 
> * Would you like to avoid a checkpatch warning by the specification
> of the tag “From” before your improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n499
I use both emails and don't think that's a big deal. But if that 
matters, I will post v3 for that or maintainers could sync up the email 
of author by hands when they merge it.

thank you for your opinion,
Leesoo
