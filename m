Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32142A72D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhJLO34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 10:29:56 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:35942
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236695AbhJLO3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634048871; bh=/UJ5hDZvfSHSyBLBHftjVnLAM7UscF3PPJR9j9mIPBI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=g2s+OulpO1WiYE7olW9CrD0MplZxDbhQULV8VVFBlXzpSiMUCpge5BCNrtIcFgV6vqC9WPK80YYn6M84Dw7LWAxjVgrDshaODIC3WRMIFVOlYer0x23lVZCWL1dMEUAN5umR3L99l/6K9TPQas9WqoIpLhUtIDjNbTFfoE82AXSuqoj2h+FbcXs5PZ7ZzrYQ2W1504FgzeQ1NigINwfHCQfkrCnsiXIcMCZdWQfyY+i1b5ckg35kp91ypqXrT26lxc9N3pA2/5U2ZP73TJGSF9aOMFx2ySopArAcG2oX43gylMIIOqtq6pMIkPhApk6/CAZNg/9PsRX9Lj/BtEDw4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634048871; bh=ynj66kj/S3l70x0xMEMydUdZcl5tgWKlkyqKDg7ylbi=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ChWBwtTv5OA0HsMaxDIviNldMrzh9I2pzskGHw5SUUq4WRXvHL5Qvk1b0m0h1NZEfb0rpQlf+WNdrnT49duncdRdaP081PRcncBRcWUwq6jdUH4EkxjDIDVUvEB5jjfJOiFpX5DV0in3n/m1K9LONotci/Zh9BpzjUMbsVUpwk8Iv5d0e1pYgye7qVjfqDqR1ZZMqN97F7W9DwFiYY1T11jFuTYYkla9naxhopavSP9j+XtDdOEKw6LQ1NfTy04dWcCPcf7Jpp1/My0GfB9nJKk3SWw1LZU+uC288GpIV2uRBBac4Pnozc+C0xdngg+PvF/erlmy45nZKTFozBfllg==
X-YMail-OSG: kFHpuCUVM1ltbMWiGrnyUQUMv97lSdyJ8XnviwPVKO.JQYy07D2BxbquNxdrJsu
 FcG8RYBIBb6LZokvVJj48QuncLHbgffo1p_nn8nKUwHGV2aJ3WXAgyyTw1bMWKgFEVhfZuP18b36
 GnmGEFsS8s2nkKvBo29zO3FJ046TMW2oRJavqTQjviI3oik0zHkSYwxNHbOE0oR3j0wBh7yTiIBI
 XeUWqqiSQGywsA76bMHOVSvFBiYX7gDvcCtOpDKKw_TwgttiEYZYSTWTFA2AvlWYVPcBhd7ev9J1
 b2ieUgZ4kIJHrTFgdV_QOZ8c9vYolpiL.utbfMBpAakqvlB6bzX.3JfBMSdTutCM2nm0balhIj2t
 B0uSiLVGFHehSc3SZMt718EtQUNj_anB7IGhLGkq8LpAddCFDJt_wxdA6nR5wCcWCoI.MaR2whEu
 fGCtAYMGiKYGGbxadx5m9csmVO7wuKftuYJTJvQW0NpqNZxRta.gC_QKlDjOzThnkNd3GPuW.az3
 cCX6pdVhvceXJM1hAhc2kwdI0XQZq010GBZMFfxgbDLqnI9o5.MGjoGguHTTkxFO.qMv2DGH2IFF
 nrfLQYzBKXoN_ktAAmyLATElYS4BECVNxBf3kp32xcVVrrHWpRku3OhdzcglSKEnXH0mbfIZImJU
 wIMo29aS_MeDvFdOwtNm6.Fjcb7Ho1.uSfp_cHMipirkwIZEyJm3vA0aCk7BW1gMaiMToXJ3_tXb
 iVHQ8jwyRrtf4d5dMVlvRwfKpKWhHrTkywfDIQ0reN7NuWB5nK50mMNp4mT7b9fG0zN10UF9hSDD
 8_Bu_U28Nub47JOgEpDxXTw3J_FUbSrmWvdcxR68yrK3zYLk8ZQ9_FSm.WmJ_c1ZBSbIUyps9WKh
 mHJIwl2Zg01rpmj8HBhjF2HorTwNTxweRzHEnNdmOd6bAegOeJ3uNSs8DJHy0tIDRQyteg0t7ZiW
 U.O0BWUcPJQhQbYXU3TVtg_urS4lUPw0obLZV83i7_tL2sGBBpg2u38mJUeYKIYHlDJBG0EnCOfE
 xhDDnx6NHJtqPZIZZ4GIfsXL.mN3ldSk14bgXCWIep2dFYKmVBhBtv7ccoWYZlRZWu0O8TFBNvDg
 TTlk2Fn242Se9Puw6YoVcbq7GXqG9iLBmQGGIpO6nsNkugxAqNQ_IlnLJIGcgBAiVJ0zcaben_MW
 kSRo4PIs8njZoNUPjcN32VeVVAszz4DGf9hIsiiPmblG5CpTyC8Ud61uLVtwpxpsoXaJ9Mj9XCHm
 HD4CebAA1vUUqsarJKANc36CmzMEKnKKJwIhQpldUzfXtXQZm9c9mxtmb24S72_2D8VCzKVnoMzV
 YgNXjLCffSJn0oVC4X3ZgJidZ2oFhcDUk7.ndDLeh3l0swQPpsv84HBn94zgoV6iLhhx_Aiy3tsg
 N0.AbWMukHB2F3zjluSxkR6E3DpQIRtEVRnP8FOg_AXw1aoTfC1QyYeqeueeiJikyRySQuXHwlaW
 cwgxo5UKp.0eTOCXLNht2ih8jblaNEo26iytHfAVuuUpv2jHuiJPH7acEvvf4ONtD9lp3HOnqteX
 whADHS2fnTdUtcxZFsYxUNYz1De6ZmTJ0C6KssVlL51jng4W6ETteOkIBW.RydtRgsqxgjlCftqb
 YNXOUfvfsA3I4NDxmF3wAc_.on8n8rQdvJZZ7gldMtW1wPdA7dCbAQWh.dec0TS8wVW2XBeZmrQh
 mvlHXcuQBgMgKahElzpqVWjFC76r4KDzzhdbYXtngTELTu5iQxeQml3vDibHKmVt9GBW6sEsi6pF
 LnyTaSfEe_QYlxtV.Y89GAZlmlyKypJxlO8Bc3kEF8XwRmYphnOdDRsn5AOUyOdjJS0Qu3yispKQ
 rnvaLk01hYHuzkDO3TK.5hwXc9kSz.3x92SjnSTJIzVuJnxGU_G.vJaJ8DUjyZjINZknEvHVV.eW
 f5pAOTXj_qxdGuFalSs3Tx2EbjpCsUazN8WOgBL42cREvMR4KQ5GBLUL0FwOhrGiBJh7nNLWHNal
 Dh7ld1prWGqiY0WTmW.n8D8F2JbzvlOO4N6gK9jgb6.1Nbf40Z.hmd3dJoKTJk2ibzfIvXr8n7Oq
 u58E1o20Gvp6TVLlnCF4ucB007_bNboEIQLQVcMIvBdjK5QfHylfgGry9VXenag21iu1hKpGOpLG
 2yhsF0ae1.tqvz2oGBoh5YktbSRwqxT4cG.8JkcfzctMPHav6Uxcy0zzVoTu7M_UV_BInhepXxvG
 mqmoMt40cZznGM9bP5uTb_oQUwxG77xQYaxooRdbV
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Oct 2021 14:27:51 +0000
Received: by kubenode528.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1a894559802b1548fa2ad31343065e4d;
          Tue, 12 Oct 2021 14:27:49 +0000 (UTC)
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
 <20211012103243.xumzerhvhklqrovj@wittgenstein>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
