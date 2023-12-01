Return-Path: <linux-fsdevel+bounces-4608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797280148F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A331C209EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460E4EB24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q8uwrgZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4F10DE
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701456899; bh=e1c5H6gQ9lDwVbTGoBiWnnHvVQC0hMQZF4WAzuShOY4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Q8uwrgZSIiTj/GnbpzgGOT5uJKwzSSxQNWUTboIPGtBPnrZVPQ8rg8dle1np6pzFvGPeqvMTrAzCotdq6AXl2wB92GkwNNy/LJfzNqhkte2fChlMEF8G18LzrHyfRb7JHFKoyz3RbaupSaTxel+rB5/ppuRapa7wNRgXM9HtxgR7gtd1rekCWuheruh1GBk5qbHBaR87rCQHYAkH5xpe6fP5ql8MBjNITMzd4bjmPzau0MUgA4/Zzc3Ssl7EFUU2bvSVEpxZGJ64eiSYSfMPrDA1Rg8UBWFJa47KPh54op/v3p4zY4zbQWSIz57VcmTypuaCYI/T+jPq6+SGyRWOOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701456899; bh=VGgq8ROJyVarPFZTyr/AaJIbB1K5YpSR5K9JojLZtvr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NO6uIAnDa0lugLaUXY1M6sUjST/EEyJ4PgNGXwI328OuDs4rA8nUjIPnXNQ7lgXRvLC4fkPwVsc24YPIXGOOfPf+bJqcV4drwIiHlxbGNEpBl0GOaiDQLPYv20G7tD1i38Z6rQCcqUdQuvjnsU2S+E10mMGq3jAyNN6h69RPMfjQKOj+Ezn6X0wlToIu5TutS2soGzeBbPcuHAIgYKKkdC3ZoLpaXYtcWeVLlkOWl15QT0Gj9rmlxWA0YwBGj2qP1KEYp8572wCEAFNVIy4g3N8JJkQ6Bbja6X+Ac1t6ASVCJjS9SoXWKLjyWi3EUQ4U7CUR5/42md1FRgeSuWfRLg==
X-YMail-OSG: _feEPkkVM1nVTU50MPOVJ73Gnma0deiW437hg6rFj_57AKjMX7rH13qcJzcOyNI
 fZ_5MvBMsaLjOErJKvZcRRg8s_VLV0iCiwA8k_NFM0rsWk02.PYhpL6APjeBLWcBk8UE2b86FM3L
 aL_qGbXvaGkqobOhoQdMVs3EW7u7hBMW4BBlIplIR10SrI3fmB4v6MHcZa_3T7JSp1afVHS52gve
 m.ZnSuzSuI7sCqA6qCw.OAEKwweq3DM4Wf.TtC6aZFIUFrDq6dGLj1H6cDk5Om13p8JXlh86rk4V
 GlYFkiSMAT072JOyjGXeNTmb7DqkXsggw1de7eFeghygG3rJkvL9ELuiZ0vc5j4j6JOPV.PTzp9z
 t_s7Kf37Mxtsn2AfeVNhY3qjF8fnE6Gqgp1.AqA5.duAvrWZ1HbPWlq7h_pTFB3pWaQQTyhKuWoZ
 TI0YjcOuFPBY0eT_KrJkntBNj2oQUyO.x8ZRozgs4VUug6ng2DrjN8dLlSbWkE1CjH45VF5puTVg
 srEsk1y.8i._GkTNt2QJuErmlKKCpZ1jK.EnpnYOwE7_4kyM3bsqEaMPy6DWm8dZWtQqzN.XZJLZ
 gUgeAlAEO._6LtRkYUJqKzknmfOyqs8BucRUg4F3AXE6lHNdE_cE2u6ALMKxs2WGftHJ94T3jPRD
 7duZWF6V0G7ObYuQyDEy2unZcdBJf0nqRJi9_E42jA.7osqFSAUqdOjqkDtGhhvHxq29fVRm_dGN
 4pzXC0z4ydEnkR99ENQQyRByizan.w9MvR4IJpExbTVb0z9LaBS_79HXD9pnz.N6ILams2rHuzZa
 EERTwYAIERuX3cVOgspWhMtkkUJRKaIMzQ.1AvKaw.dOsHB70jVJ7I2TK10KixF7He6jZO2DEOYD
 3q8tY3wJiJTHn_nwwO4k3wSjjczu_ZvC73V7t9HHlASf5TxfRcaHHhDgvRGjh3ZY1X9oNNp7GqGQ
 9X2.Vx7Gec7xwdxD_xtqX9LBGUWs6lE0W1s0DlqTpiGY8JIcwDZLfxwFunT6pR43BG2XliQWOT7h
 _Ink6KXO6cMHvE_lQTBezen3k.ouK2K6vFgMxnHWbLzGwe08P0hB0ZSZ5rifXsTJvT3ryFImp_y8
 .WgdU_9QBMtXnOCR8zEu8MThpJxpyfQXKsV.yIgKAk1JOM_myGH.gns5y59l17k.iAumyqX0jHoq
 cbJvvd7yP.8zBh2nOM4hzbyDxJhPl.Het7_iL57uk5WViG8azcOR7oHIS3nAO0P3O27U2tBXuVrE
 rA6CpM6GH49EGvcY59kXM8jb.hBCmu0haimLa5vUiFq7RwU6V1_HIncN78iENnWxiqfPtSRylghn
 70JNAzaeJXmOBwBJrsS9b4WvqM84CsQGvAcnrnMpaze8n6g9h3v_ciJnTZc_afdBAclpLLn68a4o
 by5fwgPP_m09uwE_vrw8pYlS6rqahtIQoLRE7aRShrd0Bp6HdqBv5TPnO4xf3ELpWhJqPGgjxkEf
 W0TIx0QZhvOoFpm7Q75GQ1o0NDEIomQ1drERpDZrnP9wyYxHfFcVLJB40INuQnm28fHXhx8qq8Hm
 RljS_vVQxAdwLq.d3QYZHzNs3FKEVTEFJATfNe8xjZipd9_TnIW_g4GALqLTTX._.6GLSPgSHOLk
 0WxffKLXVORp59vnFozukBAZejXiMLim3Tkghj1G7iqW_dNRlMGbfXe1phlXUkghRU3VYiMXMMIW
 f4x_1c2kxyyIgX9VfADmEg_LCsYMRLVHh.vSc7kBmjlSwV.Rt35sKLXdPJ37bLVN8cxkQd7fWQc2
 AyLccHVy97S8pGacyEzFtV_SrR8iaOI1cblR8M9zMlg5Qv9bacEi1a1xa.Fs7uGuk6qjglYiT7mt
 8DcCQNrD9cPPVNx7oP8T6JJQqEWt8ONImNZPPkZxbOm.OaEJmFntjXilaxuNjzXrHNE4fSdze720
 enP_bp3S0BYP_wvbjdarBIhVKvh2_ma6oJoZZAO.yS5ap9XlR3gwi6LROoXch.01v9HiGm633hCw
 0Rbtbwmp2u6gXTQwAVaS7LZ3_X1uHj.jgnzX9JD_kfwohR_sMV6rcJyRjGbUBGayNbfxzN5dBkh4
 WM6NKAE9FCUY294JuTs2ldOs2nAm1qhYQCz4Kpe587f4ChLNYS_sssW2mqoreMvjpESbGHVfSMmi
 sK5GlwFH2fsE1za2AyaclrHPvAyodvWir3nu758PnH5GJOrMPL8bAdqVPH2cfNOBEJvkip_ptEUH
 riVHrC5zoV4rtwwEdC3OYwIYbnrDJEOnZBrS4U3K7rviz5l3vwlpiUd1gZJ4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 314df4d2-9588-42e4-9861-1d5e2ca2691f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Dec 2023 18:54:59 +0000
