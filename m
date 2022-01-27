Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BFB49E80B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiA0Qvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:51:52 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:35274
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244126AbiA0Qvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643302311; bh=M2Qlk9REGuhjYaBELfE5YlmJbpyQZ6U9Mho8iiCcp70=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MjTPPkq2xweAHiAOc9ukbMGOKI3t0Fv2W5dfkdTyUnOh1TTHDzNkqtC5WCkpEBtMdGwNWZ4j8i55K4JyJu2HQ/2Qr/87qnDgAueQGojaWCjzEqpgbtfSjqMwWIcgIRaCeTtzG4ZqVOwHZjHDldzh3yxzPUS7ESxY49tSGjYtYwoe5IM+90j27n29roJu31j8CyzrGxBUQ/K0OKSD0L88GgPziPS5wLoTTKOk817TELfms18mrReu6/4XX0TkXLC+P1UJ/2W5fssRGaY1oIpt+aXLW1eA9+5sEYho9YyeZKo9B3ESiigtn5bA1fWZn44tuiyC9dlERddFaQJV8O053Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643302311; bh=3z21ryOZkeg9S+3xForqBScYtR9tYFh5lfegaDZDdFZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pxnSvT24P776pizI3jHZFgkrlrz4SXaj1w/ZLsg2ZG7VCUFIPFh4X5o2/QxTTgDTSOgG82vt+wOHV8LAKRJEEPH7ITQM0Bgds1n8WfbD3jOAj89NIex9P4IEw5kNBIYFFPxHAy2vFUb/JyU7QYxE0kpYk3OUd404QQKhi7FIeo6JhNeXCrX49BgF+ip2K5iHsKpDf4qM5uY0Z5bepMLPlcuz8tkt9DkfKLfKeQ1RTzYdUM8bpwv21LOJjs4eNjPgDTC/oxZRY/hRRbh4rS3/qw0Iy/MEyPGDN7go/QtUDY4vidxhyzDvdGrKeqsORpwJqkuSAV5Gy3S01aHyxWbGtQ==
X-YMail-OSG: 3FvjA1kVM1msQhi0scI_BJ.b6jT3UUzguh2GGfV.CFdaetRnLBSznzs5jxKAAGg
 vKWavFF6jaj1_9JD1GscPPHsZvzPx6Ra5548ZrdmUfUXBkisJBFtkNqKmyIgNWrtwLu8mwRmvcXW
 UpODmXs.xt9_iB9NawxVC9IolYowItyi_RnQuPcng_VR2i7jlydH.jQRWg2u5aXoGc2S6ybc_EEZ
 jKYhPd3UK4pqbDHseBfzemEAjSx.iUGsJhnNRwpG9g6JeWa_K35SGIdVo_53cEtWN6JjYKEQ3vsl
 ON_Fq2YVHipMLqzTnenboqmD2cAP3EqnBTRQfjfITbNwO8zlr40PFCY0E1owT0_AAqAOhVv21JDI
 kAueoH1gfrLQIYoVuE4CiCOmJSo6qfJEBBYZU_iLkIba1WuFV0uBuBwx_3ZUPKYauO1t_m7LHwTt
 rZRzALRmoSZ2GRHxpVZnGzQsXOwURxKZCfSpYJvryPCj7wpnjek_y1iaFED_EHzmZDrLbD954Aq_
 BM7HXj5VGzlh97CpCFNKEGPNXEi45lFNT9jBwXDlRrwVJLwV6dhS2SN_5HBddVd_70D.PQPoIZFs
 Eeu54uG38N.zWL0tWo78E2vR1Hkk0QRcQob7Z0mCGcXGXZ7tellNRY3Jmoclog0TP4osmo1bezah
 xF.JkgKPSSYw35FWb686KHf0lgzXdOmVjjdeddt9LMThzR13FR3BCUHSJqDZsdIvOEXcRrpx5FlK
 TFe.j.RMVI4WlkVv.3OXBbMyEh9.FBnMtfxNwWbdi3NxizBcYfMvSykMVXDiNikWFFQ9Ogl6KzNQ
 SNRotoxPMLEKx5Gx6EKX1Snj3jkS_5iubhSZOtUepur2NcQ2.xXTVCukF2G0gMnLEf_Njbs92jNR
 ppbxu7zwrEEQgR2dUa5a1Q1B8s_EmG5hJG9h1ngYFEvzkDtyqFa16EGS5zqihlGCUMzr.16L_q21
 XIvOcthvEL_mqABkTisgsEt550_jzGFoKLgepNvfnLyON56JLVvnN2DSBfdlR45a8.eE6_y5Iaes
 FnKOUgjK5xOEt0yuFD96ePWvmbpTqeKZ2FdIb9kWgeu9IOI_4Tv2hGBoUiRWa8WKEKwYehcXEV0D
 r1klOsUPFYkGi9yzAoH_kp14hp.ltyu2Z6qs3swn6d83BA7J8hJxYdofhbpmQLVH76SHrm.n7PG0
 PkSIvM1dkBsI5vym7P1K4Ft8_9GEwRLZJw_q9Nxqx2o7Vtc.9QLUJcdgjqLSASAd4l69DOYRlpik
 DO76r7_Xc4VeJ6ZPweSs0NwUoaiih4uqlxm58xqvu1glMGWym6V9F2FttlP4mszbp2mUTrVkExBl
 THvoSN8YXoIy95dDDQp1mAvDlUkE2sfVT98oU6yOpCTZRnbYGVjVwxHSEiqI4AqDDk9uVRSU.23u
 y2oQiN3tn22E0QL4IHjNaC4hhcbg4Rr_wHiu4GtRmUpEQz7XJK76_smHirhJWe_gJ8LDmhpVzm.6
 S7cSkmTw2Ffw6oz1zPwEFOGEcLVynrGNqeG5TXSVJ1QQfafvOaEHDLzUpqWHcqZ7A7wcAe240zY9
 B3uewRlpuNWEVvften_NG7XVbvThUucpJMZVVr13Jtx3VgcT1dNkFcMnhCllxC3YRKTD11cSg3b3
 AMIUnpfZ6IS9.2cedYW3O9soE1tbXx4GQeww.Slbuwz.T9ZcYLeoQapPjBoh9ahr.HmtuuakWsUV
 qtes2ULTAt_nlDJRJtPVIxrhpbvVenFKbmz5vr4PUpZHzRmlAJiTtZXKHtL_vh8EDXoAsVR.UWp1
 vGDdLmZ3GD6x0c5R2dxV5aAE0TyzOlnkPSi.R6QgSTjHtQKH9T0ZhWvWn4x0U7Zr9Lc_c9Jc1HhO
 L4UJjJIk0VXah8tilNPyo_ly7DG8mRHArk1vPk.miS8_SCNdL4C9Ir4FOTdgbCCgYDSiVHRm3JZa
 254DhqTTNJAk552918DC7rYcbilVt1GjRdtgTQU0n_r3DQ6yMSw2ELzuhMYp1iU6Dqox5tWViJLL
 S_OIA5INUnVjOvFztIVwcLgib9vomJfBsuqw6fr_IZDg7Z_W0FhWMcWeBR69yJKIp9LEpTqttwAZ
 GVa0D5k05BSFnqh99VDzutY54LIFvSp7tIJJV4RgINYC1p6cEmfb0VG0oGlC3qow3KYbF5fUrs35
 F_sWay_D6nkONDHMsXqXg_WTNRwX53mU3Gj89lxcQUU5p79IZ4SiBRDu2.ZzfqmH8kPAn7KjiEuA
 D1jvCFOkdij8NZOSKiwGcycH4wFc5hdQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jan 2022 16:51:51 +0000
