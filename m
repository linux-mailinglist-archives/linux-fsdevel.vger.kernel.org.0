Return-Path: <linux-fsdevel+bounces-2279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784877E46D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87F81C2091A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04C347B9;
	Tue,  7 Nov 2023 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UkQJh0wU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5C335C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:25:06 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6161611B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377903; bh=l7R28lHtFp5EdS/aj2WxyRDnyhb99pkJphheQAqdRxg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UkQJh0wUq5PeviWHc4DNjDzc9V3yIc2gSJbABIW4TZunY/rcFFCX2j26y9A+F31GoqOD0OWnOv8UebDyz7ZhVmMIMDFpMQp9F/xui8KK9LfPzxkRU78gK36N/YON5CmoYj1PNPOAoTanZZJ+jw1+zEuGzik53fyjG21Bfj+9BduZ3linEo4E1d9v5sroSfaVg/znVI6cFPeSsgcdRkezu6bc7/oBl8kyMcWL42MKtTuMInxjj3KuZKXeQWncyve8hnrbaDe0jOzpSDBNhdE5jS021Dg/k1BHOpoMW6CkAOaljX4ankbhpxGSNiHqjIZ2hdS6hMDNMaV9uLMY6htbdw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377903; bh=GRgH+s4/IRaSLLR4w6JHnzwpv6vnd1VGXIbLpqyi8rR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Xf+w+xNkO5cLIMDBQ9f8XsznXFk9e4v+6b9uxDg+aiZeic7YGadXlG8DsY74LaAvmYxfKqXbdPO3DB2sSUQTOLpV+a8adE5mgft25c15pngFQFj49No3JdwKVPnmhAw6NnavjdXl+rMWiXbFRYKOQ+goJYUMZEg7HiwT4nhbE1E5nuqRfXL7MNw5x7t9QVuqCjmT2NQAkajX/1Yf3lZ2kLwk0wIHo3x3EwYl/yy66iy9FV5xtLabzt4ZtvL3ibTO7mdCPf2idvLiJQnl7IeWFL+uYJQPykxbChUJ6mDmIHlj5N9LnmJpeXqL/cE2G1IhzXDHPESg6+j3r6ZkXog/Mg==
