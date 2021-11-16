Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAC4539AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 20:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhKPTDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 14:03:35 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39910
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239669AbhKPTDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637089236; bh=iKZCNnZA8mKurfY2xcDf1xTfNga+uLdl6MyBXJlz4uc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IlCH7UXbsHb3z0KtV0Zi4KsaknBcLvperNnezhGl15qcbrSpimDo2BPd7gXIGNguliYf/M4D0X1AjPtZTJctdwl2U+kd2cp7OZA+hCyrBiLKWjVEBgAAeKgkscCQ4VeaPUaW4OrEFXvVnmBs15uCKVRuErwj1ObCyugITDDdxNZgnOqjmB82Nm/BKF+p60ZCbiChcx7EolKMZ8cbeFI4F0ZHxwdm0zH/ZsIM33XEz2OP68BpuJReaA0apJJaQM7gm+85vO/UpRZlv9XG8aDknpNhP+FzngUfsLzv9byuq1RUPiWVNyMWdaHDQK4i5ZY72A82yaJJngVs2NDDy3OB/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637089236; bh=KakOMrcQOYQF6zPpoNGmpyCyNEzOa7vc472gsuuEvx9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aeJjUhU40xCYdNvg8nvLqVqSoO0xFZ4rXoxf2hgziY/Krx0JCEXxnQS6XAF1ZvL8fDnWdU3xAyA+0DTJDfGSW74zCDiI0DeRIu5S57lCyO8wlaja64DrQ+kYkcxR+Bdk8Zn/SO3/U/LgI7ZC+u9x6srlnMv+av371HY5b5uqWtvJ2VHEIxQZcAjOq4hnvcE8oUbNRzyYEKuaXadHLEVpYkcSLX50BxHZAltxjpgVRu8gfVe1gs5AzZ+g5wyBqjFm5Smx+PjtcWJ+4L2/PrBguWMKWjxxFbazCk8dFvr8F12wjy7poaQPu2lAFiw0/PMBNdkioOBliCMhaesXQB2qaw==
X-YMail-OSG: dfV4KL4VM1kt.GaOicztohoLnrgWtyS2u7sPmOPbByL_RitHu.lxaIsY1XJM0Ez
 mdcuj1dEhSXoO9oU1cBoSLUC6Zt27CBqCzkbx4dIimfdMAa2pyu_Tjvma2w6JddoUFXzusdUcOsn
 0osUUmRf5W0KMjIEocy_SQmW6d37YsgYK0wUHxvH9ie473oa5X0N3AUy8wD6bd.qQAvqfacokBtp
 UVxbyopGr8SdJHn8p.Psog.4FyHKpeli2J9Sa16JwEcN3beeYXiPRMkaYqd9RfMOQ1S4rOBGa_QY
 yFVY_P603FArpIViHnkM3YhVZ6zQL_.UbrKE_qIgTkM.rX3we9jpGhRejh9bEIQkeZUYR8tashVQ
 ewpN2.bC8uEPuycHdbPCzK_54tKszy51Z58lUSp5wsl0pOLNq91sJO9v51.sC21uQkIHOCRA.t3_
 UrCT7wYwGMJoEOBvDxN.6T0GP0ta6oKz8Co2kf78GsZs3H5B5O7LQUxaNs21sYM9WG1Ub5oytsvJ
 tmF.16CyUDwIG99CzudDrzBRVeu0BTGn2J03_smiqE3mBL84HbFEqNjKOoHYXrxGO1yBG4j_FYYn
 ioBwy8KpvFsHLonOWaEW4LYa6IkzqUtLD86YKd9IIt2DDWcKCSsg_Sgo24eYB6M.FWoM8_eCplzr
 4w1lGJku1G0zJtQZRGMvXfHGpcxTg24CvPQ23j8ZZ7AM_c5gaOL25gpoVsi399.KhybBfUDIuoNP
 fsaeJ1EQCr3Y1qc1mmy9KkQk1En6sca6v9huAOT5MVzHDk67HbvnLaMhfMOmcKbzvE9TKIZ1BofN
 p4erxAni31xY7WQSAf.TZ1vhqkMYsejVBSous_rmKBmBK8wzZ_6O6chyetspDAVi6nfeSRQXxOqF
 Jvas9RcspTI6AwAsN2LKH9ByoMFOHNRxi0K.MgC1r2AQmI20nkDwrM45jyGaV7egh4cyhhQtU.0E
 8xSgF7J9.KFzrpNgIo8Uy1SgBJkjds8amBCypHUDG0pn6J3aBUJSE5MHR.S0V02oHbuiFiHsS8wH
 C0z7RQ4W9Izz7nJUIRcGMnfAtuC.0ZmGFxu.Qs.dNjKWUd4oZdRCht_QjlO0OKaptnioNkIF_NQh
 T2DIBSFfMKxpmxrDKtJQn25_vnbu1nzAsXJAfPpXVlCuAe.0Cri0JBTgIZ9BomSjre_wM.kfGOOg
 qm4ZVbdqPYj7PkV8FZkhYgGnHI4I25iDyHyMNakkjsM8MIwrdyWstJKoaHA3mYiI.s4HgLGFqE4E
 nn5WT4SQfFunyou.h.HCoq0Lkzzcqnn.gc7MHxYOqGrrUf25lA0JEkVAgvCt_kCiDnnfaC3AxLT1
 OjSqV0r0w6mcbl_USL5fzd28vp4kc0ePGL5OuMVVaFf8a9kA0nDChaSAxFzd64pnqUg_DoKZGKlF
 Yf26tACFNBYFeegkD.BQJdvZMzk__qgQrOlUQNyc_UREopzbfgsqvoE9lJw5wvV8AUjapuj36ffb
 TC8jQq2o9H6M0H.FerhJMNECzowd4oh1y6XdBc2nkLUtQ1SaJh7dIFBxo8IUQ1pH.ges_xMFVyUy
 aB4DEzUGYmwrTxxlu1ERd18Rx6_YNXym7L4OlLD0NwkQoN8YUX.uUzmiBSbCLutyXO3CFxxDHpZQ
 XrG02UD8KN44_5CKT7EzNEjs0vYSxXESNald3nnJpGq_l9rLOY2C8CMcOrlg5RDM6PZX69pk9WYc
 cHYjA4GDLJQRweZmKFXCqEgsIRRcb0OEJ_EqHEbzOXjA4AntlQr6.UFODumf7wVvBX9e.J0icsnF
 Lp7tNKQUMADr3sWwjUyh7fMOBeJN0mPtLp5Gz2qsJwNiiOa0Gj5hUMCrtDmVKsKyy8C7jcxaeiLn
 mt8N2Z4tpkcpeVJXss6qZrcj8Se9nQZY2C0iDtKgVrzP18lP0ipp1UH7jku0kmW6C2.QUv296xD.
 dBKbXREiJfTkrwhNAGU3oOQf7EAH3GXTuPuSFB8C4tgZ1DYcwwTUW230Qs7rUHXEyx.lTa56GJz6
 _hsATdtKFC1sy5xYkmcPtvVrkNJASjY5nU6anyAct_tiu7tJM2kUdpzRnn.XTcRvShzcdq4qot5k
 n9MZrEpAsGAwDBA.RC1tSUq6y6_F9IU9XDIyWdDX07svYEyrsAxr6Jd6bwYLK9sJ2eMBZCtL0M4M
 Lx91ER7ORK0MDTPpQRbdaqt5Do0LeDuRq8q3217c4.JKP.JtlH5BGL909INx6R8O4mga53VWNUCr
 qjyeFOmSqSq067BWooNhEXr3mJ9PH_9WLz20-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Nov 2021 19:00:36 +0000
