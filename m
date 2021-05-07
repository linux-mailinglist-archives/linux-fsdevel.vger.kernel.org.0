Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75483376B68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhEGVE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 17:04:27 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:41039
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhEGVEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 17:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620421403; bh=iCW1xtKafD7oCodZ2TLnIySxjfaSALYwiHeIbhUggpE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=TSu+RQDkMWLISBgrnK023r1nPoEu9+WK1K3raAhlsGwIIEl0K6kv9Vh3U9CW7y1YTpCgqiW9R+xUG+GPT79W88nuiFa2ByQiugLL8tf+8QSnZenOVaRMFuMkXodGLDgoVgZ7+B9+seQIGOi/m4GIbMPhbj4fS6QAk1oIEpH5BgSOe9DSqfTWtuDCa5wgizaOIdtmkO7W2j1pe5MuCxcl/Ua42TlDD4cOCvEI4hdpF+W15d9iaXvoS+xXh2x2ObBj1X3UNVCnhFKtQ4CdA2tOFNdiOuC2pY2n9neS3Q8f5O8bJjzjwxtAzENv8g/3VfN/TvNrss3EyFUBZQSn3eTX6g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620421403; bh=EXNmQK0J4umVuGhhcwzw+eLte10pOsg4eUkunew2Hqo=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=DHOZSX0h6LWrjkKkoJ1T4+GyM+MEUUf6aGw3XCbChM+S/OScy4oZDxS1mELrMacYdzCGwrrxnVM5F6w6j37WaF6wvjuCCND/+kfyJKg65hD4jzzVvUUb1ljtXYjL8bwWXMz9E2I8YgKQIyDlpps0gLzyEF5GAQ8vPCVThPF8HLZTHAREWrciqjkPXtXe0SqC3PFZLHxL/WgrS/RiL1If/T6ltp2q7m8/wDQegX5LbYPc6/aF0xd14t6u9yd1xE6lLZfzP1H2coGYgrdQENBjZzkCQ34tRhp0ugOhasWNtIKbQ2Db9p+aSMiVHDfaZIrT/l8S2tvOBb6rlzbfT/nn/g==
X-YMail-OSG: vwH366IVM1lanUZBQz7fzg2gv2sjmEtwMexSPG.lhFYZyw15BZhJC0ChrggeIPj
 3MVct7AxsgpI_gxHsvNt0mvryniZNgKdSvsJkFJjwLARiNfgJ3ol3A_y8V9tqH3hu.AT2k30IHdF
 0jjpysaXD.5l_E3y6l_lGsSsbfdYMEiTfFvDm7cH4av8Lo9IUEKYG00WM2CS8cPIOgnyi_6bFRNy
 LcFMLSrhbeq5iZzQPfSPZE7U0Fuupr6KMnTeDyN9gaHY3beawfHcP16Vd7nRB2v6oghEJUPu0IrQ
 r.SGVDR4ElLAX_X4li9t5crQhBxgaF9B0BMroPbsgK4Qn41Y.vVdN34gBoC5.VAPt0yY0YB.Xgou
 Jprf8irC1ztZ5HUixW66aKlQJjI5lDnN88RzGzDdINAXaLWQfbrrrgFU3yRmL4CoVu8I6j7eO97n
 iC8mfPzRkC.M2gZHZlWs.A6UjCNPXMGjFRPs2tCuJgqhLjylQFHN1Ff5E0xU9EpoN52UmOXU2Y9W
 D1h2ItbobX1YfsCX906U3BJWA6W20gP4I.lAwaKO5ks1qt1TWPUMIA72BxnkIPlNytcf51_2YwiR
 EOcO_1HNHUiiGU7czI3mlmI818GMhRHUhHB7wEjiQ5WJ8Ja8TrFsI3OXcgKer0Zmsrf8NIDuzsZh
 cuJHQ3mvpTkvLr_it4Wxv9KSP3wJBiw_DHofSZ.n.2B6Auw3W82ScjHO7Y3TdjaE841TeFi9ZBoH
 iy4ZRasj5L1GBqAmOCorYTqMimc.ZOa3mXGS1a1L2A1KsfIW24WLVhci5OdoH4z7Ig8j21SmUcG3
 AEb_GlPz3aLrQv9ApLPIwILHuZ.Zst9_vlmCEzANZXzvFhaiyu.ex_m0w1MVrNRnJsdmvQkGU1Yd
 8PJpXVRNn344vrjHT9y0wJf7gkCOBDJAOWJPNzhfSlP.JhbP0PynxxQECth87fnDZ_OJmSLBpGnR
 T6Nk0VBdlWaTDnq_WDKdtQ66tZISUzN7aelFTtaJZlukBlRYVo7kRzfgaU2HR4nzEmJHRlUNUCu0
 3xLujzqv1PftDt.zJCDh0VReyr0mQrDgdI_qzNe3yDx375hEEGXjykzMxzTQm3dpuOcvwbY.tpXG
 B3nWvNGULfde9oO0vjC9zQkPwXH1fC_KWI4PbFe48bxC1YrbND9BrrHiKVwKKC1yBG4LHaKW_dQ3
 C_jmgcp.tNz9cSqJ2jIop8hVrPYCgl.TPd1azBlB.GN58z10x3ox8PMWNfOsw.wMMQYXfORta5M9
 XbG1nt_S1Cg1tNTWlPShSkHuA5wTXQbA4WMMgLHhf93WcsYB61GnAM8nV1ARnFJeTc1hvbUcg.aE
 noFaSev8YV00VNsyCpjcwddfFNtDzMFSvEbpbiS7HRS3Ofwz27hNZiYmnz460ESuwiHZ_XXyA_VG
 eXlcRUZ11VcGkA6w1v_BdzQZDmstoeBzk8QG4DpIHe29FwthcYd6rdjo.Djgkech_vmOcmIT2TA8
 e_a0gicZRwnaTocGiQS4CgYysaj5Pu2pp932lLMMUET_Q9goHSn6WClwwBnw.b2OejBHJmNrO8o3
 epXf_f6Z6BXyXbbuCMtpPKRY7NZi_xQ3xQ6.02PlQ3ElYgJtgmPC_QUuEdysHEsF.2HASBjKjkJz
 0zUBFQ7AiXi8QvHkFpIpd2C.PaDT8BlG_5tpvZ.aB7RR0xiLtzwHgTxIG7zAsq9XNU0PsSgEcGTq
 a9L8n_bhJp908w9qo8XTgNJe3_4qr7iRRwtQ6STdVDUl_qruYDqdsy2W9I4RO05f3_zs2oe_wo81
 Ym04FzcbbzRFmlrhOt_vEH1Ryw5hZQr3EbOkqqTRJyzyt9F3Ze_g0NYnvqfFuCSGWvsehuyq3TJe
 NsdwBLQWyFAiIPZ2f_GuXRPqCqQiuWp83mK6RW8Urqbr3SJz5nV6IwCI5eg38NoI9tm2dd3HipQn
 W8ct_waJCCRd.lJ685hL9sgbKtFunlFHgbAH8ctH9NU7KWbyUCyt_DY7sDwvGH.CQlAYm1HSWLxw
 cTk7tTMoM5p_jAjCTEkrCqKrbnSs.PJZQgCR9cvxWnWit.ZQB7DPWNPFnACIfu3exHjBqeoQouT5
 H2ZKTwT0X_p1bAtYhozjqInMjPJFadtIYtjQPse4dVAUiarpE..kQ5Biypg0UrLwoASJ5UwRmkOW
 .JOfePz5N_tpgxfiQpMfDQ1szWT4g_kZ0Dp24jciVmxL6.8DuOYJhaAlxCvKCgGGXIEvic9YeSIO
 T6DmDQl94syAKINmVShpEoD9e0eQoX65hgMtQElN64fNdnKCU4JN6QyCmMF66IRo0jNTa4Z02we7
 CaQ9Aj3PsJEPsyTd7uLO6c45NH4C7HdMGc3Q7uLMLjScRGp1y0glT6oB0ytaX9G7YeSWxOsvYtWF
 gdjKutiGj95XOhDigBDEcbTdaUzYcyxgZFiRQbkNFe18bOPtsi4saHoOnkf7hfX0xwQoG4kyHXXk
 xku_Yt6cHRy0XUSG5cvPhP2pqvuju8qIWmzAVD86TQW1VhH0bcHsF0WXSjjphvCRxJdzcpRf356_
 qJMxUGK442vJaVUjqfHTnypTBFBJzH03A3urTpm3svFisHQlvuHsRxvppZ.7fVZc09w3UdjeYsQ1
 AxYmgkqYtCWdQotJHdJXXm30c_v5SftM6il12O8691fWkixqXNh1CkttrgYSY_labBnCAgUG7OWo
 g0t21N4YTVbgYdpDUAbxHMpUXJ7GINMZPV6A0pV9YdfqbsVMrTmt5STfS0wG1ehAT7uMlrKYRCV_
 kiOU09wXOtFRm34qd4lCOzc3oOYW25uTVVGutvB_3WJiHfn9JqSkvLxLdUc1ytuVgRShpZHp8qSP
 hcp7Mc2poapnXp5.LvGmpS0zPEhiWc4ccL_JxuQ_TA9zCv5amMvN2kg_A4esz7fEv.Vr.OnhDd1f
 XU4jvDnEUX1DdDeqNVSgMKD0qWJmJVkPhgi6PG5t_Y12xUbDwLvXzc73kGm3_4HTijsGEog--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 May 2021 21:03:23 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e5bf990c1f5ad7b6d96a70634e0a70da;
          Fri, 07 May 2021 21:03:20 +0000 (UTC)
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com>
Date:   Fri, 7 May 2021 14:03:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18295 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
> The *setxattr syscalls take 5 arguments.  The SYSCALL record only lists=

