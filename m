Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D770A2E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 00:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjESWoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 18:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjESWoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 18:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC5E45
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684536199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lx3FRv/9ZViNHJYNb7K17j7599eHUYCX31V7AD9qU0o=;
        b=bQGmOAZGPHKk5zwa4Eec+6n3+uXQxmKybOIHoJqfPANQxwMUw9O7s7hqEPIci6DLDcEmg5
        JPxoNzQcgoL+O8Fw5+4VWW9n64+v907EnitijyY7VYo1UHl8RNWLeUKjScrcYauMioMmWd
        V9KOS4MDG3tGYAxuPZvf/RShwySvp24=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-aVXYRF4TPMKGIaqCHUms0w-1; Fri, 19 May 2023 18:43:15 -0400
X-MC-Unique: aVXYRF4TPMKGIaqCHUms0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 532BF185A78E;
        Fri, 19 May 2023 22:43:15 +0000 (UTC)
Received: from localhost (unknown [10.67.24.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D62284F2DE2;
        Fri, 19 May 2023 22:43:12 +0000 (UTC)
Date:   Sat, 20 May 2023 07:43:11 +0900 (JST)
Message-Id: <20230520.074311.642413213582621319.yamato@redhat.com>
To:     bruce.dubbs@gmail.com
Cc:     kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        renodr2002@gmail.com
Subject: Re: [ANNOUNCE] util-linux v2.39
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <652d32c5-4b33-ce3a-3de7-9ebc064bbdcb@gmail.com>
References: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
        <652d32c5-4b33-ce3a-3de7-9ebc064bbdcb@gmail.com>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bruce,

> On 5/17/23 06:22, Karel Zak wrote:
>> The util-linux release v2.39 is available at
>>                                       http://www.kernel.org/pub/linux/utils/util-linux/v2.39
>>                                    Feedback and bug reports, as always, are welcomed.
> 
> Karel, I have installed util-linux v2.39 in LFS and have run into a
> problem with one test, test_mkfds.  Actually the test passes, but does
> not clean up after itself. What is left over is:
> 
> tester 32245 1 0 15:43 ?  00:00:00 /sources/util-linux-2.39/test_mkfds
> -q udp 3 4 server-port=34567 client-port=23456 server-do-bind=1
> client-do-bind=1 client-do-connect=1
> tester 32247 1 0 15:43 ?  00:00:00 /sources/util-linux-2.39/test_mkfds
> -q udp6 3 4 lite=1 server-port=34567 client-port=23456
> server-do-bind=1 client-do-bind=1 client-do-connect=1
> 
> It's possible it may be due to something we are doing inside our
> chroot environment, but we've not had this type of problem with
> earlier versions of util-linux.
> 
> In all I do have:
> 
>   All 261 tests PASSED
> 
> but the left over processes interfere later when we try to remove the
> non-root user, tester, that runs the tests.  I can work around the
> problem by disabling test_mkfds, but thought you would like to know.

Thank you for reporting.
Reproduced on my PC. I found two processes were not killed properly.

Could you try the following change?

diff --git a/tests/ts/lsfd/option-inet b/tests/ts/lsfd/option-inet
index 21e66f700..70cc3798d 100755
--- a/tests/ts/lsfd/option-inet
+++ b/tests/ts/lsfd/option-inet
@@ -84,14 +84,10 @@ ts_cd "$TS_OUTDIR"
                   -o ASSOC,TYPE,NAME \
                   -Q "(PID == $PID0) or (PID == $PID1) or (PID == $PID2) or (PID == $PID3) or (PID == $PID4)"
 
-    kill -CONT "${PID0}"
-    wait "${PID0}"
-
-    kill -CONT "${PID1}"
-    wait "${PID1}"
-
-    kill -CONT "${PID2}"
-    wait "${PID2}"
+    for pid in "${PID0}" "${PID1}" "${PID2}" "${PID3}" "${PID4}"; do
+       kill -CONT "${pid}"
+       wait "${pid}"
+    done
 } > "$TS_OUTPUT" 2>&1
 
 ts_finalize

