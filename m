Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105211B66BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgDWWYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 18:24:50 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44894
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgDWWYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587680683; bh=pHK0n46qGNNHbvt+nhMEVCKe2n7B38PAF4u53pMVU08=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=X5XTvHTFwYoDAeAEsQutEHeotvESA0Px3AlW4l5Mr9PW0w/TrUDODysoBMhTPLLfa6JGrP5+0JPtwooFmEq43i1S17kmmksmROfrAsVMuaZUfrof9PaaCnymyPyRJZsz28pX+mf7PPRcURpW8OHcpK7CLxMFZzmwnryCgOI/VRH+Pv7guBXyIUEfwNxoszStpixUFGthS/I68Xq3es7TzW7knvdb+HVNCSZ58c2o6L9h7+YMX2y2g22b/1cvoBAtSqDbDuGzDgwF+iL15Mi5z/EHBuBh620KNzE2n2SqMmf4O/9pKYw/YVGoMESJkKCLgpwjIUhiuRj1XmijvrKAlQ==
X-YMail-OSG: aPTIGCQVM1k.HK6njIZ8w8FXpXobI_DApO6hK9kQPE_2JiP8hMLTxg2dC8bhPJZ
 cNRkRlza59GSdCy_vXjCTkn1LS_Pjf1AFB1241DEk5QmWqg7rH7DBI_6AAtOumrHyFguFRfFHRvu
 VaRL._5z1ehNC4t4L0BWjAGjCG.v.F8B6ZrBbG4B0Iyqh1_0hjqvlbN7e9eqg3jo2ZX9fTRn0Sx2
 tTfpA7gYkFiwIMhxMBIwEeIY1Jf7EKnmiYvlCRYmBqyNKcurHQz3ZLDwXPGjhR9CsyMj.06l8cGP
 C7hr9nYy.57_dOnsu5XaBP6H9rEuWXY1_laoIZeKbIRp6h5D9p_WK18ST24p_Db8wIEZfjzYYikN
 NKMZyujp06t4.uz_pbznhrJJ.1kTwSu4Gc.WXuP3AzVAeMqnmqpQF298JSHs8W5.iFZmsCRmGkJA
 j8uUhdQAl85hdBez2P8taVAk2Sfgqd.BdtQSZJbetdmrVuJrhiiwGWWH0zg2RCn5omEZ.z8wT5BO
 CP3zzSZ7s.fO4yrYao1yE6YUVLWr2HRiLfttkwqYkEnLgeo1m60kEfMDM.sN1JAcuYefw03XyjpV
 1NTPegKlUe9rJHVL57QKP99RpwLzsT0DOlLFHseGUpHGeyTxQ8kmKW9M1Bqr4ONmS3RT0C7eR_VM
 Pt8unwHHwW1dWdHW43zbLT5of5NoxVK9fcEceO0lIxCcxaDBCEhsSHJw_q61X_bZ2QRjK5FdpApA
 NjdxHRcO507JEQEiN_yKWs_jXkZwT5D8ZB4JLi..nPRjuD8ZE6t87V5P_zndKClJsNZE1CwChxow
 Cuz_GDEwSqePUeHTpTmaAvDOB5TOF8bN0Atd914CV8ecLjcHpKXI.B3ctZcfJVwQwTas8Vsj9ERY
 mip9TztpY51hQW0jt7BQSG8H6KA5MrgdlXFyZIZzyeulmb4AH2ZSIFfEFX3SB7cfTNAdLs.iEP1f
 Gxuh2cDHYtfwX2Jrx1mgMtP20guUivL.mp5yGrrrlqqb.5E2ny2B8jG0Tqp1kx3c2PEJEoZkYbwY
 QvkqK4D3wwTmEY_0UBmZ_tjxJNSdigY2ZdSpoC3OB_JAyRGHWgKQdCqbeHEiTSNG8HxjpMXPhoM8
 YzmPn4JaCCIIVNSDfQb45UfFPL9G19oYamcq5Lso6LzMUnp5SURIH3gh_wH3PhwCSleTKN3wYqw3
 asd1bwwbCMJLtWD00TwYyza6Fvo6DOjrd39aNCZ1xYPXOCLnEwsDcFswnfLriIdxxoS2_8y2ZKi9
 AJtsNOzEfYsLmxtOJsSmm06Deor6T_gJQ7RjiDsRHm_PrnRcRymhB61dwdSvS4QlkQ4uVRoxG7SJ
 FLyHuVBZ3kR4ncR.jo1hGIf2rgIBBFXRXQz4EvOKlodLMjju5Nj6DW8fPAHZw_zcy6f4BzPbgdz0
 tZtjvUTKMK_VJlX7Uz6Q2Rkqlv7hAQR13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Apr 2020 22:24:43 +0000
Received: by smtp422.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 14b3f6db69404f88e4a0c3972128007e;
          Thu, 23 Apr 2020 22:24:41 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Daniel Colascione <dancol@google.com>
Cc:     James Morris <jmorris@namei.org>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org>
 <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <3ffd699d-c2e7-2bc3-eecc-b28457929da9@schaufler-ca.com>
Date:   Thu, 23 Apr 2020 15:24:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/2020 10:12 AM, Casey Schaufler wrote:
> On 4/22/2020 9:55 AM, James Morris wrote:
>> On Mon, 13 Apr 2020, Daniel Colascione wrote:
>>
>>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>>>> Changes from the fourth version of the patch:
>>> Is there anything else that needs to be done before merging this patch series?

Do you have a test case that exercises this feature?

