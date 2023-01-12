Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139696667EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 01:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjALAjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 19:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjALAii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:38:38 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D449344C63
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 16:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673483878; bh=W7I2kaMfttM+ttZ2kPzOe+fD329e9tMxlyBDmmg1uus=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bPbS8p+qGmsJ+gS18SXt04BdMJNbjV7lGFnqbB60sD+YqZQT1cGuMV2zYcWjolz8eL4GdBRCUGjbesUt30QoY5KzQRhy7yElurVyBrKwmSiEfOlGcS1EXqJE9xsnT7+CEjHQbU0xAs6OwhG+BOGdIvWr6bm2FZAmJrDGq7K9BW7KMAuvSoTvDx77gt8sosXZmK2yrMCwOERx97D4B1P66ByUyK93SxXw4DMFfNw0k2WeBsa5/0EfpmQwJtWnAhTqtdvVA53xjWfNQXbUck6qctVUm0UoNp79pqsxVLrpRW64v/zq8Td2/bZvOpPFEvfbICvr3XUiuv33YJc6e4IVUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673483878; bh=mHCceT0ZIuymVpwA19GRIjtceLYyTmJWNeXtP6sh8oe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sqLraq1BpKU59MQ55YSIlG6/FyrfQ0P0s3IReR23ciftu0314tYzuYLXpwF3885DPG1SVOCaVFV/rhWaMKuc6VKZ2k9mLT5R+eH85Dkb+lH/ZKdP+sqH046zbElxcHZZAxLUomb5D/OQ1SVxjxbZYwFapifYrAcQEZ04NhQzDd2FP0N00xd4ZLe5z7FyUY7ewOygH1mTV1W5LrrMnZ214KJRH4bcpLf3sULPM5HHrHu7cQcT6FebN46/xwVfuFx1G9az82GWVFIy9SnvlWSjNgO/TtVx/3cDTWpr6r1gDEVh9DVoay67dl7496p9NpsprFu++tSxS2/O5MKS302FeA==
X-YMail-OSG: _IZfNaoVM1kYzaxdZrK.eLHDHwRGg55yMP24wWt_7wow3JZ3HNXccz0hzr0E4kc
 X.9xW5TBxq1bD863xfSDF2WcHsd1e0YV7fxlH6B2cx47nm1uBvQg6JcA87YK3cHbmcn6_FjArfhQ
 HP7.AHGFCPPcCLE4cIrWGfUdRgYbl6vY9H_UlIAgHP3ebWR4zR.k85XCAeK.FRCCke7IlAYJGW83
 .5UP51t1xPmFgz1RrKHfaZVxsYvIh5pAcn5vDbk_9gawBRdfe9VBSgbEpOs3FhY3KL_1W7pzt_dg
 Lma8.ZHiPrZ9fSbi_b8zcVR5tADMBP0PvFWjjou5.p1b8iIySPJsuh_F1TyR1KUei50hedqoz.Ph
 zT7rpe2aVwaPcLYumTBFkKc.qyJ3DZ0N9LItMhqpcG6hA6bRM9mA0S1xJdYrtIHgy4YXIFori0dp
 Suc.oFN8CjZpUDEIDZKX1Fcut76SOeWw0vwWNrLDoMwgfCB20IAchRo0yDgVybrKew2Y89gjGsIC
 6QQdbETMSL5ot6StfaPB5o_w8cPN7g1ppSokTvntMn_nn5Th8UHbUJUSAlUJDEeDi_3clckzvo8B
 opwyxgzYkBIPmVd6N17NpfPLfeo8Ef6T9sMrtHrmpKMtornNhZVrsg.KDweKCyEj4cWRy1Ycvqlo
 0TRgmUPzh0wFRF2n_csU0Vnt.wV7pF_LWYAapoq_BaqQyRflbq5OdVwf7iTHI30aobLSvLXKMlAD
 s0mU7mSHC8zsJpnJF.SSoZXsauqilw11Ce4fSSBGirjB4l.EDDIYgR8OxChuE5eNVQtnU2On6l4q
 kQrj4VtoyZFH6tW830KyNAI99HxNQN_RreAylhIKfofevYKvGRrdY91NbS0ayRKwvzuPoMelSyXX
 MUsLMtbV18D5wXNOZSSAAt6VRB.vajU2MLA8rR5kAdG6.yEbiJjE7g5qnUnqPef0b7yE9azOeM2r
 DBJLmM.DRLYtNeazrB7NBZgoKtPE20sdaP9nsPCmPz0D4l7In3cA7AwsUeBQrp8sBuHowEkVhxz2
 cR17I4nvOXWCKLtdCaVLsj8XqrJ9G05o_nbjL_FpKewEYBlOTPKF0vCpPGK.lYuRiOdRlNHISA6z
 NRlpFGcUmYFIWxjVrBw2FgCPmY8.nXcfpoZLgsJwH8raI6lv3m3AoH0hL.u_JwZ2WdpH5qHe7PMI
 JWUgYebCSScZWHi55BRaZ96iTL7nTZRO.78.eh6_EVZX_1Rse5TczHUz6q7YIpuNdKAvAVeN.66u
 oyjUXCy4KVQAgNVsfXs1Z52ozSv1t8izzSeNdqHY2cL3XYduU1GAEmnDHfmgJV9JpRMzMPdBKJgB
 ElfRQA5U4c4ZH.y0O94TbEhFx_8k6n0dj4Yf1Fbx_9Bmdgdjb78x_eRlOe3vcM150l4loReioPd7
 NZfNfI.3XMVHjXM894fsOFpx2EusAFuYZrzErcGbOuLC2RGWvyvU8asbN1METaVn.P0zAQTMxoiO
 .YZDGIFXQAFQspfvesfMnekdUnGDAwm5Y83Tuc50McptcUlIoer1nqOKYc6N3vNueRDjInBm8RV6
 ptlUvGNtV3Enq1QZZbK3kEC2l_uRg6f47ASvGLvy9iypCCUSE3KIDx_ORI33M287QctAIb.yrOCE
 0WgBNg6MCkLWyLWaViSkdEORBEX1X_nUKQrAK9YmGFn0ZL.5P93XgPFCCLa0U_vrzQQ5799ZsqH0
 hGnOQZ24iGhefdZ16YmVlry9W6H2pORE0kWlF5J5xj11q34xsQqNc8cGI8tF8e8WnGWwW03qtsBk
 dM935iYAUyxgG4piceErG0z7K0jzNRYEwDdoK.EZSAYsioL85Gov1Ew_JIgDeEUOH5JxuzvxzZXF
 ec.skUfjjcHtXJ2rQ1rCm0s3.sJbdoL7yf.05Bgfe5ag4ZU4I90ySS7MiG5i4bXvdhVEV9.CdQNo
 68jTkxLVPCqr0FXN0FzW4U_4T1e_G9NCXJYGFQqhGUIyVz0GFjG.mu3IKR3_kfDiy02X4lMRjjPg
 GcwlWphXBv2uO7K3lV8DfmYKVYbfasO0iEDjd.cjSoLnaar9UdJ3BZ9jAcQcjlO3NU.y3qd.w4pe
 OmvvLwc8TWKIh9HcT3AGgCzV3TI2MKTIHhjuNFteKCkreyEb4kSnOc3EpG1HvmSIhH6XxndIsUKc
 Eq2aJZzI9o67F.ezXXBRudmwkj_9dE.gAuB2NPUTGtA5IDDq.ZpnyjRRbqhw8RpLYFgkrwQyzXpT
 eeIvXy_WYBMxs._Ct.VjAVoirujw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Jan 2023 00:37:58 +0000