> four arguments and only lists pointers of string values.  The xattr nam=
e
> string, value string and flags (5th arg) are needed by audit given the
> syscall's main purpose.
>
> Add the auxiliary record AUDIT_XATTR (1336) to record the details not
> available in the SYSCALL record including the name string, value string=

> and flags.
>
> Notes about field names:
> - name is too generic, use xattr precedent from ima
> - val is already generic value field name
> - flags used by mmap, xflags new name
>
> Sample event with new record:
> type=3DPROCTITLE msg=3Daudit(05/07/2021 12:58:42.176:189) : proctitle=3D=
filecap /tmp/ls dac_override
> type=3DPATH msg=3Daudit(05/07/2021 12:58:42.176:189) : item=3D0 name=3D=
(null) inode=3D25 dev=3D00:1e mode=3Dfile,755 ouid=3Droot ogid=3Droot rde=
v=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DNORMAL cap=
_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> type=3DCWD msg=3Daudit(05/07/2021 12:58:42.176:189) : cwd=3D/root
> type=3DXATTR msg=3Daudit(05/07/2021 12:58:42.176:189) : xattr=3D"securi=
ty.capability" val=3D01 xflags=3D0x0

Would it be sensible to break out the namespace from the attribute?

	attrspace=3D"security" attrname=3D"capability"

