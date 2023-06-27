Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F7F740131
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjF0Qbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjF0QbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:31:11 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6523C00;
        Tue, 27 Jun 2023 09:30:45 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3c81:0:640:d488:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 047175ECF5;
        Tue, 27 Jun 2023 19:30:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8UOOiL1DbOs0-nPrKI8NU;
        Tue, 27 Jun 2023 19:30:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687883410;
        bh=+8H+6KHTtP3zOIWuObgi42qbQrOaAazw5td4SHG7F/g=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=tlke0Aszxyf9h5b+t3X/fKzSm77D0ZpFzjfEPejJkwUUDdb4W8FzDxqrs0+Vks2ky
         SfJ8scrpmwr/M88omrGNgqRKha3znJZQrkP2csJ7xhSyk1x+mA+Jsgm6W0fkiv/bkU
         sQUex1yzjBBCeULHH5cMtDXtTETF8jhHYaHYFIrE=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b4cea85d-e0d9-4926-f103-f29dd19e7b92@yandex.ru>
Date:   Tue, 27 Jun 2023 21:30:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] v3: F_OFD_GETLK extension to read lock info
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
References: <20230622165225.2772076-1-stsp2@yandex.ru>
 <b18c49ada119b6904b92375a847ce8c764cb1663.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <b18c49ada119b6904b92375a847ce8c764cb1663.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


27.06.2023 21:23, Jeff Layton пишет:
> I've taken the first two patches into my locks-next branch, so they
> should end up in linux-next soon. Adding support for testing this to
> fstests is a hard requirement before this will be merged into mainline.
Yes, it is _hard_...
I am still trying to set up the buildroot
environment for these tests:

https://bugs.busybox.net/show_bug.cgi?id=15665

And this will take some time, if at all
successful.
Additionally, these tests simply compare
the output with the pre-defined textual
patterns, so I have no idea what to do
after I figured "this feature is unsupported
on this kernel".
I sketched the tests, but the above problems
are holding things.