Received: by hermes--production-gq1-5d97db6675-b9fxh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ffe01bd5c3ab4930b448f81636554e9e;
          Thu, 12 Jan 2023 00:37:55 +0000 (UTC)
Message-ID: <9b031aaa-08f8-3b99-64f8-a4ecadb3f7e8@schaufler-ca.com>
Date:   Wed, 11 Jan 2023 16:37:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 3/8] proc: Use lsmids instead of lsm names for attrs
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, casey@schaufler-ca.com
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-4-casey@schaufler-ca.com>
 <CAHC9VhRwg8g--i1db9fkwOey5aU1b2-9nRBDRRzbYRRm_QVr6w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRwg8g--i1db9fkwOey5aU1b2-9nRBDRRzbYRRm_QVr6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21062 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/11/2023 1:01 PM, Paul Moore wrote:
> On Mon, Jan 9, 2023 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Use the LSM ID number instead of the LSM name to identify which
>> security module's attibute data should be shown in /proc/self/attr.
>> The security_[gs]etprocattr() functions have been changed to expect
>> the LSM ID. The change from a string comparison to an integer comparison
>> in these functions will provide a minor performance improvement.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> ---
>>  fs/proc/base.c           | 29 +++++++++++++++--------------
>>  fs/proc/internal.h       |  2 +-
>>  include/linux/security.h | 11 +++++------
>>  security/security.c      | 11 +++++------
>>  4 files changed, 26 insertions(+), 27 deletions(-)
> ..
>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 9e479d7d202b..9328b6b07dfc 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2837,27 +2838,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
>>
>>  #ifdef CONFIG_SECURITY_SMACK
>>  static const struct pid_entry smack_attr_dir_stuff[] = {
>> -       ATTR("smack", "current",        0666),
>> +       ATTR(LSM_ID_SMACK, "current",   0666),
>>  };
>>  LSM_DIR_OPS(smack);
>>  #endif
>>
>>  #ifdef CONFIG_SECURITY_APPARMOR
>>  static const struct pid_entry apparmor_attr_dir_stuff[] = {
>> -       ATTR("apparmor", "current",     0666),
>> -       ATTR("apparmor", "prev",        0444),
>> -       ATTR("apparmor", "exec",        0666),
>> +       ATTR(LSM_ID_APPARMOR, "current",        0666),
>> +       ATTR(LSM_ID_APPARMOR, "prev",           0444),
>> +       ATTR(LSM_ID_APPARMOR, "exec",           0666),
>>  };
>>  LSM_DIR_OPS(apparmor);
>>  #endif
>>
>>  static const struct pid_entry attr_dir_stuff[] = {
>> -       ATTR(NULL, "current",           0666),
>> -       ATTR(NULL, "prev",              0444),
>> -       ATTR(NULL, "exec",              0666),
>> -       ATTR(NULL, "fscreate",          0666),
>> -       ATTR(NULL, "keycreate",         0666),
>> -       ATTR(NULL, "sockcreate",        0666),
>> +       ATTR(0, "current",      0666),
>> +       ATTR(0, "prev",         0444),
>> +       ATTR(0, "exec",         0666),
>> +       ATTR(0, "fscreate",     0666),
>> +       ATTR(0, "keycreate",    0666),
>> +       ATTR(0, "sockcreate",   0666),
> See the discussion in patch 1/8, we should use a macro instead of a 0
> here (although the exact macro definition is very much up for
> discussion):
>
>   ATTR(LSM_ID_UNDEF, "current", 0666),

Or LSM_ID_NALSMID, or whatever. Agreed.

>
> --
> paul-moore.com
