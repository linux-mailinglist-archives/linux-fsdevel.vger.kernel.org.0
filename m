Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE43E71653D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjE3Oza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjE3Oz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 10:55:28 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com (sonic311-29.consmr.mail.ne1.yahoo.com [66.163.188.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577DD9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685458525; bh=3FMUIMVjxqoIet6J5XunI5v9pbm9gMa2Y2zkBlI0iN8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=doz/EUyg2TEuJQQv/LcpJYX+Ll5JkyPkrT0OFuj1USPITYiuEngqb6TKxq9mU8ymEcWzYXpOe5RoHx5GbEPZ3ljD6mOCMiO9/GPSUGZV0LXZnnUU2rGvwx4PDLPeyOtAqqOfO5MYyJ+p/RjAoLpaULqGvx5nuYjVcDzNKcqglnH/vFyULmOeUzlfksUk/iL87BhiReYEIP9cl0c6QCa9MyEHUBWAaiIfKwhB5hsHHMbxb4SlTbJ8apHPaJvHGRjSP5SUyjCE/3YcoqH61yFEdiHlTThLoLNhUHyv1pkXz5XI6UZajfTKveYBHFOwhde/Vzo7mCE1ARV5cxZ8xPaRmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685458525; bh=JRffqSiaddwPHzLtZhi+d7gX3cU1Qd6YJ98ysTs7cXE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XNCxp3JEgtjDwJIsuTdV0pMcbKIRJm9sez1wDk1pfwidcsHPezRwDNg6IFzdTNsIHlwyZI2NUjverUp4DOTO2s3LBS9WR5LCT+HUhUSQk6GiowCz886Om+7uxOKftClnYppJOfO4QsvIOK8XmPStxt/zAhFCnGCjFXkLtmYYUa9eZoKxCZ9825cspmmj0f1RpupbR8/cMRN+FCXYioRbTWhGR2AUhak7A3winTg2lBI1BNWulPnsHR90vYPI0b3AOcRy5OF/gVMehdX3iUmXOE8JDTSDmuNp8nx6XacRAqqxEwV/kKeCsa8gGdBBX1yK/QIf0g+3jpqtCqnr6FVtPQ==
X-YMail-OSG: PzNVaEAVM1mpyU5BLfsxyoISExXNsM4jBEb_woBB1j8osNGXDQuf.hZybT1Xn2P
 V9YFwXoxyjLPK8e4KHNexzpsypsF9FQgyeRhptR_SqYsPQHDaVBlqBHhilcq5RJ8L68JVZf0mQVP
 187n63QyGURhs0SuOcHSgHiKV0TmymJUAXmlcTCl08fc.lLeUIxV4BCW8GNUc4LDaR2NQJA9vlac
 ww9JkF0omblWmsuvBDfINrCVzoLBzL4N4Qv3NVIfrdr7IlDFZgFv7c8Ni.9nZsE.MU_dO8QPrmwD
 UCC.qA7eXS8jBnHSHJTE8A9FK_YBzKK74JYkZrMpYGglQS4LwDk9bHDnZxiGhS1D1I7_dYQy3Cqv
 xD9CqAbBF2In7XbQsIT5txvs2gNd.NPHWsSDLloQjbajxLwrLMxVTowDhoKazgT5kMtsReb9O9ru
 MPIXtTr_hh02lsBKkRFI6M.UroUxcDBvZtOLL2STWWcc5lF59OhXSbO8d2oElbfbQH5KPKJ00KHT
 9d5DO5hjvplVsEvtNtbuoZdf67Yec9Fy2X66uoRjKSjblKPdJGq.Cxs5muifxGS7uw2EVdXafT2V
 wd4lLXhSUmKK0Ic2otH.VqCe4gozY2aa1AX59oOUApbCcd8jngfoZWdrlGiJDRxZFerEjt8XdsF7
 v5ttHl8scDpMmnZvNSqbTGAlOMZ.k7r0FBr9F2y62W.2TxA_8kry_5F9kCne4IUCnQeA3xqcG6Bq
 UDXmVTvXKUI2jUCCGUNsu6La_XZW3oN62LEYGCvesIBkjpStih_1jzyDnqMtD6L.5mbJ0MUU0Mra
 UuviewBleb5akzBcdFt5dmCmtQWblURPb0DVLDpJCpEFsDvh6OmIJa7GYDoKmuj_j.JcwPWsh66A
 WvMIV8VUSTH.T8zQ1sCh8kMayTv5WozGIU8vWu5pnJ5KpliEn8uboyPwfCdh5Sb2AGoLFC49vG2H
 InDojnIVzeuGQ77Jhmp0GdVw9fsnPRgqKIIRkVIlmaFxzu7Km5dIquu3e2v5geXsRlPfM3RLoKBr
 pHINLwQukWzaxjG1vP8tmLDSFb5eeRkX4VOKVvHUWcZfUTy3JafxKN7hIf9B8Uib2kTANBqu2VUR
 oTbLOZvt7zifYBfvMitVdbwDovvXBIR6FJuKM4ylH94Y119xbi6j_QpdBgIymthyjOhWjquGOZ3B
 RtBs7Jtv6cWIh4_Kp5xs.PNXlAqDhrcIgP2F_IakhSqa4UMtXJkLuHB.8_nbB5lbEHOm8xsJBPWO
 fm.kjO5AUuIM_GwtCxNditAkKl7D3WB1leZNj6pldnw861zIPGleIXrSks17fd19llYBeDB0RfcC
 f9Or5QkCQJfiiXJLfo2kzZpWNzzSlq_XMNTn7SVqqp3kxqYAWAEaOCK6DxV6n5jfbLcZL88_hecK
 a1sKHr_5W8.c0sjrWQCIRcsAoOD3dnRfWXpE7DqFtNSVvHAYMgdkjgMylKEtulnN32ywYshCnR7j
 Wk0m7hsjzivMRuTq5iXWt91a8u0WrvKDZGtlRVb6utuEvKfwKlv_MQB2ID5XdGj77PRslpKBsI66
 Em6LMY4AYJFhti3Z0ovDiRxfYiAU3W6cvkIWhys99LL4f3I3RSw4zyKMzByfzvqCWTWbsR6rs5yU
 jjQTDqcZ4xJ7vrMj_zj_21_i256bW1KbXfbPwDOTP6iPfMm9G3vOorJ.iRbiFEe5ixbkPOECROZU
 G8_FCVuell1PfWXTZD0oMTHi7kc7bM9usU1gEydwA6Hdcq98ZsYWsWaFnmOza1EjUpKSsbG8_1sb
 N1e1Gwv_cUHVLuHAimis7AJMPov18F1E4N1nxPvKYxgTFVmlu2zoZx6zvToMpbN_dJggld.GaSpB
 RPIxyhhfNKMvfR.dA9FI6QVjfV31F7hnIaktl8eVpocV6lmhtS78f9qqfDu9S7l.uSAMnWGs1NYc
 6GnYW0zWpkExywYBo_0QfWrywMqEl34cmY9IVU27UPPXvo7tKWluG2ausYFPNkMmkkODY8kUTBM.
 aUR3qxVJ15Upo2I0q6T_0aM0b5900q0FpeUkXAcyiRuIoHdxyIkj9Du4iJm97cTIWrgHLBBwYtWo
 cgdNj3yqnHEoIbUeEsqaDmuB0wCjZrfIgeE1NCfj_5pj4yDOz1DHITlHS.UT0Z2sUkLDh6c_Aqw1
 OiL0uy8eAeTPeT57e7d8f4DweRQ9IblcaodZ_Q8NxAiL3qfGPvVCVEovJdbLVcb0PxHj59cBXKrI
 JGv02PFcir5N6te2Js78kiDtZAESJYgmMexPYnECVFot5b3VfyyjW3MA-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1b869320-0869-4dfa-8b97-0be207cb43c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 May 2023 14:55:25 +0000
Received: by hermes--production-gq1-6db989bfb-c6sbx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 59e7b2b9a557962954e0769a872227c3;
          Tue, 30 May 2023 14:55:20 +0000 (UTC)
Message-ID: <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
Date:   Tue, 30 May 2023 07:55:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        dchinner@redhat.com, john.johansen@canonical.com,
        mcgrof@kernel.org, mortonm@chromium.org, fred@cloudflare.com,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
 <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
 <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
 <20230530142826.GA9376@lst.de>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230530142826.GA9376@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/2023 7:28 AM, Christoph Hellwig wrote:
> On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
>> The main concern which was expressed on other patchsets before is that
>> modifying inode operations to take struct path is not the way to go.
>> Passing struct path into individual filesystems is a clear layering
>> violation for most inode operations, sometimes downright not feasible,
>> and in general exposing struct vfsmount to filesystems is a hard no. At
>> least as far as I'm concerned.
> Agreed.  Passing struct path into random places is not how the VFS works.
>
>> So the best way to achieve the landlock goal might be to add new hooks
> What is "the landlock goal", and why does it matter?
>
>> or not. And we keep adding new LSMs without deprecating older ones (A
>> problem we also face in the fs layer.) and then they sit around but
>> still need to be taken into account when doing changes.
> Yes, I'm really worried about th amount of LSMs we have, and the weird
> things they do.

Which LSM(s) do you think ought to be deprecated? I only see one that I
might consider a candidate. As for weird behavior, that's what LSMs are
for, and the really weird ones proposed (e.g. pathname character set limitations)
(and excepting for BPF, of course) haven't gotten far.


