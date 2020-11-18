Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933472B8211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgKRQjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 11:39:20 -0500
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:42603
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbgKRQjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605717558; bh=5W32lEV6rt7DuSUNIejJQ6qtoFpohPS7oPRtwwv6AEY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=cd+s5knJNMmWiKRVvVWuN+d9lxZpSLe2GSku+3cHe174uFk1rELCxs32SSHOWDcgzi29xg/jMz//7b/flJAgSWT/N9vS1J31CuHc6gh0VQbO4/yGKclV7/T4GUcKFEhiKt35tUktrUVfiBu+B96G86FsQd+cdVC1QReO9+yQH+zIx+5AmXjkJsL0QHhZ0iBa/Q4VOXe99nQfDl4ktSVJXLz8bnisGuYgsy1P2APZzaHZdYyQ0N13jXdtW2VcKFl2THRp8K9HahhOYu7hFhdmdn/ytwm1+4H68wlnict2QUidknixE7qNLejUK74XhFc8ojD10Oeyvuyp1cCmpcZzfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605717558; bh=CtWlpnByEs5EAoJNGB9JagDHwmpZ0Rd0b5Vez+PAKS2=; h=Subject:To:From:Date:From:Subject; b=uNDSrKxUdWEj4Z/zcd9ucGqXtIycun4G0EVxrXWUnkdqBVrbn1C/tYj20lT+tOM5Q0C2E5a2cMxz7ZPOQoZ8p1VdDRgs1beT7w+L8G9gqg3+i8RrNMfKEy+cz1kvxKXWCWV7IVCTaW5BE3ilNCYKQJcOUmuAg3OkXjDZcyx5m39ghVIZM9XIWt0vwLpT6u8HUNe3ra2xd9QGocuJ2Gfjw8JZ0y7ZhxmIq69roQADbJtUzXLgGzTvWKUVjIH+CEuKUOI8+6wcI7l0Z4sQimVwkDGU1SbVymeTW/esLmS2dRHhG9ouz3gBNAhQ4kj/Vn3XPTvPqWE70a3s8h7OKuJ44g==
X-YMail-OSG: 9y20yxoVM1ktxUd1DhKVtBatCP5B5MFqdz8dO.fPu_2QnJUfsuhqxYfx_4.SjkI
 Y5k69KUsD4dKhVMX4zfRicZzcuCGp.f8iOyUumiONsjXugqXLQUCxUufdNuMD_mPf9ryUvSd8k5o
 AXLOu9VzEt3ChCP8JwQWCyCUMDfJZBq08CrX.dnVYvZkf79A9nmPOPvrzHpm3xIcDl9hr6o_wjoi
 8ZCAZeQGfpFsuHGYZLLSs_dBW9RAkU8avc6Q6tfjaB6ordDWfgR0ZqVkMx__BBHJfA0_f29tDwjn
 Iej1hMthW_G6zkhBfYX9M8e.Ox5icheUvw2VVOgcJ0sPjEosRkUfMnpkXQZETe3w0HRLYQ8TvM0i
 qitHqpSc9u_UOCVw4cYlzhKkinXHtndPwASdU9wuC0.95tUWJF9s_leFqIFwUIEsbyCPAqi.F0Ay
 lECOE_Vmq1GbFjcJ3Q4ShQ.cR7EIy_yD.2MYvvGdZXfBUdCspQR53469CtmsD5Z5ZKGolydNfOeH
 dCSGwfeF7Cgv3PGsY9mpNtrawumRbHYi2wvbwNwc8lUWp3KBx2sDf0ZaVGnS0DKTFoGZlMrzbzdt
 8Ck1.JmZ5esPrSOVv4dIa0J_0uMg_FD3M9RMuwxLaXFuCAmQYrcp8qFEtnG8H.WGfdghsr8vJGb3
 sldJ2zfdQ9PpCeeQ.AYAhy4yZxQkj5bWDyw.4g0VpX3o3sOn2Co3y2LlQy3.jA3xsuKtw7GQbDqr
 Ykz3WOUbTZfQMXTaMnCg.R2lT9sS8a1EXMd4RqJvAVLSI837JubX0lbeO6wiJu2GB9o232pxk4KH
 OhCcHU1AlnYuxlaH1UkwTIBtNfujOjERiGTLdy77pzOUG9r69KJ45cCs3ItzRDsI.cxjb1B4GoeC
 0abQRD27fD.BhP17nuMRnSXG7faWBgEAkcaS01F9hnAM5Gf14aU.Aef6X2_75tQvTd_fX_HrzjAp
 vawa7RMzUZJ4Ogz3ZL2ZvWSNKA_yDzuvG1E0vQSEihNdhcfWUATVNDBgbibeAMa0195oolN_DSjO
 OhvwVEufCiVcYWv9uzytn2NAlLlN.YafmMMlb8aPQF9DnT8PM3GbFZH7GfihuqqD4ZglWOwHosDa
 Y8il.OwRYZQOD6qKdPuFGpzio2PqoOvpIkRLpOhfu1OBnjYDi4fMJmw6L8EBzcA_SJhLlh2HKRnq
 JLtxGA_ggcn1u7outSYhmOBwEFjJlmj5z2u7oQKk0wHwbzvpXM_zUuPUc5BAlRLkEJFD0.THVSW3
 Ban97ABGs5DByeM7w9S5xH4r4CfvtQiwsTJUhiGqW9UeHe3QQCEHGv81JRA2nchnLBTQJjsRI_Ct
 0FwUxzjHCpeWk1pZLjx.pUj4C2PFAlZMYahNw5W_S4E.y683XuBtZwPU7hex172QgHi6qKHiz8rJ
 F3jIsZZHXK1Jn6NSQSfgNLff96F1ffgqsWhyGWaZ_RFdi9elIVSvTb5mhgpJPiymT6guboZfDBSc
 diDT83m5JdaTDwQa7GDsHld2b7Ex38Yd7wJffWrVeHlKd_sk0eBaDWbZ5.kmCWi8FWonPlo_DReN
 MLHuPEPwtWoyuQiZw9J5_pEI8HBTwaDpk_HicXjVToNyAw9u_mc9YCGHTzuODS5qA.XR5Nj08uoC
 YUDH11340xVh2AuBvlU5E5Rp58Jp5Eq2Rk3JYtGhsH5AQpuwJixN8ARV6jjXrJN64QWbsqK_9wTh
 M6Wd168n_jtzZh7vK9pbEwaDDV1b2_.xWZOOdI1bkfp13.Jnr9Z.MaMVWLb2WCwG5Khr0TIvdvnW
 qWbCP58w8fHcvCpkcBTvPFnxnItwhHh1knf22CW7cqi697r8.UYHNrGh20qsiKWboCAewZS_Pzd8
 G23htUK_Fv.GsGbLoXe6txZm5pQz1Uqk1sGRhrVtZ_1XbkQNChIqv0PlqBjf.CnPlGUAvhifLDfN
 0uasSMsWmlfj7aJOm5d_Z7m8tSsH4S5KHAZjzW3PSgUOPoCZl76VXPf4zUD8RlzyAuvc4tNixh5b
 oE0EOWxy4_Qf5K25WoBZf4RH5yTN6JGHBA_m7D7Axy3dDSgyOgUnpp.GkPTLKHJ2aHXQEia225LC
 U40WrOyRRRdthiW2Rx2n81L32TkLsI9JYefeFjR6Y8ogey5Pc9QYNAxzIyKslwHMkzAPMakSAN6l
 V9OQrkSHyFwtyN3yflrUPHQDrQIO3hwy.fVXRYzfyyZwbXkNTELveS4UvySA.UGNWZXxZ88L.sA2
 MgaPsy8waCrn5pDIGtn6xFBBn5t49dYEtWrRZpmH9rRjddIuRQnkDq5tKDNEdkrGM6lCrUL8Qfgj
 86TBMmCRdH_O1E1ZdtOMDFXDmPb0COhKzk3G8PeW.nKYPMS7QruuhMi.O3olzli6Yvb1F1khqqi4
 gvv_sFhPEXGmjlguJPjCjMMNHftMiWR0jCOijKGdwKIUcs_paSPLF5FYdvDdLcDMrkJ_fn9ym85Z
 RntU97diKf3srIzNc0x3AYh5hJxXice9fMdro0BToivUAFkvDHy6psu32921Y8KvIsBsaap6mMf9
 En7FNUYF5nixuL05f7GsYoE0v_dtJ8qEdPg3rd8LjxgOvLGtq552ET7GHlp9fGHzg6SY1C0ZJIi2
 uHiknWOJ4L9TbjkF6w0nQG9RKNlOaqGu_uz76dkeloI1qlLU5lcKHVsA2GJVW.tkt9c2qxecGUNJ
 YRqGaC3Ei2dp0Ro2IU1jn9pvwamidO2aye88QdjasR3W.vqsgO89S14voqxBkBZJECnyOT_O9ZIq
 Ht1VSKibqlPweGHcQlcFI18_1SL6VJ3qb43DTN.6JMP5_WLWJCu2.3JozOr_bPA6Q_U5K.TrEUWO
 .nZKdM6r9hMuVsLr1UdHExcOlbitdmOxbSqPWoBkvSvvGwXKsIbAm1oQihpimNGaETt2guTScdhu
 FdxwXcBJs56jz85UbcqTs3Mxb4crqqZRC9kqbRB1pviRM6RD9_g8MnrwBG02jY183Bf6MUQkX2cy
 MDwXUr9kvegI1x28lEG8x07ZtmheUpPMngYqDthKSIU7jcGW7vtgcLND8_46TjAiwMpLGsb9E2YK
 pnAYNPwsd8INt4Iqjo.l8WWhAIMDQzUOX7BCc7pVB6GR2YrUQBjph3HkJhoVqPFS4gASC6sY.ojx
 JHVXlLitqsv7Sr1HeseKBNyU3DNhBPcAHxleQXBA.CkVyHnLCD6vFv6jUXoUdz3Vb5S8hinzkYkq
 0qqSW9povvN7myrJMojuCMtZsNmSI7CAAVaGnVgM7dFcvrAeEDqOhh3wWnPaVeIPI3nJ9J_28ElN
 VjIDCHu0b6uIPsAZvWZ0zXJr7eYwi7bjXCXG2sQC1gswBlE1eSIbnuLcFZ4sEFv.CAzqzOgwvyn_
 SLlZbXRfU.XNY_ixFLul0rkIF4NTdgII6YZ99_1ezVrdLMAsEuxFJL7NvuTzRTHNkyRXmy5JGC5v
 rZ44OEDBKQjake_nSQkRoHRNrJStfdRp1I.SR6ltWsv.izg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Nov 2020 16:39:18 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 39aa6a48a8f7879961366994316e7466;
          Wed, 18 Nov 2020 16:39:15 +0000 (UTC)
