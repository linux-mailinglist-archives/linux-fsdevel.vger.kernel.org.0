Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1677388E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjFUPYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjFUPY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:24:26 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA519BD;
        Wed, 21 Jun 2023 08:24:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:859f:0:640:3817:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 8E16F5F339;
        Wed, 21 Jun 2023 18:24:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GOkJr54DRW20-lq8r0Yu5;
        Wed, 21 Jun 2023 18:24:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687361058;
        bh=PLIndlg4XuZXOQOaF0urOQKFPmTObBhkO0SlGRY1jJg=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=A6oczahYIKWko6YBLh5O9cSJ6eJVVdKAzNTwPj1UXfqOcPS6VePMgEbAuTbk1jFsX
         uE4essZGeTI7DDZXeSGCrwklNxmVTw9tRDtPusAR8xj6ctcbp2WKAuCmvKkCcnk6/a
         BJq5yFT9Kk8W6APRYb2H0dQU6aF7QqZfIAWFlE6w=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e9c344c8-b5ee-c981-9d9b-fbfe703aa2f7@yandex.ru>
Date:   Wed, 21 Jun 2023 20:24:16 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] fs/locks: F_UNLCK extension for F_OFD_GETLK
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20230620095507.2677463-1-stsp2@yandex.ru>
 <20230620095507.2677463-2-stsp2@yandex.ru>
 <c6d4e620cad72da5f85df03443a64747b5719939.camel@kernel.org>
 <e7586b46-ff65-27ff-e829-c6009d7d4808@yandex.ru>
 <e1a59fa3eb821e66cdc95fcecc68ef9f9434ddf5.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <e1a59fa3eb821e66cdc95fcecc68ef9f9434ddf5.camel@kernel.org>
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


20.06.2023 16:15, Jeff Layton пишет:
> These days, it's a good idea to go ahead and draft that up early. You'll
> be surprised what sort of details you notice once you have to start
> writing documentation. ;)
>
> You can post it as part of this set on the next posting and just mention
> that it's a draft manpage patch. You should also include the linux-api
> mailing list on the next posting so we get some feedback on the
> interface itself.
v2 is sent with the proposed man page
update and a drop of an l_pid.
Thanks.
