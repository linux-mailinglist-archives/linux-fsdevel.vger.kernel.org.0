Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF5456267
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhKRSdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:33:44 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:35093
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232978AbhKRSdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637260241; bh=XafFedPH7s43+MtcyjIXwoQYQrKIPGHG2kyqdRzE+fM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U2BXMRNBinflz+OQvA9utqPlOSrDwpQ0thgapaUmGwvZS4Td4PeqY/6H3ouTUGg3/GuMO7/ohYcAKTOyAPJHpbHziZ9YXs9RyrRMEyL5l4vlg4KQHX0jhM9jRXnexyA14BnR5B5Mi60d6ygeIoQjRrcTIVDQbxXPKHmQYaHMhBlyRUgcEmfJRwRjYC0II/KMnGM8iYSucj1YBvg0yfzMDYoXAO+n8tv0CDMUBB3awbygJsJKB3/3CFVVl7Zd4rIZZHLfPrKxJWLogbO1Z1yooY1dhhnYtJmw7FEZcTpNa1/1xAYRjDV+LC3lx+xlPOLJBis9ijNrGTUSBMfnds4Ujw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637260241; bh=WD/iKJ8YVCq+L7cGsdVhIU7GY77lZO0y8QorIJr7UAt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UL64Zxn1GUtQTE2Fc7NPBQAEs+xiOXt6gJwElTOobHfMLEZ7WFgRu1M4JQ0VBCZItFrC4KgIBxl/caZO/ETLrnIFAOQBuhhyBJqGHRQT7hNir0UOLwubmEavEqWLAoY1712ZIpcawFoZIOzClmu1aVBmPXzgZoklKvVgR8Ojp755p9u9APDI2vrKT592vaPbDUBecZHeq28F+vhmSGXyKMxtLLRdwGG/wEcPYyJEpa3qM+Adszn+oWT8TofgKck0q5qNNJlM24HA6+nKpXFuLam7XzGvxN85LaKH+2UPsNrDNK5WHC6YHc6zYqZ6GmNNFLq36gTAMtIZaX0+FAkHzQ==
X-YMail-OSG: VTULgO8VM1lMyNXM5G7EqDOwioUiaYihIBA0G7qJmHC8uK2xpplkZhesWLKtIEC
 yvoVAcyHa8_3iRybnGoJae4.T1r1ZtDuWsDUCvQIDGjqJKN19QfgMYumqdUJxYK_OVKJtsi35Uhq
 8MjDwF2CscAE_RZJA.EcNfaLHTrlwBYach8zGymjimhmY9sEoOyf0DrMum09PjPmaYZDHIp7lUGl
 YlOohDVUYGI.xAlkotn.UgGjvLw4givru8z.WJLH9hLTlzK_aNJJffWNjhfjlLgsthpJNUXlA6P4
 xLbI6Rz9IAbIQ1R6NhowpbG_3kYtEXFeORxBYr0hXnoxEGhkcKn9.PwOj7wUnCo1VEYxnCDYNoGo
 NpgUowPRT_lCFoLGPnHIYcB1Xub7DIxtZ6deoS9Zvq9776PnYpSTecm8UN0BKbIxQ11ngk6BXkT.
 YUVyrER5yeHbRWU8JLz8eZxsBT.5zgi.tjNI9Zfb.CXLLmKBh0lBSuud6I7FdZ.zc26WC0G5UItU
 GqgNLC0kRfxlDGKBACuhvCMIpxgaOqJ2pBAbpoxE8R16yILN0vwsGL3NL7Q1p4r.2gOs6K1Si8hI
 sGd.T2DztJA8gptoVJVTpvd72GBa9g7IMClI0LJKXVxQSa0wunZPmDnpXJTxnKjT_jtjIE7IanTU
 2M73OACHdw.2Lm3NiZ2zhRbCyPZXHZ8eBxioPSOlJllUX3Ji5dUE.UHii1GIZ4UBgkc_9qQa7iaf
 NrorRfAi9TsDEcQc8jOH_5QW2OgBxYEQzvhdjivEhO38cb6l2q4JwY7.riFu5m6alBvRFOZRUNH4
 5e9Ki3RzkZRgFrb8VtAddDjcd6BNIwunBYRhlIrPxVnFK6c9jtLotDhvKE9ZPVYFgrwFOudTcull
 AvAZ9E28a.Y0Bi_avSyaCQTz1ATUgZhGzTk1lG10bSi7pp3JAWnUHoSeUVIIVwebTNdHxfSJYNrq
 tfg8qbaF8sI2iv1IY75tIf0jWFOaPOsinN3RW40Zn.m8Afba.0PzFHL9yU7T7xrGTETORoHoFXrU
 jYVI755uMdlFwCYh2Os.CKQTx8vIGCHVeD4FfWJcs2ysy7SqLDYLiNuouh3Z0merZdAJoiVqOchj
 2ZNChFtHnWAKX6UU1IDP4fEt52zOfY4QwqysoeZUiU7v_l3mgo8ZJE1p1nkwzR_4vi4wPJP1mD5c
 2aM47prDB.V_SvzSYgHWUNFSwo.ehYtr3V2YpqHJuoLK4Mz3A5TyTFGKMrV6aP9qIONwqGhlahcR
 1elIf474odUG1kX6PyPmFUtyoZuO55_Tl4._g7WR2ICtulvSPkpt7qTWR0dUajtddQCJ8gvbQiQD
 oo5fLKKS0FczCkb3xXJszK8yS.Vk9VL3tcnz6KQq_EpQuOhK1fvNAVzlOltdi3emdSRDd4yNwXhr
 XuHMTfkrxZm0LEKjoDUUDA8C5sk.XAJikb0WYVIt8ebsU0xIVdLfSrad5nPAtktr30YiuPT9OykV
 FclwVRt6ZDLYpOHDVJIog5iYEDYrc0wSHtF22YT0mkvg.d8mmu_HXCcCYsvxRZsjbLNWfm_xL6Lk
 F4Cv4xonLujQ_uAbRKTa51KFm3d5zhyRLhmgrGB8dTNDFVASCAC1aHtSVmAsjQYDNmlIagvMTnAG
 mxyBlk0TstaQknaQbONWuiW6wFEJ6Bt3EeauGAOaPBKGYtIydXo4rL3HG5szkA3b.f2yDxJ_.4Pq
 0clG4AGVAzzMdhglv6tNiQXKZtAN4iGHi2vHjm4RAQ3HTyp_WxpnGBy_6BLCB2c6ptRlmA35MEUb
 GfM9L1RzBTa62.aSt1rxLvburWnbTxhMdkhXmqVjVxbB3B_rwuJ1PGNKpnXMXjCrGBRerGihbbKO
 gd3vdSJFy_AmtKGcupmq78KsJIBrqrqdZBul4V8d3M4HPe6GjfWpZvxZ89KzVqetM_LhHlx.PgYt
 u87JEw9uLqrJrxGznHBXkTCJhDHVt6TqicfmaFqYh3mufJS7dK_Xgjw1BOGsz0eRNbZJHaq76OFS
 gghT8gtEVhpszJUINlokLt5O3WWw3MEvQxariE0jYsZ2SK1E_3d5s9yV4FUoHv5sFuhjXMJGLDQl
 oYV6_13wCxXRV829WQ1gme_Nkd31piHKyJlYhLNvrbGscBAFkJYiZL_n85oxaq8kQjDgmzDLaxgx
 9kfvl6l_Pv084jFsjo2fQLhto.QHJi_CStEFSxsNqW_7lmL5HpCTUSI12_OLXpeKUM8uyewMa7rk
 3vTWcFgZ5KxrF4Z_UyWg6lw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Nov 2021 18:30:41 +0000