Received: by hermes--production-gq1-5cf8f76c44-z2sg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 74d77983c061dd50f267fe5c917be7ff;
          Fri, 01 Dec 2023 18:54:57 +0000 (UTC)
Message-ID: <660e8516-ec1b-41b4-9e04-2b9fabbe59ca@schaufler-ca.com>
Date: Fri, 1 Dec 2023 10:54:54 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
Content-Language: en-US
To: "Dr. Greg" <greg@enjellic.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, mic@digikod.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
 <20231201010549.GA8923@wind.enjellic.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231201010549.GA8923@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/30/2023 5:05 PM, Dr. Greg wrote:
> A suggestion has been made in this thread that there needs to be broad
> thinking on this issue, and by extension, other tough problems.  On
> that note, we would be interested in any thoughts regarding the notion
> of a long term solution for this issue being the migration of EVM to a
> BPF based implementation?
>
> There appears to be consensus that the BPF LSM will always go last, a
> BPF implementation would seem to address the EVM ordering issue.
>
> In a larger context, there have been suggestions in other LSM threads
> that BPF is the future for doing LSM's.  Coincident with that has come
> some disagreement about whether or not BPF embodies sufficient
> functionality for this role.
>
> The EVM codebase is reasonably modest with a very limited footprint of
> hooks that it handles.  A BPF implementation on this scale would seem
> to go a long ways in placing BPF sufficiency concerns to rest.
>
> Thoughts/issues?

Converting EVM to BPF looks like a 5 to 10 year process. Creating a
EVM design description to work from, building all the support functions
required, then getting sufficient reviews and testing isn't going to be
a walk in the park. That leaves out the issue of distribution of the
EVM-BPF programs. Consider how the rush to convert kernel internals to
Rust is progressing. EVM isn't huge, but it isn't trivial, either. Tetsuo
had a good hard look at converting TOMOYO to BPF, and concluded that it
wasn't practical. TOMOYO is considerably less complicated than EVM.


