Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38C86D63F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjDDNwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjDDNwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:52:37 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011AE44A7
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:52:14 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PrThr5x5JzMq5rv;
        Tue,  4 Apr 2023 15:52:12 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PrThl55y5zMpyCr;
        Tue,  4 Apr 2023 15:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1680616332;
        bh=NkpIhe1kl9WnqUOccAkPsR5Jf4eiMpyR5UHZ1noE414=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uo53S+JgH7zp/iT0qtMYzUhb7MI4AQ0HKRwChoSCpIzu/DeAe7Kr2E2dhldRkv5vb
         EB4b4gYIjuVRr/smWobo2/gcgeOX7Ts9lqJC8+xD5kRYU2nj/W1ha7m1RWLoaDVOxw
         hzgUL7N4USZt889kpUbgSFQgmDuoji5bkT+bPwEo=
Message-ID: <1f347bdf-a3da-981c-bfee-d6a1f7f51b85@digikod.net>
Date:   Tue, 4 Apr 2023 15:52:07 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 0/5] Landlock support for UML
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        kuba <kuba@kernel.org>, James Morris <jmorris@namei.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20230309165455.175131-1-mic@digikod.net>
 <cb7e6a4b-63d9-ddba-e0fc-d6352df2b3b6@digikod.net>
 <1227008149.272858.1679434728169.JavaMail.zimbra@nod.at>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <1227008149.272858.1679434728169.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/03/2023 22:38, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Mickaël Salaün" <mic@digikod.net>
>> Richard, Anton, Johannes, what do you think about these UML changes?
> 
> I like them but didn't had a chance for a deeper look so far. :-S

Good! Do you think it could make it for v6.4?  Should we push it in 
-next for testing?

Thanks,
  Mickaël