Received: by kubenode523.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 16992bd20597bf90782469ca1b8ad7d7;
          Tue, 16 Nov 2021 19:00:31 +0000 (UTC)
Message-ID: <fd86a05b-feca-c0a9-c6b0-b2e69c650021@schaufler-ca.com>
Date:   Tue, 16 Nov 2021 11:00:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home>
 <202111151116.933184F716@keescook>
 <59534db5-b251-c0c8-791f-58aca5c00a2b@linux.com>
 <202111161037.7456C981@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202111161037.7456C981@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/2021 10:41 AM, Kees Cook wrote:
> On Tue, Nov 16, 2021 at 12:12:16PM +0300, Alexander Popov wrote:
>> What if the Linux kernel had a LSM module responsible for error handling policy?
>> That would require adding LSM hooks to BUG*(), WARN*(), KERN_EMERG, etc.
>> In such LSM policy we can decide immediately how to react on the kernel error.
>> We can even decide depending on the subsystem and things like that.
> That would solve the "atomicity" issue the WARN tracepoint solution has,
> and it would allow for very flexible userspace policy.
>
> I actually wonder if the existing panic_on_* sites should serve as a
> guide for where to put the hooks. The current sysctls could be replaced
> by the hooks and a simple LSM.

Do you really want to make error handling a "security" issue?
If you add security_bug(), security_warn_on() and the like
you're begging that they be included in SELinux (AppArmor) policy.
BPF, too, come to think of it. Is that what you want?

