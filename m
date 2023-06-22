Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9A73A6EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFVRGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVRGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:06:03 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E01FED;
        Thu, 22 Jun 2023 10:06:00 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 920C05ECE2;
        Thu, 22 Jun 2023 20:05:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s5KIGPLWma60-sV8UCj0A;
        Thu, 22 Jun 2023 20:05:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687453557;
        bh=TATLT68oe3MHhtxQH6KgA5F2FGSSAZUvru8GdZCvHqY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=ksiFJQ2yV0l0MPvZrqThDMdYs7V12K90bdXxKw49m1L9xaApeNDltyqaOlCQASA8g
         w+JDBFNZ1a7F3v/csDg2Z+Ofwl4/GuO+bu4YdrgX3CDskWbe1w17jLgqOfZZHsKPEZ
         yF1WQexQ6OsZVzjV/vSjVlIMJGdCndv54vrNSyYI=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <26a798ae-b93b-2f68-71ed-35950240927d@yandex.ru>
Date:   Thu, 22 Jun 2023 22:05:54 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] selftests: add OFD lock tests
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-3-stsp2@yandex.ru>
 <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
 <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru>
 <8F45F47C-86C0-472E-B701-001A4FF90DBC@oracle.com>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <8F45F47C-86C0-472E-B701-001A4FF90DBC@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


22.06.2023 21:58, Chuck Lever III пишет:
> IMO that's not a reason not to do this properly.
>
> You should work with Jeff and the maintainer of
> xfstests to make it happen.
But its not going to be in this patch-set
anyway, as its a different source tree...
So I should prepare it when this is merged,
or?
