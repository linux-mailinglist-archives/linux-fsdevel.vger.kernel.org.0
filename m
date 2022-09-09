Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64C5B3C83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiIIQAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiIIP75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:59:57 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B76370
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662739187; bh=J2wkSB0hWoulJFkXOVgp/hE6iPhuuN2lxPG6RmyE9Rs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MlRBfQEKWSL5fgMO5qz2aq7YWTYfJWGce8GIjzu6NoSalSiz+T6utRfiNcDvuIRnTpjv/+oduKhva6SMDNJC73UvV44mZoBH7uxc0obG+C+VXBknjEsJTdnF5mU/EZ6+cWwBZAcogb+01nFvTdKM8T9J7nRJYjjLcXGCHCUpjUYZgTJa1XPZA24FBz4pfFXGR4NLjbN9+HqSXLourPZYuFJuGL7IjDvpox7qAyCt10XosWoisdxuiZAswXK9tNGnFe+wiZtx5AP1Z0SowMkRCeKI+cUZCuOqml0nEI4U4poEfcpJJ1Ezp1B2Tslib4vJqdmmiOqzmpQ3jk7xFi+knA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662739187; bh=lWO/J3Yi5t/b2Jg78CQimCwtLOjd7wgS2astBGkeF+I=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iao/bYWY9rf325QcS5H21/NljF7g0xfP0xj2DZ26jdsBsdhM/Q3z6rZ8lcqxjXk5b5xL9oWeTawqRJy2h0G8Lyo8SuA1mSihGU3ZPOWlahnIJT3mg6TeG5ScFEQKSRgN5oG0U1sb0mHuhxbsavf2UkWSvRrjKNNbz3DSV3IPsll290UccoJ4hWgXi8p5hiTcTxP08YhJwfRyuSula8SD08DHXfmDQwlSKhhduzkxAqZ1bD8YLh9q4e17iSNV5d8gvGOF0zZqdiIKrnbX8uSZIegeexLTb13qaCDV3JzMAflCheAiNoJBMMpN2ZXq1W5EcF8mfbyn9VzCnPCv3rgnGg==
X-YMail-OSG: S7bJKGoVM1kDGvw6LCHbv3xcHN467_mW58sJqxDk4Ne8GblYJ6yV4V30Ih78FVM
 To5gYvAGEl4p2b2Ngikm_vHrvAjiah4pZxjXLfxenZOY8Noeqv8tgBo14u5FOhys1j0O_1EuvT1b
 FDla1Ot1_uXRTJXlKvylm1EqNfV18bdkbQBe1vT4lxgP_sKxRTY4lBBYGB8NHIamwKR.BZCKN4Xa
 NcmlKUehtPMwyGXf6lwd8NrWWfSqcmN5k0nQwsxGwL3cya1xB5mVlzfFI8grXgBn74K2TXm0a0Xx
 zpwdnLO9emab4SWBt4NRpNmfEhK7hus3Dpv6gGzrDgVPpejBCjf7rgjvJWZc6KLttSIdqDrSd4pf
 UZDquCHlcHD.u_KTE5gai03oGuP0E5ena3SMECzwalJS4hJR4UeJ.GNnWCRn2IDRIjNcYbmRTIBd
 7tQrzxF3QKgVVjo6MnCVIfEHqnpym6tM75cMVEafVptDrfTgyRbc7eWtC0bHXiG17UNyUq1oq34_
 lOu2FClirreimLJYQiritrBV3LWWfVGj4vAEjqJmuDAM_hSztnpU7dKdNtgJK.9rNcGQ.E2KiHQz
 pNrWze8obSee1sknnGkt.nq.XFOacNeH5L._KSMsloJwL9NexbW81SmfhjpxPWg9IjOtB8xuv1hk
 RkLJqfwp2XQPdZOHToyetMQhUYjV68ng7ldOaJEMUteU76XFHGv7jttAxv5hFHQnQ_kLfoTfZ8ze
 JI6WsMSG9HMAiR56b2ogX0lwmPO0dyhJrG.3ZLMWp2ugDJaSU7K4L.3V_Ieq0AxQcg18763g.ujk
 mTakZkeHzze.P0BRdQbFIskgOaZTOikmhTjsdR5s1a6r42tphZBguHy2WNggBhLv08s8O5mC5e1q
 Kt3VCxbDSe7SNsYlGfISTruiJEOcNPtAS.jwmAynk2lIBSARCGFWhtuwDtbAACpOizpvtNXTzonQ
 fAWvVpaOMSjuGZygsI3K5TI9p0LwTQGugDC8qo6y5.ma4CQPj08AyMtxhiSOBLaai8W9zbf8I0Yj
 SnFKACXs5oglV17SgGxsyVmoOOaSrh1tFEsQdUZz2UhLAwGgOqG1oB8zPaoF03YCyrZb7S2K5.pQ
 U8iAWHTKSBIJkXNugIF62lVD3kU.xC0XUInnaZ6DBStnAgwinBtMkvDryAQAHcp.jEfl_2KfJCvp
 ASE8BYrjrdLelbyNt1DeTOZK0hsR5RG.hDWBQqVyzWaG8XGywSWednt3MhxlswnHJ43nq._5mR28
 Mc1misiIBUi59wkEkdaYv_D1MbWtWUz6zsfuP5nOGXplbs_Fbwv.vQRFHw59lm4IgtW7ghKiRO3F
 3GMyFMjfHU8fwajWvIOm0C.k7cb4LfTH8wtZ014qS3F.CnbmiTD82TkvycZFRzYYX7Wjsu.ALXXd
 jyG_3QRMxUV5sEkQWDJJTk3IvmNMuIqkUKTlAEr23eibO9RcTIxKU0GOFN62uWnjzxbvmGOpogRP
 FlmoHxqQsHi4PdQl3daGOx9S5LOl043VbGq4VsEhiyYqJ3XZy_j7CELnsq.TM1vg0mZT0SHyWyR6
 3mJWVug7xgyZgq5.RrTiVrSSS4dnjBhdEDR3G.2CGxOSdn6PRH9bV1RIRbaiAbAEx_mcoksrkJXI
 BT8XUCz90DbTubKvEUhuKncMg.Ru2DIdiLI4vBaqZkJ3Yh4n28DrJjZB2kV1mHOwyuRHLFOKPFUc
 LksrhrniyB4sg1TL2JbLMopqJMpEhu38pJdwphVoGzlZu6OHgIY9EJ4.Vy2fTm5Jnuv3_cxo8Spd
 bjnA2i4Ebn8UzqWyNe6Riva.HBSKiXwrfgpO0HryjMoLxbkzZ3yToLtd.HZObJL8MrN.uV3Dwv3e
 yuQXVyGXc75xL2w3IpEKJpIx42Em4VV1tIs1yuJBO1aDivB1sNdPT6b9zeVUbkV6owB5fdFM4Oka
 Qu8h5dsA5Jf6Apa2DKuYf83FNegY7SwgltoKpyV8..oknbLk0oUfu65QEKFJkt5pTEf.iMs2ZKw1
 9iNINRBfSFq5RqWWk6jJkbSJ5lF0eyMQu9RuOHq77ufwXDjSPBZZryby3uffG61cEfyHVwmlI0ur
 bCEyL4rQMRD8b1ajhR1ZnNE6MQb9alQZAxaoK161ow8NzELryNJY01RGecENaWSOXL3nr5sKc8hg
 4JFGXmXeFyph2dm80oqxcOrSK.D7dzzvQcHCtg5pwCSwXE97QAuMCvU9vkuKqPu4GKGWhYhVug4p
 s4qWqqTfk6MC11FesJgAxVW1YZ66k4BYsM5OqV.jFw3id7uacfzDYdqxXGv4uSZxeB5UWsu6djq6
 l7uNkE_yFopE3.6oT.olSLIWzlv4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Sep 2022 15:59:47 +0000
