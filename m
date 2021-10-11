Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564342997C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhJKWmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 18:42:31 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:45548
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235492AbhJKWma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 18:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633992027; bh=jLQluOCMPO5rRjRMl+Q68u9ZH7qqQfyDRJUR6BJ2huY=; h=From:Subject:To:Cc:Date:References:From:Subject:Reply-To; b=ijGoSwinX9Rir2agJRG26TqgBbberIguVcPSmPSJEYVJoD9r//vqNCH1UMhjJap/P+/9Ase4i/7GvPgi/0XmbBru7ZUQoYxw05tZmLWlU8NcJFG1SF8KUOzez2PWDnMwGqjD7r9nOfj0K4dtyHxem3vVk9cplDocX51tDJdqeqN+mBUWqlTMZVopYJBYOjKJbRpEv/YMpd/byBcWCOWUQjTMeMcSJZQ2bZ+p7L3hw6+ebtgpdcU75jgLJmfy6dldZ4NbrEaeVU9RN3YdX5ZEuJTKrCBeg9TX9MJ/vzuUQHTwqGKNJTzns5kdNRQzEHqiVLCrXi4yc8gqKN5xmqRkhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633992027; bh=2NSEyr+UEwaAiyOvJyRV5A9MRNYgSMLHldikQZIKAaA=; h=X-Sonic-MF:From:Subject:To:Date:From:Subject; b=nIut1lOmM2ziHv9OOjNQkFojQzm9FU8n8yLpMqdLQHDBezg8GduVBInIv1oQrw4dkcMtaDlFDBHqpIscVn4N9KVIGmwweJyBqChrSoBgK1ap+TKnScJrXvRRt0aFCmDX8DyzWSQnTJzOASqUchfXmSZKGDyLfnrdDjxm+JpdpUiL4nTCMSMOOtElmEKu+gj/qCHLw1D/6r6gpk13GqIHxdUCGyVhhnpKnnNgKNYcYqucr60QOb5gJbPg8Qn/gQQJmwLMOovzspKEGxOn88se6xQxfWEUkWhCyiqXF1BPPw9ss+XCLmR1N4QcqX/g8Cjv+y3TvfXqYifJ6jsd2dUu4w==
X-YMail-OSG: ul8tsh4VM1kSmoq8PSS.5GHSk2Jrqvk6pvXuXpfWvb7jm8Fsjaqc.fQ_o1gr0Ws
 tgAl.6uBGfMrNNzvu2_VQ3YzrkhMzmzOMgGR7sK0A7.m1sP.utDG1n2jxiahlr1I4dZODwuNwxJR
 MLNPUM5TZDy9aha4eSEL01hQMiv9eiXEAW4_qom_odoG6lkl_lqJEo_XRTAey93NhCl0NHoY6nsX
 v.70p6bZMcK0AMnNOyu6mG7rSzn2r.m2kPhFZNuGcngdNXuDO81u1sA1UsHlXmBBOO.zgNEJm0DF
 m.rnCQU2nrxd4NnSGlvaczYccEsE7RLY8Jqoe3OjM26hxebAgVzIaQB3fNV.eeKiLk03u6VrZ1bH
 aIXvhyusIr.qS7.tfBz5xbBFWi1uEaxB4_K7Pl2STw7iwD5LOc_vr.LwumwO6RDw373ol1CeTen0
 Fq.iiTUNn5McZbCsTyXNrIkjrDXzlJzUhutPxNXTHRftKX_.wfEtCJ7XEOYKYrEPdIesIKaASEZz
 6Dt7E4whVGuxMLqbIohtsdCyAylD1wX5OuQ1J_VNX2UcWQhbiGmKGvZZYWpf7flGs89Jgp46aWlJ
 Z9jTCcFP.MFthVfj_p.qL1piCgXrX8HJlSiEQyKVWDZd_Krp8c8cgAcY1ohozs35KhpSPCdljJWo
 dlPebdgetxudvj2x3H3ixjMHwBNywQHzsOqeKXvlEOePsZ1lo.U5p.se95Aaizk3OPecB9STaRsW
 DFc4PEOWD7w4xMK2cUqFyTEFAK6Ohp84Z9Q_duVllfVwCj6w4byEwk0eFMoP9rBBmuPlh8sg7.uw
 M6t15i5GpPNsVTOrMUBNq8VBbqhuRARcuXFKVkX2ox6x5J5LWGD.qKckc317OCpEbYAfznsTaUL4
 lqyinpmnMqt4r5x9KPfYq2GInx01BFHkk7hgRcAQLW7Uz3Apf5maf9MFEtWK7hoyIIG1cGVX86e8
 RU.PbjYxqkhlLEfkhZosMUz7yTtUZTpvNtX9HWuIvFwZXVkVzl3.HEUTBw9uo96_2hSss5GArXNe
 dwcd4qPaPP7h2wTcfhOyKf7DXS1sYNfKnAD8d0wdmcFfp2lMS90.P5Yh9_NLXXh0Wl_cfHczYGKt
 O_2WCSubtQzCHgqI7_FuT.mtcIgqMYz6_TCprcv8b8dcFWLXKsbBofBqEbrfywfg10EWipmtm0p3
 rQhk3.RzMGZIOxIBQJ9j8_xp1xBLFm65uLvsyI0hFArW5zyQbKdP1yTQ.LpKsG.6G_eFVqoW5v_M
 kfjPOnx8fa7wGdNnv9q8XygooTwLSsdqB0UvN2ueCX6km21HJZdMEgtSgn.6GuXdA_JZMT44fK71
 LGXPhJfai4ouaXIjj5SWExRCdpWdctV4Q3wrgVx7s.bZOudYIEDnro55YY6j34hds9gxvX73wDJl
 2wFPkXZypQVR3q4IpePJueHupXtM8OJ5v09HloNZX3b2MwjiG4AUT3tAoqg.l7MN9PROvFEFTysD
 kMIqeVR.OfuvJqL7vF6aagjWQXdrkfnAUqBasVd5Z3Xi2Cfuc7cCEH2YfJecjW7KQuCWJPMOqtaj
 jJSDU0esPrvhI2VDx53h8ONFXBJNqudEk6we8pd9cozFnSYAahygWKFAdHn97YAO4.m8dhH_07SY
 wQe.muuHb7mdPBn_T4TO7WCzC3OJqB1V2HfizSzYU2NnLxmphq79lQ2N3CwjnXE371jFteds9JAB
 L8gmDpDlVOeNglelFDL.RR_ZoqNJyCJUafYJzss1O.HU6j1gqsTB1JIWsEHsKUrQrcS3gUN5ysHz
 fMeqJK5bnNPqxfRZUh.0TrptlIKI7cQMhmaF9XS5hzisS1tBxwKPdlufp_0DxdPwKDcai_fuuwVc
 tfOU7zT.5lGTfqVo0oVBk5tpsgyJzgDd4VvSf8O0ugzvuAzvhnr6RaNI2wa0bzP2YimgY6Gsb184
 YQk7TMWujNZZZQzAzsOynaaEvi2mW_Zy4YxxuYauH4BiMC_pk7B5VaaC8ILchpPaAwJROna0NhaE
 rX44KS2s2AYnnFOplS8igSnmvyRnfz88tkrsyMSRCWf8b8IhoirzsHRViQXnC6ei_oLv7uxfWT_N
 nr6ieCOtUGHUpzVEVU81fbTJirdAIbfFlBxnJc84Uege5WRSmoQaei.Id.e2CltqgN00BH11wDxy
 YjHxdcnWOpP_HdnLWIsMzm30cqY_NHEGYcG0mjSkjVa8tfnY2.rMm97NIfodC3gy2MTNntNUgRLI
 UgSkVUmbSbR179sntPTSM1XQ2yc.0iSe9ezF5PXJ3FX3qEVk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 11 Oct 2021 22:40:27 +0000
