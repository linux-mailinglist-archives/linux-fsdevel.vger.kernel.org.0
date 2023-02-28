Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88F6A5E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjB1Rw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1RwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:52:24 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839831E2D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677606741; bh=a+W38S0Wj2Cfx+WBbh38VdGDNFE60cgTGY05el8a9B4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=i6kwr8g5/lu8GPs2x4qWDl26LFDaA0Aa/3sMSMISCYIrMDQ74dhATDZn02AkhHgbsuisrgk9m0mOg+uT25FpnG66/0OhwtrWt0RxA8T2/UKKPBXwQRmDu8XcStq046t/getRBWPaEb6rmaqxLzFe8/k9Kmdc/2nB0r28xqViVDPu697ENIZkDJmdSzasJkoW8PG9thPtLz8titSyzYzSnkPv3n0AhvhqVxftbpXVIbDeS1qhAJGPoBc5CyYIus50ctuipeO4d3UOZhUOu1bZYlJ/uUBnFWJF/Mp2zQpvC2CNP4b6+/EXRrbjAYv90kO+UW/s/EVMAbcpptoKeDdc6g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677606741; bh=GibFDfXZLJqQzhOZVG2qki5QnqiaO9jLqliJCg1AD72=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DC0+TmYwA7xhwEFX/KTxxsaFy4L/z4pb9uzOlziSmhLoSoL264JetvpWnQrsJVp7VmTv/2QFRTyUPGMQ8VGZlJ9bN1Lkp2fhu3c19t+rJWjjMlAAb7CX1KOfje6cm318LjPWoJ9PRnQjjXlDdpKIv8xq9g05HNbw3RXOKrd5s+BPy0lu7LDcgq77gUu0BL5xWRur4FlIUcOOmzKj1F335I4wLYSJxeupeimUvuFHZ3kg2d+4699FGC6u7j+b0Y35dsAWF3pLPG34jILRPDN1ZTmx9x/exXm1q/MI5S3+0D4x3iMXa0KnMoxHK9AcuSDndmupRHdxsWEyY7Zg5jxgrg==
X-YMail-OSG: XJkfT9YVM1kEProVxMPgqiH4f40BPMG4QCS_IUNoVObsmok7Y9CIVftnIhnGhBC
 zKpl7r0J0Y9w9Ptbsn980cEnLmrDPAKYiqHXRS6EfSkTOYSKf2Q3PcUeIfnqe44RStBLcLeT01KJ
 xCEWWk7psKmJDCsKssjKobKUA7FzWNZYvP4QMCy_6d4r8XqP9N7O.WNvOJmzd8xhQppL4VgpxI9W
 S.L3BgOY7C3qwBVS2f.sGwoiM7dClYqgFJlmef2C5ttX91bFPTHAgNUZ..djjRUerP9qW.tYBobE
 SYAFJjbmYMhwDIkKooacNJ2cl5UAbu8_q__.toOwso5BMBIMZETn44cblZZvNt.fCsBoWOujG79l
 fqdtlN0o32DZ5uzATDXpJoyXB31RHruW4Jx4IRf0kv02crkQ1Ln6x5zHFaC0NgGPoI0HlOSA2Hj2
 C96mJ8IhWdH1eKVAo0t2rzTKeW.JRkOii8Rh.EPlbOvZ5khjGi9ENY8Ex5MZKQSKBkpykUSsgSIJ
 U3DbSEZiHi8GdcS41deLwcTDf.Xzd4VKspCTcKOmXUO97I.irbRjakL_otxCWi6UJAu0ajtxW8NG
 ecCsVJ2MhAUlVJkMZ7aY_IKkb.N6zziJ2UIGOuA55I2VlLH43tEhduSrCDGfc5j5n0l1WCHaiYe6
 eHGmfLZufT_VSq48Fu0DFO3dl6jEIU_rtx1A_IxDz7g6uT6rP_mlzLiwW36le9Lumrbc90TqHG7D
 OCvpj5YgI0.WaMPyA.o5tBxiYRgsyRtgqOgsk667W9TKvQzrJOYjVKrslRIi7pzHHeRA9aqBl1hL
 P4pLlg.IR8yM_3a8HskcupRDoZFd_8kADqums5AJxVWjZHVSQ5wHpyLkmz1VfDVybBdvve.NpaxL
 yJ6ENgb6u6TEPCJM7g32dIEG2bnlNA1XAsYo6k1Psw24EFp91HP1G_KVxRPOpGnDsXnt4DtKoJVj
 2xBvZivpRc5js9QZL.LEyba180y4YvsyD.r3ZWnslRyp899ZbcjAtvzZs24mj2ve9VC8DYdstH_T
 qWNX47k595FiiQKC6ipvsV2hx3U6NO8VP_W8VaObZCY3_iaasgUMQAq848ogBkfp33KV4VmvttC9
 C5rl3.bv3aQJ68t_leNuh6NENcz_ZLk5NJ1z6ldNj7tBDWJa2MM5863JR7Gj8Imqjj9ggkmq.Ofm
 197uXQakXkhJL2HGcdd08AJ16Gcasso8qW3bZm__be8u9s4WO7pN6OiwIwK5xce.9lwtCTaR8nXD
 Ziz38IC1IB3uDEGGh1ESnoEFgJFoAp0UJjjNUdAj_W1ilLnJCJ0Dp1AWn0CcTma7jVA7f_u5qUq_
 WUMBnir63WPKqWqPth4LXGlRZF8WlaEOQthzyM_UbL58yWhTdLMW6k94BBZrpG10PUwWB900DjcD
 qpACf89qUvnghZMVaZguyO2CZdJB9IyDurX.D8pnsvfVul2iKil8Jv71eVSIwHJlv6hJfJbVeyCq
 cIhX4tfuDyu9tyjUVVCCquoqd8CatnbG75ekScyGEMCGiRgFNo2s8sjc4GbS9ldRuJ8N2B2d0qTu
 xlMJw.I2rBU91UdJd3hm15A1iFp6Kh0pYpRWa2KTdkOFCw7s1Uw7EWQe7svMczFh.MqnekQyPsyk
 UgpnE6_heJplBme6uJYQLQaE5Rwchzn3Vzz5HLr3vblvnr8ixIqb2QATh.mO2fyGpEYFB_mr23X.
 Pu961.ZOWwiNRd1oMlOB9UFSXlyffLoReGWu7RsrnT2yBvpmiJyTM.oaKNFjbPUCxou.NNHTt8CZ
 9vcfu02WglC6p.Ht6o1K.bddfhEGkeaIjRDDzEm7w0ir9YretEeA9uYWU6zGDVHGiD0v0lVqG5Ao
 hLEV4k_.RtAgqlRgw2rOKz_oBAryjhIYrF4Oes07HbbNDB7BHpATsJH1o4AczMCfkYbxnr3N8j_P
 DFoAhGm5IobJzlPDUrTHuVR9.GalpIcFiejV.Xq3GEWqL31IESoeD.t5LK5vMrYO3439vVnchk2y
 VgVCrhoBQq8tmU0hNU1jedMuzxSMTDtclAvgq2l8JeQdG15ZRFlHGlNNk3aqDzeZLD94xlnVDOM1
 uwLfnopYmq3kGInbzzOyJqx.7DKx5pyuyXoQN1ktW.uM.X5NZYzN3ePiRPUdG92if2JNL8GZ9nQi
 nIt.nSav0gSKbrUmnmsJAVLm5sVYoJbd2bLJqkE905hBgq8.sVzTkV8u1ADkiE6pQywLswxm_fMD
 veiv_8YDCt14ibvjirBS_C9g423wvbRbWdVay9ZfDCs2oiHaLQeaQ1zpFdOxsdEzOx5_fw6FrN1A
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Feb 2023 17:52:21 +0000
Received: by hermes--production-bf1-57c96c66f6-d255s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2e904187b8fcbed5f15b154824e7d115;
          Tue, 28 Feb 2023 17:52:17 +0000 (UTC)
