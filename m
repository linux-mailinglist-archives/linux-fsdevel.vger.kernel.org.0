Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164E27924C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjIEP7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354926AbjIEP41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:56:27 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147CF198
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693929382; bh=THyHfKoPV2fsuUoiXFpq6kpXStlY1R/c05SvFssw8ic=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nL/MCo2EaOVqeGvQVmPkAgdSTBQbXlbl3f9rZgHSTvBlgYky5+NOpmukm4tFGhxMO8jC3h4Kb8vSYSbZzmEiquFJ8novV5wGGi01YJeRQAwKr3L67KBO4CGOdQFucw5aRGYPcmE0zfx/JspHgZI00SfFWzekolOHFDDivqn6w+VKizmP7KXgzjIQDuvlv3uCRzsYuRBpNXTRnicS61wf0BZBVtBv+id8eJFW3Md2rUgFAAfr7vsSp36lbtc6ray61vMJgCj/G//5WovoZ/jFbE/mo4EuWeTDJEr5wBNW0NofS5VpH28Mwjj4we78bHNQMnxlAuZlNa50Cfy/Eczymg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693929382; bh=DkaHx4C6jwSxjVSNZ5qs87/z6Ie3ZQRDV6CUZw2QUMp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jJGG+AJRYrIJ1NDDUdmLlhcBNyn02E5/iy31ivu44RK3Xj9sKJEMywy0yxw9khQ7LQdA8BFC8BKGWKc5XKbzCWM5B15jZqa6w/qiZ8iwvhc5g8X2DLTksd/yGRxFIv9RKfRjM/zqljetV+e+aVQAcVlor9Fpuo9Qas5rD8LT2w1m1futPR27pAylaTWtX1A+aipty0jAceCRtDrZW2XBl1F/+4ZnSHghOo8v7eiHSoXznzM0uLOeARA5ypRGbgQx5ol8ofiERyoVhxEqWTd66YMNKsxoFVq6JCADef3JMRMYaEsxRJfb/pQjs25iOwRpNDUy4osynLPZluWy/Cz1/Q==
X-YMail-OSG: k9OkTWIVM1ldty.fWbkXGTKLls.RiXQNn_V.9WMitM5BuQk9.mji_TZb73rvWDt
 2G4d2n3DNfceBrop4oIfE26eITf..qCEQ3ynZ_SmqYIlMM.gflwN2aflioiUcK_uqFS05Y8lvVod
 YdDyA9VsyAX9BqStXDFlOvKNgcJWSytWF0kKm02ZMnvnUnNOkFG.sjj.lhhgAjcHrOBrtkFBOdN4
 vRvh8qQIDMIntuC3m1f.FaMQTORFHiMpSQaN5F0zL0MuWAcRwNuxkdO66AudRNlKcwnoz0MLk4gi
 HpXAdLVXAu11.jPOV2NuHO4a8VYWNDz6Y7RXGbrlZ75z_yypqTjrxFA1CStMN6PhbF8z_.72Xbvn
 Qf4uJ93lbdFj3Ze6YmwbfY5sAm.OsVny9s7FXLyYzBS3crMN8t6ti_lv_JQPGysl9f4gOcyZexdD
 9kOZZrKMkorjo1PbmKE3WJHsqCFgPRAbKNL_IGdQ6S0H17WoTGxZv6mi6CBzwzmwkE.xa2PVgsQz
 k5Gc6LAqRizzDZYWsAPhD4XdbiVn1pZlAZ2LAjtF4Vd2VQM9DsnVc5xebzQyffKcKNYpJPNHsTnN
 7YW2yLNPL73QsdXj7hpn__mEKDhHnOLR6MyeXgTshYzhsisf.iwqFZ6rVG05KfK4YbZWvc2wCkOA
 pNwDY5ssnf4D0FLl6n2KbWUnjUeQAbajLp9ZDkyb1gXFLGqPkVhbMfpIWlhk_oRTFm.2nmflv7Rf
 oUccSSeFpx6N_VmI5AXB2HsvA_gPuKpMdGVq7zaPKa2nllz01NbJYl8sZmiL3tGoZcjt1VUcJe1N
 G.7cPvEYFineyvxdJ39jPNoeTI8pWbwWD7pm5su.yl6lgfA7x6QomHf58O.dfqJ3L6qmwXGUlx6X
 0sEh6brNUlVUD63FGFJfemhPEF8xFNCLwClV3DsC8MS_tnNlDpppJl_CU9S09fhO7D84bv2jAcnA
 gOlG04QuuG5x.BoROlXyU1DZFIj1LCwqLuRA3GvItkTPuUP7PNl75AraQbxxvbf2wEtgSnQmqTkt
 qbkzz3ofX.ztFupgMjx5PzSZ8Lz0i.I34ToMu2Wv_ayPltP.VKcgx8ouflSTGqBKB782.sxewDkk
 7EScJHPtfFlETKPfcfn6ycj7CTirwJP4WnVkIFfO._fHq7aRTOJujd0dQv6gec.Qi0ud5GXhdNqr
 6QVPYhg6ZOSiDzMZJHbtrUCVbtGdaWIANtxP0Q.HzplEYm6lJbPpigaNkT.NXhjV1PN79YceIDhr
 thQcLl4PjmG6YHtzQgNjWtWrAASRU1I2PxP9.Wk1Jn6log.eU_EtCJOc2nYDzFdBoj8eQwz3MZc_
 y21f9eQqWafVA0IWNYUOVWZ5rcjl_X2HEgpufWnwGNzslnTWnBvT1qNSB1oNj7EhotsfpqLHnaLL
 7UAJrbW.xeHFqdc.434riLleeytm8pD3AnzXK62lpnepko3Hbzxyw3NPSmi3REeM.1hVzTZd3UHt
 NmCt6xeESYhdvkkehfPu37LNKbRjNDn5pQwi5.jLAlsVbRAp.FIiQR67xWrOIHc13128yc6xV4hD
 P9TZGmMhytguxLb9AoTAcEX.Wy2VJaEADkECSXNdXoVFJrXpzOhTdRjoklAvsm3zJc0lDme0Dt1U
 fsOT162D.MZbOMnizIZjeVmW_9t1MBeUnz_1vVI8M1GNTTrV1SQlXgZzhukp986FBWN2J9agwXH7
 _.U14P0fxKw0ZTw6UG30FHO._HAQaQr4Rw3jUdrMu14Q9UYceS3dKwhE5S1aRN4Z6bvNMeq3Dvfh
 xp9LHkWUe676tAdVqJkanKbm0Mv9ZK7W.CiHBoyoGYNa6hA6_iWyil26PRggQTY8rgNNZaw15vbn
 CCngWJpgZkb74SaefEIxE_Z4AVBsAbwwX_e2olh.dbwY4V_m4QFxx7kbLSvSOY10pKRgENSOSogN
 UV1l3ufpBsJLF3vC3ENKxfAk1vCasx.eKoSMFFPrkrS9Pc7gwBLZWK5KsrV80WkqRz.ZvH3uIrQP
 xvwM3QeZptygrwEKsjJtD2FEE0EF22N3J578jZGFKqpbxONR00ILBIxeXbruwprjH7gBiclJoMFo
 6s2D1e5ZX_N09VZJpCUo3f4wcNwxoABccGsBSzp.5Hwky2wy3sR0Z1RFZYoVuUZPh8w.cWP.sWw8
 RKqgpRZ9ymR0UwexFMktwjjisAsfGe2UzqNYfOS8BMZjqNktQ6.b04uhpKCJyMzeyZYtFEwCKERq
 SSyuQeIW7lRU2WnHA8sZ3H8cX8yuUGDOQLWPkCUF3W4A2pdj_vS219mU7Uj.MBBKE
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4921507d-37f7-4ee8-b527-766546420342
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 5 Sep 2023 15:56:22 +0000
Received: by hermes--production-bf1-865889d799-k7hdq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ef8773b1b277e360687bb4b263a51ff;
          Tue, 05 Sep 2023 15:56:20 +0000 (UTC)
