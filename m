Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356A178F5EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjHaXBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344814AbjHaXBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:01:46 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12686110
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693522901; bh=+6T1p/rhLk9I37VciR6gyF41ODEw3XRBP94uwIX4k+Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GqEmRxx6AW0roPc7S2EhIsIlwaduMemxmLs44Zr9kwLBNozaZhnbkJBGPO4Vqby/zYMp/jbYcfb9NhGC+cIlBDEsBcyCJzPHhvVC1usxrckNCoT3HjVX8ASn9XW1HDz7ZR8Vm+RsPpiqx+fFaKj9MokdhQXjCl9zSxo5TSEdAzn9+x9BYqKwE4Ey/WjANqMPxFgg24t9XeVkNT/hoWj8qY2Uo2MN14dQ+Qmb95QnFmYx24aG0em9BjQySXI+SQ1UYX5zioeDWTQu4NxDyO+mMiKid00ybaCHaflJcBI2S9TaA7+8qZIYe77ZymCG2yGwx5teDVCJYlVAWkmgb02J5Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693522901; bh=03CDcU853UrGsOxCSFhpceFcTsABrnD4ibKV7m5KZ/g=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PfYfzdYhccQto1elnCRK8t2Wc0VlLsjniXAuYN0mHI0Y1aF/9cunKqlsVx/2F1XxG6D81QaRcaR+nh9h6YJGSs8+wKhsrPWQZIwg1gKKU4G4qAur3Jqe8g6TZ8sWjlTDOZhCPR6hezNHuSAJDn5SeatXi+BB/O6Dh1Ddr2Dv5ZYGCcSUr/KERBJI9NgHiv7BsxZwIeRzR7502QzizTEHIqTe96+Zx9yQf2HvOMgRJnFBzdJpFbUl6tgeUz84+7mbEtMlR4nw+98gFxu8aNmVJWL/CWbNESACB6rVATZz5+c7vPCPGxL3Dj0b8RjXiY5d5kFIdMBfSIZgAUM0pAklbQ==
X-YMail-OSG: 8mceQoAVM1nNxvO2ZiypaR3guAyo04eePlFUfaJG.KGyJuUIM9cmYYNXSUuvVC9
 4rwoNsVP.nRLgc_FH_tF7lgQ0ezbZBzrhQPyJbrCtAY5GxH8EWwMtE.TvKTM3GAE2KDVGsctqCBJ
 1x8OBNe96tFDP5UuNpx_FObQkufaHyLTSSF.BY2jI9rhUOfXJDi52CHwl55QIsJ_1wbPIJvCvBPA
 MynvZHWV33xHSto9K4XjPt9bb0jjwt1uOx_cPJqtHrKUcVvO5L5ShjWXo7oWoeog4pqxcdIrd_t2
 .64.ujbGOz3sNGgTLcsFBZrLvboaf1fx1EtyRp5koeKj9JIkGGpQpB9ijhMPJSX4dqhxcwyLnfpm
 j2waGk2mmwGlX8UauYsLl2K.HTPvDUbJeiQvcuFphzR4OvlYbIgQF6L3CqM6_Vr7zWB2psXe8q1a
 JzTFfZsRzvmpDJiqeZbAolh3eOjgZclPIH.UH_IF9LGiF0jAixsc2HZuUtfKVXfeGDSVB6tXvj8p
 V54mn._Shr2YE_TgKeKzPS0ZRA0I1_08v6v45QxVB706HNC4X8VB6H9AGM8R6b1eKefjNsfrd8A6
 uiVsVyKJvtkd7jQ9yiicqDk4jDl.AHwDVvHLvhEFI5j2Q5sNPezujItUwcgLDeTWLulILgCuWXJm
 f8DmtMTYH21LFkk9JxaZxrTjoSLvAenFgyPQD97BRJlzFEWXdxwZDjggwz6oxLd6ZSIUF31mPH2S
 niN3UqG8SFhmgKOmGYmf1rsI_0.Y3lVx3rS42ohLUJRBTeWmGlYAg5oFSzwEEv5qPeaXsDZyrLcC
 paq6Om9eLcAlEZ1GdhjpYocIxfiwt_gCWRWtp.8u6y1HfOiAYTIuVK2kF_HGbbYj5zddyaNtdSSK
 3P.mFYfX6vGhrCelZKjkLNC.cCtvvZyZfa0v8jHg7hScf44AyvCG0WaFjnC_3wkQvTKJ_OAjJhCV
 MMEC_oYRRZdH2FyhhRUz9xQfYVCUIWS6xj_OdQ.xNZnIgjWOB5FtnM4AzDo4No5uDeqhU6cChk8G
 3cY_T3eDkZO9F.y6R7_x6xEG054Rkt4NCH6Ph8ARuZW_tmcfklghye6egKwNS8b6hOROH78WDGpe
 Ni5ncmvJJNV4kYVM_iqyHz39f4pQOsjsrtjXHWyE4lzhnsvw7G01m9S7HPWM.e2yHC1pEZOB676h
 UlzzghE.Ycs2LOjx555GoYFIaAGjy3lsZBKNIP7GTgNM1QCHWQ0iuCuOeuHSJWSYW3z7zYy9Yxzm
 GITF5Rz050E9Wt2fBV_4TTEdr_C2C.jjgvk3G6ipd6hbyR.zMw5SQ9gvaMYUgrSnQ7A7ZEBFZhna
 jMA6vpaObf5.AkOKxHiAqn6hHJiIsyDkQsHQMo8nRcKESV2XpGqAH46iXwNdha3vsK77rDUO.WwC
 ru1GpLZaCRixMFEElcrcwqNvx9t4VR.ZJAR2DQFzac6tX0E7jY2YLPLIC3nxZy9jz_fAPMBtrbez
 0zX11hHR.Y8YI04IgsR7r.VNXpmimKhEnWXrbhJ1JMsI7jpbMPqYxyeG._nJO8i3c3yz.7KDD9oT
 NLOZ5dlb9N768vOM6uxJTtrKuf7mB75qkmdBkD9PGTRaBbkCM_3xfIDxF9XV03_1bT1NLz1MQvHH
 ipdYlMO1qMWMegUy2yylLz9dE54_Kvgya8l47.XRyVqpdqXYuS228wZIv8e2JfFZ_1pl1YHmAfL9
 u3nVLHqeMvAGD4LzqjGogalVevK_35h8hMdyZ_rPmCq_rj1N1m7c_mV0pbBZ6cXNbsekaqGGqCPr
 3dYJ1xue43y2cJgVn14iYgUUCSaDy1Kb72Xc7OCna1lQdaCitle2pElHEsyN9Gu0D7IlwctFvLT9
 knrH2pzRRO5XWpZrWvdV_hBQR3Hzz6kDVtMCz7bs70IZQiwYTg2myM9GmX_8QH2qsQvOgXcOUM2F
 WX_nyCgWZ1GdmzLShobRWPw5CpVG2vL2TGyy5g9gklBVghesIIhNr_wQpxDdFTMt7gNvPjgiK6CM
 QpADVrI1vOjfsvP377H.TrLvJs_LxmkN.I3NHkwiZjdSwwsvzPM79TCyJYXsBAyct2ypYulHlp2v
 kT_4Da3Z66xOjkw4LuVZssbaeznJMRNzqkJ8_XmPMZIbdpGaxpoFIX6.u3tTJtlf5jL0YI_vpCPI
 GYcda81096C1yqz5qIV6RL1iDuLlbIlueQPw0rdloZ3jH1wSNlO2PflJ5zAg2S1rn8CV6viRovYt
 WjQ9VNcMkcslnNKVr2T.yv4UPGSkHnA5MH7K6QYX5X3AHkAn39dkf8cw9meJrd57PqSwoX3dBxPq
 arSpW
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a6327dd2-cc5e-415a-8107-72409134d7df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 23:01:41 +0000
Received: by hermes--production-bf1-865889d799-k7hdq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec66d5285539eae986581f3ea1896b9c;
          Thu, 31 Aug 2023 23:01:37 +0000 (UTC)