Message-ID: <56e7fefe-0c42-14ab-1962-098f9fcd2c0a@schaufler-ca.com>
Date:   Tue, 28 Feb 2023 09:52:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com>
 <20230228173225.GA461660@mail.hallyn.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230228173225.GA461660@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/2023 9:32 AM, Serge E. Hallyn wrote:
> On Mon, Feb 27, 2023 at 06:46:12PM -0800, Casey Schaufler wrote:
>> On 2/27/2023 5:14 PM, Linus Torvalds wrote:
>>> On Wed, Jan 25, 2023 at 7:56 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>>> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_cap_t b)
>>>> +{
>>>> +       unsigned __capi;
>>>> +       CAP_FOR_EACH_U32(__capi) {
>>>> +               if (a.cap[__capi] != b.cap[__capi])
>>>> +                       return false;
>>>> +       }
>>>> +       return true;
>>>> +}
>>>> +
>>> Side note, and this is not really related to this particular patch
>>> other than because it just brought up the issue once more..
>>>
>>> Our "kernel_cap_t" thing is disgusting.
>>>
>>> It's been a structure containing
>>>
>>>         __u32 cap[_KERNEL_CAPABILITY_U32S];
>>>
>>> basically forever, and it's not likely to change in the future. I
>>> would object to any crazy capability expansion, considering how
>>> useless and painful they've been anyway, and I don't think anybody
>>> really is even remotely planning anything like that anyway.
>>>
>>> And what is _KERNEL_CAPABILITY_U32S anyway? It's the "third version"
>>> of that size:
>>>
>>>   #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3
>>>
>>> which happens to be the same number as the second version of said
>>> #define, which happens to be "2".
>>>
>>> In other words, that fancy array is just 64 bits. And we'd probably be
>>> better off just treating it as such, and just doing
>>>
>>>         typedef u64 kernel_cap_t;
>>>
>>> since we have to do the special "convert from user space format"
>>> _anyway_, and this isn't something that is shared to user space as-is.
>>>
>>> Then that "cap_isidentical()" would literally be just "a == b" instead
>>> of us playing games with for-loops that are just two wide, and a
>>> compiler that may or may not realize.
>>>
>>> It would literally remove some of the insanity in <linux/capability.h>
>>> - look for CAP_TO_MASK() and CAP_TO_INDEX and CAP_FS_MASK_B0 and
>>> CAP_FS_MASK_B1 and just plain ugliness that comes from this entirely
>>> historical oddity.
>>>
>>> Yes, yes, we started out having it be a single-word array, and yes,
>>> the code is written to think that it might some day be expanded past
>>> the two words it then in 2008 it expanded to two words and 64 bits.
>>> And now, fifteen years later, we use 40 of those 64 bits, and
>>> hopefully we'll never add another one.
>> I agree that the addition of 24 more capabilities is unlikely. The
>> two reasons presented recently for adding capabilities are to implement
>> boutique policies (CAP_MYHARDWAREISSPECIAL) or to break up CAP_SYS_ADMIN.
> FWIW IMO breaking up CAP_SYS_ADMIN is a good thing, so long as we continue
> to do it in the "you can use either CAP_SYS_ADMIN or CAP_NEW_FOO" way.  

