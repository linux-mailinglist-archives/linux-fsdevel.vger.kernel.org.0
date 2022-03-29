Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712AF4EAB43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiC2Ke2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiC2Ke1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:34:27 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6DBC2B1B0;
        Tue, 29 Mar 2022 03:32:44 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9E51815F939;
        Tue, 29 Mar 2022 19:32:42 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22TAWea8133078
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 19:32:42 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22TAWeeK502767
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 19:32:40 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22TAWeH6502766;
        Tue, 29 Mar 2022 19:32:40 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     qianfan <qianfanguijin@163.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: linux resetting when the usb storage was removed while copying
References: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com>
        <87pmmee9kr.fsf@mail.parknet.co.jp>
        <06ebc7fb-e7eb-b994-78fd-df07155ef4b5@163.com>
        <15b83842-60d9-78b8-54e9-3a27211caded@roeck-us.net>
        <87pmm6hbk9.fsf@mail.parknet.co.jp>
        <e69813b2-9b60-02de-dbec-414c2baf42c8@163.com>
Date:   Tue, 29 Mar 2022 19:32:40 +0900
In-Reply-To: <e69813b2-9b60-02de-dbec-414c2baf42c8@163.com> (qianfan's message
        of "Tue, 29 Mar 2022 17:08:10 +0800")
Message-ID: <87ilrxgibb.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

qianfan <qianfanguijin@163.com> writes:

>> This limits the rate of messages. Can you try if a this patch fixes behavior?
>
> Yes, this patch fixed the problem and watchdog doesn't reset again.
>
> Next is the console log when usb storage disconnected:

[...]

> cp: read error: Input/output error
> # [  218.253995] FAT-fs (sda1): FAT read failed (blocknr 1130)
>
> 'FAT read failed' error message printed only once.
>
> Interesting.

Hm, message should print 10 times, then is suppressed. So this time, the
test may not reproduced. Can your test reproduces the issue reliably?

Well, anyway, the patch looks like working.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