Why isn't val=3D quoted?

The attribute value can be a .jpg or worse. I could even see it being an =
eBPF
program (although That Would Be Wrong) so including it in an audit record=
 could
be a bit of a problem.

It seems that you might want to leave it up to the LSMs to determine whic=
h xattr
values are audited. An SELinux system may want to see "security.selinux" =
values,
but it probably doesn't care about "security.SMACK64TRANSMUTE" values.

> type=3DSYSCALL msg=3Daudit(05/07/2021 12:58:42.176:189) : arch=3Dx86_64=
 syscall=3Dfsetxattr success=3Dyes exit=3D0 a0=3D0x3 a1=3D0x7fc2f055905f =
a2=3D0x7ffebd58ebb0 a3=3D0x14 items=3D1 ppid=3D526 pid=3D554 auid=3Droot =
uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sg=
id=3Droot fsgid=3Droot tty=3DttyS0 ses=3D1 comm=3Dfilecap exe=3D/usr/bin/=
filecap subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D=
cap-test
>
> Link: https://github.com/linux-audit/audit-kernel/issues/39
> Link: https://lore.kernel.org/r/604ceafd516b0785fea120f552d6336054d196a=
f.1620414949.git.rgb@redhat.com
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/xattr.c                 |  2 ++
>  include/linux/audit.h      | 10 +++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.h             |  5 +++++
>  kernel/auditsc.c           | 45 ++++++++++++++++++++++++++++++++++++++=