You need to have a security policy to reference to add a capability.
Telling the disc to spin in the opposite direction, while important
to control, is not something that will fall under a security policy.
It is also rare for programs to need CAP_SYS_ADMIN for only one thing.

While I agree that we shouldn't be allowing a program to reverse the
spin of a drive just because it needs to adjust memory use on a network
interface, I don't believe that capabilities are the right approach.
Capabilities haven't proven popular for their intended purpose, so I
don't see them as a good candidate for extension. There were good reasons
for capabilities to work the way they do, but they have not all stood
the test of time. I do have a proposed implementation, but it's stuck
behind LSM stacking.

>
> But there haven't been many such patchsets :)
>
>> Neither of these is sustainable with a finite number of capabilities, nor
>> do they fit the security model capabilities implement. It's possible that
>> a small number of additional capabilities will be approved, but even that
>> seems unlikely.
>>
>>
>>> So we have historical reasons for why our kernel_cap_t is so odd. But
>>> it *is* odd.
>>>
>>> Hmm?
>> I don't see any reason that kernel_cap_t shouldn't be a u64. If by some
>> amazing change in mindset we develop need for 65 capabilities, someone can
>> dredge up the old code, shout "I told you so!" and put it back the way it
>> was. Or maybe by then we'll have u128, and can just switch to that.
>>
>>>              Linus
