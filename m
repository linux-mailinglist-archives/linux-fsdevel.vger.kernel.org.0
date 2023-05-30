Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF171708B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 00:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjE3WPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjE3WPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 18:15:08 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7265F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685484904; bh=M3FptpK0dre4Vl5h5roYbX7FnwrYeKGSVF1j9bZEXKE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ayJ8tdiLorsKAOLSzLsXrstWXo+2R4034OpCcCngbkKbsXE56jkkJmg17oIQxZU1Sg9uYroxTh94qIBfWfzdWsVsEJXDfRDDz52t/nnCj9ANmEDkOsijDjLF8DqH96nkhUOMc+cp1H5M8OjhUPXW/nt3Xnops//lsxFAiwYogoyBsCU1GGqa11mGoKjkZqrbhAZoDmmHCvH6EXpN2ZHn4qcaGwWG94uQadS79GxEvkqIdpSJkm2KBB+aV+z+4LuQ50Fr7jn3oIrDSOIlPVeD7ik8lCSMCqtQHt9h7OY0wSpwNqAXj1HEsD7Q3rxyXeCXzqIQFUv6sSxYX3skXgmZ9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685484904; bh=m0jBu7FnGohxkywaH5HxFqRVtflv1AvAFXS5FKj94tB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YW1yw87eMdxYt7xVagzMMwO9Ck61Bvf+ZwSjwkNbYTPksq1GqeF+Ik00V5QnkruTX4ohC/s/mL0Y6hukSQz5C1xJv/NZADv1xFGkGYyGGog8PKsmvPqy67PsnAV5JS8ec9GSykj8upsoz8ZWHSBLbts2sPtiMVns+PxhGZdoGhLq96mDa6/Y2hnjh6UfWV8UlbuY6TaXVZCVz3Wcl9BWtrydoy1EEQ0jSQcY6zOL//+HfzTtTe2raX0l7dZGEZoQZztTXoRWCFkYVIaWrf5AUNFAkW3pXAcKznbsBD8Cqtal4bZv8MxR5Y6IDK83/a13aSq9u0JLhOGJP06zHXiPCw==
X-YMail-OSG: mTax22kVM1l16k5yT7pC2O1bT4Z6PuhpbmB8RLu9eYr1eAx5w4CepGMevYtViQg
 1NVrcKYjD40By2_iwk4qEL0I44cFzcDiJ1IdRjx2wULGtafs9IbAqA1LVWB9CiR5_FwQhOJcGz.w
 s66WMN16KIqI_cfbUU_gykZKC0zOtIYT1FezQX2z4iCe3tKgeUHb8qfcTjIW7IvH9JMmysXNf..P
 lu9UxvTrE22QQsA43FBPa1tNqgmuyvVsHQtZ9GJhTonPQ6qm90x46IwzY6o5rjqaM1feiEw0wu8y
 1MNdmHquMfaMXDjOw_D3NL2dJbLg_YoCufADzIJ4qowXXuA9EMYnX9L31_z.iU15DdYKSAuR8cso
 pizv22WfWNLXPxNWo1mfa2cWAUyrUsH9euDP_81zt2g2c6DEqJoukHC9XUREIRLxWbXEmDYR0RAB
 EBC3IurpARJyfv9eCUNyW_RULkz_4wgarruvxtrARZu7gyKsKKeS3nBnP183_RCdlZPVqNXefpxd
 l7S8NO2Rehw491cSJfPC9t70HFgp3dIcurlISD_nwE657CVCFT_AxuxWiN2ozhE8sfsQrnpEQ7Jo
 1sAzSGaATyvOqS0bxgP29o.GOWfmRVTemzwIBsuEOFUFhulIzMLD6Qcg70spbfzazUebeLbnWoXW
 7o3chrir6Ah_1JQFKaUm5LwmdqHbNyYR_NPXJ9WdVsuPZyHmZLi9X1FjyykP_K3Y7M4mupwMZjPy
 5ZlPY66kv566GPsRzRiSV5d8YT3GxXLxbRyLNRCQZrG89Ish8F.FONRHg6xNZc_vwhaNV1GmWZGj
 XMisrbrfjrf7iA1MoYd0QnxFuOomtvoouLblsCFa1eAtdaOxeYlPG0Lc54MhRSwNeQXd2zMzk3RX
 kB1FBasA4TTEn8Yvsf5Rhl9EU08DeUzj4lRBZbwbMgwWXeaZAgTcqBXIy8W4.6D.NjtWnzluGRVX
 KO35LgREbTandq4Zdk2VjOQNs25sgULtmLyG.B2xN8tsKcs58H9eWVOIozD7uali9PBvH2MGDGjC
 rYFz7NP.Ha.VRpyVI8XAt8umovdFzgXaHkJI7LWKkxRiHU44Zce6btrJyVeqApGapTbOEsZJoe47
 C7vNvI4Pf9ZCjfNB9xR7HkbG86HLMnpPRTestKxTTk3iZBUVOKPDWFmXQ7LjTtFeNNJq3Kw1kLpv
 sX3iI7g.aw_7BYTPmQFI63giMlfSOy0widgBEdyEVVGkjWaUE2HB7DNg6ku0J6dVn_hAJ.U4kRIj
 L4og1Ov1dUlGLsdHlxRSlSe_LmBCfVRHoSXqDSyQ.6joQMx5FB1J3NB3TSrCn_VKhm_ORp1AcUqu
 laUywqvqKtet_nw1WV4jBen_j4pH_K80.FfNob25EsY6I9VtMe7i_XM41v76oWFe1nGgVgYjdZsj
 veNYcMMZziPZxqk3slODtHqbg056hlXo57rmSb_NxrYa6LX73JKjRHbtIcyaz12PY05UxdIkX601
 bCZ9BrYmOyyMkhVONyXH0Sn2sQeis5PV1IZxRWTp2ssHvpXlz4eT3Vv4Fpb8nTsM_XkRnkDTc430
 cmVr9wYJcJbldHEHar9fx0ROYctdKu6m9_2QCxNUUH1qgLNe2RKrbAOz_XywcCih4Fx99jcUy8KO
 xgqlZT3tZmRzhD1BrF5wANG3Cgls3JZn1ezGBmB3XC_nlUW9KR5i72ffd3MR6BUmmgCXVLJ0PFyz
 paRXtpb0CG8.8jwcZRD366A5J9PKWL19vfMbFD8ITM6u_96sPARzk3qBKqjYN_CXrnM9Xlxo4M77
 zIuj4SOPF2MR4KVpJ6qEAyZuuHyFAOm0fHh_vyHa7qd.kGUVSEHwPTIoJzuT6Mcq3f6hKfJy0fSD
 IoQHvl7zOQDDhyh.Kd4VRA0XX11POQB6K4M0bwxI6.aphWpPRX.PXCQYC4cK8.8ZWWZ3nIosmRyB
 KY3346NGo3Po5yqHuX4iKPsx0AFCpk_b41TAY8c86sqGEKCh23ltzNTKPLFE.bQIzvbJTcxxTJ0c
 qyCxym_AovTWVj6GHVlEo.R6bNOfiBPqfdYwodK5ftHnCS7RGiYnrxy8LspLwawfHz1931HTY949
 V48FA66D_KV0CVbupsPmtD43672ZXelDWFBeEYsysy.gOrzSsTKGeu0aE4ZCVO_s2axLLut5iWrP
 .xcuxKstHOQ_KiM.qsUDaTsg6y89q1j1q_FhCjgzWxvWIYM.UwUWsS9oNmznBzAq5bX2NatBn.nt
 joOWZcwUu8y2Of57kAhk_rbTIU9Xo_QFX
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ec3c0326-5610-4751-b411-bab55e7c81bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 May 2023 22:15:04 +0000
Received: by hermes--production-gq1-6db989bfb-4sk72 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3afa87517718980d01f16661ce4f0e8a;
          Tue, 30 May 2023 22:15:03 +0000 (UTC)
