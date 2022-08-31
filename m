Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0055A838E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiHaQxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiHaQxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:53:09 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A6DDCFC7
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661964785; bh=ZCdWOAPS92e0L8p/nSC2kBeHBP1h4DoQBYzuNRI5u+U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C2Ta+o3Il5MP8bKvZbxOh+n9Q/l7S6LpGCk4RtspiXnWJOF/E03lTkYaNq78kUc654j8ZKzAPot3kx0l0o+nhs4oF0xVtIJ73AP9ZCB1Ou8bAYbijDzevQ3IKB2JVnXgA+SdBe5UCkncuwiRI3qoxW3m40RkV+xRuN9QhsVNySqXK5xo9/BNqCthWDO9JPcSrDFdvIkryAmdZRoEDu5kqwiMq6Mqt2XjnNwIkUA+QBJoFN5d6OM8bve5/QaO7UIXzYIP5yQg9zE6wt9mb+5lVQFdi4pNYyTlJiZg2EysSegjn0a142PDOtQrHnt4+qDH4JUQOWBl3+6d9WU/Kh37UA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661964785; bh=8OplMxJbJkJZ9r7vM63IiotdRomZJCnDpbR8aoQxPjV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OselDFnnrcq47Vosf6n7SYy4PRFgzyCKVKQzwVo4fh/IvFnIOTlIuFI7LQb9Mtj1didxJlZssJ1udE8Kn/rFiJ4ZtnK6o2c4XLP09Y4yZrrkFjDUgOD7T1yQcuCDOf21UX6EvxuX5mZYC05y4xy4dhmfiJHXGlxEjNxKZu9cza1G4lHsYG1zydHYhsYuYQVuDZrzEdvo1WNHFXC90xM6ns3eSojAP/p3QTe/q7PuvYiIj9cBPC3f6F04NHzl1WB9NVXy8C6AXAcxoIU04mxJNcYdsehvrgh2+4Vpvd6QfpaJxUJcvBG+bQLYqUuZMtgfLPSh27Q2TCgEy1gnvaFUXg==
X-YMail-OSG: 0RdEtYYVM1niEJJkXuqbzhxiFHwZuTcNFUqPOLFl2StBWLTKjYVHGBvQH5pOq_p
 oIg_pWVyilnlRqg5AUexGcZiwpNexJpoMS_tSso7KWebqnPBIN96mQKtBAIEy2ZCJuuN1IMrEcvg
 DWUc6EvkqRtY7WSooEnVfYnHQ6KhjaprU73SobbkYlzIToIRnldzcGNZRLOiSTUFFFSV6dINoBtH
 n.8_vPQNRglo_nvAi2scl_CgfnoSnE.KL1GxD0zNcH_2YKvQtkYMqP7k0me5qCeUqdJrnRF7_Bk0
 OEKjUS3WGUjilgOUFuHBS5uHGI9R1SgrxZOC1dZV4KcIW_rK.eSv0lgQMpgsfDg1tYM3I2RapQ6v
 cnA87UQWsl.lHCcc3d9tjuEvYRY28x7bbquAps0l15rojufio8nEI0XvLFCCSTQ1S81KXPBdMAwd
 rMCmChIUaNXJR5vcNdzXCO.QKKI4sET42AUvaOWicAqF1Az_XdzHUwVoAjJdT4QqCr3DDm59hUDc
 lmxWUKx45.d_JwjJq5y_m9PHpuAOzRjKfeV3VnrbE1JkKkfIrdVa0qKevDyKT7RIJ6tYXRuX6Oua
 yS_Mc0XcDUCNP07JmCxnntk3f2vAknWQRrhwmM5Vrvy.2Ms9I._afIZFdJoWMRO2EkUXDEpBUZnz
 HK0iJhIiJApFS9z0WcT.jFWwJqeqUNFT6S1IVrt2Xmq2waa9EvN4GCgUORQ1C5DQz9k1totxs8Gz
 YX.jEKFKv8HPxLKs5v10J3he_oszldXHwRRj8RmqZwSa_2KIoPGBBcvMjHYzGWc26Fn1gZu4jFlL
 2Xg8Xn27PKCVYvifdaplV0T5GRXtLEdOmwd7MZsGeRKU9AbZ7Brki8a6Pgu8Bk6Z.PT9En1u9mZ6
 hzVT8zjjLVEh0htyosyYy.fh7g7vFasff6AyS4KycTrXGm9dmJRXuxvbzJdtqohbM0LFzhKJR7ue
 wY1bwY_PP4Im1zEuHcTGqBq6Vil.O289U01fqhzazTKT0TquvkM13r0X1.ekrxqdFTjHztMYcrsp
 vtjuhedblUf2xGrbKPOfj.Xzd3aEtFM8iXzYXzAtx2CThawlkU0fxK11ARAwC5Jj9DCyd5ggpJeG
 d07fKORhaRipG1I1Dhs25dc4JktSiJ5Uub86cf00Z5w4iIP7JAZqHDyJw2EKRCcAwUrVJI9mW.B8
 U0lDrjkNw1rboLGqudaMd7A22QD3j39ZZT_xFxitGQu05cEMOMdjK3UZ8IuBk.F_gFcQmFvynKAj
 xp3_8TZC67F8MEciunQi2hBp7T5s6Yaunh2iCKJjN1DrJbp4xddIK8UGDEfy5wH.e1Skd1IVGWEp
 Gqm7t4bmHKUjBDMBxj5tegDYqaUSAOuCESM9njYIyqhuE9IWW92dI8n7e..beQKMRV1_JYW4mSo2
 64APWNT_eKsQsDcuZEPxrP_4mCd1_jnyUc7.1VXg6q5qV4jzQZnMQDlJ9lGLcjPD1TlR4eW9ntwB
 HJzE9BBKZ.lFxiKMQX5ye3VZ8HJQhGfhogV5zqGYkazBb77yeXQf2HDsll3P9nkhxOyZpZ6Z7oDX
 TqjW0GxdMaSFfAt1oz.oipn1wnk8xJ.NYl6D5EtcnnwohAYMDxYIQreNxeG1R8fkBEW32fC3dla0
 CW6WQ2UPNimUgQYK2OQLe9AJjd4iYIk.zn8K0PREZ.PvGxSISQs.059vfG3UbTj3oJKfD5baDUqY
 13XhhZyBxESIDTXZfIXpKt7LC3oppuNnhvnd502v1YzSuh062OuA3NSsQCbWWTBNh34eUHKJb4fU
 NhHoWEo4FjRnk3YFC3eopsWCIAkJieaFuF.8m_ecsiBSMwQZYCn8mpgaXVBxFcyu41s17sRpWKP8
 xYPPC9ADuNZE9jo..36bd59PV_eFCmTzQbZq_5qNcIG.QCgQ6p3odgB3RRzvrL53Q8uuPjHd1jMY
 fesXh8ISBx9kK.zNp.dB8BpjYdKnuRlya9qwkvX.unJSRqC1R9Lp9yP6hkDZkFp9mna4R4Z0T0sm
 X9GtbG7JIteNAQ7zmDi7pOr0jlnhiTRq70lU5xHavJrjRx_S2XXpZsxXrxRnUvEvP2G.kGKZJ4ST
 xfWKec8HEUcTq1sY01Sd3BdevtMgSmnfl8wv6Lls2GoSt32LYHaVUPbEYAlbByCPSfndYNhG.iCb
 XCTFZTipebGqvsDC_OvINSi9w3t4ot2epPzUWjuzUal7B4FVy3ZmtNQKOCCRaV_T8n3BMBfMD2ox
 dc23fg2GtKd3yu1SyUYzq_HtBOd4YsacQfQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Aug 2022 16:53:05 +0000
Received: by hermes--production-bf1-7586675c46-lmmdh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f8c2b6d5afb29179a6b494874f2add6;
          Wed, 31 Aug 2022 16:53:01 +0000 (UTC)
Message-ID: <766a755d-bd43-22eb-7a90-970a807ea803@schaufler-ca.com>
Date:   Wed, 31 Aug 2022 09:52:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <89548338-f716-c110-0f85-3ef880bbd723@schaufler-ca.com>
 <c648aa7c-a49c-a7e2-6a05-d1dfe44b8fdb@schaufler-ca.com>
 <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk>
 <20220826082439.wdestxwkeccsyqtp@wittgenstein>
 <1903709.1661849345@warthog.procyon.org.uk>
 <1535495.1661953720@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1535495.1661953720@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2022 6:48 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> No. I appreciate that you're including Smack as part of the effort.
>> I would much rather have the code working as you have it than have
>> to go in later and do it all from scratch. With luck I should be able
>> to get someone with a considerably lower level of expertise to work
>> on it.
> Can I put you down as a Reviewed-by, then?

I haven't had a chance to test the changes. I wouldn't want to go
so far as Reviewed-by without that. I don't think I'll be able to
do the required setup for the test this week.

>
> David
>
