Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03174C6745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 11:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiB1KrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 05:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiB1Kq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:46:59 -0500
Received: from mail-out-2a.itc.rwth-aachen.de (mail-out-2a.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5135B885
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 02:46:17 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2AcBQBcpxxi/6QagoZaHgEBCxIMQIspkHkhhBSaQwsBA?=
 =?us-ascii?q?QEBAQEBAQEIAUEEAQGFBwKEECc4EwECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEBBQSBHIUvRoZDAQEBAgEjVgUWGgImAhI3EAYOIIVfrleBMYEBiFSBJwkBg?=
 =?us-ascii?q?QYshzOHEYJQhA8wPoEFAYQMgkuCZQSUR4FwgWB+kiVVgmFGjVycYgeCEVRmo?=
 =?us-ascii?q?BuWQwKRYIcXjzumTAIEAgQFAhaBeIF+Mz6DOVAXAg+ON446gSwCBgsBAQMJg?=
 =?us-ascii?q?jqQUwEB?=
IronPort-Data: A9a23:Ct1+J6rSGyfF9vGdYIms0fXQchleBmJCZRIvgKrLsJaIsI4StFCzt
 garIBnQMvbYNzT3L9x1bIyw9E8B75KEnIdmHgdtrSFmRSkU+ePIVI+TRqvS04J+DeWeFh49v
 5VGAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvX4
 4yq+aUzBXf8s9JKGjNMg068gE431BjCkGtwUosWPK0jUPf2zhH5PbpHTU2DByKQrrp8QoZWc
 93+IISRpQs1yT9wUI//wuajGqE9auW60QCm0hK6UkU56/RIjnRaPq0TbJLwZarL4tmEt4gZ9
 TlDiXC/YQV3I4Ltw88MaiECPTB6Y+5o17bbEEHq5KR/z2WeG5ft6+9xEEE7LcgDpqN+R3tR6
 fxdITxLYh3ra+CemennDLA33oJ5co+yYt93VnJIlFk1Cd4jSJ/FXr6M6sVfxywYnN9SHbPXb
 sEZZDwpYBmojxhnYQ9OUc5hzI9EgFGnfS9Vi13EoZEJ2DLsjw02wJaqFcX8L4niqcJ92xzwS
 nj912f0DwoRM9uc4TGF6HWph/LK2yThV+o6Hb6g89ZugVuO1ikdDwAQWVKnoP6/zEmkVLp3I
 koI+i0ovO4j5kqiQdDVWAexq3qJ+BUbXrJ4HOkz9QuM1rj8+waIHWkHCDBcLdYrrss3Q3om2
 zehm9LvGCwqvqaZRGyQ8p+Koj6ofysYN2kPYWkDVwRty93ippwjyxPGEIpLDqG4lJv2FCv2z
 jTMqzIx750XjMgWx+C48ErBjjaEuJfEVEg26x/RU2bj6Rl2DKagbpCv81/s5+tPPoedSlC2v
 3UencWaxOUHEZaXk2qRQ40lGbi14OyCBzjVgFpuGZYl9i+xzH2uZ4Zd5Bl7LVtuKMFCZTyBS
 FXethlc/4RSO32xRat6boexFsUxi6nmG9ONfurZYcBDeYNwcwmc1CVvflKLmWTsllU8160yJ
 /+zb8e2Cl4IBKJm0nyyRuEAwfks3C942GC7eHzg5w64zbqTdDuOFfIMdkGRcuB85a/CrAi9H
 8tjCvZmAi53CIXWChQ7O6ZKRbzWBRDX3azLlvE=
IronPort-HdrOrdr: A9a23:OoMEaKNht6N59sBcTsSjsMiBIKoaSvp037Eqv3ofdfVwSL37qy
 nOpoV56faaslwssR0b9OxofZPwJE80lqQU3WByB9aftWDd0QPCEGgL1/qH/9SKIUPDH4BmuZ
 uJJMNFebvN5A9B/KHH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="3011478"
Received: from rwthex-s4-a.rwth-ad.de ([134.130.26.164])
  by mail-in-2a.itc.rwth-aachen.de with ESMTP; 28 Feb 2022 11:46:15 +0100
Received: from localhost (2a02:908:1069:2f00:f9fe:b87e:4b4b:c4ea) by
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 11:46:14 +0100
Date:   Mon, 28 Feb 2022 11:46:13 +0100
From:   Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>
To:     <keescook@chromium.org>
CC:     <akpm@linux-foundation.org>, <anthony.yznaga@oracle.com>,
        <glaubitz@physik.fu-berlin.de>, <linux-fsdevel@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <matoro_bugzilla_kernel@matoro.tk>,
        <matoro_mailinglist_kernel@matoro.tk>, <regressions@leemhuis.info>,
        <regressions@lists.linux.dev>, <viro@zeniv.linux.org.uk>
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Message-ID: <Yhyn9cjDV8XfXLHm@fractal.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <202202260344.63C15C3356@keescook>
X-Originating-IP: [2a02:908:1069:2f00:f9fe:b87e:4b4b:c4ea]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> When the kernel tries to map these with a combined allocation, it asks
> for a giant mmap of the file, but the file is, of course, not at all
> that large, and the mapping is rejected.

> So... I'm trying to think about how best to deal with this. If I or
> anyone else can't think of an elegant solution, I'll send a revert for
> the offending patch next week.

Shouldn't we just be able to patch total_mapping_size() again to instead
sum up all p_memsz fields, instead of comparing minimum and maximum
p_vaddr?

Runtime complexity would be the same as we are iterating through all
segments already anyway. And I would also argue that is the behaviour
that one wanted to see in that function anyway.

If you agree with this, I can post a patch, but I would need to know
what tree to base it on to avoid merge conflicts with the just merged
patch from Alexey.

--
Magnus