Received: by kubenode544.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7bc05defc074a31e48e050f8eb7ef791;
          Thu, 27 Jan 2022 16:51:46 +0000 (UTC)
Message-ID: <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com>
Date:   Thu, 27 Jan 2022 08:51:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH v2] LSM: general protection fault in legacy_parse_param
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
 <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
 <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The usual LSM hook "bail on fail" scheme doesn't work for cases where
a security module may return an error code indicating that it does not
recognize an input.  In this particular case Smack sees a mount option
that it recognizes, and returns 0. A call to a BPF hook follows, which
returns -ENOPARAM, which confuses the caller because Smack has processed
its data.

The SELinux hook incorrectly returns 1 on success. There was a time
when this was correct, however the current expectation is that it
return 0 on success. This is repaired.

Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
  security/security.c      | 17 +++++++++++++++--
  security/selinux/hooks.c |  5 ++---
  2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index 3d4eb474f35b..e649c8691be2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -884,9 +884,22 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
  	return call_int_hook(fs_context_dup, 0, fc, src_fc);
  }
  
-int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
+int security_fs_context_parse_param(struct fs_context *fc,
+				    struct fs_parameter *param)
  {
-	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
+	struct security_hook_list *hp;
+	int trc;
+	int rc = -ENOPARAM;
+
+	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
+			     list) {
+		trc = hp->hook.fs_context_parse_param(fc, param);
+		if (trc == 0)
+			rc = 0;
+		else if (trc != -ENOPARAM)
+			return trc;
+	}
+	return rc;
  }
  
  int security_sb_alloc(struct super_block *sb)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4fc29..371f67a37f9a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2860,10 +2860,9 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
  		return opt;
  
  	rc = selinux_add_opt(opt, param->string, &fc->security);
-	if (!rc) {
+	if (!rc)
  		param->string = NULL;
-		rc = 1;
-	}
+
  	return rc;
  }
  

