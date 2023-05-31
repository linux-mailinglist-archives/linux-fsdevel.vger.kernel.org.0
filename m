Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF597184FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjEaO3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjEaO3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 10:29:37 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E6118D
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685543362; bh=u06wsoXDKdLhDwBL6GQjdUhNEcg8dn6HnYPO197Z4ZY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dsghcZ0knm+rtK+60835/ehAlZRqpxaJQKCmaXs40FEp8iNoxa8Uf+v6ApUaf+n24hoDHtvUDS+v978srAGizLeqf5IUQ7uV0SjCh7qe02nLDo4lBeaVBKNVGgqo5z8UOmXo3tA+JV+bn4H6eUznkDsuWYuJHtANM8QLkAGARkWRr7GASC6DZd9Fn6DjLlPQxNXG6deBvXM3JHwFWyJ0cpAENDsv8z/wiYWOdZ80Nid3Re4+AsdWQs2RzA6m+yytWHIu0yV9V+Xf+TpUSB6mGpvaBUlz6MupZTrAjXz5qm5jHUwaEDBldDwdvPsIN91Lg1whUQ6EczFroJWnKw+l4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685543362; bh=NoNrV9NL15RgR9cHQgTBUdim0SuN5MNaB1Jc9VSS07c=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=B/8ejvkt8gSDK5mD+AtVqilJqeWFuKiX+nwlTNtY90mXwS0NKjB/ue62WaPCvYZ2ilbCHfmsI4uef2V+8KinQSCevb0/V6RvZglQbVJZHlz0htbJieAYTqfKsReicxoEhCuYt27+wbVx8LbFK9Nrxul4i/wG0MuBd4wSSBmZOg2BUxUv8uo/dwlRgAvtDqV/+/bVEbZtHEjfQsdBIxHzKN7fCSujhqvO3sIG8yv93ILMJy1DB0RmWZ7WKIq/gNZrIwQgGKr4v9087BN/38RhhUk9C0LSHk+8RGPkUe++4fnhaqmyNWrdjfTUBRoP68/hzZo9Lc3j8kebqMfH0UfAfg==
X-YMail-OSG: YS2OiOgVM1kmwmgmji0DUz5dLhGzTb5Z198M4.LCNKObOZhn4oZZvKSnFZmfrxY
 UN6hR2P.A3qTmfVVDLFNYjn5QLt.nWYU8UGVZqmdVBdYYliraQ4peiZ_mZcfzn3.A8K3FJVwas4G
 KCkturum0T2vml6moo5VB_FFFCpq9blIh4jyzDm553j1p2bCA71u8R6jlUzlpTIt_AfZPJNoCA__
 H0qDyP0SzecdXb8h5oqmF9l3hveY.Oscf_4EXTa6rBmRoFDSjkoq8QSewWZX3XufbrpnwqTtTVUw
 5P4lE4bm8YEuzhtOqPLNsFHy8ALL9jifaNIHQeYWomRilT54uVLHQBjcs2PUTQk9EBgGFm1Rmmdt
 B4KynaXuuw1_MkEUIlciCaFkiDKBTKzMlbGg2PyiNrmZEinAVHVh7PTVCsbfiMwSBRjXxhjqgdSt
 ukLyssbUujJcgQLRcitba21rG1jjuK3FNCDPagA7f.v1IE_d76aBghD7vp8dhcSs2aiicgjLXhtp
 0KsakzlYZyz0O0sTeXe_c2ac9GCL_AlpGd9TzKiouagsNT9CCDbgbIU.MKNYAOMcAo1l7PChe4iE
 zSTIZcZEnzmTx1Cwxy.VgFIeEXgxMD22KonFWwq1k8lyWC7isb9.8czYhGHqT4KuTjcg.fGOd.p5
 PcYFKBOQm0244ErDybsrwRrRoYWLFQcFq5ZM3_akYqobgfpsqw1KPRGneQQA8Nz3fja7n6GUbi.0
 sF3GEfazRl_OkzU9pLsL2tvFb2oo4cLKB9oLJQvfOMX5PVv6KquqCIGB9kQFvpCtGrDQpkhF9uwO
 zByidQDBEvSU.ktIviMPVxB1aqq5pcdpQkfsVS.cPz9SKVqFZQ661XuWjjPg9Kgp3e9M0POOl4R1
 rXvZJb_zS8HqbT.vWYysdJ5KhAGE6Iz5wlVivG2pXjXNGRJpLUOvz25viKevlGxdtO7j48C9FwUS
 bJG0rsEKsL62VVoxF4PuMPsAyFj9B5XdmQL_8uEABBVfXBEFeiB26z7FB0vJ0a3YZ_uSrDioHI9k
 nkQITYnz2FAAVrFLOcedWIc8xj4iPYDkkLJIqyno6KmWYiZQrQLAJWx4iOGKg72Fg2ihfubvT85r
 fbelkwhNU7S814bNZoeXzHHJKHNqpW.SVpzgloR_rWwPhwopW2hv5P4zcV3N_BNwZ7hVDUwn0TBZ
 TrnvLMAvHMzsjtYBAkpZE19ZH6b0R_qDTh95G_nF7DgX7oBkCp0lgN96yAmR9uxkxgRJGLxycFN5
 I9iuict_MkQhlkgXJ3Z0HtOrvP.Eg6jO5tzPRE9zS23fN.zQb5mWCTkZO5tTD6f0v0gWiR4Ipy.Q
 WP4x.2R7E5ZW4bBZ4Dyh_CmcklfnK6Xd5b6p3XFXwPn0iSWp1EyX7y7eKWSqjAzLG9e4sLtj4Ms8
 OA9jegw6OLMyuMrqCGCN6aJ6mlG6jhFhiPgl8AkiPLFOD.KEoqO4IkMnkBE_cyF3EpqnDZOqHnbS
 1eg3T_W027MlCxYxaQnjXm3ovfPg3S2zbHe4E2Su6n5D7vpK_pcTsL.VBJP7M31FkZABOboMXUl8
 9OjG9feh6TKi7q1wcG4iNFhgeOlXfcxzG.1zgrTbib79_ZBbsgsob9dNCzCFEZkf8dhcXeqBGA8D
 35Re5Hm2sZgi1YAJK0qvF5hPlMFmciJVbhlYm9hDa50iGdskBZoLcn1SJFHjx6yxBNbXWnD2vqiX
 zMwjsMNeICbbzvVLzWiA7iHhQ1jUvnKO8xGwQXjGy3b8CA2wQ6LOf4G2wabay9gwtSzKpAoNCRwf
 2903ZRu3jb1qoz3OXVdKb6G9phej1Yr1.G2LnSPYfiZGYNhFEsRXWF9JMI7IEX2TGbS6Yy4brrPf
 TNrZ4dFaKP1cNxLBT7tQKWqHopat3VrDLHWs0pfcgBKvk1wJjWiVZuRPdMtlQ5m.YBhpcT3KeubG
 2Nddz9SCkTCdE9dLB6PQOLpd6IfCLw9clJNhKfccV1hvMEJ6B0Si2Dm5lG6ehw0.HhcC61YrSuNo
 MZTp9MbC.z0KejFZeSUufaJa.0QwifMQkyjMV7LWTZnp.fo2C2RYgPyxqZCc46kXctvazZO.6WuD
 2puR7R75dq8bRw77TcUQ.gG1I6Lv4sdt8Fxf84nPpOLxQ0VR_kRW.3StmliYVsqwshi_2FIMrC.i
 JraN9OfrRBrDGTnKPvU4OpTs8nRiDZNPm.CboKKDWSWk6uMsAXNkpyxWW7dRodvE1zI1oKKFsniL
 0ArNumaHMH7b9R6glIEZlbmcJ3zn.5mQyOhh0J4YxJszoanvccTV_P02lqJGioEc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4d60b986-7ed3-4d05-823c-5d7a7b7466b1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 May 2023 14:29:22 +0000
Received: by hermes--production-ne1-574d4b7954-bq277 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 174ebacd8784abefa7ff5b7a2ade66e9;
          Wed, 31 May 2023 14:17:11 +0000 (UTC)
Message-ID: <cbd61b82-43e1-ad4d-e984-775f1209948c@schaufler-ca.com>
Date:   Wed, 31 May 2023 07:17:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
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
 <20230531132200.GB30016@lst.de>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230531132200.GB30016@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/2023 6:22 AM, Christoph Hellwig wrote:
> On Tue, May 30, 2023 at 07:55:17AM -0700, Casey Schaufler wrote:
>> Which LSM(s) do you think ought to be deprecated?
> I have no idea.  But what I want is less weirdo things messing with
> VFS semantics.

I am curious what you consider a weirdo thing done by LSMs. Things like
io_uring are much stranger than anything an LSM does.

>
>> I only see one that I
>> might consider a candidate. As for weird behavior, that's what LSMs are
>> for, and the really weird ones proposed (e.g. pathname character set limitations)
>> (and excepting for BPF, of course) haven't gotten far.
> They haven't gotten far for a reason usually.  Trying to sneak things in
> through the back door is exactly what is the problem with LSMs.

Mostly developers play by the rules, and we don't let things sneak in. 


