Return-Path: <linux-fsdevel+bounces-79482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOleCQliqWli6gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:59:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3CF210319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67BC30E6FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5CE383C8F;
	Thu,  5 Mar 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Wo8XQxeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D937754F;
	Thu,  5 Mar 2026 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707933; cv=none; b=QerKdCt6wM22mb51yBJb7Hmc6vPp5YciJw/t6teZsSAIuEeyhriz240362t0B3zeZNoNOBpfL1zFehQMINMa2SGrMMXstNJhcLXq8/B8AJgMUasawp1DAS+RgkbQ10LOnIeKOIARw9BuK7PyYCAN5sbVhRgX5PEKpIKG2LDMk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707933; c=relaxed/simple;
	bh=H6DqZHRa2/qpIgezvyC6B+KevSzeDRlsnd//MK7SrY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ut/JyqlvVv8xCEfzrDlUUMoKcxFh8FW+DIWw8VV2zzsMWHlSoIoKDQWEOz3Cb5yPdPV72l74U36yfk9rCzDi/uAeu684xUpSopVqvqfJjL1y7VbttceCczz2TaFMqNVIz4VyFD11oKiuSf+K4t4KCohLYc31MSn/wsJGon6C4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Wo8XQxeH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772707907; x=1773312707; i=markus.elfring@web.de;
	bh=H6DqZHRa2/qpIgezvyC6B+KevSzeDRlsnd//MK7SrY4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wo8XQxeHY3HiB97I6xBMVoiB7TnTtxraUnAXZDXZICINfO51vD8FMYqY2bDDTb3F
	 /TFEFirnlzzYma6my2xfV0/x2OA6dJy8bL1IUUDA4hbLlpwFtbAfz6snxeN94eR9o
	 kxM001A7HpfhZZdWcvDjAOyqdnyWGLpuZfNrnuWsFhiVxdtwXL8pBV6zAQb33O2HL
	 m0rEDEQE1qEBQkG0Fux05mDHKkhLKhgfZELwCwA8EC78a2IEVYntgZb5w/5yNq2/Y
	 DFxHQpUe5JpW+pOSkLqDzMdUkPDxvqJZusS4HH+8D/sgf5BE3q7rCWZTMargWkYgC
	 /kfacR5wnHDZTLP5pQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1wKsUR3rVN-00IvGN; Thu, 05
 Mar 2026 11:51:46 +0100