X-YMail-OSG: 15dPgDYVM1lf7LYU5YjICDb4.o.KG8mT0z6WpqNOAcpdAJ3UiLF2BWtFy_t6daB
 mEMj77_vtJ5vcyI5TokoUuk43iJOD9UW23GclLeFQpSKWxwAvUwdj3el7uZfcHblVc3MbTufcn1d
 J.WIcDSnz2Od09NL5bY2eQyOmvObb3LMrZFsCeF3AyDOrko8Onk4i_fSTPBCm7LNFRvMSAwnhRl3
 HHA3TMUlE0o2XRwYFmsQt4_GLuQnkyXrj_T0giLxHs6wihUKAYzJQiT7Ji5fyyemPLsVOAvSKvB6
 Y5votF10Bw9E3Rp_jazHViHfRLeZsMzGBKTEb2fRoBJU0vZTRYLzFb6JCODeY2lG98ccMwudFmXy
 YN3qIgwxBQASD1a2r7lfdWnbW3mLI4nH_F.fpfLzPiV8nF4RJU4946pS8DVQ3qz34QXPoyqTWBod
 hKjXf1mxFG1hx7cTj6_X54kZKM6hySGeWtIAo1_MzO6Eg079oVFGs7tOrgv7XRVXxmfnhm2OTl0Q
 MtWGWzJPh6b4boLLISpVqdkWRtUiP6WXQGe98VNTKvcRo28TYv4sF_lxQGKj6BTrq.lsB.LokMll
 enN3XblyUhpQMdvOQ6ZhtVY33IRv20f3igChMcyvTHIf4jyMdoeRRcmb3mAUKOVlVNmgtpxJGQCn
 AIdgjd0J7a_jP2o6O14qu50hFQORoRxMVZH.CcwEyuutfgT9a.6i3VOOyUGSm8V0TrjN.VdSQfn0
 r_tRPEsq5YLqkpsu40m3pHmA7m2.9O.Zrvq73.Fb2Vw3dQwwrgQIGqhRbb9RFP974PntHQEzSi7i
 xLXRMI9aOak7_miy2CLecQ0yl6cRgCB_6ep63lIVTiM5Gdp9QtkxbOgBXAF4Ps.sijwVZZ0qbI1k
 OrsKd_e9OwIEwyzEdqzxF.MtwxLfWZUWklWL.6rV2J49Esq2vXiEvImC3yKJRLBQto9E_iGliWAk
 q6v7krb6wwnWvXYGFpqME_4_5mAWD5tq535LUB_.Zb3d.92lJ71PW0rsnhfkya.9of2k.8KhB8pR
 wOmvN3GVMPQo5sN2ZL7eqnogaE09QGwMm6hNNLqtWhcpByPhZUCSGKwGOYhdCBsie2lPy_vIV4wW
 2ghN6.C2B_1TTUaD5X12KiHL.kPFi3eKExMV_F2UTUf.IqJhbHvcMWW73DepokXIoWUOAIetCqBI
 BvZwZ2lGDNL3gcpPL8Hg2yYzQZRTihShr0cjXOfjhYVQBDEYLTIvwCc_5fV8Ck28pXcVRcYfYiCO
 ItNM92.lsHy_xKOGiMieNNCrSw.tsWHotMqg3YRK4DwzTtod2fFcepNBLNy97EHjeK1ROgQbr.Rw
 FPr10vOzA4QQGAIrKd_1b6NZvm3.1Lw_Y_8zW4061TkJmiKk2IlmVtyldHqjYdoBiVil3SSyCESd
 wXHI7a7hKg8Cynhvw7JExoh2S9p5XAUeDRogCb9GPuSBnH4MfzFTpGG8PTJD4KVbaOpqop_D3syp
 MBsxd90qFdApM0pU_CQ5ahLh0xR0PanCB8bSonTfNY3ajPvvZlj9WtO._BIM1SSQGICE8Xhxa8Nv
 w2zkeI7SZYVyKXfmDzZXn04J6GGe7A6XES7hLRHLaXy2aEQPMh7MnLg0kegvpKgEVQ3l3aDkZ67p
 ATRuw_f.sr8dNjy2i.ZD6ZoNBu6Wj2BVBdi_E1CPz1F0tcqvI9qsxtz7yOYcw7Cu0ldHLdeUS2.U
 SOTDCal36iim5Ff.n.KfPxaaMeIEoFScYYy0q1MUoUcqgvy1c8iSiH4IE.Gcw9UQT2zmavpzJLtd
 QvSM5bLfP_jkoNWVOIlEhzQQRhiIaKt9ThqBrtPtsTq31aLW2MDY43bNnxsR3nCpEYeduMy3mRda
 Qinmvtl5hN4iC0366Uva1_UGZkkfe6N4fP_8B2MfsOkQndeKqvQskQMC6zyZE48QKRYaqGPuyJIF
 rn2LrllM4ClqXVyjfy0yM1QQypSrFPAm8LNBZA0DdRlKE.rJP4Z6XBGHBOrCHED96yG7ETAvAy5K
 uycjqBdpsh2Av3qXPQqij.naiVO72nhwC7JyEy1OXdIukI0C_ZDBLa7KtIUF8fywl3luTz9N99ji
 OWbijCMglyWA7al7YyuWxMMpsK_DYJOt3dk0zFGdSTde4GcgXqExibwjgRt4ZLLu2Slj5juh9H6w
 JjU9kl_TTLvczGE1yle41DFXPzj9lGkSeiphD5IT5TAx_gRk1Ay6_Sa0LBJjQT_ixbsrFjF8C5Yq
 3Ud_kVTIB_iJdzIJ_Bb3UuPt.H04Y_oLRN2b91nTow0KOrwYUDFvBwX1ibTzvjQzQH1e_2QPGLQ-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5de0a5c7-bf41-4c18-9ffb-97f58d603d7b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:25:03 +0000
Received: by hermes--production-ne1-56df75844-8k4lp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ffeb3ddfe1dfa694d24e3ced306e1385;
          Tue, 07 Nov 2023 17:25:01 +0000 (UTC)
Message-ID: <8477b471-2d57-4b16-912c-64002edc4f6d@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:25:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/23] ima: Align ima_post_read_file() definition with
 LSM infrastructure
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-6-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change ima_post_read_file() definition, by making "void *buf" a
> "char *buf", so that it can be registered as implementation of the
> post_read_file hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/ima.h               | 4 ++--
>  security/integrity/ima/ima_main.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 678a03fddd7e..31ef6c3c3207 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,7 +30,7 @@ extern int ima_post_load_data(char *buf, loff_t size,
>  			      enum kernel_load_data_id id, char *description);
>  extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
>  			 bool contents);
> -extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> +extern int ima_post_read_file(struct file *file, char *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct mnt_idmap *idmap,
>  				struct dentry *dentry);
> @@ -108,7 +108,7 @@ static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
>  	return 0;
>  }
>  
> -static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
> +static inline int ima_post_read_file(struct file *file, char *buf, loff_t size,
>  				     enum kernel_read_file_id id)
>  {
>  	return 0;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index b3f5e8401056..02021ee467d3 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -803,7 +803,7 @@ const int read_idmap[READING_MAX_ID] = {
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_post_read_file(struct file *file, void *buf, loff_t size,
> +int ima_post_read_file(struct file *file, char *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
>  	enum ima_hooks func;