Received: by hermes--production-bf1-64b498bbdd-tl26t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b512eda9ca60ce711aeadfc1d52b1dd;
          Fri, 09 Sep 2022 15:59:44 +0000 (UTC)
Message-ID: <8865e109-3ec6-f848-8014-9fe58e3876f4@schaufler-ca.com>
Date:   Fri, 9 Sep 2022 08:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Does NFS support Linux Capabilities
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        casey@schaufler-ca.com
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com> <YxsGIoFlKkpQdSDY@mit.edu>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <YxsGIoFlKkpQdSDY@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/2022 2:23 AM, Theodore Ts'o wrote:
> On Thu, Sep 08, 2022 at 08:24:02PM +0000, Chuck Lever III wrote:
>> I'm not sure how closely other implementations come to implementing
>> POSIX.1e, but there are enough differences that interoperability
>> could be a nightmare. ...
> ...
>> The NFSv4 WG could invent our own capabilities scheme, just as was
>> done with NFSv4 ACLs. I'm not sure everyone would agree that effort
>> was 100% successful.
> Indeed, what the NFSv4 working group could do is to take a survey of
> what capabilities are in use, and more importantly, how they are
> defined, and create a superset of all of those capabilities and
> publish it as an RFC.  The tricky bit might be there were multiple
> versions of the Posix.1e that were published, and different Legacy
> Unices shipped implementations conforming to different drafts of
> Posix.1e as part of the ill-fated "C2 by '92" initiative.
>
> ...
>
> In any case, what this means is the exact details of what some
> particular capability might control could differ from system to
> system.  OTOH, I'm not sure how much that matters, since capability
> masks are applied to binaries, and it's unlikely that it would matter
> that a particular capabiity on an executable meant for Solaris 2.4SE
> with C2 certification might be confusing to AIX 4.3.2 (released in
> 1999; so much for C2 by '92) that supported Orange Book C2, since AIX
> can't run Solaris binaries.  :-)

Data General's UNIX system supported in excess of 330 capabilities.
Linux is currently using 40. Linux has deviated substantially from
the Withdrawn Draft, especially in the handling of effective capabilities.
I believe that you could support POSIX capabilities or Linux capabilities,
but an attempt to support both is impractical. Supporting any given
UNIX implementation is possible, but once you get past the POSIX defined
capabilities into the vendor specific ones interoperability ain't gonna
happen.

>> Given these enormous challenges, who would be willing to pay for
>> standardization and implementation? I'm not saying it can't or
>> shouldn't be done, just that it would be a mighty heavy lift.
>> But maybe other folks on the Cc: list have ideas that could
>> make this easier than I believe it to be.
> .. and this is why the C2 by '92 initiative was doomed to failure,
> and why Posix.1e never completed the standardization process.  :-)

