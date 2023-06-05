Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE46B7230B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 22:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjFEUGz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 5 Jun 2023 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFEUGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:06:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198491;
        Mon,  5 Jun 2023 13:06:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6DD4363CC12F;
        Mon,  5 Jun 2023 22:06:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yjEGPY6tiAgF; Mon,  5 Jun 2023 22:06:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F1ECA6081100;
        Mon,  5 Jun 2023 22:06:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zWWbem8M-Ve5; Mon,  5 Jun 2023 22:06:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BFF0663CC12F;
        Mon,  5 Jun 2023 22:06:43 +0200 (CEST)
Date:   Mon, 5 Jun 2023 22:06:43 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
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
        stable <stable@vger.kernel.org>
Message-ID: <1324905118.3685909.1685995603629.JavaMail.zimbra@nod.at>
In-Reply-To: <a0c3e6d4-2827-d9b4-8f4e-aef25997fa8a@digikod.net>
References: <20230309165455.175131-1-mic@digikod.net> <20230309165455.175131-2-mic@digikod.net> <133970354.9328381.1684703636966.JavaMail.zimbra@nod.at> <8249dd59-ce08-2253-1697-301ad082d905@digikod.net> <a0c3e6d4-2827-d9b4-8f4e-aef25997fa8a@digikod.net>
Subject: Re: [PATCH v1 1/5] hostfs: Fix ephemeral inodes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Fix ephemeral inodes
Thread-Index: XBAxT/JtpH3OjQ/qxi7IxqxKKdqxXg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
>> Good, I'll send a new series with your suggestions.
> 
> Can I add your Signed-off-by to this patch (without touching
> ARCH_EPHEMERAL_INODES changes, but removing the Cc stable)?
> 
> Are you OK for me to push this patch (with the whole series) in the
> Landlock and next tree?

Yes. Feel free to add:
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
