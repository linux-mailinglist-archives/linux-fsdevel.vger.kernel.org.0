Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CA5A6582
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiH3NuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiH3NuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:50:03 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B378583
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661867280; bh=B5MGNwLw1R/K6iXbs2us17O4OX0icSuWFBTlB2a4F2M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=O/uGPvRsEknq7kDFYpG4ZLOyXMCDSY7qYm+nYPE3v3Upx02++3uBgBlxQWiVHjFVRrz9Hffg15HIkUrBVzZLFMVR5o35Zws2Q3QQx96PDwPCKWnrggZyB2NtJEPIs1PkcFEiMiS7n98rcJrBolJ6296nrs1+Tm03aVxtTUHT27gjNfZk91VJGmURJp8vXFKxGwq1T816wJjhw4VEIG8TM+4B8Okdp6tArkTygvHbsL9Q2rK7lUIDYUpJ9NLktdQeOOdJNqkdbGxC+drUjQo4FKfp1UH/Z1V6sflOfg12yCW+kA8kHYx8U4vmd1wckLkesYiCpkoBuD2JMXNoRlLOjw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661867280; bh=T2ZoFCGq3etlFB6RfXACydBhjBS2Jt+rn+43SIxk0ZO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BhCfnFQWlJf6PUaSAAZ4s1eno1TYL7AjnbIhyHaPcHMpCsDJvoQT6e2e7/k+JB21kQdF3/Rm2zdOAcUXaDcPao9KG21sJWLm/2nJw0jemLNLwgg29eQW05IgGb7b7vLoK8AQLqKO4Bx0AhWsPLPtIBw2dy9Bor8/TdW3h2Eiom68L0CHig5URKOiBEzqK+tUJU76dMeypLwko7rnuEwZMUJiJjqSSwFsxxAxIv0ZgrPwMW2HO9cmTB953H+z79BDBD6POwIntBbkLm9JVp8Dp82l1FCaLICj88IzQQef1M7iF6EETxceEHbtV3iuIuK9JpiZjSO6fC6eBIZkCJo75Q==
X-YMail-OSG: 7J2QYA0VM1nJ7OTEJ1KfWJ3fpjEAB6rZCW0PyoNiqg_7rtbOHDvEFsoG_KVljvQ
 FYgYoHDON.kTIyfxIrgRl9uMQ4INDiNV0hXGY_F_bQKm3fr2k5P03UztI6O4jNhDmo8d2.bvPxk7
 .WL_DV4zu_WyDb3k3fpwdvozzsH9NlPKANuREtgTP8UbriRoqL.uKYUFUGWG.W5RJa.T62URv6.u
 f2mKXcgZSP4MVaf4jgedwJ8.x48krFQLl2UQGPjqFq.ESzTi1aURtHXbkaTOboRXpI92iWW9ados
 yYw9h5M0S7hIiqbX43G8nGCS.QR35FuVsQlt4eWo5s0iMIG6HNzL8UuXZqPqNe4fdGqqn1zPvw_H
 SiA_b_dZUFHox1VXyhiR2xsqQ7YyIZ1ZMl.LkEyOZ5AxdyOuqRyby9NIBlRvH8dVZrbAuahTSWv0
 LtMgD8HGSPEhfO9zqVAGYpPji8jKqs1oj_Ri0WoHFWVsj52UNDZDdTM.oqZXUZd_g32Jk732ifVa
 rAdyrCUEQwXwKIZinTmQ6YBTYh7QJF9Ox3i08qaqaxeyvgNtYcQx2sLtEFKp8jUFgLN5zATprEiQ
 _FuFk6tWZK8qfnLPflr8ZAPSD3Xgr.KrdkRI_DrDuWWV6I6xZeqNybpSJVBZIO2yPSMXm9M5mkoF
 5pYFjjqrnyQWX22k_HF7tXS_9RVIdzooJIikDFgOW67Aji.ya2KkFhc1Nun0vVMwcK4F_P40Yvpq
 ddDlRPaOQkoPla6IxcHtqqFQ5GblrkAqtJTqXJd7kNnRwK2EviJzsE37hUPVh3dsM1oE1IGG7gMz
 09UoKwnjzz3zBAS.IGXpbhKqX6C75F95c1NskxWrf6Qm0N4JfYPLI4726ejPkSyUMrA3YsXhJDTi
 IYrJI_bgf8RZGUykuWMUCxjE9KPQ0Q0HrQYeqmHAYMTwycNWV8F8j2PRuL1Ox8yND0e0IM3VOZrn
 OLtjxRUcdFPVBcX4aLrQrpEr4vPGZ6tZTsAYADukMvx7RGkiRdCZ7iEosyzmDJS9vRfevXmBPn5r
 KsUza5OONtWNGA8Jt5DNtOZzthaaf4T3j6pN_cPT1v0XzOctZd5zyW2fjSHaY2IsUH0fxxdrrc1y
 bkVh2dG_x5bViiYzZR.LBl7ort5kuTUEX5WjiNnCeid9QlqLVoNU6H87sYMRjqdGnbMO0vNWSBJI
 qTIzNYFm9PgaPL_dUt9GBVK37foiTju5Rh1buDNhC.0Ufz0En2ByK4vWpmDg0STVupiGM5M6UYij
 BhXSHunir13cP3kDj0.lJpslwLdVX9VXDobvKD3RE0f9bBRechFp8kgQFV6yq7FKV32NDho9Ygtd
 kM8mVoitvMZF0xajvIA.h65w5L2yzs9Yd0_9Fm49kyjLqVO0xbdG7oAVONBBn9dlMSD5ApG0bDVZ
 OlBSDMXZLymVuKGfWif.TzRxbJnod8VbdVtUZwoOFeipGohgTIbg_gvFG.H4o5eDkYarxRHs6K2M
 gjguGdjyuLe4XtUUpE5oGiXb9pOvkV9O_M_1GuYf56Na3SiHk5WSQi2PeSlP6p83MxhoKrEjbT4v
 ddVtMF2AFBj8202KENjy2PhnTAZbawEYEsDNU8oldCGXluk8rTxCYD6SJMF92JLfZUI4TTik4K.J
 qM_jy5dvOg4YWL4S8ETsbkSoTyXzG4stNB5K4VEMC183Ez5tj70e6ktJAimwpjQ9Rg0Lchdjs6k0
 CBrZbm6oG7ttakJ7PnKVEeITfgdc3dBnTHlFYpj2vlcZ9U4lgVUipTl5oUNORfE3y.nIUSbb91z7
 U.LW0iRi.pFn4VlkJKz2LEEKe_YXypfvxUPMLPLRkkKD8HHxK9JyVSEwrhXstVl4VJj.HCQ8poi3
 acAttq82E4f2JXdBIbw2q.ntHRPGxnA0cXUwHTfxRUbdY6H85pR4HFxmZHXWFJf0Ng95shR6Jb8M
 okT6O68sQOa60EZDtPyjGvi21YBrBk6BZ3Z140mGElMW3sHhRRNoxy1wPoiKbSr97Hma2lR3P092
 X3v330zAoVLtH6H0qLMfOJbeH4TktlpLHWM7SeeH1Elgi72ThjR4yyGsoR_DgCKtqcbqFgCvkyYP
 dYy9010OcbI_nNlFj.pUYOTxJBfN5Ffd7IXjak91udh90DAbQRsHpeNY_TN5V5uRNbtQ7I1am7yV
 sEU6mX1Y8zl9_h7C5_lNnfrykgvdCw8O.gZryzERbdOw.HbJ6bAoJy3sLnyh8LfHWglLzYY1gCJk
 t.sKjz4_4vrunpcC0A_peaTm5X25y97ZNOkQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Aug 2022 13:48:00 +0000
