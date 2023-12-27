Return-Path: <linux-fsdevel+bounces-6973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9181F1CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 21:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CF4283CF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AEA47F6A;
	Wed, 27 Dec 2023 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eVRtI3eY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A647F4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703708411; bh=QeQB/luos8iTHtvu7slYFci+x7sNWDy25TvvSl1IpjQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eVRtI3eYsVuWJIFv4qV1FPVdvzkpxg2gaBIHHizd6KWLuOxWTlhpR0V/CekUEV6V2NazRf6DlbnayERM/YBGjxpCMruIewjJnLUkT+qsqelpsV73ZxoC+z9Qz4wB03n9AAt5DZ6NhZvOiyEDj3Hd43FJ2ZtRfbMwaS/IV6JwChxZLCLWorH7uBlZZp2TV+YPgam09M3PLy/recnVNRtzFE/4GwBJfRtS8BH3vlZ87H9goG2UaavC0Z3SLrcdj4GLgbfEE7oypWN9QWodQTwpqEHS0r4eEAjj47A98xs5tKP4VTUMQoy9gmeqbBQO3RtGJfSX/rTWxs93jqrwno6U8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703708411; bh=y7MitWxjXS0rdAixK1MI7RL720PRAOERok9cz8h1G+H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QfpWk3eUNDx0rmPnB1zsOxECCckjhIUy8O7ADcKL7eakK1rjmERl/b8DFBj7H1BR5+dKd4tUkB0CbK0Eg5Id+K4CSNpCBUoLLYrursCMhTK9jPYJ2GZPESC3XRfk9s/eK9yoKcS+axD5GwMfIepn1xE0OnwX5Vqx5/LCxIfGDMpVoAsad8J+iKpO9YjzYf9CxHiR7V8pXKsOpsy4xIAkl4PWgKzMPqaNxCKXfi8pExaQb2V1DNB1OHdSzVsdH4zKgRNAH2iSNFsGG7D5LS1gFddXnws1IzHy1QpMX5qgDsu0qer3OAppJ5/s8HcsHlX2jgqj9u6TCabYxZM4WEHCNQ==
