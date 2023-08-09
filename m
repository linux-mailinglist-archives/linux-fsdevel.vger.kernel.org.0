Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE7754B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 10:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHIIEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHIIEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:04:05 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 01:04:04 PDT
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217979F;
        Wed,  9 Aug 2023 01:04:04 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 8C1025EC41;
        Wed,  9 Aug 2023 10:56:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vuTatqBWuOs0-Hh7wC64C;
        Wed, 09 Aug 2023 10:56:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1691567818;
        bh=YDBk0KjQh1HzWuh0Dn/kXGmLDEsk4jPretTZd8jrNcY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=Klvyi2pEWgIVNQ8vbrf0jldMARt81cx4SDQ3yguOP5JrQPp5Jesz7semU/6BzrjMW
         c/EJk1KUvW34WiaFKd8g5SJmm/394hla3o7QFDEIIjMK7eXGSLIguTZWaE8j0q0VQT
         UJC2wrXoTh9tSHuvWw3/xO1IawcXQ3FYNs1BpA1Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <aa8a99e6-55e7-1f7d-dc64-4decf0ed7c80@yandex.ru>
Date:   Wed, 9 Aug 2023 12:56:56 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

22.06.2023 21:58, Chuck Lever III пишет:
> IMO that's not a reason not to do this properly.
>
> You should work with Jeff and the maintainer of
> xfstests to make it happen.
If only I knew who is that maintainer
and why he ignores all patches...

Can someone else please take a look at this:
https://www.spinics.net/lists/fstests/msg23115.html
and make a review/ack?