Received: by hermes--production-bf1-7586675c46-klczj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9d7aea0643af7036c6f2938b0344572d;
          Tue, 30 Aug 2022 13:47:56 +0000 (UTC)
Message-ID: <89548338-f716-c110-0f85-3ef880bbd723@schaufler-ca.com>
Date:   Tue, 30 Aug 2022 06:47:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <c648aa7c-a49c-a7e2-6a05-d1dfe44b8fdb@schaufler-ca.com>
 <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk>
 <20220826082439.wdestxwkeccsyqtp@wittgenstein>
 <1903709.1661849345@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1903709.1661849345@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/2022 1:49 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> The authors of this version of the mount code failed to look
>> especially closely at how Smack maintains label names. Once a
>> label name is used in the kernel it is kept on a list forever.
>> All the copies of smk_known here and in the rest of the mount
>> infrastructure are unnecessary and wasteful. The entire set of
>> Smack hooks that deal with mounting need to be reworked to remove
>> that waste. It's on my list of Smack cleanups, but I'd be happy
>> if someone else wanted a go at it.
> I don't have time to overhaul Smack right now.  Should I drop the Smack part
> of the patch?

No. I appreciate that you're including Smack as part of the effort.
I would much rather have the code working as you have it than have
to go in later and do it all from scratch. With luck I should be able
to get someone with a considerably lower level of expertise to work
on it.

> David