Date:   Tue, 12 Oct 2021 07:27:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012103243.xumzerhvhklqrovj@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/2021 3:32 AM, Christian Brauner wrote:
> On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
>> The usual LSM hook "bail on fail" scheme doesn't work for cases where
>> a security module may return an error code indicating that it does not=

>> recognize an input.  In this particular case Smack sees a mount option=

>> that it recognizes, and returns 0. A call to a BPF hook follows, which=

>> returns -ENOPARAM, which confuses the caller because Smack has process=
ed
>> its data.
>>
>> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
> Thanks!
> Note, I think that we still have the SELinux issue we discussed in the
> other thread:
>
> 	rc =3D selinux_add_opt(opt, param->string, &fc->security);
> 	if (!rc) {
> 		param->string =3D NULL;
> 		rc =3D 1;
> 	}
>
> SELinux returns 1 not the expected 0. Not sure if that got fixed or is
> queued-up for -next. In any case, this here seems correct independent o=
f
> that:

The aforementioned SELinux change depends on this patch. As the SELinux
code is today it blocks the problem seen with Smack, but introduces a
different issue. It prevents the BPF hook from being called.

So the question becomes whether the SELinux change should be included
here, or done separately. Without the security_fs_context_parse_param()
change the selinux_fs_context_parse_param() change results in messy
failures for SELinux mounts.=20


>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>
>> =C2=A0security/security.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/security.c b/security/security.c
>> index 09533cbb7221..3cf0faaf1c5b 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -885,7 +885,19 @@ int security_fs_context_dup(struct fs_context *fc=
, struct fs_context *src_fc)
>> =20
>>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_=
parameter *param)
>>  {
>> -	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
>> +	struct security_hook_list *hp;
>> +	int trc;
>> +	int rc =3D -ENOPARAM;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param=
,
>> +			     list) {
>> +		trc =3D hp->hook.fs_context_parse_param(fc, param);
>> +		if (trc =3D=3D 0)
>> +			rc =3D 0;
>> +		else if (trc !=3D -ENOPARAM)
>> +			return trc;
>> +	}
>> +	return rc;
>>  }
>> =20
>>  int security_sb_alloc(struct super_block *sb)
>>
>>

