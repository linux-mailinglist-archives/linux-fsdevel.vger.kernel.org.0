Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD26F6F86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjEDQBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjEDQBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 12:01:48 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4644A5
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 09:01:46 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QBz8Q5N6szMrLwX;
        Thu,  4 May 2023 18:01:42 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QBz8N2pJJz1KT;
        Thu,  4 May 2023 18:01:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1683216102;
        bh=dialvkrEAVQAFxQGrtELfEYjCv+jfvjYJX0K1jjADPE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=czlPYxfVvpb9lJJZJZDdwLTnctbTzvWaGQFItDHL1Y8oW5ODmqA7x4bNcl8So4oyE
         cmhkeGu84kkuh8WtACtT3jhSNYDYVJt+403nZ5VgFCW7YbgK0T8o0RrZ/gEfHGiO8y
         PTVHFHIJuiO95WzEZv8zmiXsgQXwg8ovIHcL6eKw=
Message-ID: <e4d1cfc8-6d50-57be-fd64-8c648acacaf5@digikod.net>
Date:   Thu, 4 May 2023 18:01:39 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 0/5] Landlock support for UML
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
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
 <1f347bdf-a3da-981c-bfee-d6a1f7f51b85@digikod.net>
In-Reply-To: <1f347bdf-a3da-981c-bfee-d6a1f7f51b85@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard, any news?

On 04/04/2023 15:52, Mickaël Salaün wrote:
> 
> On 21/03/2023 22:38, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>>> Von: "Mickaël Salaün" <mic@digikod.net>
>>> Richard, Anton, Johannes, what do you think about these UML changes?
>>
>> I like them but didn't had a chance for a deeper look so far. :-S
> 
> Good! Do you think it could make it for v6.4?  Should we push it in
> -next for testing?
> 
> Thanks,
>    Mickaël
