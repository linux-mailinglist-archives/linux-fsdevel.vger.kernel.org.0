Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D332421324
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhJDP4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 11:56:02 -0400
Received: from sonic312-29.consmr.mail.ne1.yahoo.com ([66.163.191.210]:40207
        "EHLO sonic312-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235935AbhJDP4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633362852; bh=MTAAMO9VARBgJw8xr6qP+bA01V8Rjqw/obIb8OefnLM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=skU9HW94pxnJUiygQZe+gtCmzyLKiybFYjEFcVp81kHD6Xz8YPHtxGl9m+6Wg6BIflzaRj958R/KxWmVy51gzHhTofiDaxOhBgTKym9Tu0SVUoQNEqGv/EF4wZC1rAa+Xp4XRt+66hljUejs4zodqX9vugo2iixiFXMqwYqc11D/FX5qLxs8Dl3BfFYnbq/63R7z5Rfau6lT68s8FqQQvkc9nZZwYyA0vIpxfrGe25R1+JD1RPFGtqQMTLk9mXNkFjwgVvPAJLn8vsX9mzn725C77PfT00GiUHPShiFoJ67BWkaqzMltxzAjk06fuQZ2Ht4FXf26IsXZNjIvM+pJ8w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633362852; bh=C49uDnvAsplsc34zR5nzZe2oWOU+w9di3OTIy35QGIU=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=d3PgnPsw6W++KVWuHN2+A07W/pkRrDlNpH7Mloz1cEh0SAFQTxJUW19mA2oP/DmOV/A6pOZOtgs2zq+quQ9uoO2E+4lA5p1cq+vanP8emE7gj6GEfwb78Jbo1C1sZA359Ds3nwUPOP8/itDFvQjp/cJmz6zL7CzbmRGUDiPwOdnx0+tdhGV9lxctcKxSiWOWnzg78KbA4l9i4gWLUc+7pqBPYU5RlxwPaYpc1gdM7hNw9cyFgK1REOyg7uOQfPfIkqE41cihiU3r3j1uRDJVvZ89SrVh0WrU2doRVzNITuGNxvmXkkYg4VJ/rEWVCck5OqKOr/UMqs1Rej6uRgj0eA==
X-YMail-OSG: O8j6dqUVM1mD5lBXXgVVZGiP7G_hE24hxcHL.o.STH7gjeZ0o6Nx_r7zuFM0NCf
 naZ4ERFxrRDZYahV8QeEpU5C2DuHNDn2BF9ZE1uQHm2ZBE7K_XwBG21guEU2.EZtehlcQtMQZcxW
 LTbHIMmJ9ZfoU.bwZekW6QSkQEjASzr4I4TS4hLN2Y0ZLDeQGJ.VCZhimrFLvAwgPxWUCXKY7igr
 l_KZtvoBfD5YRyEsdOA_0Qdjof5Y6v_mD0DGbuzyOe9XmZQxEBkRX4DOQFYGie8189CsSDVDTWky
 h4XOxkwv14wVhX1sqPo08OzQwKU92IIENNzMJ6HIJ4Jg9Q8eRR1ZYUaYgdHa7pgOXmEtgCQfWPDS
 TeXq5i8haFIPczQZ6R1q8NFYlYZGlZ0TYHKhxSrO8zUpa4fzTZqDF_.kVCy6WWnK9OGjE9.2fKnU
 Nvx3iDebdFlzyciwox4EIajT6iKChymqCSDYi_yyZwy.r9tquvkRA98Wok2aVeVyF_CSx0CfJ0Pi
 RbEmVPfi1cakc0HPP.TbC0qfRKTrCK2UuqaRYbXYOdt.d7c67hdey.bGTBSDNZpKXEAX4LYYC_8d
 Xjy18Ucg0qkK6X.K28TNj2UrhqOcbtieguO25dziazT0UY8YmIZkC4FIkwjKsyw8qFoa.0_c3ppY
 FSioM.fKM5mHUZ.s9wv4h7JoAJb6V9Niq640MP_gaPeT12M5UPANcexgTdYB8t8OSgWiSZD5GWuh
 EEuVsELEjI5C.nc2XlOWhcunEPjg8rHnMzhgsRONeGIm5DUdQb4aU7F1y.Do7J8RcJmgywQUQSjU
 wNRIriMV_wHfsy3gaJ8Biqzb7cv4znD4gtEZGOXt.XfvztvKA8QFDowMaaJnZMfi2XH0tynRtSYt
 1Dea8W7C50e6_HKtXN8eDRzl7.ZwOR696WwcXFzjjIjl9Tt_5wXMfk.wXtNvToDoYQ3_UDMMRb3e
 FXJgPGcjLCFiDu7YGk8lUbYAyGJKRt3jJs5kfHht21t5ppoylkpTWYwK7NTXo_LS6CsmHZR2owlm
 uargEDpxcsFJ.h0UhzamLQs4Fk.apSjDVnaDyMOU3zQc4Lwos3.cK39Qu1WM8sgHQsVxVfc4ZJL.
 NPgtZvgwrhJcZRGebyhWrQtpCqPUzHWgx.DNlTn0Ox1gfW0eCpsKRFSsUbzn10ylJu4c.vMhgo5b
 Ggz_e8anXcM2wyyiKRQJjcmppVhT2Mube5fXUyXo_smLjUA3xolVpriaj99fxA5TiRbyPD45xOlB
 9Zp5koqyKiQuCtv_okvIX3gLR89wcXKs1y1sY8r_UiQHwsLGc0LdnENKDf6qwE.XoFP4rk2h6iSL
 p6OW72Y9z1pPtGKRG2Q7ERN_jMF4BX.AbLQV9WWMKY9CHhieGnburQOWKB_CYeqxdx9yXDm9Lawx
 MYLONDakLAzTKUYKOS1zHCQpuTncZvBNeCJA1efe.7lPhfnwwpPhIMMKdTl0Uu2udgo1Da5dCqZK
 oVnnt5JkLdDD8Bdn1NX5hgpsWJnpYOKsjM6MJpAzo.LjAy1FtwdB6GOv6MMFsQUMUtX8Mh2tbtmZ
 bc4zPvNAt5JBut5fCR2VUu617BjTv0uTPuoDIBqVgf5Vx5Mc42ffoIEBVq0NQQJafYAZKDI7vba3
 3c5.S_ZRZk0SwwuiPG7JocnQ4Zn8goEb7nojf7Rx9znIyB1tIdGTFVSdLmVjoMl6EccF8iKr_MHI
 YUkUAVSxiziJgNuyV_8PhAe1TMU1ONYERfMlVn24ddPjiR7eS72jF167vdh2HFrjPRuJsDqtoaq5
 J1hUNxfpBqoN_sx4nMJHLkuplN8LQ2JHu2cSDBN_zTlwVN30YD8LIMBmgK.TzwUAvOUV5F2sXfS.
 VneAfuqJZGYToaZz2kbokB8CDeSNNDqD.GqkRLeZe7fJppRkZJvHD6S_olagcr89.P1dw_EsxuuV
 kSIywitiQE19cebdtOudHnflLBSw7QxOLC3_AHcDzvVTSe01qRBSUAoEgcmjvRR74F2xR8OBONgT
 a_9d.w.ohC...1HLgb2PMX7l9LGCPg1DuzCYFhAC.PbL55f0iX9wIQNW3_RZEGyF_gx1qQS0tEgx
 k8hmObBCBfPi3ev_jIWBUvSvunauxC_IMq0CTqR4Z4YjFvbMixFIXGLGk10SMjxf1UUWVAMDt.5g
 naM2s3Urp2vvDbbJAnZfDwB1f7SiCmGpd4V_xLdoG3F3GKTUVPwdZncgbqa78nWHF8rP4mKTdrGi
 R9s5TnJ7kmpUr4GIp05kl8jFPjyj5Usma8xx3d39FOMIKmaz0BvKbnTm6inUtc6RRj0.QhWfJHYt
 UyxsFEx1MAvYW9vr0xuSkERRXcE.DMPOvVMQjEWeUSxLB0t0zLziRPKoXhxIXr7hdbGd7bgDd0x5
 V_DB3TH_YJ3Br.ATDUTz60BmJ8UYvhzWk6I4iUrAqqH1OuJ2oWd0Q80t3v3JUX.5MRlaqykwx01I
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 4 Oct 2021 15:54:12 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1bb28cb8e61ca42aa930e4891ddd6508;
          Mon, 04 Oct 2021 15:54:08 +0000 (UTC)
Subject: Re: [PATCH] security: Return xattr name from
 security_dentry_init_security()
To:     Jeff Layton <jlayton@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bfields@fieldses.org, chuck.lever@oracle.com,
        stephen.smalley.work@gmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <YVYI/p1ipDFiQ5OR@redhat.com>
 <1583ffb057e8442fa7af40dabcb38960982211ba.camel@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <06a82de9-1c3e-1102-7738-f40905ea9ee4@schaufler-ca.com>
Date:   Mon, 4 Oct 2021 08:54:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1583ffb057e8442fa7af40dabcb38960982211ba.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/2021 8:20 AM, Jeff Layton wrote:
> On Thu, 2021-09-30 at 14:59 -0400, Vivek Goyal wrote:
>> Right now security_dentry_init_security() only supports single securit=
y
>> label and is used by SELinux only. There are two users of of this hook=
,
>> namely ceph and nfs.
>>
>> NFS does not care about xattr name. Ceph hardcodes the xattr name to
>> security.selinux (XATTR_NAME_SELINUX).
>>
>> I am making changes to fuse/virtiofs to send security label to virtiof=
sd
>> and I need to send xattr name as well. I also hardcoded the name of
>> xattr to security.selinux.
>>
>> Stephen Smalley suggested that it probably is a good idea to modify
>> security_dentry_init_security() to also return name of xattr so that
>> we can avoid this hardcoding in the callers.
>>
>> This patch adds a new parameter "const char **xattr_name" to
>> security_dentry_init_security() and LSM puts the name of xattr
>> too if caller asked for it (xattr_name !=3D NULL).
>>
>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>> ---
>>
>> I have compile tested this patch. Don't know how to setup ceph and
>> test it. Its a very simple change. Hopefully ceph developers can
>> have a quick look at it.
>>
>> A similar attempt was made three years back.
>>
>> https://lore.kernel.org/linux-security-module/20180626080429.27304-1-z=
yan@redhat.com/T/
>> ---
>>  fs/ceph/xattr.c               |    3 +--
>>  fs/nfs/nfs4proc.c             |    3 ++-
>>  include/linux/lsm_hook_defs.h |    3 ++-
>>  include/linux/lsm_hooks.h     |    1 +
>>  include/linux/security.h      |    6 ++++--
>>  security/security.c           |    7 ++++---
>>  security/selinux/hooks.c      |    6 +++++-
>>  7 files changed, 19 insertions(+), 10 deletions(-)
>>
>> Index: redhat-linux/security/selinux/hooks.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/security/selinux/hooks.c	2021-09-28 11:36:03.559=
785943 -0400
>> +++ redhat-linux/security/selinux/hooks.c	2021-09-30 14:01:05.86919534=
7 -0400
>> @@ -2948,7 +2948,8 @@ static void selinux_inode_free_security(
>>  }
>> =20
> I agree with Al that it would be cleaner to just return the string, but=

> the call_*_hook stuff makes that a bit more tricky. I suppose this is a=

> reasonable compromise.

call_int_hook() and call_void_hook() were introduced to reduce the monoto=
nous
repetition in the source. They are cosmetic and add no real value. They s=
houldn't
be a consideration in the discussion.

There is a problem with Al's suggestion. The interface as used today has =
two real
problems. It returns an attribute value without identifying the attribute=
=2E Al's
interface would address this issue. The other problem is that the interfa=
ce can't
provide multiple attribute+value pairs. The interface is going to need ch=
anged to
support that for full module stacking. I don't see a rational way to exte=
nd the
interface if it returns a string when there are multiple attributes to ch=
oose from.

>>  static int selinux_dentry_init_security(struct dentry *dentry, int mo=
de,
>> -					const struct qstr *name, void **ctx,
>> +					const struct qstr *name,
>> +					const char **xattr_name, void **ctx,
>>  					u32 *ctxlen)
>>  {
>>  	u32 newsid;
>> @@ -2961,6 +2962,9 @@ static int selinux_dentry_init_security(
>>  	if (rc)
>>  		return rc;
>> =20
>> +	if (xattr_name)
>> +		*xattr_name =3D XATTR_NAME_SELINUX;
>> +
>>  	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,=

>>  				       ctxlen);
>>  }
>> Index: redhat-linux/security/security.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/security/security.c	2021-08-16 10:39:28.51898883=
6 -0400
>> +++ redhat-linux/security/security.c	2021-09-30 13:54:36.367195347 -04=
00
>> @@ -1052,11 +1052,12 @@ void security_inode_free(struct inode *i
>>  }
>> =20
>>  int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen)
>> +				  const struct qstr *name,
>> +				  const char **xattr_name, void **ctx,
>> +				  u32 *ctxlen)
>>  {
>>  	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode=
,
>> -				name, ctx, ctxlen);
>> +				name, xattr_name, ctx, ctxlen);
>>  }
>>  EXPORT_SYMBOL(security_dentry_init_security);
>> =20
>> Index: redhat-linux/include/linux/lsm_hooks.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/include/linux/lsm_hooks.h	2021-06-02 10:20:27.71=
7485143 -0400
>> +++ redhat-linux/include/linux/lsm_hooks.h	2021-09-30 13:56:48.4401953=
47 -0400
>> @@ -196,6 +196,7 @@
>>   *	@dentry dentry to use in calculating the context.
>>   *	@mode mode used to determine resource type.
>>   *	@name name of the last path component used to create file
>> + *	@xattr_name pointer to place the pointer to security xattr name
> It might be a good idea to also document the lifetime for xattr_name
> here. In particular you're returning a pointer to a static string, and
> it would be good to note that the caller needn't free it or anything.
>
>>   *	@ctx pointer to place the pointer to the resulting context in.
>>   *	@ctxlen point to place the length of the resulting context.
>>   * @dentry_create_files_as:
>> Index: redhat-linux/include/linux/security.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/include/linux/security.h	2021-08-16 10:39:28.484=
988836 -0400
>> +++ redhat-linux/include/linux/security.h	2021-09-30 13:59:00.28819534=
7 -0400
>> @@ -317,8 +317,9 @@ int security_add_mnt_opt(const char *opt
>>  				int len, void **mnt_opts);
>>  int security_move_mount(const struct path *from_path, const struct pa=
th *to_path);
>>  int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen);
>> +				  const struct qstr *name,
>> +				  const char **xattr_name, void **ctx,
>> +				  u32 *ctxlen);
>>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
>>  					struct qstr *name,
>>  					const struct cred *old,
>> @@ -739,6 +740,7 @@ static inline void security_inode_free(s
>>  static inline int security_dentry_init_security(struct dentry *dentry=
,
>>  						 int mode,
>>  						 const struct qstr *name,
>> +						 const char **xattr_name,
>>  						 void **ctx,
>>  						 u32 *ctxlen)
>>  {
>> Index: redhat-linux/include/linux/lsm_hook_defs.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/include/linux/lsm_hook_defs.h	2021-07-07 11:54:5=
9.673549151 -0400
>> +++ redhat-linux/include/linux/lsm_hook_defs.h	2021-09-30 14:02:13.114=
195347 -0400
>> @@ -83,7 +83,8 @@ LSM_HOOK(int, 0, sb_add_mnt_opt, const c
>>  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>>  	 const struct path *to_path)
>>  LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
>> -	 int mode, const struct qstr *name, void **ctx, u32 *ctxlen)
>> +	 int mode, const struct qstr *name, const char **xattr_name,
>> +	 void **ctx, u32 *ctxlen)
>>  LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int m=
ode,
>>  	 struct qstr *name, const struct cred *old, struct cred *new)
>> =20
>> Index: redhat-linux/fs/nfs/nfs4proc.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/fs/nfs/nfs4proc.c	2021-07-14 14:47:42.732842926 =
-0400
>> +++ redhat-linux/fs/nfs/nfs4proc.c	2021-09-30 14:06:02.249195347 -0400=

