Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AE777B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjHJOnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjHJOnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:43:49 -0400
Received: from sonic301-27.consmr.mail.gq1.yahoo.com (sonic301-27.consmr.mail.gq1.yahoo.com [98.137.64.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F61268D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691678627; bh=s6tCDk9UyfhL1YSRdrWMA5pGWVmqutdN/x079yKWyxM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BNUK3mVqzq571+ZpNt8UBUHRr1AZE+J/4TLtfOlprlPq6Ai+Pb6zpTLGWiEwOS5pVxOpEET0U5M9oUGkqUrsbYUDpc7A0a4vsabjD5UbKW62zT2hFd52RJB3FQeiIvfhQVPbW6a/3l/m2RXjBmn7YVV1YxLKt9cXV9eQjq2ouPvqwB7sZ8ceO+UbtutEM7102ZGNqdbZ2XDdJxo65vmr++c46X4DLQUo40lwDm6jE2LLUAQPpI6IyHfM+wAPEfOk/kn/3bOs1UQ6lQJy9luf4I83W1OPEbsuWY2QL6a8bUrMNIxhnoNAhq8PmgW+thU+zgMbPsUGmOL2wiqr8Rlb0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691678627; bh=IZ4Xtuxgl2MQQv8LtjaTOceb0kurY54ceFgtnFZ/cnP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uegDNNJeVmJwcFvZFmRL4UOLPVAYP9sF90uUxpox3G6tIvfrkc9Aco/RxGSKKISULQmDtaC/Yv5CrRmBwedKZWD+mE//D4E8wzIkcib+ykv1SlyLl1nppvGvisNzl5fPTpm93UVXhJP4+N8XO+XKynHkCjN0w5fyB3IV20/naMEZbLx8XLc+90vTeZZGs53XnHkHIDy/24IQGQQpHASBrhepCBYKzgdjboPmkpshV0hpz6tLk8lTtluy402G7ZRbbW5crbHkCKNnn8rAaOak5c1IInLBCJZRcFw0cuyW68Mt66gSGh43VrEp92fSi8E24EVaH+rod7iFwP2NRVDlKA==
X-YMail-OSG: Kj9YFQEVM1nE45h76xI3ndv3RQ0Cn55y3M2ZVlMLZtjpXi.sGArvik18D5WcTED
 XY7M.Tih2zTBJTQdkcC0W.UfDAZQODR0hMW5ovKhOk5dK40mEBZINRVp07b0aZoOelshiMqXaHtd
 _eN2sLoMEdBohZFcaVXN92GbK1XQWrc7IPqDYETotpUUyF4UhtbfoN2I04aKpZ1KX3A_iqaFDoRk
 xNznK8aa31cLPK09CQ.5JmQsmjexCzG_tm2ZufI_ld3nH3qiT29FSz2earDSlRY4zxPsPPf5DnWu
 NiyCyq0U0mY.aMF360e4f_IIT9Gf7LOf4q_O01E_6tImvYZsEd5EK0CDzblkhMMD_4sgqDXJ50dp
 rVe8FppI8ws3zhWTPGE_Gat5ZDv1pZqtF3CwTOrpyTScw58sA5DF4Sm7Q3trdtrSPcbqh1tBw2OK
 hfhlcpPhtxuvotqM7N0uzTxNqyYzo6PMQJX1BtIxUjiMAAFS.r0FnWZ_wkBah6qxYTmf5j0P2ADM
 SSptQRL9Zf9FIF9bLLBp_OIzfsSqd482lf0LrXEq6MjgyH2456kdAUAmp5ZWOD5J7lr5GZePZYMK
 gJi.xiGGdeeThoTyG0osXzpHMqfHj5tYr2k0j8QxUzfmF30evTNX2Vri7vlOfy.s5a0MQDBrCvov
 cg3rh3HpCGFt7RNVUjStwhc8r_5.R2ETTwrYLK2z2w92YNU7cwCpqoBcVrmIVpGvIDsBLdAU9QKs
 qwZ9gyo_kBbkm3AJDpz1KkuJnigPqamwg3GCExdp7Y7dTy4lnxNuyLgZLBY28oLdBp.4u.rCoT9Y
 c5.UpGtw.6US3zAcw.zXfyCnYuKJXsxvU8zHTA0Px98ibT1CcZNp7MMKK00cV9n.sIITcW6c_HJl
 Qg6itAsqXteiKZ3Tc9t.ueDRLrcPV6T.bhuxiKr8SgTEsU0WgBWCysbC7I7_wIBNO_3UT.ZvKLnb
 alqZjjhvvMvlGPKgxvCorrVrlqG67YRh7frB2EgW83Yit.sJLt59P1srcF_MPsp1i0SXt2C5BPZZ
 McWsFSvVYsj8rm7H2NcgKfFcl_8ZrT9Low0nDm0z7aoue8k03H4zqGnDHpD9tE8AuwgN.qMB46Rs
 ch3LM6XrmuipzbFCalnfK1jKenewAtp78.pIChpJCaOSDEb9gQr9nOiTnNI6LR2Y5E9_libhUcho
 qfN75wVb1Ldqi2ngtATlS5pY3n4UvLGcnzqQ8PBVnk9ruEWOauhQAIBUj5zNI.SlVbRXOaPuhqcE
 WE0R5FDN2n9pMC87mGSTotJXx_kv5wZkHFPgYsQp6Ab.CiyVIF_0accmHqirSg10D909cOypK.Oc
 4m.0qFBme3Bi2yYVDi_pVIBuT936_AVmAsgHTg.RHqDnB.7KB.yN1NzssmYWXEYzbEgVrbLXGBhd
 k1ScaxHtctBRPdXYrzkhq75Hdv4b_LN_LhIsNLl5MuOGROXX3yT2ALWfmmFz0zewxa71P8jpJN95
 E8vPx689v5.LgffLlsqt8A_QxCwwohB_OMoNRkssfx4xpvIArw.KnUi_wen1vlTVC4TCET6D8_rO
 RKdXYolZOG4XjTn8AzOI99ascJ2P_zgu7PKbW3cIMbDw7UEc71xfJyvF0VS4surJfH1wpfBnhTEa
 _euJh3gY5gHDNwugSQlIY05_jOonyI8mGsxkuXni.WtdCr1fEtkOGuBkAyUIIOfIZ7Z_POT_Iv38
 AnS.4I9kkSxlqtzZ8sQjR2fcXFj8K_wvMnJblayFsJzMUYTEi8XF.SImi4TcX9DDGOveSwBWO16U
 F_JPW3inukm_FzJ3rFJ6HwVCT8QZC4WzVyDo3MeBI3rBOdJEloN9h40AF8HhDna5hUCU43toaSLX
 AaJS.zh7XbkMAdBYo9_BbqIarnFv9gCVYv.kgEcI7fKQO8lLx2l0t7EjHmavwPr063uwXHPq_i.A
 Dmuz1mhi8W_DJi3V5DML_OC1Qqz_i0Cvmo629bmPqcfQK1XKERd3NxuOfOfNHSWAmHAVRfEKAusy
 Lph2_jnWSLjU_OuNDK3IAIJ9uCxg34FetyKOAkAM32wi8gDGqjK2jQlS4M7zPZU72AMEeOUflL_W
 7SA2KNo33_wgU.PBgyEj_iWpNLBhBhRiG0KobvRLmltToDLxtDveVph6HNPnVpzN_rN6S8T6.isL
 BhwY12Jd5rNs7JsF66ZKheWREZTtidSoCQFv3oxeLbsNCEh0GapXnrIwpzztNPEu8Jz15ecBrd7o
 IsFtoxSygoHXDNlZQbrLBEX_.IiPL_iqnC.aoSKDsRxz2E7DvPBUPxmSugjvLNXLa8n1mILJnPAI
 PuJ26MykYHDtY
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f0cc5f6b-a4c0-42c0-9ba7-403f28037460
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 10 Aug 2023 14:43:47 +0000
Received: by hermes--production-bf1-865889d799-jmdc5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a9bbc77b56ed87ced85bb7b61b95bb7c;
          Thu, 10 Aug 2023 14:43:42 +0000 (UTC)
Message-ID: <52e17a44-2572-22c8-269f-d2786e32022f@schaufler-ca.com>
Date:   Thu, 10 Aug 2023 07:43:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v9] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230808-master-v9-1-e0ecde888221@kernel.org>
 <20230808-erdaushub-sanieren-2bd8d7e0a286@brauner>
 <7d596fc2c526a5d6e4a84240dede590e868f3345.camel@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <7d596fc2c526a5d6e4a84240dede590e868f3345.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/2023 6:57 AM, Jeff Layton wrote:
> On Tue, 2023-08-08 at 15:31 +0200, Christian Brauner wrote:
>> On Tue, Aug 08, 2023 at 07:34:20AM -0400, Jeff Layton wrote:
>>> From: David Howells <dhowells@redhat.com>
>>>
>>> When NFS superblocks are created by automounting, their LSM parameters
>>> aren't set in the fs_context struct prior to sget_fc() being called,
>>> leading to failure to match existing superblocks.
>>>
>>> This bug leads to messages like the following appearing in dmesg when
>>> fscache is enabled:
>>>
>>>     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
>>>
>>> Fix this by adding a new LSM hook to load fc->security for submount
>>> creation.
>>>
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
>>> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
>>> Tested-by: Jeff Layton <jlayton@kernel.org>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> I've made a significant number of changes since Casey acked this. It
> might be a good idea to drop his Acked-by (unless he wants to chime in
> and ask us to keep it).

You can keep the Acked-by.

>
> Thanks,
> Jeff
>
>>> Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
>>> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
>>> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
>>> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
>>> Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
>>> Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
>>> ---
>>> ver #2)
>>> - Added Smack support
>>> - Made LSM parameter extraction dependent on reference != NULL.
>>>
>>> ver #3)
>>> - Made LSM parameter extraction dependent on fc->purpose ==
>>>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
>>>
>>> ver #4)
>>> - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or Smack.
>>>
>>> ver #5)
>>> - Removed unused variable.
>>> - Only allocate smack_mnt_opts if we're dealing with a submount.
>>>
>>> ver #6)
>>> - Rebase onto v6.5.0-rc4
>>> - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d48299168b@kernel.org
>>>
>>> ver #7)
>>> - Drop lsm_set boolean
>>> - Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e48407298@kernel.org
>>>
>>> ver #8)
>>> - Remove spurious semicolon in smack_fs_context_init
>>> - Make fs_context_init take a superblock as reference instead of dentry
>>> - WARN_ON_ONCE's when fc->purpose != FS_CONTEXT_FOR_SUBMOUNT
>>> - Call the security hook from fs_context_for_submount instead of alloc_fs_context
>>> - Link to v8: https://lore.kernel.org/r/20230807-master-v8-1-54e249595f10@kernel.org
>>>
>>> ver #9)
>>> - rename *_fs_context_init to *_fs_context_submount
>>> - remove checks for FS_CONTEXT_FOR_SUBMOUNT and NULL reference pointers
>>> - fix prototype on smack_fs_context_submount
>> Thanks, this looks good from my perspective. If it looks fine to LSM
>> folks as well I can put it with the rest of the super work for this
>> cycle or it can go through the LSM tree.