X-YMail-OSG: kvXxldoVM1nfcPSbpFC9tRcnDK.uvat_WN7fvXIQ8Egc_vy3AhambR9kKOUTJJK
 OYzwTr6AUHXBnJb7Yi8e2GWqnhkyoAAXEayygeazgjS.8QXgfGrp0zj8xE8hICveR2pzZzR5GjQd
 d_iinKK4Y7.Y3plAlH0M1Fq2PH.uS1XKHBGgcojtaTDWENlgGm0SU7lKXlm2.NCCuMDtN4VMNfVf
 6oirfdzDfKf1BZqqD5WZlDLVB18nfJ_YneAzC8Cva6pEop2uYAgiqhRM_mtudEfPCM31X.bJYMxG
 rwbmbR7QJzyfPR4eIBSGlfCfsGZqSNWZTQvs6hmmnrECOFAta_YT8aDd94s.7g.Gjhm0tqmcXQH4
 7PQdZiGP.c7rJFXuhOFXhX9BRiJRKF3HMu8j1oNny23cGu8ZxKQLamkiiDUE1BH.293dhUtyIj1L
 0MsoQ4drrfEwpym0M2oJ0N4xDulmA1OnMSLofOOELXxN8wQ2bzcdbPC2hRveTYMMJKcO9KQYcKdE
 S_p7rHSptJNv8T6xC6Ao_cCBXk2XjQdhQp9ValcmMbIah5zoBYMc5byVYlhblYdjZ3SGTE9gKrJe
 lq7XKvjb3fgZLyXZ_9j9NqQWlRgidoFqpuzwyQamgDa0PYGxNbzaoQg8xoGN7OH19t988Wjx9RsQ
 7CPz.D8J7a6m5Aymr_WNVmvMeHo4EsB0UNWlETLPL.dfUqGLgK23pb7a4QDs19yFSu3REq6tM79R
 7lJb_egimT8Y5OPEizFv1abHlVc0__ypMJtxDt9zKTAdofrpOWxM6MorfDYBc6s_CSmYZfVFBI_2
 xlvYfcjOj88Qft.BbId2Fjx3uvZ9owneGvUPOyFzutX1SMQNs8EtktMkbufjekxCteLGc_woUkJT
 AF0cxRSDSivxo_DlrpAy42.aN6oYV3xRKlzDvFsR9v6YerFuAK.6pZv3wi1RM5rpNOJrVWT.ADv5
 u2w4KWLuLwI2bTJDOyDOJW1mIK8DqeWd61pOsuWK2iH7PtDARrikF2dQ1JvlV5PkMEGmOiB.RKgs
 erJb.XSAewpFiIGvpgxLhTeA9_WX57BwoXBgQuTz1Q3HR8XCrfqhwGKBXEkb.HTsIAr_DlyXHyhM
 K97D9UTSlTmkPR_kWilmzpuKbame24fCUtBNujy4s8X62mDO58rOrwgKVxzobfVcIEK1oZPp8xoj
 FMnozpfEonWJA0Xo1.Qubxs46wie4vswMqpeJ.WBwCsssenzj7VggBp6QhYvBIJ0GZJ9L0c4_U.d
 2oqjxBMPMjEOZf1t5M0gWnoGpNHxYGSxfoLHLWsfnBuyI1LSgZnT7d7_TYUPMYQ.iqIhYnb4FWOY
 3URFrw.7zi8myVYVg4s1CtTx4Mv0nV8ykfcFzv.kqYFRkCqX9akY79vpuBl4WxfNu4F9GPp2Xuhn
 hQ9_FuUAere3OwgniMeOo8cUf9lj.w0BoOeQ8_lKPvDJ9uOLyeGekiP6WWtH2D4h3OdpPgPC7_cL
 TSnoTumqh8vZ90nUCjnirt7T.Qfk7D.oDn8DBuzjp8y40Y7PpC_AhIgzyxJTZOyg61kYpNaXwxCx
 yaOqk_uX_VjZYZohmmfTl.WkI0DkBwSH8s7h00C1haWd5NhyYpAZilesD_5GZD6FY5CeDvRZ2duO
 FW.L1zfsA3trQpbd73KuEBklH1JefuR9YRdvvyRN8eqXzDUROfkxZs3.5pfV5NZcpi7R3n0b4DIT
 YuzMO0k.YV6v9Ys3fzQ.IOAfzL9lvJ_.6KSyffzTCBPVQ8_A3VHz3ASD79I3bNDoEclCqr63yRZZ
 FCC76KXwkrY7PeWsyQ2cZ4T5YjRMezIywxGPy5j4yBwXmYcUGItJs_TdVxEQ4NGJRrSqkz5aPemM
 u6BklRUFrxCBEn6nJIW0VB3pBcTCarEVzWBkxOQZgGZsc6peMm.qDoCx1OL2qMMTNwkTZTTTM9bj
 qCMQGvPL6s7XVcpEcD9C6PuMUInZ6S_fIhMl4bNITAkRaARemHgOGV5uh1M_ucgtbuNkjnJoJQ9Y
 a1JlDpBmXi420guL5fvoyFDClNScIcjAW8TkBY9oPlVGfu.Pq8khfOUFkSr1qFBaCgRZzATJrmcE
 k5zW4ycg5F4.WZbBpt735hBtbmSuallWcfn45TkfnwEXB4mIvgtTFlM94f9dhVB8NdqehWF1koSg
 Jtly92ARfdVPpaLxeRsNRSgnYzob3jWXUZ9_NMmVl9R0FKiefMQBoqJvYihgPBNgrxzoEjxMDeF9
 eni15FR1YV8Rg2rpJseSSILRrhhkMTdG4Tl_sLGreKtwjZ20id7zbaK4szHeQv0mFWeWB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f6d3f408-3d68-4663-aa3e-251ad529d9ef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Dec 2023 20:20:11 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5923925b0f3382c245bc6a332ebdcb60;
          Wed, 27 Dec 2023 20:20:06 +0000 (UTC)
