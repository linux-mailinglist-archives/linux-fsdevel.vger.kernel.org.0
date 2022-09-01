Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384825A9D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiIAQqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiIAQqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:46:01 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2C74E2A
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662050757; bh=9nHeOjx+oUd5y0MsJP7DNJNKQadTmJll50lk9O3Na9I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JZ9gg8a6GLDaMpgGyH9Z7Ag2ocklEAHN4JBqo2PPUyKHYpJo9fvvXLaMnau0hOiasTvxeR3n/PUVoipGK3g+4IQUZJeyHHd164pVpeJGhkP62PEOX+xyX+eFPrwNzYRnJ+J8o+Nfau+PtO4KS1ZBQ0hasGZsjFyg4H4Yz6ZrXzpp3bignVuhJF+DGVLlfuEMWVMNWK7OzCj8nDFMN+mfBsuUz480bCMs0AE6FIOQ4YWdzoJWEqTkrmehbxty5h9gqMV3oUkmakzPMzf9qj2Lc9CA2CsxBj6P7iSSNH6O6WCn7buvvkoExOdlQSI2Zx8KRyntE1QDqBw4+SaHfaY8FA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662050757; bh=/3CobprxR6K2uzLbcm3nw2s8yew+lDyi/NfpgYNRyBH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DhBtPfin884uXXme9XcFbk/SYkP8bovzL6rTsK/9M9WbCAfca8T5PLavQW6k41wdNN+DwP1cF2Untr5pnfbdzV+1BvJEHUyqzqHhLGS89Ng1AvJB2PfxtwgFCN+0UeNiipd2AqL5OBjviTzjurPl0rAMz5YNeH1h274TTuZB/hRek53xZ1Wsc7+uEAV7ZUHVCxMueU6SrNTKVvCjF5J+a+1cbsGW19dNESGBQNdhcnGy98MEWTZ25TK/lyRBRPe0BgIfCMxxJPGtKq1roVPiqU5X3NIrjK+JChBL+1yQGkAyEaR0k0ZH061WZlcFQTPQ58bx1ONtucooNHmJFKSsEw==
X-YMail-OSG: lgTRNzIVM1kiPmOFxRpQD_pm63nB3UTKqnImFapRXW3mVCD2WiLQqHTwT3qh9Il
 Y_nOA9WqFX_fL9IwkxETq3CKksuPvBt.o9gzjc.g3X_oGYq5gNtNruRykZtM6Prd1HS54wz_1UoN
 ZG1ECjTMJZAEzpfZAsPYnt.PR5b76OIEY8hi7lTs9dI4f1XBGEf025vC8vuR.D2Zz2DEtpAtrQo7
 7xzIbuUH2YyUgkwqwatiKF5oOG0Kn7UPwttmmHxInXRjmb.PSuZbS928H4JD3tXHy.WUOspTiJjp
 7tjSWZQlWNE8wULBpNba5nKlKjhqSnWbduziuN__iwK4VtJ9vGq3mFbb6C7qZyBulZ_BcrUCJEja
 VC7jA3YT2WP8yicZXd2bKMvpVKzm6Wypv1vi.VaDxCVL2Pmey5m1pdvikv.B3MwEN2deV5FOdjJ2
 OKiFE_TmGRWMNhsIIA.cH3Z9yWCHpIbBm.FZva8W5ripRn1qTzhs9..nmhDBbgI_a6GlmIwGFDdP
 200OKLL3ElMiJkDAIZCPgbPTI84zn2WiR6odYUP0lRQXmFT4Vu69z8E8x.rnoz4cUVD1bZck7b3I
 aOaP2b3UQU.wK0UxYE5y8r5lcB9NKTtOlqwNHIf.Z_UP5PNu684d7wzSqStqc.2GxkpVHkTdtDDZ
 QzXlMQQnSejiSYyEkA0KqLAE59TXdjFIis9MvgtSxhuMufSPHw650wojlwA_gUydJ2xBYB5XWpZ7
 XD9KtKvG8DKXOjO_b0cGL_Y0IrCUIrR0dXVYtPIYuFdMx2_rKjfglR4PL_X9ntZFPFarFHplVRpV
 TTd4drTL3AmkEWUQX_wLaTMyNPmNyFjUy6Ig8nJK4TtjXbTFh97rkdPzxFl73IuozSfidPH2DPR2
 9KmXAqQ5jmSZ6an6iva_2p0.fOK4.m2BWRPeEC5qK2zoDKTA306dM6CxaY.OMXyPWQz_6InhnQkJ
 ZXiih4OfyVTq22gV3tK.kqGRif602JCfd73zuFfsSc_D7ehfas9mZPK5tcuAbrdQ0uvQWOWJKhFm
 TlMOyj4ehZaeKJwrX6r2GsR4rBDlJTLXwmQFFifhL7FsbfoqQNhYIa3pbkrgnwwQBCngCd3hLaf8
 zmri9JG6yys4UgQlb3mrwMSsxhWr_ncnKnErjF7hYGBejWWl57QU8LV19hHcChtM9TNGwjNqFC0Y
 GKfMUWmun2_oG3R8nBnCPBZSuEpxHE8oRUNldc_oxVEwCcg8bdFwsw_DAnWqRl8xGbesKCCM2pcW
 iBbxXVeR9LLu5yx9zeT7Kurm5.pb.oKmTKxF9MJ36s0IUny5VtGuEeYiwNLENic43izNVGsmod5K
 wVQucGqb0Pm15Ng.FBaGmDL.UHYy6YLuLGfnLFwKevc6rr3fiSHHr0AQyGa8r_liRdJvqL3Va8mq
 CJ2_7TsTAbLO8Am9tKmWzo5.qDZQAQ9hvZXbEDZudZ97h1Ro2dOpqRZAmjODuimROLayIHfGZ9Wg
 VnuKBPXTl3fXdr5X1xmy.dI.XuTiqvLKmnyW4ba6ny8FnQIBUoWI7fRyoSCOTIVDE.9fdziEV41a
 QOY9u4qJFa3SWVagJaPtZDOyZammP0KoEPEi0SrWZUceoGH46Rij2dhtelLNdzV6Zbzg56kIm82Q
 ncn9uqQEYS2tNITf6uqWWmaBSWnM_wjd9Xg6n4WfiVz7ysE8W_sPTR_gfy64flZHR_F1aaZxvWET
 AuIuL_NjDcB0xaZO3UyxGA.vezoFXbhdlGl.6ZOAdW0yIjWd3EDWQB8aXRVvMOq8sJhhh9c9B_yM
 u_xhaJV5l615logpm.5SqkhC9zAuK77eh6LCzksQQTIjSoklRUT9DB.fJ5gBDQk4j4Xym1wmmClU
 B0hYpCcV1_voJC1Wop5OIp43zr5Mm1XosJ1hFg4amZbV0W5t6JJKWBgkCUDfTP8skm8_51QnjXQE
 8QCpQpaPddXZc9Hfx8m.Q2.0P8pQO3u91godK_vr.qiMeUI6vOOFqYeRaZOrA95JD_x.rtD0s3k_
 U9bhsQCX.VTmzIKrKjFVPjpHagPm35StglXeP4vUMxWor_i5bKk0hKX9DMxYt9eTcoMp9NY191I4
 qO7YchoVzYO0EveRwEy_EiXlBwGVUm0JacfVd0AN.7sbKiIdVyEoPxaYenupG2AMP5OWBL1GwFlD
 QKlQbRQF_pU.Lm6yfw_EVlJA9UnwBZay9m9Hmi0jRXSi.tx8VkPtsNWOYXrpPSjqW4OGcV5zWnqY
 ibo2F3s3HdQXix1bjFw4D.3ubhLeT7Nv6pKeZCcPxPJYH
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Sep 2022 16:45:57 +0000
Received: by hermes--production-ne1-544744cc75-fkh7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 562a760a3854b598b8eb46b4e9c8ee91;
          Thu, 01 Sep 2022 16:45:53 +0000 (UTC)
