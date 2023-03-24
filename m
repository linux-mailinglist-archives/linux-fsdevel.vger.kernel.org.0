Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120E6C7537
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 02:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXBwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:52:20 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92A2331A;
        Thu, 23 Mar 2023 18:52:18 -0700 (PDT)
X-QQ-mid: bizesmtp81t1679622724t44d0krm
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 24 Mar 2023 09:52:03 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000000
X-QQ-FEAT: fQ7bGlHvZRF4Sn2zEN6FX0NS95S4FTJ9NyzD7uSP8SFE1RnwJWLrQVbaOLqT1
        Atqlhfwx3tYgh6kDX+r7nd4Rwq9f0k4J4gbp1c99PHn4X5LUDUBLRL36gdUjjw0gmDgw7CW
        vmQT9IDtivSuYgQWpQEJeVp92trHQ9YZwlS0dSjvONcEiwcyq9gc8WJDKuLE6ZQdZDDM2v6
        v4MBf9KLWu3LfRgWtC4teGF1R3tsVl2A3wsIw5zLUOVXVVzdhBaEMLf/Kf7h3KhP/T/u/rD
        YSfmH5XZtTqkHK0l5m8ujDa8xmaRUcyK53vMUEIBuu3Q+/1DFG8VHEeHTXOpYvDmDF4hcps
        lPLz6PVZDBfuP3Yd2EJj3vgrMzR0yG5D7Te+a4yyg73yIxHg2sCriMUhCEZn7dxW0gVh7a4
X-QQ-GoodBg: 1
From:   gouhao@uniontech.com
To:     willy@infradead.org
Cc:     brauner@kernel.org, gouhao@uniontech.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/buffer: adjust the order of might_sleep() in __getblk_gfp()
Date:   Fri, 24 Mar 2023 09:52:01 +0800
Message-Id: <20230324015201.12511-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ZBxExR3/4bphAUpF@casper.infradead.org>
References: <ZBxExR3/4bphAUpF@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Thu, Mar 23, 2023 at 05:37:52PM +0800, gouhao@uniontech.com wrote:
>> From: Gou Hao <gouhao@uniontech.com>
>> 
>> If 'bh' is found in cache, just return directly.
>> might_sleep() is only required on slow paths.
>
>You're missing the point.  The caller can't know whether the slow or
>fast path will be taken.  So it must _never_ call this function if it
>cannot sleep.
I see. Thank you for your explanation! :)
