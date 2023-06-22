Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409CE73A743
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFVRbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFVRbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:31:14 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1B1FC6;
        Thu, 22 Jun 2023 10:31:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 9E1B35EC28;
        Thu, 22 Jun 2023 20:31:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6VKKXtODUqM0-DyvVaPAp;
        Thu, 22 Jun 2023 20:31:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687455069;
        bh=NcOau/7zdZ8/BFXcxr6E1z7OtQb5HTRH7dBt5/yHTzQ=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=BHUqk3yONpOCWh1NKnqJtWU+7I6mwPvKqPle/chE8JGsf8J3qnrQ4lhFPh7PmiKqf
         Vu80m42o2CaZoi9+CUsdCYcXB2RtZ3OkcgQWfhLjqIe7eTc6ECbx6sTRH8VIRnWcSC
         LT/ODaPAGXvOZC8GqL9XrnIcgzuCI1eFpwx2VIgI=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4582a51d-2b29-f430-2f8f-ed1239d70f70@yandex.ru>
Date:   Thu, 22 Jun 2023 22:31:06 +0500
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
 <26a798ae-b93b-2f68-71ed-35950240927d@yandex.ru>
 <187C3E49-A977-492E-99CB-97F032B24E5F@oracle.com>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <187C3E49-A977-492E-99CB-97F032B24E5F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


22.06.2023 22:12, Chuck Lever III пишет:
> I don't have a strong preference. A good choice is to
> push the test before the kernel changes are merged.
It will fail though w/o kernel changes.
So what exactly is the policy?