Message-ID: <94f41f09-e5d6-49c4-958e-6965ee161388@schaufler-ca.com>
Date: Wed, 27 Dec 2023 12:20:04 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/24] ima: Move to LSM infrastructure
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, shuah@kernel.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
 <20231214170834.3324559-20-roberto.sassu@huaweicloud.com>
 <c6c2d413f340d858e43aa3837abdf80cb8be9d84.camel@linux.ibm.com>
 <42fcd014-733b-41b2-9c7b-658533cd01a3@schaufler-ca.com>
 <3bcc924ed59ecdc5fda5ab8aceeed9450a54c829.camel@linux.ibm.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3bcc924ed59ecdc5fda5ab8aceeed9450a54c829.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/27/2023 11:52 AM, Mimi Zohar wrote:
> On Tue, 2023-12-26 at 12:14 -0800, Casey Schaufler wrote:
>> On 12/26/2023 10:14 AM, Mimi Zohar wrote:
>>> On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>
>>>> Move hardcoded IMA function calls (not appraisal-specific functions) from
>>>> various places in the kernel to the LSM infrastructure, by introducing a
>>>> new LSM named 'ima' (at the end of the LSM list and always enabled like
>>>> 'integrity').
>>>>
>>>> Having IMA before EVM in the Makefile is sufficient to preserve the
>>>> relative order of the new 'ima' LSM in respect to the upcoming 'evm' LSM,
>>>> and thus the order of IMA and EVM function calls as when they were
>>>> hardcoded.
>>>>
>>>> Make moved functions as static (except ima_post_key_create_or_update(),
>>>> which is not in ima_main.c), and register them as implementation of the
>>>> respective hooks in the new function init_ima_lsm().
>>>>
>>>> A slight difference is that IMA and EVM functions registered for the
>>>> inode_post_setattr, inode_post_removexattr, path_post_mknod,
>>>> inode_post_create_tmpfile, inode_post_set_acl and inode_post_remove_acl
>>>> won't be executed for private inodes. Since those inodes are supposed to be
>>>> fs-internal, they should not be of interest of IMA or EVM. The S_PRIVATE
>>>> flag is used for anonymous inodes, hugetlbfs, reiserfs xattrs, XFS scrub
>>>> and kernel-internal tmpfs files.
>>>>
>>>> Conditionally register ima_post_path_mknod() if CONFIG_SECURITY_PATH is
>>>> enabled, otherwise the path_post_mknod hook won't be available.
>>> Up to this point, enabling CONFIG_SECURITY_PATH was not required.  By
>>> making it conditional on CONFIG_SECURITY_PATH, anyone enabling IMA will
>>> also need to enable CONFIG_SECURITY_PATH.  Without it, new files will
>>> not be tagged as a "new" file.
>>>
>>> Casey, Paul, how common is it today not to enable CONFIG_SECURITY_PATH?
>>> Will enabling it just for IMA be a problem?
>> Landlock, AppArmor and TOMOYO require it. Fedora enables Landlock and Ubuntu
>> enables AppArmor. I expect that, except for "minimal" distributions, you
>> won't get any push back. If a distribution is striving for minimal, it's not
>> going to use IMA.
>>
>> It makes me wonder if eliminating CONFIG_SECURITY_PATH might not be a
>> rational alternative.
> Embedded systems were the first to use IMA for file signature
> verification, not distros.               Could they have enabled
> SELinux, lockdown, and IMA?

Yes, they could have. I know some have used Smack and some SELinux.
That's not really relevant, as neither of those use path hooks. My
thought is that CONFIG_SECURITY_PATH adds more aggravation than value,
but I can't quote numbers on either. I don't see a problem with IMA
using path hooks. I also wouldn't see harm in moving the hook(s) you
need for IMA out from that configuration option and into the general
set. With the current rate of new hook additions I can't see moving
an existing hook as a problem.


