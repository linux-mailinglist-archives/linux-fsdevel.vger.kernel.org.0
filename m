Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F15756783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGQPTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGQPT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:28 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 08:19:24 PDT
Received: from mfwd04.mailplug.co.kr (mfwd04.mailplug.co.kr [14.63.165.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77B136
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:23 -0700 (PDT)
Received: (qmail 21433 invoked from network); 18 Jul 2023 00:12:01 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        18 Jul 2023 00:11:48 +0900
Received: (qmail 529759 invoked from network); 18 Jul 2023 00:11:48 +0900
Received: from unknown (HELO sslauth52) (lsahn@wewakecorp.com@211.252.87.165)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        18 Jul 2023 00:11:48 +0900
Message-ID: <af4cc40c-a68d-6428-8710-5790766d5157@wewakecorp.com>
Date:   Tue, 18 Jul 2023 00:11:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] fs: inode: return proper error code in bmap()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Leesoo Ahn <lsahn@ooseel.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230715082204.1598206-1-lsahn@wewakecorp.com>
 <ZLKzl+Ac+px98GwC@casper.infradead.org>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <ZLKzl+Ac+px98GwC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

23. 7. 15. 23:56에 Matthew Wilcox 이(가) 쓴 글:
> On Sat, Jul 15, 2023 at 05:22:04PM +0900, Leesoo Ahn wrote:
>  > Return -EOPNOTSUPP instead of -EINVAL which has the meaning of
> 
> EOPNOTSUPP is the wrong errno. ENOTTY is "more" correct.
Thank you for the feedback, just figured out that ioctl never returns 
the error code.

Best regards,
Leesoo
