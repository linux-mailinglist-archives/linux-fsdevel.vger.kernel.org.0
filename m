Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05AD4E5B5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbiCWWlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 18:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiCWWlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:12 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C225C6E
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648075181; bh=mC20+7TfRW6SdSbJR6fvSbCljYYikadz3XaqubTXWoY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PH0HRAXD67YIpmWyafy9rFOEVuYUyIq8X//OYb2DMN04faT0PnlF3KwpR8mZXy8AclhocXmwgKUmE0fKsCNQND35nq3Rf/CjFpMOI9RiVsI6NaO2C1BSauVCjct/N9mKpvjLvQ1n8N3oa9amr3PsOwn8N95yB8Bp0xb1mSMBl5RDnNlVuQ1+QVfmxH2FSKT/lt8OGQEM7IazaB/OGzj9ppAt4KAlbILYebbQjvXclM0mBb3snFQZEjJI7L/yO47jjcXT6BJ9hEQ/SUd/8rQAN7xtSmCv3dZ0Jrx9nsEtqa0eeK6bkJji0f2JEM8xOt5ecpiwr4ofvs7vzX0d7wMeew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648075181; bh=bT1BWLYh3huKi4ud4dqj1HI4/AEBVypxzPWNmAT4ids=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZX5EYmTz68twxKEGZE7p0+9qxsYKa8pv/0rYZljKAo0VuVCxZVHxXIIppkGgBxoh41+t7gaxd8DTZq36Ivcd6f425SQ/ZDgIvAtkCJ081k2m8bENMBgy9Tj17oKC+28OwT2sEPkyvhb7o2X4IyLxxeFzCRJHsVqU3Di3sjCfhkVjSnpuP4kf2Z/RDiJ+8AHAgbo6SGpjFfHUw/fKSZ2mDUF2LbNrPUE4PYE2J3PHAue9HC/bU6gnReLkdFuVTJTd/RstSw3ajf7vdtqVFBoz+9OJyNWEqAwqd5NLs6xs/P6UOsv6L7Kt2igZOQroFaSo48xvwbYjLihRCr5nGI4dCg==
X-YMail-OSG: aRtVYpIVM1mcjJ.GzVEao9yrcefHqRuQJJQV5bnHobGLoSqFv6ixDYNnp33Q6J4
 O6wcg61HZXxIrKh241.ARyjgYLW_BZomXhC_fm69liIfuCNgSw1o1DlDZDY7ckpx4EL1YHxQfvba
 0XRp42brli2U0GaB2fAuhRvaIEGc1VInOFbQXm6NVyrDr6AsNnv1YZUaJcMK_dDnXLWQ3lwx_zLh
 kwHtfz3K0ji6zY3n20TtVlEgs9BPwHwRM6wS4gfQ16biZ8avXe9Z6rhr59OQ.dXNmjPKCsFWD.Xi
 xhZ9lj0t2MzC2sZB960gp84Q.akfi8hGua17Puz6ioV27GvZbXvaUbqJ80CpaFrhwxfKGTKShRKB
 jSvZprgBol6j4dempnAM2iKgA98CJvkldDBA6GM0T5okKvqNkTL45.KGOusVUbAJR1nkNWSAobXl
 GK6njZuBvUQcTuyTE63ga6cgEzelkb.gVOjHxmjh7aLI5Y5uAHySk2tBI.SimdyqdtKnkNDHgy3g
 XBTfuOSLVRbA0mniu2TlzejhAo_YsTPpkIqs6OOGwKGZwCxkKC3efipTNYgCrVbCDds08_RLsx.i
 HqWkUWiBno3pFuuCvAxuwHG5HMyyBpjmkqBaLrlbHRIM9ihEWg6rucQb_XakkuNR1VRq9llMJnlL
 anUyC23w4vtzTnFSAJVS31w.ninIpS2VLKFW.9U_SqdJgV7WqAZ9BbfujN.wfmVk.clQGLEEZK9B
 B3hsv2XXwZA72U9x212vkvZbWUz5eRoTBjHKpzvfwm7.jVv58VrKa824ICtGIpGalaW_iwitcJ9C
 XdWEvoIy4PI8QvXmoVFdYh7BerDemLMoprEWs9JC75iv2NSsQyDn1gC0efsIE.ZgtNjtEgCf87B8
 qpQwHdp7Rnw3G.eKNXMo.1794KwjoguOezCkXY33IsCtMJamdFZFYUH6cWoNTOWxFMjiza_9N4r9
 MPBzhKSL1iKNxchhGSBQ7FXEgoc4CSuWTB..nECTIVAwKpx4wgF5MhFfcqCu5F7lOduRO.wChuVY
 KZ4RDENm5T0HkVudv0ofQCzLXXa4b4WIItpY84auduRcTOUQldAugaU7JURuuwLSOxNDAeru9QYm
 orTqQ5aYYgHAjF0VVnoCOh1H5wemxTzAFTYEA0.YbIP6IEpjX3N82nHoq_QJyjbFM6rNM6gVD.Lc
 05rtS0IjAhJ3IL2JctbsQhsT4qf.1kS6rFh3YbYrzeRoW6wSbpdGe2aTDXsxkI5i8luyKENR5eD0
 MgQIgqKOhuRh_74U1l5symqEYNVNZRJsbaAHWgvUdsARiEGVk39ZYj5Yz2LqGKagf3imPz8FNipo
 j1.kQdU1T93ztMARo6H96TeOsUts6G45x34qxbur5GCIGse5zliFl.Bo.h.94kEn2szypcE7k8WB
 babF_qk5q2fgFbEJQpj26vKusCE0iSbvM8HdyliVqBtoUZLDcpnLqjR.Fbs37aQQyZhrJLVpqKdC
 c1yBpLKXir_SN9vh6zidi20ngxIPufZS0n9GZcLb0aXhwxEcbPaIGz36n6iTQvMmQcQCgylqBId8
 _8vUW_OJDPfaIW1JpKMhdjuNxUZSClHaNH1n9_TfnEq8kkwaonY.SOpS6V8.KC4nrQUReic3006X
 Oc6FQQToxZvB4hn2tC_iZZm2.ByWF.dbItfjhfc9RqJG7B_lg2PVIcCvGkzBrVkIjLTqctqKg6pR
 JvzEMQ1t.m4BUonAq1uR1Vf6qRld8z6WENRqKHdFLlGp57Mmt7XakLMM3LgcufyPcEQjxyG_9q3y
 PndMF6uMxlPt6_ajanYVkD4Jh6S.XF8FhIyaK8gZMMP3tV8BnnjYhHoBqFAn1VEIp0.FwvcSbuDc
 zJMg8.gbg3p3ElWDAUfWNnvXu5B0IGpzJwwVDcrzuJn_pJMi4wCbfQDSrESMdgjwuyH3jpDkRDHR
 QK0tdrrLc1a392lJoneXeGEZQdBFHg_gt1DLzrnANQmHfFDBTCx_lRXG.Fy6iRnQAn5n4cmZyUx.
 Kd0OxdwrE_3gdqYKVQTpY_EcdJa7lcgNdZMmXUgzNWCqhqr7._zek7BabXejjTbmGs40OhGyGn6U
 hTZdhxuOtqtMFIbgNE2aDeR.MOzJmW2bCRXe4dobJB4Pmyl9PFnI9VQkfFUjbKbxaR25QJTopStF
 UzJ6lWFMHacHE9ZMU9s.Vfg43Fms27uHaroreo1N6ZqYxSI21ja7YG8cs0krHtQleUSMsYf6nIWF
 1XTsNFEA5wF9PVf.tcuFoUttjcCRyUPwjWVQ0P.nOmRmDet7TprAe7XkZHdY2u3XDhyL.rP_USiC
 YpfERr0INimq_.KnTrTs-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Mar 2022 22:39:41 +0000