>> @@ -127,7 +127,8 @@ nfs4_label_init_security(struct inode *d
>>  		return NULL;
>> =20
>>  	err =3D security_dentry_init_security(dentry, sattr->ia_mode,
>> -				&dentry->d_name, (void **)&label->label, &label->len);
>> +				&dentry->d_name, NULL,
>> +				(void **)&label->label, &label->len);
>>  	if (err =3D=3D 0)
>>  		return label;
>> =20
>> Index: redhat-linux/fs/ceph/xattr.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- redhat-linux.orig/fs/ceph/xattr.c	2021-09-09 13:05:21.800611264 -0=
400
>> +++ redhat-linux/fs/ceph/xattr.c	2021-09-30 14:14:59.892195347 -0400
>> @@ -1311,7 +1311,7 @@ int ceph_security_init_secctx(struct den
>>  	int err;
>> =20
>>  	err =3D security_dentry_init_security(dentry, mode, &dentry->d_name,=

>> -					    &as_ctx->sec_ctx,
>> +					    &name, &as_ctx->sec_ctx,
>>  					    &as_ctx->sec_ctxlen);
>>  	if (err < 0) {
>>  		WARN_ON_ONCE(err !=3D -EOPNOTSUPP);
>> @@ -1335,7 +1335,6 @@ int ceph_security_init_secctx(struct den
>>  	 * It only supports single security module and only selinux has
>>  	 * dentry_init_security hook.
>>  	 */
>> -	name =3D XATTR_NAME_SELINUX;
>>  	name_len =3D strlen(name);
>>  	err =3D ceph_pagelist_reserve(pagelist,
>>  				    4 * 2 + name_len + as_ctx->sec_ctxlen);
>>
> Looks reasonable overall.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