Received: by kubenode543.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2e663ab451f2d92c944ad4412edf944a;
          Mon, 11 Oct 2021 22:40:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] LSM: general protection fault in legacy_parse_param
To:     Christian Brauner <christian@brauner.io>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
Date:   Mon, 11 Oct 2021 15:40:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The usual LSM hook "bail on fail" scheme doesn't work for cases where
a security module may return an error code indicating that it does not
recognize an input.  In this particular case Smack sees a mount option
that it recognizes, and returns 0. A call to a BPF hook follows, which
returns -ENOPARAM, which confuses the caller because Smack has processed
its data.

Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
=C2=A0security/security.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 09533cbb7221..3cf0faaf1c5b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -885,7 +885,19 @@ int security_fs_context_dup(struct fs_context *fc, s=
truct fs_context *src_fc)
=20
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_par=
ameter *param)
 {
-	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
+	struct security_hook_list *hp;
+	int trc;
+	int rc =3D -ENOPARAM;
+
+	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
+			     list) {
+		trc =3D hp->hook.fs_context_parse_param(fc, param);
+		if (trc =3D=3D 0)
+			rc =3D 0;
+		else if (trc !=3D -ENOPARAM)
+			return trc;
+	}
+	return rc;
 }
=20
 int security_sb_alloc(struct super_block *sb)