Message-ID: <28f3ca55-29ea-4582-655d-2769881127ad@schaufler-ca.com>
Date:   Tue, 30 May 2023 15:15:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
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
 <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
 <20230530-tumult-adrenalin-8d48cb35d506@brauner>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230530-tumult-adrenalin-8d48cb35d506@brauner>
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

On 5/30/2023 9:01 AM, Christian Brauner wrote:
> On Tue, May 30, 2023 at 07:55:17AM -0700, Casey Schaufler wrote:
>> On 5/30/2023 7:28 AM, Christoph Hellwig wrote:
>>> On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
>>>> The main concern which was expressed on other patchsets before is that
>>>> modifying inode operations to take struct path is not the way to go.
>>>> Passing struct path into individual filesystems is a clear layering
>>>> violation for most inode operations, sometimes downright not feasible,
>>>> and in general exposing struct vfsmount to filesystems is a hard no. At
>>>> least as far as I'm concerned.
>>> Agreed.  Passing struct path into random places is not how the VFS works.
>>>
>>>> So the best way to achieve the landlock goal might be to add new hooks
>>> What is "the landlock goal", and why does it matter?
>>>
>>>> or not. And we keep adding new LSMs without deprecating older ones (A
>>>> problem we also face in the fs layer.) and then they sit around but
>>>> still need to be taken into account when doing changes.
>>> Yes, I'm really worried about th amount of LSMs we have, and the weird
>>> things they do.
>> Which LSM(s) do you think ought to be deprecated? I only see one that I
> I don't have a good insight into what LSMs are actively used or are
> effectively unused but I would be curious to hear what LSMs are
> considered actively used/maintained from the LSM maintainer's
> perspective.

I'm not the LSM maintainer, but I've been working on the infrastructure
for quite some time. All the existing LSMs save one can readily be associated
with active systems, and the one that isn't is actively maintained. We have
not gotten into the habit of accepting LSMs upstream that don't have a real
world use.

>> might consider a candidate. As for weird behavior, that's what LSMs are
>> for, and the really weird ones proposed (e.g. pathname character set limitations)
> If this is effectively saying that LSMs are licensed to step outside the
> rules of the subsystem they're a guest in then it seems unlikely
> subsystems will be very excited to let new LSM changes go in important
> codepaths going forward. In fact this seems like a good argument against
> it.

This is an artifact of Linus' decision that security models should be
supported as add-on modules. On the one hand, all that a subsystem maintainer
needs to know about a security feature is what it needs in the way of hooks.
On the other hand, the subsystem maintainer loses control over what kinds of
things the security feature does with the available information. It's a
tension that we've had to deal with since the Orange Book days of the late
1980's. The deal has always been:

	You can have your security feature if:
	1. If I turn it off it has no performance impact
	2. I don't have to do anything to maintain it
	3. It doesn't interfere with any other system behavior
	4. You'll leave me alone

As a security developer from way back I would be delighted if maintainers of
other subsystems took an active interest in some of what we've been trying
to accomplish in the security space. If the VFS maintainers would like to
see the LSM interfaces for file systems changed I, for one, would like very
much to hear about what they'd prefer. 

We do a lot of crazy things to avoid interfering with the subsystems we
interact with. A closer developer relationship would be most welcome, so
long as it helps us achieve or goals. We get a lot of complaints about how
LSM feature perform, but no one wants to hear that a good deal of that comes
about because of what has to be done in support of 1, 2 and 3 above. Sometimes
we do stoopid things, but usually it's to avoid changes "outside our swim lane".