Message-ID: <d955d8b5-ca2e-c040-9415-772fa5a71bc7@schaufler-ca.com>
Date:   Thu, 1 Sep 2022 09:45:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 1/2] fs/xattr: add *at family syscalls
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
References: <20220830152858.14866-1-cgzones@googlemail.com>
 <20220830152858.14866-2-cgzones@googlemail.com> <Yw/eEufm/QpKg5Pq@ZenIV>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Yw/eEufm/QpKg5Pq@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2022 3:17 PM, Al Viro wrote:
> [linux-arch Cc'd for ABI-related stuff]

The LSM list <linux-security-module@vger.kernel.org> should be on
this thread as SELinux isn't the only security module that uses xattrs
extensively.

>
> On Tue, Aug 30, 2022 at 05:28:39PM +0200, Christian Göttsche wrote:
>> Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
>> removexattrat() to enable extended attribute operations via file
>> descriptors.  This can be used from userspace to avoid race conditions,
>> especially on security related extended attributes, like SELinux labels
>> ("security.selinux") via setfiles(8).
>>
>> Use the do_{name}at() pattern from fs/open.c.
>> Use a single flag parameter for extended attribute flags (currently
>> XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
>> syscall arguments in setxattrat().
> 	I've no problems with the patchset aside of the flags part;
> however, note that XATTR_CREATE and XATTR_REPLACE are actually exposed
> to the network - the values are passed to nfsd by clients.
> See nfsd4_decode_setxattr() and
>         BUILD_BUG_ON(XATTR_CREATE != SETXATTR4_CREATE);
> 	BUILD_BUG_ON(XATTR_REPLACE != SETXATTR4_REPLACE);
> in encode_setxattr() on the client side.
>
> 	Makes me really nervous about constraints like that.  Sure,
> AT_... flags you are using are in the second octet and these are in
> the lowest one, but...