Received: by hermes--canary-production-bf1-665cdb9985-6p9bt (VZM Hermes SMTP Server) with ESMTPA ID 39a8b820c79283304b7db448c9a80e45;
          Wed, 23 Mar 2022 22:39:39 +0000 (UTC)
Message-ID: <d0894565-9783-b398-0faf-60bfb96837ce@schaufler-ca.com>
Date:   Wed, 23 Mar 2022 15:39:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] getvalues(2) prototype
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <d3333dbe-b4b7-8eb9-4a50-8526d95b5394@schaufler-ca.com>
 <CAJfpegvwTmaw0bp70-nYQAvs8T=wYyxnDEoA=rOvX8HDZnxCTg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJfpegvwTmaw0bp70-nYQAvs8T=wYyxnDEoA=rOvX8HDZnxCTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/2022 7:00 AM, Miklos Szeredi wrote:
> On Wed, 23 Mar 2022 at 14:51, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> You also need a way to get a list off what attributes are available
>> and/or a way to get all available attributes. Applications and especially
>> libraries shouldn't have to guess what information is relevant. If the
>> attributes change depending on the filesystem and/or LSM involved, and
>> they do, how can a general purpose library function know what data to
>> ask for?
> Oh, yes.  Even the current prototype does that:
>
> # ~/getvalues / ""
> [] = "mnt" "mntns" "xattr" "data" (len=21)
> # ~/getvalues / "mnt"
> [mnt] = "id" "parentid" "root" "mountpoint" "options" "shared"
> "master" "propagate_from" "unbindable" (len=76)
> # ~/getvalues / "mntns"
> [mntns] = "21" "22" "24" "25" "23" "26" "27" "28" "29" "30" "31" "32" (len=36)
>   ~/getvalues / "mntns:21"
> [mntns:21] = "id" "parentid" "root" "mountpoint" "options" "shared"
> "master" "propagate_from" "unbindable" (len=76)

That requires multiple calls and hierarchy tracking by the caller.
Not to mention that in this case the caller needs to understand
how mount namespaces are being used. I don't see that you've made
anything cleaner. You have discarded the type checking provided
by the "classic" APIs. Elsewhere in this thread the claims of
improved performance have been questioned, but I can't say boo
about that. Is this interface targeted for languages other than C
for which the paradigm might provide (more?) value?

>
> I didn't implement enumeration for "data" and "xattr" but that is
> certainly possible and not even difficult to do.
>
> Thanks,
> Miklos
