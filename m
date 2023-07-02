Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30496744C73
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGBGmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBGmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 02:42:12 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F2C3;
        Sat,  1 Jul 2023 23:42:06 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2991:0:640:bb47:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id C314A5E97C;
        Sun,  2 Jul 2023 09:42:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ufJuntUDda60-5bVh6QB7;
        Sun, 02 Jul 2023 09:41:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688280120;
        bh=XiUBoiw+8W0drTZxJpGsrmWe6kl6B1XHyd8+N0mErnk=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=jIJ2sLrtjo9QdXxGAw0kf9pBVRsfZn2SjCyf+pFyXLmPIkKZNzjIG7rMBCwL6Eoqj
         dhDl21QNwghiAmKPhS6UAV60RM636dbPORMcZzA4hmU5pmexnlGNeDcvo+8kaC0wI6
         uZdslIR39olm1oxX8P36oYw1V9HVli+puHQiALFU=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b0315095-0634-1eeb-fbd7-86f44d00d659@yandex.ru>
Date:   Sun, 2 Jul 2023 11:41:56 +0500
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


27.06.2023 21:23, Jeff Layton пишет:
> I've taken the first two patches into my locks-next branch, so they
> should end up in linux-next soon. Adding support for testing this to
> fstests is a hard requirement before this will be merged into mainline.
The test-suite is entirely broken.
I posted the patch:

https://marc.info/?l=fstests&m=168811805324487&w=2

And the question:
https://marc.info/?l=fstests&m=168811862324941&w=2

But no reaction.
Unless someone helps with reviewing,
nothing will likely happen.