Message-ID: <21bea0a7-c8b1-87b5-b03c-d13deef6025f@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 16:01:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 00/25] security: Move IMA and EVM to the LSM
 infrastructure
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 3:41 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> IMA and EVM are not effectively LSMs, especially due the fact that in the
> past they could not provide a security blob while there is another LSM
> active.
>
> That changed in the recent years, the LSM stacking feature now makes it
> possible to stack together multiple LSMs, and allows them to provide a
> security blob for most kernel objects. While the LSM stacking feature has
> some limitations being worked out, it is already suitable to make IMA and
> EVM as LSMs.
>
> In short, while this patch set is big, it does not make any functional
> change to IMA and EVM. IMA and EVM functions are called by the LSM
> infrastructure in the same places as before (except ima_post_path_mknod()),
> rather being hardcoded calls, and the inode metadata pointer is directly
> stored in the inode security blob rather than in a separate rbtree.
>
> More specifically, patches 1-11 make IMA and EVM functions suitable to
> be registered to the LSM infrastructure, by aligning function parameters.
>
> Patches 12-20 add new LSM hooks in the same places where IMA and EVM
> functions are called, if there is no LSM hook already.

I've commented on the individual patches, but it seems like a general comment
might be in order. When a new LSM hook is proposed we want to see more than
"project XYZZY needs this hook" to justify it. We want to know how it is useful
for XYZZY and how it could be used in another LSM. If I were creating a new LSM
it could be useful to understand the difference between security_inode_setattr()
and security_inode_post_setattr(). As a reviewer who has had only incidental
exposure to the IMA code it's important to understand why it doesn't use the
existing hooks.