Received: by kubenode503.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e5e3fbfab78e6684116fbc0b425b72ea;
          Thu, 18 Nov 2021 18:30:40 +0000 (UTC)
Message-ID: <16baa1f4-972d-c781-2d57-508296a83bfb@schaufler-ca.com>
Date:   Thu, 18 Nov 2021 10:30:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
 <fd86a05b-feca-c0a9-c6b0-b2e69c650021@schaufler-ca.com>
 <202111180930.5FA3EF0F59@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202111180930.5FA3EF0F59@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/2021 9:32 AM, Kees Cook wrote:
> On Tue, Nov 16, 2021 at 11:00:23AM -0800, Casey Schaufler wrote:
>> On 11/16/2021 10:41 AM, Kees Cook wrote:
>>> On Tue, Nov 16, 2021 at 12:12:16PM +0300, Alexander Popov wrote:
>>>> What if the Linux kernel had a LSM module responsible for error handling policy?
>>>> That would require adding LSM hooks to BUG*(), WARN*(), KERN_EMERG, etc.
>>>> In such LSM policy we can decide immediately how to react on the kernel error.
>>>> We can even decide depending on the subsystem and things like that.
>>> That would solve the "atomicity" issue the WARN tracepoint solution has,
>>> and it would allow for very flexible userspace policy.
>>>
>>> I actually wonder if the existing panic_on_* sites should serve as a
>>> guide for where to put the hooks. The current sysctls could be replaced
>>> by the hooks and a simple LSM.
>> Do you really want to make error handling a "security" issue?
>> If you add security_bug(), security_warn_on() and the like
>> you're begging that they be included in SELinux (AppArmor) policy.
>> BPF, too, come to think of it. Is that what you want?
> Yeah, that is what I was thinking. This would give the LSM a view into
> kernel state, which seems a reasonable thing to do. If system integrity
> is compromised, an LSM may want to stop trusting things.

How are you planning to communicate the security relevance of the
warning to the LSM? I don't think that __FILE__, __LINE__ or __func__
is great information to base security policy on. Nor is a backtrace.

> A dedicated error-handling LSM could be added for those hooks that
> implemented the existing default panic_on_* sysctls, and could expand on
> that logic for other actions.

I can see having an interface like LSM for choosing a bug/warn policy.
I worry about expanding the LSM hook list for a case where I would
hope no existing LSM would use them, and the new LSM doesn't use any
of the existing hooks.