The POSIX.1e effort wasn't completed because vendors lost interest
in the standards process and because they lost interest in the
evaluated security process. That, and we'd made way too many trips
to Poughkeepsie.

> Honestly, capabilities are super coarse-grained, and I'm not sure they
> are all that useful if we were create blank slate requirements for a
> modern high-security system.  So I'm not convinced the costs are
> sufficient to balance the benefits.

Granularity was always a bone of contention in the working group.
What's sad is that granularity wasn't the driving force behind capabilities.
The important point was to separate privilege from UID 0. In the end
I think we'd have been better off with one capability, CAP_PRIVILEGED,
defined in the specification and a note saying that beyond that you were
on your own.

> If I was going to start from scratch, and if I only cared about Linux
> systems that supported ext4 and/or f2fs, I'd design something where
> executables would use fsverity, and then combine it with an eBPF MAC
> policy[1] that would key off of some policy identifier embedded in the
> PKCS7 signature block located in the executable's fsverity metadata.
> (The fsverity signature would be applied by a secure build service, to
> guarantee exact correspondence between the binary and a specific
> version checked into source control, to protect against the insider
> threat of an engineer sneaking some kind of un-peer-reviewed back door
> into the binary.)  The policy identifier might be used to provide some
> kind of MAC enforcement, perhaps using seccomp to enforce what system
> calls and ioctls said executable would be allowed to execute, or some
> other kind of MAC policy.
>
> [1] https://lwn.net/Articles/809645/
>
> Speaking totally hypothetically, of course.  A bunch of what I've
> described above isn't upstream, or even implemented yet.  (Although if
> someone's interest is piqued in implementing some of this, please
> contact me off-line.)
>
>     		     	   	 		- Ted