Message-ID: <19943e35-2e7c-d27a-1a5d-189eea439dfd@schaufler-ca.com>
Date:   Tue, 5 Sep 2023 08:56:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 11/25] security: Align inode_setattr hook definition
 with EVM
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831104136.903180-12-roberto.sassu@huaweicloud.com>
 <CVAFV92MONCH.257Y9YQ3OEU4B@suppilovahvero>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CVAFV92MONCH.257Y9YQ3OEU4B@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/4/2023 2:08 PM, Jarkko Sakkinen wrote:
> On Thu Aug 31, 2023 at 1:41 PM EEST, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Add the idmap parameter to the definition, so that evm_inode_setattr() can
>> be registered as this hook implementation.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hook_defs.h | 3 ++-
>>  security/security.c           | 2 +-
>>  security/selinux/hooks.c      | 3 ++-
>>  security/smack/smack_lsm.c    | 4 +++-
>>  4 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 4bdddb52a8fe..fdf075a6b1bb 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -134,7 +134,8 @@ LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
>>  LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
>>  	 bool rcu)
>>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
>> -LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
>> +LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
>> +	 struct iattr *attr)
> LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *attr)
>
> Only 99 characters, i.e. breaking into two lines is not necessary.

We're keeping the LSM code in the ancient 80 character format.
Until we get some fresh, young maintainers involved who can convince
us that line wrapped 80 character terminals are kewl we're sticking
with what we know.

	https://lwn.net/Articles/822168/

>
>>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>>  	 struct dentry *dentry, const char *name, const void *value,
>> diff --git a/security/security.c b/security/security.c
>> index cb6242feb968..2b24d01cf181 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2117,7 +2117,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>>  
>>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>  		return 0;
>> -	ret = call_int_hook(inode_setattr, 0, dentry, attr);
>> +	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
>>  	if (ret)
>>  		return ret;
>>  	return evm_inode_setattr(idmap, dentry, attr);
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index ee7c49c2cfd3..bfcc4d9aa5ab 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3075,7 +3075,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>>  	return rc;
>>  }
>>  
>> -static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>> +static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>> +				 struct iattr *iattr)
>>  {
>>  	const struct cred *cred = current_cred();
>>  	struct inode *inode = d_backing_inode(dentry);
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 679156601a10..89f2669d50a9 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -1181,12 +1181,14 @@ static int smack_inode_permission(struct inode *inode, int mask)
>>  
>>  /**
>>   * smack_inode_setattr - Smack check for setting attributes
>> + * @idmap: idmap of the mount
>>   * @dentry: the object
>>   * @iattr: for the force flag
>>   *
>>   * Returns 0 if access is permitted, an error code otherwise
>>   */
>> -static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>> +static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>> +			       struct iattr *iattr)
> static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *iattr)
>
> Can be still in a single line (100 characters exactly).
>
>
>>  {
>>  	struct smk_audit_info ad;
>>  	int rc;
>> -- 
>> 2.34.1
>
> BR, Jarkko
