Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7947E5E6B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiIVSyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 14:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIVSyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:54:07 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4C2E9FB
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663872845; bh=XSaiYpaysSiPjsIqA9Ch2kSkOcTG2tmMjcJt0RmfDbI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hD0SDI/iLXyYNq4VgdUoY1rFSkSyI0RxlQKq6rvG1ReoRToP/HI0/BEPN/b5haRxABgI8iBKEVpo3GI3c2UUIIC8wV6+xw1HwSmpNnHYlXpEH5W/yA9EPIcScYl4H9SgxedIICtX9f9MtxsNm/fdsjBffrtjPObv1LUyIbuzhGhk9ucplrDphtUBf5hLDdxXNUj5thpXV1Xc0CExnRNI7JJs/H5c+l+DGxL+MP1RG2X9XldD+dzgkyIDGJUVmNqdG4gcDdvodx7XKJsbSYt/WZN1/njy0DNt9QDVG8FJNawvJHw70jCmDt4flSY5pSXpap720dfvjfEUuSxi6rXuQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663872845; bh=7gZ1yEuXpNcQ+ZCr++pOL8Ak+V7WrnUxNCvZlitrBHb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sVgUGGGVOU+elo3drspnUOU7n3hCDOViRVX0nbP//tsNVS7LWrEaNJPDuHUGxwIrQX/npk187neR1yhxoXQHql7Grnc6m0/ulN4mx33sKUEqX/OaMD9N29f+IsUWEVH9Ica20wvqhttO1HSYCRvcw9yqTP6s8pF9ck1iWSDRuBNvtuQ1QwVDQHLyGG3oXt1/3cWB2BhXbva/60f+9GoW8kXYhSBowqZb3sbQ0YZ7oWcJme9IwrGRiDGYCbiH3cpE7tq6OiaWXZyk0THQ4sdBdxHP7NvPrkIkbwK7c7+il01pxcMf9qrqf2yCVfIob11+HFfu4j5q4IfmCdaNeyEkBw==
X-YMail-OSG: cPzkj8YVM1lTlGUwfLddO8J_lcKIjN3_rEGyqDmbc2ooIn4TOPeAyx8F3wm1zNQ
 4wCIHzRK7r3MHULXLyWyfvvPStvq1.LIx.JQe.dnUdIIwyqwEezF8Rn6aUvoZ8a2J_GI.iKtizEr
 NLvKixf1mZ0ZB8HXaeh8jsCgsDF0TF3cAJfhrgQxa4jwJC4nvmch73nTvJTGdNFfvW9eQblqnJx8
 H8.1toYJ509lyvVC9DRIAX5jTYjNBIWf7Ecm5aUo5oBiNoTuP2Bz3cBEOJIvHdGZ7iLthQ6IIBZO
 bA1lY_vFfOHL5K5ltdo6EnvwjB0ySz.42uig8B5WAsLFjlfgGmc96zP_7xNVnQZlw5EGbgO1nnQC
 e8CtRM9sp4GVOCkdkI1bZI_shEGuOVVKAMZ2Y5jNZ3CYWcmacIOu5RxzBTspaviVDLLX3ffAr6jB
 vFo2IZLhYIs1ySyW1dRm5Oo2AQKR9JWX9vTeyyLnBw6b7NVb04WfCVAdyRhshs4X_16.oYXE4IOb
 hn2RZzhGEVzCbW9yt9z.WunB0oB8DT4mkrlIlqj1fqTT6QtR13.7pj1hb80zTfdbZ5z_xEjmXKWt
 D0iZFYjpXK5wQ14op2NyuinHO4o3cXeFx6odPhakHte49NTzvSPuo5.k7gbD5zdGklm10uXn_qJD
 tlfVeF9J3wrYttm0N2I4fOjOxYTrii9WHTxNq7ABJJHqZmI_UwNw54MmWUPFrhyqO05vPBr1uUHJ
 Xp_vegij_ktmZShUfq81LJZhpK.Y9eILq36SY1yBydYATjNAnOsXS7ZoAlF7D8TdnQ.obnPddfHM
 pxUk3yWmqLkU_qv8C5g4nN2U0X0633t8bDXF.nfhIeGr_jwRJOX7rcUqvyLXuSxFbC3u_fF.4B4R
 jslFVa2x7j0ZYzh0eK6tniwN33NcBXSTUz2F8FdhlvIIMdT999p4gCDjSjNuj8dvaxUhOR4O89Cp
 vfgftrTD9N49oD.FvEKFSXFiunHBVw1NU2zbahXulLxB4WiEH_QimHPgubOpJUQox28Zq9Dkyh2O
 mUgZIlXdnYfpJqEdFbkYGbnXn9_Sj0JDq3crOKl6nmzZwYZ2epljOS9R.IEoDRRec0Tki5osk7ke
 oWxKr6sXv1DybS_RGZ3Bra6esk.R1ug6WZJyLClpsod3kqRjFDTe5hCmTNUfI3GG8RpFW2J83oU_
 WL.8ZvEUBHKgoMPBgWiqHsqaKGQxxVmkj7M80CcBslEmqSkw8hMV6jFD78K55EwCSP43bBIUPc3H
 XLO4mB.hDE0N78i3t9VGGR4gSjcdfC.bJlJKe4TuEHhL0Bs_n55g58GwbsaGLHrrltc98x4NfWpU
 E1CXyLtJQncDMTHD9mBLuI7f2kY63I3Dcd7OapOtZHiAFzXW_23x5eXL3FdBmLI6_9XPNzpuzSd2
 tCucFvwHtoQPVWnD5XTKFM9l7wK_0opuCRKsaLN7uySKfWmRHU.w03yKP9rFHmDA9DaukaInwML_
 tp7pLKKWKnmUVTCmUKdWfEEOJuUOHcScZ6qxP1ojEXAL1MbfvDls5AQjYdgcGD16VnxwSuolQ3jh
 s2k6fOz2XVwO3m_iEbkheFlecEu7vQPYDe_noEANXJxM.JniGioxEBDKyyL4Om2H0Zkc58BwM8t2
 qdG4NSJExA2.UeYcsYjAcP5v47bpVyKbyIebx8TV10kwU5Kah78MpTuqMNqpOMjtAod6RsD751NV
 Rqqvys2WxX5q.GYmzuQ6xkTuYQaZOKfura2x6TdYkHKvqhXRNLGbkyht10s2rMQMFo9quMQWSYhw
 r_hKgITC5QeJCei5AjLL3s6uhmBrs_jsNo8JYa2puqdQAdMrP4BaUI09m7iIGbh2I3xoH63MAgYs
 QzAwWzy1uiUlA5Yq5ZuW9O3QdgrAwjHPImJtz_MPTKZv0BLRSWkUEzZTeFRSo.rA49M4UmtilVPv
 qfLsc2wMvaWKxxnLzn7Agrb33agG1KT9mpmETmRwSquTiuShCOM4ZWOwndQexwU2LtNWowPqNcbf
 lwxoGeVvLKd.hpqiazw7m1Tp5lyrH29OQQNDYJqBHLb5MtxAaeKpWeJwNR1ksypQDrDl9eTJFtN8
 a6.hkT0jhzVV5jaeXFjBhGPxlUJoLijCnvd5D8vKGGs6RGAp9DNYltAOmLOdy90JWuIDOiYL4YcK
 qiGaoTonz54GGbwtrQZfIQHzdFCMk7EVRP8ztuFC17pIIoUBAv64TMW29f3H4mRq0X7hivcKva4u
 4xywNM46xH0yOuSl4AOQclKMQyrbH6KpA1QcB0kUPmYAr9DQZtImxjA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Sep 2022 18:54:05 +0000