Message-ID: <3125ae55-e592-4491-9599-4fceb483d882@web.de>
Date: Thu, 5 Mar 2026 11:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: exfat: Fix 2 issues found by static code analysis
To: Philipp Hahn <phahn-oss@avm.de>, linux-fsdevel@vger.kernel.org
References: <cover.1772534707.git.p.hahn@avm.de>
 <10c20860-e879-4679-b9fb-e65c301a0b24@web.de>
 <aahL4icRtdiZIhwC@mail-auth.avm.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aahL4icRtdiZIhwC@mail-auth.avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZRB5kZk45bmlLRAxUKiR+FEWrToXpLxmSqCO99zeSrdJ4kx3ADh
 DIq8d/TuihG+2hGy1OEFVwUhwABOlmHVWpC663rswWFI1HnRhpiVkg+0HNWzDWG47gIUCTh
 MoRTqgMaNjevrtu5+WCFdr88luz8kNDshYjtZeinX9Zu7E69uw0CEez+Bczb3KIcFH3kFLl
 vFwL3S8PxPKyR6deijUoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5yG6KPxuahY=;BPiE4cTSdFRfw7yyG+mJK03b91F
 y8Hh6ZIEszVwhF6qhsCWVl1EGyYjMzOnxZ2F0DDjTF0ZG2+dlUajFpDl/HI4fxDcaG3Ykyvwi
 RfQMPgoZNRcS6ly83GZq6LKa3jkEJDDxq/zEYVY+2kBcnAHcLcU0IG7ZG8TFqjdd1SkDUhlLX
 BGS1O97sTv0DtvclIAv/lXLnCTW1zpkqDJP6VxJz6uyHTUBwwM4q+9diJM41nqLZKmJ/fazIT
 7EQGCs+nTSs6mYyXy24hz0at4TTczKGrxvaKd+SmXJC9dfJyAbP6uhDmo/h7X5asPD1qaTScn
 9vSjUcT0cxQXBrS0RLefBfBcGhctZXsn00Ca2zi87wbb4GEXGRb1FewYvg3Po2Bhn7wIpDnOK
 v8/XnpoP6xu0oEW2xDMkfx3VHrpNsUfLHzL8+8xTrWdFpzlowFqRdPt99JHWKUpX++Ywfdj5g
 CZF+LQMK220EslOhMz58de6CoUa14sJW5efKSo8nclO1kchUhnooNLwmB8fyHV1g5ROJ9ELoZ
 6zZTtsNAunxJf/O9MxlXVQQCnMwGK5fYPk9SbFYQydS5VytpYoIGTlunEuDonguZDlTYqv2ZT
 FIOfFNy9rcO0Gt633c0IQIch880gzFfwTEQqbz5UeGowg7GlnxCFw/fuJtQ5GpjqozHt1S+Ff
 /265eVaNAYkKnyXmoyaCqHLm/4zd6Zh9rCmFcMIfCKr3hUOEvaAHqRAblVpNOd7jHAejMVz3h
 MUk8ids2a0IM5EWnAgTBT+DqW4i9iE6JeaB9xF5nRZ9j9S74+F9SaW9lvLyChIopHY1/08QvY
 o7F+whpJ3wPtKysy4CBsw+RS89N4ZO5XoRFiMLiYuni/dHMBWV6H7xkeQK0XSBMkgoGWb02Kz
 AGAsXJlhlOYU0HOdnX0pYk6st7fGxhzsI7K8dghgElJOtGLNYA0/muLH+5KH5PWNHFkL3OScA
 eTLUyXuu8LV3gUdnXMOe0NVY1CxfrE+TA5UJJls6usGAWLWcbqEZQ6GYduCFV29jl1N2v7lRK
 mFuOaP5dnGD4mE++6t3prpvHy9VBP89FydTp9akbGJLodt0Ket700pOV5JWzQQBi7m0MZ9OyT
 zQnFPgoznBMikjoq2tRVwcpI360CkYGSNsmTrPXtfbd5xpUNdfV2qopkKjavyUtg2frLkno/J
 NslNrjLdwaDxchP7Pwj87/TaKt0fzNGyISqOBwlyLEYjcnxNGFRszicKSB997CqtTGA+OQhcD
 seW3tQmgDAJYSDJSu2cAYZeee7BhMsYKFaEY6i69TDt39eumlwyosuZtkHRtwV6NcZQNbXnwO
 ZVNAR0hiWLuhXTX2MHLVfjPmHwRYk+He86TiRRcet7FUo0xnwjckoStKoNDMFisHwOtFfS2uH
 l6peTnWsyJejnD/gwmUMQmomtTPQ8UnGV4xi0tA/C3utehvE/mFYOXNoo7cILXGHPj1j0dAsH
 BXs8y8A3YbvUG4TE4KNaUV+dRCpkNDMu/6SaKbVVhL9fxcFblrklnjXAHHVx2EFte//6G5zwx
 2modd2QYEVACjCgVCC15cS4eodGA/K7XJQszrO/Q65jlqlCrkD2rzg5sa4khI0kPwzCUaNuXX
 iKqkVSd8nuqiNasgHVxHtRUpkymqDzlmkw/X0gf+YCyNsZoYLbryDavursVumFel+wcOZA4Xs
 jTGHksm7y88wtq+5tTmxjXNvawVF/vA77cRwZCOILex3OHfljj1BkiPTeZjyQ/F/wCSoVlB9m
 YDe9cSQeYKCIoiqALzbaLF4MXkAmvO//MDIJYl/UAK5MLB36VFoAwWxEYu/INjTXXZ7XmdZ5j
 h3tMz501IoaZyd2/1mu0VYQ1Gtrjr3lhL7w1oVonmkNvNZBjDXQkloTv4eSq9ugjjEWiQW6we
 XBNSvL72ZmSp9jlPM3Ts2IDNM/Yma43SGGfZm4U8bQU3sd21/tL7Ce41nXS/DxDIEDiUkHBrE
 E7ClhEKi2nXJluma878D3JUOIxuErhTW/Z+G4WmlEPbPulD9IhaXKuzs2FSeNS7FIs4lY75Kz
 q1hj0thF+5FJQbqKG9J3ddRKgza0QKoefOgFyd59RmmFvxIBbBEIQ7S81QaW7S4Ui4J2/2a6Z
 JrbrzeMxs4CA2NAQqhvwjoAf4Fv6KRmeH2mr14fCyoBuchTlBErLlmgaEB1wi10krhmNxHjto
 Fl6pWZAxxAV112NknxpprCBtz1hae1PPFGifrEMA//7uszF7TtW+GNptChdcGdzaY7hZYQQXu
 md4FG8Oq78Wu7LUBgtd3C9WhdO4xf85+l097QZ3EUP4VVzSErYP7JcmP77HgEx0DpUkn/iXVV
 G8Bs4yBUyzU42maWBaji0U8D2PkvSkhcSc6a4gGdgzbkg4YRAfs4HxFKOTGgoOcvniIBv5/Ov
 oTXKl+gqcr8RNPy+SRAFcnKVn8KsLOq7GcvFls4numodBKvTaP819VR28wiYmlSuwwbukutns
 CUHCkTe8/Gkp8qKFdew1FeaBXNSc1W5edTzxWIAGpZaslnGck0B05yuWXVYqmrNecYNViQVxm
 uIW+h+w72kkeIBNqUJPP8Ll3BLpW/MckXlEic2Jk1jTYO3bbHRm7M7znrAMZZfAq2wBttd8P/
 4DWYxCfKbURFx8oiWs1Cnmm+vo0lB20KFaqkOcgsrUWrhclB1knwQUfbdZUErSyUMF8jYRLnt
 7SPMb6pGUOp0CwoOITXvPg+f83z6zea3W0cybWYhZjPAspPFJ3HHjStjXtv9yAnG4UnLqMnmK
 YMEFmuB167TxCG1ZKYFKd2+QD8wXXjXXqawo82PXHuXNmpUi0zUXLIV26WzeMPLYb4yGFy0HG
 iHKIRvX+Z9iSesBwa4W3/jJitXxxO9NQ+7EoZ+KT/NushMJn9563tMWU8cfYLWPB7H5rWQGLB
 TNSXORDr8sTuDtY4QYTJFFdZDjg2pcBHLIF/IdAvBiP9IJLxMGmBVnEsA74q6jtNBGxiB20WS
 LHdeeHfd2DKPK1LSs4Tp7rpOp5SBB23gmpKX5AgbwLdVtDBMKTWIV8sJTnFHhIIUNbpc9YWFJ
 p83D6E1xywSrORIbYlJHe9yPDfNc5rUQD5xrRYEpb2dusfjaeMkBZWz005kVhLuLa8xroD9MJ
 EnXIEn9fLcjo1KGf7eLglOeaq7rJ72RiWQhsuGkeH0/roCt5ZWYJPGGqOpn3upbdrvjbvEhya
 6HISD5tvf90214F7KNoY0RioRy3UwKxlIrw6RTkWAC5yiNRNfEbIAlKzIifsJD5uiX9+s/Jgf
 MPc3noZR/LP7I877ESVs+tS4fISC0vMNC9E4Qhqzu1A3HiC/WZT4zzpQ91AfX7N6hW4v28AxC
 myzQYPp8JEGTneH6lPgXOMKM6Ywtk/DtZWy0FakcSqgncMmGPNVzDUNeSRnhtrZMSXaYMXGdQ
 7qrg3dMo3rzm23XQpnmDhl7C7GeGWWoc6wpE4HaYOlnRkY6Obpjr9X62Ld+uLJglsiAeXLgtP
 sXnBhbcvft7Mh8Fak3Ypi0dcwNgqzCiREiToukx3ykflSuWb2bbot/kPA8hY+hDbfoQU53BOV
 nWGj3oLVbcH/tL3kFboBVXGCeI60KSmWVEXA3WemMBvxZe4TMOo3I5BdR6uxUZ4fZnlxx8KII
 GMlyJjNLZGNpBnSBgsR/afohOUtPY45g31QJHvuGAqxJSGkuZol1bEpz5xwEN24/g/aCTVkcg
 ikNJYGdCj4FLuKhyxwNr7V2/jxAoQ5BnCZH0ZgthsNAEWQdWOhRP3g42Vwnnu+safdhAB5Of9
 GeEObOmp3jBNBNF91g8CJ3jqUyihvAU4TVFaQ58nvPzYZWbk+0G6IPvSS6Mhh4MBvbtDQx4SE
 uLJxk0Hg8EXVk4CfKv0nKOG4stS0i9SAClyvKqKnUA1bzDOsmBxESXCemAvyNN6fu40U561kv
 KLpiEuFuY2zlDnO38vTryfRI/wErMLTlO+Gkg5lCg9nhkJvRtjDJO3CmPs/26IkLqzXTxdqyO
 BNXxYV2YQ3V/l4SkrPrtxpL1f6pTZpJZjsr988WFzVVODbKxB4y5A9/Jqbgw5Jb+VRANGj++l
 8T2YVqNccX40YrxZoaMsxaWp+CHlZfcPXAgileGKii6moudjbBDaddbfyRWJPqoVpjO2IlSGL
 LuTLSGK60gVdBpDlmwU2A2Ozfdk09dYlRvFAoLd54GSW3ZEUJGMoJWv0xdjxzNtqsNcw5ekKg
 0k6skS+bn2dtYUZGmFZOOyAl60u+KFMGSpeqbq0o2sYp9CdeO5qL4GPaayCeMzT9XGMcPKroM
 Tgnm0aSVG+iQ9uDuyM5n6o6BDRRKmfc2zQCPA8pn4P6B5HUSoVVzyuf4/tMG0YzqK2Yt3LzgL
 E6BEn4X9NUoYLJwZ+X3i0VJdpgYmH/XoXDdHW0QB/kgYlcS4/p+UmeEOavUgQS0ClVOPkE1Wd
 2AMfuKeaT4bnz/tNuMCqbPS/8uWT5QeA+yB8dPP6e4c0TelFrZ00M5sOmNSDt5b3kXntcV1Mm
 ri0SiMpF+sFMY8xeUCzVkLtzBMjgi5NXAkPzEfv9LrijgMKpVuE90KiJ0JlbH191DAYUihBGF
 9+KcjM4Zqu6GFQzymxxWQztPc/i++sW9sMSTRArRq2SoGHpY4ejDQ25Ep+n7UPS6Oa5KDKqH8
 c2bh4fAOn6Me9O+BpbKEtdxO1E3w83/Lx9Zlyhhx1EY78GsCuP4A+Lxn78NhXbKNu9/K3qiwT
 ZuaLsEwSea9NtEY+F9d9CpAgSq9oeEHmtKdOwAklxGL+AaedqksnZ+Yi9yUiuUQ0QR0MdZyvy
 ZB+oqsE7ziAXy6wq+WEG7Tzp6pG/w90Hwzy4g+dOXDQodNuZ55H+yJRcCIscoUfu5Pm15IfzQ
 YUzej3dGMgQZtZAg664NDjkYyBs1gz2pgzgkt9mLO16vvpzJJBcJ5q9fFfyRENpxPoMWeGY0H
 yp9HKiky+sKPV6FVShdV07JgpIoqtKKPok/wGHQBvj8+yY62DIRULykgZw5AgZu4h55rDbZKN
 d1HpJMsB9lRjo914pXs+eYcvfAb6PQdmMSUTXvfXx64srNoRNT0WBRKgf2tJ8Ab9DI2bcDX0m
 eqLPcY6pwVFn8iILVYXF1hep6SObHLKqy5uf60n4pZ8a9pbBpvRlYWg5kgsVcXaXAY8mqPAb2
 OxX1S4Ga6yeO/yQIncXqP+opOcTMKSTKgdH+o3zw3GT+VnfANKmnHCD5wL4FI/5QDyOUKrY0C
 hzCKYSzo+17Pv3h17i414lu6bjzxsfUkl+r8vTIBJt4W74AO/Rg==
X-Rspamd-Queue-Id: BA3CF210319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79482-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

>>> I'm going through our list of issues found by static code analysis usi=
ng Klocwork.
>>
>> Does this tool point any more implementation details out for further de=
velopment considerations
>> (with other software components)?
>=20
> This was a run on our internal version of exfat, which matches
> 'github.com/namjaejeon/linux-exfat-oot/for-kernel-version-from-4.1.0'.

Thanks for such background information.


> If my time permits I will run it again on latest 'linux-7.0-rc`
> respective 'master' to see if anything "new" crept in.

It is probably nicer to repeat source code analyses on more recent
software revisions occasionally.


> I'll also report any other findings outside of exfat when I find them.

I became curious on the aspect on how many development resources
you may invest then.

Regards,
Markus

