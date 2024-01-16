Return-Path: <linux-fsdevel+bounces-8077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987ED82F29E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0184B235A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765D1CA82;
	Tue, 16 Jan 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A7u7ADJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05F71CA84
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705423879; bh=3SJp5s3Z+exCH+4UfHcT4UCsjWtziANQFAalTNp3V4c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=A7u7ADJqhucDT/inj+zEnSMaejTIONrsEM1yaVmWrmsNg+aNwf2yDcsjf0DHwehiGogDbZlGAA1PU97UbzGCBUOmEDpzwgLtf5a4QhXNiUvCvbanOiJ1ol3UXeP0ITEmwrQPyUr58NPzGMBh+ySGQWZIGaqM/lJm8g50+tEuznMw3u58zCylW9KD7uHlXfCt98KpVJR4H3DXY7mYfUFE2dBJasazPAsGPfVhh8pNVfSw8RaWpNvu9SxPGg4X9uHMDlZO2DQJsk0RintUKlP7vFyv7IYJXaoq8ZlP7X3dDzFukyGLkbMBY71ByEc8vizGgpVmAUVUD0YKQ4hMNIgSQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705423879; bh=6g1/Z5dhwtw34v2/raI1RfnLcnZRJC7llHW1yzDrq7O=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HHPu3liBO2n+pM1rPTxEPcgtbTjb14gZHzeduQaiNR7QcXvwLrW+t19dNENBguBJWqkIMOEDCoE9WqWAMVYDjb1dEdqVYWZTgB6LHvkbPVwrMxmKuILTs9DNUuu2xEWZxtN/gFLh/PSJU1Iw1RMmfGK08EflKNKlFlpewDbFgZ17NRY1vaPebOtf11My02lwuMj+e+XKX56Pihp9FQuwaR9UfNUCBwpOWW4/4uSlYnEzEWwrDU/CB0VZp1VPhD2jzfR6stYT1bix9ZBwFO8CUBin9Jahhp+0jgZoyxe3rX6hL9OVFM4w+rr3Xye+D63bIGmPVfd6afBBGg+xop8G9g==
X-YMail-OSG: A5CgyOEVM1k7T20.uer7oRuubZ6Y.egXrwI9sExA1NznFEIXkWCZcUCJBQRI5z0
 dUVoM9vL8JUmxqY.WM2kmbbrxV.NfunHNLhqt27_Td7Qp8mDDtF8yKJtMEwlwRlQqFtI0uc6UNuy
 v_t3cIW12YNMGiUmM6FM4nPaT9nu2e6onqnHWVYEP7jb61S0dwwoMh__F8x2QCcICqwKrK6hMHU_
 pqxG7IcbsGCV0pbHfJO00Y8.sGYefulMmQgbRxUbeZvdZ6BpGK6hqnLVM1wdlTUaMdsYfOGgdIIK
 IUearccrrWHBGkDy3PmPk8lzrQhbRNQ1LiuIKGfgD6B1ywCC2nTjtE6HrQjoIfTB8acmrUDOowAo
 BmigJ1K9guUkP55v9SyMzPXid.6ClEW.cVDO8SBwoc1fLktaQhOEt95B.o00s35aPT6juJVzHPbw
 lY1dHEVUmWNd5YynMOegvFdy1Z2oO1BSMEDt1NrLGPBUY1mbUA4H55YgUYT_5cWSL9UXu7ApG_NQ
 74s40GkbeWfg1w2cBEPnfkaysIBp96g.o4Is_0HnhHo6ABa7j0VZUxSVKN7XOQ5DcNwfIRsveNif
 5sHuJIOJBI2dnzkuw1HloeLo1jRayxwz3me4iqG_8kSJOBDug9WqGgR_ItxTwaaf7l91eq6a7.JP
 Oz66mhWnRGJjQpmcZeHcaurCHDLhfiXw8eq2tHNBCod9.2LNVd9wPKMSb1xktR4bqElOr2syyum2
 7LeMoURNNR7lPicU5dXVjnvE0lMHs.pbHx10gQNWgkhOL_ooOFif23zY52KjLihVBfohWM3IyiwN
 N.h3r1huoQ_60cNOv3A8OSSYgeNeKX_Jsa1LEQw4aZKZAQbEuYmJuzTwT6G6FiPcYT7k8ODiPyZ6
 5uytBjv3N4S5fFaqaDtF6KZ1wUsPGJuefm62Fde3xRnjK1q0fyAZ3bqi08cm32JsMg.h_fGSIUdB
 6aIAjWdqU1W4HFqTQ.lHZC2SSdWvUMfQ.97VPLKZmc1chzt8NmnLud2oh4rdQ7MGE1ynInKRZdTs
 cPH6m8O7vLOyaPUfZoZOgZi5kmvj0WW7OBGHR5AKh8KtUnTyGCPz8FDRRjexQ_y33Nh4fGagXtfG
 YLCjiXLVC7rBZiw0.jqkV3Anp7Exz6SsyRvEBuraPG6StqmvWItzASprjkpeERwr431mfouJ2QRo
 NEHC_oLtPECK9h6ORbFRW7Bn1aDwDQKW_6DzKKC72GtjxqQSQhrPqx1bULiTykszuG2tRsjyDbZI
 GFIFhYPq9gQLI0HQsToaiZ.aGz8hRFRImH4_UBqEdAk.cbTASyHqPHVdHcRtTKaF0i7RKOrpFFRD
 DCieCh7SftO0cdeDtn4qS1T_jaOPDAelXyJThAcR1wJV948czh6gM586k1N8IGG4ce2vb5TWgmC9
 x8J.b4.k9ZakLNmtAM_oC7P5UI9iWQOa2RMfW6YQhldAiMki.6cZw6HcfOsoxUqIB4wahHwyF.Oz
 H3Gs1wqS.aQXtEdgQYKQTTn63BrWPjIH4VY3a9CfgoCyYmMatopckhvT4SUFtiyHHbnzV5b8Rj1U
 jxO5FhDkUsZKkp_HQIIK_0iNBx_7iSBTjt4xz6I6IP9gvW8S_VxfRPlJ.pC0UdbabMngDaiCgcTZ
 FjmkuXQtO3yqbDd4emfoZxh6uO3XQtSRMHe2a0xBQtyzobBh3Be3n0IvlF7HhnfJm7Rb4PpLNmaO
 yrSEZ7RIqnQOGZSt.lP0DnTI0jpc4vMNEsaWCvK73hMiQjva_ajuJaDhXYATCWd_wQYn3in9en8C
 LAuiLXdQDl2Q1jjGMcf2nt5vObnJnzirYjod8N2IYulsifjIU0wgapS4JTDLIqDraLMyXG7sP3xq
 vYCeABKYECZJkxZ1kspcltO0yfr.E0f5zAHLuajake8Hj9k300IvFqAJhL_IqnfyDnXEUAt39QME
 qbdxglOjBmjP2OC.yivvwfak_unL4S6GUKypZOtfifFzTXH8Rmn63WTf64F39y45aCUdy9QVF4r5
 3xq.HH0id_rBFNbce9gsI6P8Sz0IWxV6C.iA_OLzb3p0E2FA5Y6AZFFmdacSnrfStmeVX1NUeuHp
 meURET0zgC18FcL7e7_b7AoBWmElfXF7Pg7maB9re_.PPQp15DeeDq1HR7q6fcs4VOFkIQbnq2va
 Rg1VWn9PiQrAiarWNFi0yClhqn_tw8kWJ5QaIMOeovQ8Ut.Itbsg.PbSbKaa0zFJHTjaD3hKaYE_
 zDfVfk0qF2Ns_9Le9GQ75eJD3ybiOYwPFOwK2.5Ap.5BLgwkZjhJHJLGXSE4a
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 15ae8b31-4e9c-4be6-9dc6-e6e06b3d0f25
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jan 2024 16:51:19 +0000
Received: by hermes--production-gq1-78d49cd6df-mvdth (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 44515f8eb2e2b5946457ba67dd58da86;
          Tue, 16 Jan 2024 16:51:14 +0000 (UTC)
Message-ID: <00b7ff22-f213-471a-a604-658a9af80d59@schaufler-ca.com>
Date: Tue, 16 Jan 2024 08:51:11 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
 eparis@parisplace.org, shuah@kernel.org, mic@digikod.net,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
 <20240115191508.GG1674809@ZenIV>
 <3b440f064a1ae04d69f7e85f4077f8406c0eac67.camel@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3b440f064a1ae04d69f7e85f4077f8406c0eac67.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/16/2024 12:47 AM, Roberto Sassu wrote:
> On Mon, 2024-01-15 at 19:15 +0000, Al Viro wrote:
>> On Mon, Jan 15, 2024 at 07:17:57PM +0100, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
>>> the file_release hook.
>>>
>>> IMA calculates at file close the new digest of the file content and writes
>>> it to security.ima, so that appraisal at next file access succeeds.
>>>
>>> An LSM could implement an exclusive access scheme for files, only allowing
>>> access to files that have no references.
>> Elaborate that last part, please.
> Apologies, I didn't understand that either. Casey?

Just a hypothetical notion that if an LSM wanted to implement an
exclusive access scheme it might find the proposed hook helpful.
I don't have any plan to create such a scheme, nor do I think that
a file_release hook would be the only thing you'd need.

>
> Thanks
>
> Roberto
>

