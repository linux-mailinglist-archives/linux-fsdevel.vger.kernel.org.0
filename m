Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C94BEC25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 21:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiBUU66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 15:58:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiBUU6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:58:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4B23BC3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 12:58:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id om7so16248112pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 12:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=a6R3uiwBvQCzSW4IZ+vEVAnPpskx5ZOkFf1DXk8xFS0=;
        b=oWK2h0gA5Vxrrnw5yuR7cTomlH6B1SfEtqRGX6nMnZ3VwtIqdXGXM7IEmQ05mx0KtU
         XUTmq6ACHafZL8hyqOnHwU84L9PgFUYXsAvalt+INQ081ZwjdgNbXYsBZp8Zmhwag0m0
         JQeI8nHe8ztzQSHBVu7zhx3LqRNA34xE9KONk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=a6R3uiwBvQCzSW4IZ+vEVAnPpskx5ZOkFf1DXk8xFS0=;
        b=DT87umuh5iphf8RBilpMVGBWuJRFzqUDInxemN0JExbam8/RwvoESX6w5aqbV45Er1
         MFH76dTpHhhSfBcR6capP45AdQpTwAkMB+zfDrZLaHypyrfGJwFIaEYQlvmWPsuSHtOx
         ebMjHKdJAJ7HmYTP+hoxVf4irIAhYkhG3BIbd6CjIiDUjHZyMCs2GWJ8nFA6fX/qtXjM
         2hxQriUy5G99RindfNVaL45G/XYNDHEPTlix9Q/0Pk4jJV10ShkSoLZ22+eLsRpcqzkk
         pFuk6KIc+Wms7YUp7aTlrvDsi2AHi4B5w/J7VnB6fcCEfS1o2DA/xY1hhsMuMix48UBG
         HOGA==
X-Gm-Message-State: AOAM532MCujr5zMn8g+5/dGG/CwZ1dHZthNC95oc9ZdrhJccDhjZpvdF
        /tAk0rfcpfdIXpUJAxN2PryDbA==
X-Google-Smtp-Source: ABdhPJwTzUj3oImdd2yhD2sZDVqdPHjySvfH8Q4/jdqzKMlaWiAqLrTil9g53jvldHuKwbydPxYm7g==
X-Received: by 2002:a17:90a:da04:b0:1b9:8539:b45e with SMTP id e4-20020a17090ada0400b001b98539b45emr712980pjv.151.1645477109671;
        Mon, 21 Feb 2022 12:58:29 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9sm18813346pgb.56.2022.02.21.12.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:58:29 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:58:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Anthony Yznaga <anthony.yznaga@oracle.com>
CC:     matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
User-Agent: K-9 Mail for Android
In-Reply-To: <94c3be49-0262-c613-e5f5-49b536985dde@physik.fu-berlin.de>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info> <823f70be-7661-0195-7c97-65673dc7c12a@leemhuis.info> <03497313-A472-4152-BD28-41C35E4E824E@chromium.org> <94c3be49-0262-c613-e5f5-49b536985dde@physik.fu-berlin.de>
Message-ID: <9A1F30F8-3DE2-4075-B103-81D891773246@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On February 21, 2022 11:49:20 AM PST, John Paul Adrian Glaubitz <glaubitz@=
physik=2Efu-berlin=2Ede> wrote:
>Hi Kees!
>
>On 2/21/22 08:42, Kees Cook wrote:
>>>>> Reverting this commit resolves the issue up to and including git tip=
,
>>>>> with no (visible) issues=2E
>>>>>
>>>>> Hardware:  HP Integrity rx2800 i2 Kernel config attached=2E
>>>>
>>>> Could somebody take a look into this? Or was this discussed somewhere
>>>> else already? Or even fixed?
>>>>
>>>> Anyway, to get this tracked:
>>>>
>>>> #regzbot introduced: 5f501d555653f8968011a1e65ebb121c8b43c144
>>>> #regzbot from: matoro <matoro_bugzilla_kernel@matoro=2Etk>
>>>> #regzbot title: gcc segv at startup on ia64
>>>> #regzbot link: https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D21=
5601
>>=20
>> Does this fix it?
>>=20
>> https://www=2Eozlabs=2Eorg/~akpm/mmotm/broken-out/elf-fix-overflow-in-t=
otal-mapping-size-calculation=2Epatch
>
>I have applied this patch on top of 038101e6b2cd5c55f888f85db42ea2ad3aecb=
4b6 and it doesn't
>fix the problem for me=2E Reverting 5f501d555653f8968011a1e65ebb121c8b43c=
144, however, fixes
>the problem=2E
>
>FWIW, this problem doesn't just affect GCC but systemd keeps segfaulting =
with this change as well=2E

Very weird! Can you attached either of those binaries to bugzilla (or a UR=
L I can fetch it from)? I can try to figure out where it is going weird=2E=
=2E=2E

--=20
Kees Cook
