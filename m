Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F322870B0F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjEUVto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 17:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEUVtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 17:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB5FE1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684705734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3PglHXX3G09T9urKQFQE+zJxCvdy2Nz0+nq/8wJZII=;
        b=ftbO6RzTfCzZZK2RdT75+Zl0pTwaGeISnqjK6UIUNtHP2TDpeA9Y7GPxFSCA1cDVF5VwQJ
        vY0UzqTONnZkgUP6fX5ZLkJdc6Eh9gKKj+widGz8D48wUiJOBjsFbCyoPhKFv5yc/9Rf/m
        OTiPYMuYyoLm8CBYkTpiNtka+SaVE90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-GtqmvSm9Ma22gVXfgHSKUQ-1; Sun, 21 May 2023 17:48:50 -0400
X-MC-Unique: GtqmvSm9Ma22gVXfgHSKUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85EAD8007D9;
        Sun, 21 May 2023 21:48:49 +0000 (UTC)
Received: from localhost (unknown [10.67.24.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15759C57961;
        Sun, 21 May 2023 21:48:46 +0000 (UTC)
Date:   Mon, 22 May 2023 06:48:45 +0900 (JST)
Message-Id: <20230522.064845.1518051418018369671.yamato@redhat.com>
To:     bruce.dubbs@gmail.com
Cc:     kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        renodr2002@gmail.com
Subject: Re: [ANNOUNCE] util-linux v2.39
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <ced4d4e1-8358-d718-58ee-9effe39cff6e@gmail.com>
References: <20230520.074311.642413213582621319.yamato@redhat.com>
        <2fc8421e-634a-aa7d-b023-c8d5e5fa1741@gmail.com>
        <ced4d4e1-8358-d718-58ee-9effe39cff6e@gmail.com>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.39
Date: Sat, 20 May 2023 18:16:07 -0500

> On 5/19/23 17:56, Bruce Dubbs wrote:
>> On 5/19/23 17:43, Masatake YAMATO wrote:
>>> Bruce,
>>>
>>>> On 5/17/23 06:22, Karel Zak wrote:
>>>>> The util-linux release v2.39 is available at
>>>>>                                        http://www.kernel.org/pub/=
linux/utils/util-linux/v2.39
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Feedback and bug reports, as
>>>>> always, are welcomed.
>>>>
>>>> Karel, I have installed util-linux v2.39 in LFS and have run into =
a
>>>> problem with one test, test_mkfds.=A0 Actually the test passes, bu=
t does
>>>> not clean up after itself. What is left over is:
>>>>
>>>> tester 32245 1 0 15:43 ?=A0 00:00:00 /sources/util-linux-2.39/test=
_mkfds
>>>> -q udp 3 4 server-port=3D34567 client-port=3D23456 server-do-bind=3D=
1
>>>> client-do-bind=3D1 client-do-connect=3D1
>>>> tester 32247 1 0 15:43 ?=A0 00:00:00 /sources/util-linux-2.39/test=
_mkfds
>>>> -q udp6 3 4 lite=3D1 server-port=3D34567 client-port=3D23456
>>>> server-do-bind=3D1 client-do-bind=3D1 client-do-connect=3D1
>>>>
>>>> It's possible it may be due to something we are doing inside our
>>>> chroot environment, but we've not had this type of problem with
>>>> earlier versions of util-linux.
>>>>
>>>> In all I do have:
>>>>
>>>> =A0=A0 All 261 tests PASSED
>>>>
>>>> but the left over processes interfere later when we try to remove =
the
>>>> non-root user, tester, that runs the tests.=A0 I can work around t=
he
>>>> problem by disabling test_mkfds, but thought you would like to kno=
w.
>>>
>>> Thank you for reporting.
>>> Reproduced on my PC. I found two processes were not killed properly=
.=

>>>
>>> Could you try the following change?
>>>
>>> diff --git a/tests/ts/lsfd/option-inet b/tests/ts/lsfd/option-inet
>>> index 21e66f700..70cc3798d 100755
>>> --- a/tests/ts/lsfd/option-inet
>>> +++ b/tests/ts/lsfd/option-inet
>>> @@ -84,14 +84,10 @@ ts_cd "$TS_OUTDIR"
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -o ASSOC,=
TYPE,NAME \
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -Q "(PID =
=3D=3D $PID0) or (PID =3D=3D $PID1) or (PID =3D=3D
>>> $PID2) or (PID =3D=3D $PID3) or (PID =3D=3D $PID4)"
>>> -=A0=A0=A0 kill -CONT "${PID0}"
>>> -=A0=A0=A0 wait "${PID0}"
>>> -
>>> -=A0=A0=A0 kill -CONT "${PID1}"
>>> -=A0=A0=A0 wait "${PID1}"
>>> -
>>> -=A0=A0=A0 kill -CONT "${PID2}"
>>> -=A0=A0=A0 wait "${PID2}"
>>> +=A0=A0=A0 for pid in "${PID0}" "${PID1}" "${PID2}" "${PID3}" "${PI=
D4}"; do
>>> +=A0=A0=A0=A0=A0=A0 kill -CONT "${pid}"
>>> +=A0=A0=A0=A0=A0=A0 wait "${pid}"
>>> +=A0=A0=A0 done
>>> =A0 } > "$TS_OUTPUT" 2>&1
>>> =A0 ts_finalize
>> I will do that, but will not be able to get to it until late tomorro=
w,
>> but will report back asap.
> =

> I used the above patch and it fixed the problem.  Thank you.
> =

>   -- Bruce
> =

> =


Thank you for testing.
I made a pull request based on this change:

  https://github.com/util-linux/util-linux/pull/2246

Masatake YAMATO

