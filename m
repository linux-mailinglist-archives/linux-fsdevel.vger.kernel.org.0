Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7573A6A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFVQzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjFVQzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:55:33 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9B2102;
        Thu, 22 Jun 2023 09:55:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:859f:0:640:3817:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 424555EBFE;
        Thu, 22 Jun 2023 19:55:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ksJrp57DYSw0-Q9OfMlBh;
        Thu, 22 Jun 2023 19:54:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687452899;
        bh=+DtKJEE0DNuSWeAUMe4WpveaxQuC2zvDOUKShdHVNNw=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=cpKvGU2UucGtpO6yAybO+uV/Wr16/O+xj0h1ydGOssYE1ufCU7Y6xrSu12xwQUUto
         BlubACIKXrqrI7fYx6OSoQAKQlikHZQDYoT7H7pftFr9cmd83aIgn0gqQme7SAs+/Q
         cW0qmncMuo46x/ecUq8SU91Htny6DYAXZV7MvQ5I=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <639ff699-27b5-254a-ac19-270369874939@yandex.ru>
Date:   Thu, 22 Jun 2023 21:54:45 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] selftests: add OFD lock tests
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-3-stsp2@yandex.ru>
 <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
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


22.06.2023 16:48, Jeff Layton пишет:
> I'm not sure this really belongs in the "locking" directory. Given that
> there is only the ww_mutex test in there, that's more for internal
> synchronization mechanisms, I think.
>
> Can you create a new "filelock" directory and drop this into there
> instead?
Done and sent the v3.