>
> Patches 21-24 do the bulk of the work, remove hardcoded calls to IMA, EVM
> and integrity functions, register those functions in the LSM
> infrastructure, and let the latter call them. In addition, they also
> reserve one slot for EVM to supply an xattr to the inode_init_security
> hook.
>
> Finally, patch 25 removes the rbtree used to bind metadata to the inodes,
> and instead reserve a space in the inode security blob to store the pointer
> to metadata. This also brings performance improvements due to retrieving
> metadata in constant time, as opposed to logarithmic.
>
> The patch set applies on top of lsm/next, commit 8e4672d6f902 ("lsm:
> constify the 'file' parameter in security_binder_transfer_file()")
>
> Changelog:
>
> v1:
>  - Drop 'evm: Complete description of evm_inode_setattr()', 'fs: Fix
>    description of vfs_tmpfile()' and 'security: Introduce LSM_ORDER_LAST',
>    they were sent separately (suggested by Christian Brauner)
>  - Replace dentry with file descriptor parameter for
>    security_inode_post_create_tmpfile()
>  - Introduce mode_stripped and pass it as mode argument to
>    security_path_mknod() and security_path_post_mknod()
>  - Use goto in do_mknodat() and __vfs_removexattr_locked() (suggested by
>    Mimi)
>  - Replace __lsm_ro_after_init with __ro_after_init
>  - Modify short description of security_inode_post_create_tmpfile() and
>    security_inode_post_set_acl() (suggested by Stefan)
>  - Move security_inode_post_setattr() just after security_inode_setattr()
>    (suggested by Mimi)
>  - Modify short description of security_key_post_create_or_update()
>    (suggested by Mimi)
>  - Add back exported functions ima_file_check() and
>    evm_inode_init_security() respectively to ima.h and evm.h (reported by
>    kernel robot)
>  - Remove extern from prototype declarations and fix style issues
>  - Remove unnecessary include of linux/lsm_hooks.h in ima_main.c and
>    ima_appraise.c
>
> Roberto Sassu (25):
>   ima: Align ima_inode_post_setattr() definition with LSM infrastructure
>   ima: Align ima_post_path_mknod() definition with LSM infrastructure
>   ima: Align ima_post_create_tmpfile() definition with LSM
>     infrastructure
>   ima: Align ima_file_mprotect() definition with LSM infrastructure
>   ima: Align ima_inode_setxattr() definition with LSM infrastructure
>   ima: Align ima_inode_removexattr() definition with LSM infrastructure
>   ima: Align ima_post_read_file() definition with LSM infrastructure
>   evm: Align evm_inode_post_setattr() definition with LSM infrastructure
>   evm: Align evm_inode_setxattr() definition with LSM infrastructure
>   evm: Align evm_inode_post_setxattr() definition with LSM
>     infrastructure
>   security: Align inode_setattr hook definition with EVM
>   security: Introduce inode_post_setattr hook
>   security: Introduce inode_post_removexattr hook
>   security: Introduce file_post_open hook
>   security: Introduce file_pre_free_security hook
>   security: Introduce path_post_mknod hook
>   security: Introduce inode_post_create_tmpfile hook
>   security: Introduce inode_post_set_acl hook
>   security: Introduce inode_post_remove_acl hook
>   security: Introduce key_post_create_or_update hook
>   ima: Move to LSM infrastructure
>   ima: Move IMA-Appraisal to LSM infrastructure
>   evm: Move to LSM infrastructure
>   integrity: Move integrity functions to the LSM infrastructure
>   integrity: Switch from rbtree to LSM-managed blob for
>     integrity_iint_cache
>
>  fs/attr.c                             |   5 +-
>  fs/file_table.c                       |   3 +-
>  fs/namei.c                            |  18 +-
>  fs/nfsd/vfs.c                         |   3 +-
>  fs/open.c                             |   1 -
>  fs/posix_acl.c                        |   5 +-
>  fs/xattr.c                            |   9 +-
>  include/linux/evm.h                   | 103 ----------
>  include/linux/ima.h                   | 136 -------------
>  include/linux/integrity.h             |  26 ---
>  include/linux/lsm_hook_defs.h         |  21 +-
>  include/linux/security.h              |  65 +++++++
>  security/integrity/evm/evm_main.c     | 104 ++++++++--
>  security/integrity/iint.c             |  92 +++------
>  security/integrity/ima/ima.h          |  11 ++
>  security/integrity/ima/ima_appraise.c |  37 +++-
>  security/integrity/ima/ima_main.c     |  76 ++++++--
>  security/integrity/integrity.h        |  44 ++++-
>  security/keys/key.c                   |  10 +-
>  security/security.c                   | 265 ++++++++++++++++----------
>  security/selinux/hooks.c              |   3 +-
>  security/smack/smack_lsm.c            |   4 +-
>  22 files changed, 540 insertions(+), 501 deletions(-)
>