Received: by hermes--production-bf1-64b498bbdd-jgj48 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7e73fc98ebfe996b033bc0567110ef17;
          Thu, 22 Sep 2022 18:53:59 +0000 (UTC)
Message-ID: <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
Date:   Thu, 22 Sep 2022 11:53:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220922151728.1557914-1-brauner@kernel.org>
 <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20663 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/22/2022 10:57 AM, Linus Torvalds wrote:
> On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Could we please see the entire patch set on the LSM list?
> While I don't think that's necessarily wrong, I would like to point
> out that the gitweb interface actually does make it fairly easy to
> just see the whole patch-set.
>
> IOW, that
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
>
> that Christian pointed to is not a horrible way to see it all. Go to
> the top-most commit, and it's easy to follow the parent links.

I understand that the web interface is fine for browsing the changes.
It isn't helpful for making comments on the changes. The discussion
on specific patches (e.g. selinux) may have impact on other parts of
the system (e.g. integrity) or be relevant elsewhere (e.g. smack). It
can be a real problem if the higher level mailing list (the LSM list
in this case) isn't included. 

>
> It's a bit more work to see them in another order, but I find the
> easiest way is actually to just follow the parent links to get the
> overview of what is going on (reading just the commit messages), and
> then after that you "reverse course" and use the browser back button
> to just go the other way while looking at the details of the patches.
>
> And I suspect a lot of people are happier *without* large patch-sets
> being posted to the mailing lists when most patches aren't necessarily
> at all relevant to that mailing list except as context.

I can certainly understand that. I don't think that the filesystem
specific bits are going to be especially interesting to me, but if
they are I do want to be able to comment on them.

>
>                  Linus