>  5 files changed, 63 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index b3444e06cded..f2b6af1719fd 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -570,6 +570,7 @@ setxattr(struct user_namespace *mnt_userns, struct =
dentry *d,
>  			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
>  	}
> =20
> +	audit_xattr(name, value, flags);
>  	error =3D vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
>  out:
>  	kvfree(kvalue);
> @@ -816,6 +817,7 @@ removexattr(struct user_namespace *mnt_userns, stru=
ct dentry *d,
>  	if (error < 0)
>  		return error;
> =20
> +	audit_xattr(name, "(null)", 0);
>  	return vfs_removexattr(mnt_userns, d, kname);
>  }
> =20
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 82b7c1116a85..784d34888c8a 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -404,6 +404,7 @@ extern void __audit_tk_injoffset(struct timespec64 =
offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int ne=
ntries,
>  			      enum audit_nfcfgop op, gfp_t gfp);
> +extern void __audit_xattr(const char *name, const char *value, int fla=
gs);
> =20
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -547,6 +548,12 @@ static inline void audit_log_nfcfg(const char *nam=
e, u8 af,
>  		__audit_log_nfcfg(name, af, nentries, op, gfp);
>  }
> =20
> +static inline void audit_xattr(const char *name, const char *value, in=
t flags)
> +{
> +	if (!audit_dummy_context())
> +		__audit_xattr(name, value, flags);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -677,6 +684,9 @@ static inline void audit_log_nfcfg(const char *name=
, u8 af,
>  				   enum audit_nfcfgop op, gfp_t gfp)
>  { }
> =20
> +static inline void audit_xattr(const char *name, const char *value, in=
t flags)
> +{ }
> +
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index cd2d8279a5e4..4477ff80a24d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -118,6 +118,7 @@
>  #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
>  #define AUDIT_BPF		1334	/* BPF subsystem */
>  #define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket=
 */
> +#define AUDIT_XATTR		1336	/* xattr arguments */
> =20
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 1522e100fd17..9544284fce57 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -191,6 +191,11 @@ struct audit_context {
>  		struct {
>  			char			*name;
>  		} module;
> +		struct {
> +			char			*name;
> +			char			*value;
> +			int			flags;
> +		} xattr;
>  	};
>  	int fds[2];
>  	struct audit_proctitle proctitle;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8bb9ac84d2fb..7f2b56136fa4 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -884,6 +884,7 @@ static inline void audit_free_module(struct audit_c=
ontext *context)
>  		context->module.name =3D NULL;
>  	}
>  }
> +
>  static inline void audit_free_names(struct audit_context *context)
>  {
>  	struct audit_names *n, *next;
> @@ -915,6 +916,16 @@ static inline void audit_free_aux(struct audit_con=
text *context)
>  	}
>  }
> =20
> +static inline void audit_free_xattr(struct audit_context *context)
> +{
> +	if (context->type =3D=3D AUDIT_XATTR) {
> +		kfree(context->xattr.name);
> +		context->xattr.name =3D NULL;
> +		kfree(context->xattr.value);
> +		context->xattr.value =3D NULL;
> +	}
> +}
> +
>  static inline struct audit_context *audit_alloc_context(enum audit_sta=
te state)
>  {
>  	struct audit_context *context;
> @@ -969,6 +980,7 @@ int audit_alloc(struct task_struct *tsk)
> =20
>  static inline void audit_free_context(struct audit_context *context)
>  {
> +	audit_free_xattr(context);
>  	audit_free_module(context);
>  	audit_free_names(context);
>  	unroll_tree_refs(context, NULL, 0);
> @@ -1317,6 +1329,20 @@ static void show_special(struct audit_context *c=
ontext, int *call_panic)
>  		} else
>  			audit_log_format(ab, "(null)");
> =20
> +		break;
> +	case AUDIT_XATTR:
> +		audit_log_format(ab, "xattr=3D");
> +		if (context->xattr.name)
> +			audit_log_untrustedstring(ab, context->xattr.name);
> +		else
> +			audit_log_format(ab, "(null)");
> +		audit_log_format(ab, " val=3D");
> +		if (context->xattr.value)
> +			audit_log_untrustedstring(ab, context->xattr.value);
> +		else
> +			audit_log_format(ab, "(null)");
> +		audit_log_format(ab, " xflags=3D0x%x", context->xattr.flags);
> +
>  		break;
>  	}
>  	audit_log_end(ab);
> @@ -1742,6 +1768,7 @@ void __audit_syscall_exit(int success, long retur=
n_code)
>  	context->in_syscall =3D 0;
>  	context->prio =3D context->state =3D=3D AUDIT_RECORD_CONTEXT ? ~0ULL =
: 0;
> =20
> +	audit_free_xattr(context);
>  	audit_free_module(context);
>  	audit_free_names(context);
>  	unroll_tree_refs(context, NULL, 0);
> @@ -2536,6 +2563,24 @@ void __audit_log_kern_module(char *name)
>  	context->type =3D AUDIT_KERN_MODULE;
>  }
> =20
> +void __audit_xattr(const char *name, const char *value, int flags)
> +{
> +	struct audit_context *context =3D audit_context();
> +
> +	context->type =3D AUDIT_XATTR;
> +	context->xattr.flags =3D flags;
> +	context->xattr.name =3D kstrdup(name, GFP_KERNEL);
> +	if (!context->xattr.name)
> +		goto out;
> +	context->xattr.value =3D kstrdup(value, GFP_KERNEL);
> +	if (!context->xattr.value)
> +		goto out;
> +	return;
> +out:
> +	kfree(context->xattr.name);
> +	audit_log_lost("out of memory in __audit_xattr");
> +}
> +
>  void __audit_fanotify(unsigned int response)
>  {
>  	audit_log(audit_context(), GFP_KERNEL,

