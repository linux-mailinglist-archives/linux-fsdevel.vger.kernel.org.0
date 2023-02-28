Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98A6A5168
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 03:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjB1CqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 21:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjB1CqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:46:20 -0500
Received: from sonic314-28.consmr.mail.ne1.yahoo.com (sonic314-28.consmr.mail.ne1.yahoo.com [66.163.189.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE0E1167F
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 18:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677552378; bh=BQ+WXlqpXh/uVG2MKB5itNMQ6Bd25Ipr7yTqsr/SVgo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Lr+3eRhGyfq+C1ZSB+BQVj7xCTZ+SzGg5OlaocQiuwwjan+ZiD1iGT9PY+dUT5Q52kkk/3lyYkGZK4zfygbFjO9b0HaZ3k7PB0bo/5I5a3kubItuUAmiE/+wBDYVJ+awz2HH2j4LYMTYtCgLrndk0Nt9iaUdW5n/mscv00PvN8UQ2Vv/JIiVLv5JiHeuK3Ep4/Kr+/SNjAlAJdQjJajjExiwcyGqISD4HAoMVxR7J7MadlQzGYwbphww4W9muARwb8+316o4/WeZLrqOMkTBBQ1G21042DcoWWvu5PzqW0JD5FAniqkAvoTFUvHP91fM8YXqlHMljo9tL+qgMdRBag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677552378; bh=CQMeHqcj7aXG5ZlssH8sHHcD3WVvtuLyXO4qUFLtlWX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XOzdlBgztf+yNBsBb5135Z0taK+0hGMkGs4oN3VWZkPWwy8V0A795aGEaXASQ8rm6pc+g4ShG+wNlb1anwZAv2HCu9j5Ks3xhVvXTNR3vjcesj12ARH3LTj4Z4Tis0L3Gsl8PpkbDdIYxPhtg1mAb0ossvBom7C1rXxxxsfqJliRvAeCHOJWlqr4D6o3Yi/SM8JVCgKDHyq1HF2BgX3RgYjLJHfCeuxuzx6d8QCPFFDdMi0ThPcbQL9f3hx+ipjqCU+ezH7G5mKwQzzYS8xmAPz758QrAkYfzeTtLsT4E+XyNVr2ZpR7jiRqKWDla73xxHxceJG/jriQmbDevI1FWw==
X-YMail-OSG: ci610LsVM1mzE2wJyzYQMs_u41uMdgejp1hCT7fxgMe3Hk2FE5DaJoEXW2iwB0f
 WpAlwqs7BG0ebXhR1xCTeCvVq_pRnLIY1YMmiLy8AC7HuX1yddhfV7WixyI_DZ0nRoalNQUxYARF
 f0oZ6NUshS4Q5p.rOSOIYBVp45UZsDlD0XipBnzmL81Md9qqzHRLuGfQtMnvhwe.mfOKWtYP8gFn
 2hiSopzljNdbHRhXTZhpgE61WUnB1aQ7qXEvcERb3kwaQlo0UAVBZ0PghBTZliVS.I0h89Nogcb0
 cThtpiDwRsuEtH0IMlg6rGUyk8V_tjv_1ky3bdZS0A4qSjWy05VGz.KGFpuxnOygqYu_8m0_XBIy
 nHDI7W2PNb7VTvT.IG7OLM1Il7XBq_fFy5xCaXsGKVI2LGD5kPqaDqvP79bP22AQH8goZWJhqKyr
 LGYodniDi1x179ITC9TVtdtPVuHo7BkkZFp2DYZaL849g3H1iyWwCMiSIXiGVnaTxyQ33tnCF_K3
 cYMW9g.PtqI7BaCttIzZjzS0rfmk4GJTBtjotUeZzrCPfZN6h1VPYw84HyXu2S0.8OjAt7Klyl77
 Ha49eUujDL60MZ5HjdDHnlzNEsVcbmSgi3WXunlAZFZbKG4Vyuf14.yhEFv9JqbKpiKv2954hW0r
 qxap0mycBx1B0d4xubnx300y0YXHz_vWcs4EyBD8Mv8xIycvKn1INPHJYzDRQWKzhDNIfmi5.2bT
 SRi2kB0XMyipnZ6fR.uu5bHmQ99xDBFH_R_ZRf60DYbqw.YUKfycRD2NrFYoTfyR4qNJdZkO.i51
 I2_KqBgYYPcRb8BFW5fuD4fHCpsud8eF81dLKJkvvxagGWbm5IvSTGQOmC2hB792EFCGN5UCIX9h
 GO_t5GWp3NHotwDLE4ODQsldHIYhrQ0S3MCYnJqsAFhh2wa1Z6nqltF3wjBdPXzDCH98R8rfQrWT
 Nae6ta.s_FSPR5WQmHEC2jQcAfSlEeQWUAAj7UwctkS9LxiPVHnDN763vbMz09S6cRQS9Nw73JAI
 .Dd8SMBPTaKFBJsXNtggzsWnyXR9q9es77XHnX0hXo5zXmQj0mlfvgqdIYEkuE65lstciv2aCWdK
 6KzcshgGnQw4DXmLA.mXW86ZylktiQHC.bnScVzgalC2gLzXsc9TlT_QbksM9oU_6N.A.DzbY49o
 nod1QL60zTUagREZRfHlxlzp.S9K2iPZEckJE_xaDqoeWMNDk0705XXBw_Isy3JeQykxBuMWYrbI
 fgKr.RiwdcYlKXqeYnMXVgjz.109P45_025CwLGAHrBTbO4RuuEu8aTG8YSGeu86ye5U.d0kMmYg
 OqHbXftMrlKRhZJrP1QhI0kcLYMf.6P4JtLlml1iI4ovLLtUEF4WJJMFxsLptkKmq.YGthh1HsLh
 wmlr11mqcAKBv50IKmO3xWGJzFzhbE5bzdOg6x4fDqrfQHfIqT2zpHNM6obPgKdXaZuxOPfGmZh6
 z72cKYxD9.gtPvTnEpJPcSSsXIZk8kMUHDI9EpCsa_76O0p.FeaNdvpN0ioVmCOlKJG6xqnaJ6m7
 z2LJtL7JWapqyAi6vTyWfkeiZTjw27cYSgI_j_9tHaAgK5TiCcVGGgLTWkOBjlv_hxkl129xrw.N
 G6CpMg.Ely8UDu4Lodz0sT1FGVbXYtF6TDaZ2AC8z0PcI.j6PUbWGhGhRp.pMMFEYXvSpdDuq142
 tIk1DO2rgOtowwvJrCPyLKoshJtMzuaxWhuR.7zj4Oi03.1Ifz3TqJVoK5EKaTHD3YFdtOlySTXg
 giRq_WouLi6ZLxACfFolIJxy92P8xP7r4QHrDLL.IKBK1cQuom_z6cPzpqd2Qf72KSD9_fP_x62j
 5s1oDWF7ZK5JkFSaT.uCDdP43uzhByB2KGtZCz3oJsMdssqM2KTSyb6dXAhrbb_9cSlVuUI4pPeI
 3_9KXUPJ3ZbORA_7NihWOfRq.rva7d8kucLf09gFQqDH7XYzzM9CymiqzqsHZMDriPgOBtkFp158
 2D_JOVH7_Gbed4ng0NrrCNZE10VeB.tr7.z8fFVkvYgmY0u.zzjpUmM04TsnKlxUEWBSRN6WB8zA
 1g_MxorlOO50XfISIBgZfGI13Wjt1U_C1TRfroh0k_FXqBlA2k3AuSit1awPeEfuuq4A6lR7fSle
 OfXKC.veY4sdULIwUYN0NYzdhjeXPGQu5rslXjWJo4kGJnvH4g9A6KZLTEMxyfUy8VQF_lLWf2dt
 zkFvjbJoD6mxLU_VxJs0uPGaAiQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Feb 2023 02:46:18 +0000
Received: by hermes--production-bf1-57c96c66f6-l6456 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d4e562dc8e3f825fd81194f5c4ddb2ab;
          Tue, 28 Feb 2023 02:46:16 +0000 (UTC)
Message-ID: <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com>
Date:   Mon, 27 Feb 2023 18:46:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Serge Hallyn <serge@hallyn.com>
Cc:     viro@zeniv.linux.org.uk, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/2023 5:14 PM, Linus Torvalds wrote:
> On Wed, Jan 25, 2023 at 7:56 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_cap_t b)
>> +{
>> +       unsigned __capi;
>> +       CAP_FOR_EACH_U32(__capi) {
>> +               if (a.cap[__capi] != b.cap[__capi])
>> +                       return false;
>> +       }
>> +       return true;
>> +}
>> +
> Side note, and this is not really related to this particular patch
> other than because it just brought up the issue once more..
>
> Our "kernel_cap_t" thing is disgusting.
>
> It's been a structure containing
>
>         __u32 cap[_KERNEL_CAPABILITY_U32S];
>
> basically forever, and it's not likely to change in the future. I
> would object to any crazy capability expansion, considering how
> useless and painful they've been anyway, and I don't think anybody
> really is even remotely planning anything like that anyway.
>
> And what is _KERNEL_CAPABILITY_U32S anyway? It's the "third version"
> of that size:
>
>   #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3
>
> which happens to be the same number as the second version of said
> #define, which happens to be "2".
>
> In other words, that fancy array is just 64 bits. And we'd probably be
> better off just treating it as such, and just doing
>
>         typedef u64 kernel_cap_t;
>
> since we have to do the special "convert from user space format"
> _anyway_, and this isn't something that is shared to user space as-is.
>
> Then that "cap_isidentical()" would literally be just "a == b" instead
> of us playing games with for-loops that are just two wide, and a
> compiler that may or may not realize.
>
> It would literally remove some of the insanity in <linux/capability.h>
> - look for CAP_TO_MASK() and CAP_TO_INDEX and CAP_FS_MASK_B0 and
> CAP_FS_MASK_B1 and just plain ugliness that comes from this entirely
> historical oddity.
>
> Yes, yes, we started out having it be a single-word array, and yes,
> the code is written to think that it might some day be expanded past
> the two words it then in 2008 it expanded to two words and 64 bits.
> And now, fifteen years later, we use 40 of those 64 bits, and
> hopefully we'll never add another one.

I agree that the addition of 24 more capabilities is unlikely. The
two reasons presented recently for adding capabilities are to implement
boutique policies (CAP_MYHARDWAREISSPECIAL) or to break up CAP_SYS_ADMIN.
Neither of these is sustainable with a finite number of capabilities, nor
do they fit the security model capabilities implement. It's possible that
a small number of additional capabilities will be approved, but even that
seems unlikely.


> So we have historical reasons for why our kernel_cap_t is so odd. But
> it *is* odd.
>
> Hmm?

I don't see any reason that kernel_cap_t shouldn't be a u64. If by some
amazing change in mindset we develop need for 65 capabilities, someone can
dredge up the old code, shout "I told you so!" and put it back the way it
was. Or maybe by then we'll have u128, and can just switch to that.

>              Linus