Subject: Re: [PATCH] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201118102342.154277-1-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a2454627-88ec-9e36-445c-baef82568aaa@schaufler-ca.com>
Date:   Wed, 18 Nov 2020 08:39:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201118102342.154277-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/2020 2:23 AM, Ondrej Mosnacek wrote:
> When SELinux security options are passed to btrfs via fsconfig(2) rather
> than via mount(2), the operation aborts with an error. What happens is
> roughly this sequence:
>
> 1. vfs_parse_fs_param() eats away the LSM options and parses them into
>    fc->security.
> 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
>    nothing to btrfs.
> [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
>  that for simplicity]
> 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
>    options stashed in fc->security.
> 5. SELinux doesn't like that different options were used for the same
>    superblock and returns -EINVAL.
>
> In the case of mount(2), the options are parsed by
> legacy_parse_monolithic(), which skips the eating away of security
> opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
> FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
> (from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
> sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
>
> It is a total mess, but the only sane fix for now seems to be to skip
> processing the security opts in vfs_parse_fs_param() if the fc has
> legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
> combination currently matches only btrfs and coda. For btrfs this fixes
> the fsconfig(2) behavior, and for coda it makes setting security opts
> via fsconfig(2) fail the same way as it would with mount(2) (because
> FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
> hooks themselves, but coda never cared enough to do that). I believe
> that is an acceptable state until both filesystems (or at least btrfs)
> are converted to the new mount API (at which point btrfs won't need to
> pretend it takes binary mount data any more and also won't need to call
> the LSM hooks itself, assuming it will pass the fc->security information
> properly).
>
> Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
> based on FS_BINARY_MOUNTDATA because that would break NFS.
>
> See here for the original report and reproducer:
> https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
>
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/fs_context.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 2834d1afa6e80..cfc5ee2e381ef 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -106,12 +106,28 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>  	if (ret != -ENOPARAM)
>  		return ret;
>  
> -	ret = security_fs_context_parse_param(fc, param);
> -	if (ret != -ENOPARAM)
> -		/* Param belongs to the LSM or is disallowed by the LSM; so
> -		 * don't pass to the FS.
> -		 */
> -		return ret;
> +	/*
> +	 * In the legacy+binary mode, skip the security_fs_context_parse_param()
> +	 * call and let the legacy handler process also the security options.
> +	 * It will format them into the monolithic string, where the FS can
> +	 * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
> +	 *
> +	 * Currently, this matches only btrfs and coda. Coda is broken with
> +	 * fsconfig(2) anyway, because it does actually take binary data. Btrfs
> +	 * only *pretends* to take binary data to work around the SELinux's
> +	 * no-remount-with-different-options check, so this allows it to work
> +	 * with fsconfig(2) properly.
> +	 *
> +	 * Once btrfs is ported to the new mount API, this hack can be reverted.

If the real fix is to port btrfs to the new mount API why not do that instead?

> +	 */
> +	if (fc->ops != &legacy_fs_context_ops || !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {
> +		ret = security_fs_context_parse_param(fc, param);
> +		if (ret != -ENOPARAM)
> +			/* Param belongs to the LSM or is disallowed by the LSM;
> +			 * so don't pass to the FS.
> +			 */
> +			return ret;
> +	}
>  
>  	if (fc->ops->parse_param) {
>  		ret = fc->ops->parse_param(fc, param);
