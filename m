Return-Path: <linux-fsdevel+bounces-75127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG29A3pncmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:07:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E753D6BFF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07421314A2F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941B39CB4B;
	Thu, 22 Jan 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XD1JB33f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4D3904C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101593; cv=none; b=gFkjH9OqramJp7slbULMN3Oh6MBDTrvyVdNIModH6vK72eVHfpSSHcuaqvop+56SXatZcdtX4bnOy5QiWlzv4uT9VgHYQXkYXvNA24GtPkgur0y18cN5PIvIYRkBkX96n/A9LGcwUq8iUJwtAFL7nhANAKI+NaMl/PR8nnmE8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101593; c=relaxed/simple;
	bh=5klaN33jvrpNPqnnd22ydqrvw5+FbN9YiE8xchVg2ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j203hfPQUwPsM3n/hLRpN5X+H+RCSa2vCyvYov92qDAWpHBRJs6Kmia270K0TCJpZgaa/KwGYYzFVYcZ4LP6ump3STRWEUAv9VTw1qMT4vznwBnyepcxm3Q/AW3fL+gc3v0ixo9nkdB32klecs+5BNd4JcWL9keS5mdRtSh/oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XD1JB33f; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769101573; bh=cruiEawMGiI72EZiu+kzD88U6Dmgh0lmjUBecItvmAo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XD1JB33fRRmYG9blU6YzVvfpvPNWhcMdY5lvyp+WZUlxoO++Xn+GCkYi/8pqM6lseP8imLRL/ULN4NCq978t64KlQ2qb/xWDjybf/iyS+RdmIPtRlU/tatzxNS2JTLPiXKgcuDBuKGbsw8tjfDKa9I7UoK7WxUaS4CcjPMvo+FSgNRm6yAxPbUfh34mNAAqVt1l2ONHCrvWCo8FwI9Lf30uw4SjSRXnqAAGI4nJAiK9ymnIpAIcqWriWb34TwMcBa8Bjmkl/7i7TKCPio5h7uu1Q+kyhVHJoyawOhJfZClSunh45AOVaGlZPEQUKbGMRkgDcLlX7eSvPZfcG96bjHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769101573; bh=61Lj1pKOm3sANDJnWFobYHzQkDPDm4FuNGrNsAUB5Vj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JljWLDA/saehOdkw3ux1wSf++dpbKMhpXGSPznUjgiuv20rY3wayheOZAdO7wRjAJqvFKINaOd+Rd4v6lPyk96nit4TvBxjhtoP7/MAo9htqM0vWoFYxXd0OTNmnK3MVrTATvaPYKlSXyb8nCYIA4APCS4SpkNJzmLxWtI2TYFbmICRHZmIVaIEaqZ4ur2TKT6P31rxVXVhKMTnJQGNryAJDNrHD9JXCLVSo2o/PyJT8l798kApD7ZArJYHv9PaFmh7cVz+JfahYLF5mPJ0b7eQmCjDz6clj5XZJfihVmbDPm6tNzBH9NspPb4cwD8eOQ7Q+IyWTruY47uwHJswREw==
X-YMail-OSG: cSnibPIVM1lDUKJEU28e7RHQRAxG5BsjmQOBfLexDg4p0URZVmJNodbrpto_xdX
 n.lwTH67YzBrwPkDdGf7KkVbvSlGNiRbfVp7DLtDOC.vGY5Nd1hdnvQM_bGwXQhPO9O64moznDVd
 z4g0fWHDZbRtr__MCDnTUY7WGqJFKhcpKYfI7s.u9hdUJ6n2hKpjsOfiyibY2i3nNFHKUTRvQWy1
 d4C4B0NdJMBhse_5qtZcu04myxAi8W8n0XQu2OQR5Z2PT57UOV2hzK.wdwxVdOfYcgbM2hmCrUxt
 KrSYw6K1NSeeaxO9ftJ1SQ_NPG11GFWKtVbW11T9Dut7dMayi4578htbyd2xUk3y2nxXPyPz5JOo
 AYY_5YQAicooXPATTpndCb8J_A4g1ndlAzNnMGoeB7GLzrwDOsnU5dCTJmDU6M4Gs7nsutBpXHfd
 tIb9GdMMhBQ6ysgcxaOyop9.7OgUOnaby2uwg94TDq1XABGQ8DwdDhBDIMZfwPHpbdSA3GVrQoFb
 JxR4Rx_04mrQlGUVq5nNlK8kVu9i1GzNEKda8jTLoqPoA.GMvPa35JSODgmhRr.x2IOk5E4pY._3
 XBgz1xQYaq.nkcEVwu.S8n.H9xmVhPsbB5pQiz3pTXqtqR1zPiqGx_k.ey9CxNul3wswse5dF934
 fHF6DrWe6q1lXyt.ne6D2C53wVzhKOu3cwkfGN85UISBf6VD_VMAOpnE9rqPm1JPd6hWhprgvvcn
 toMaTIL_vAJa_u3jpEPr95QwrNQYR.Qhex3LiqNXirEaI0iMxIz.BaAOD5QlIpA.iVPxiaI0yj._
 CQf2OL4RNJlxww2pwDklfK.ycumNUJxJ2yj.ahq0uIozr5FwHW2DUTgKCfqdqcPh5OVXYTmkfFfy
 86Hvh.F0dkcjJHf8aD3F5M9TVu7Z9tKUQWpGWjmrtlWsUHgqbR3vxRgBSFAIhS.iNaP1WKj2qGqf
 G3SLeo836P18AV02fchfaR9zSVCULrnAEi3HV0k7C0Puc3xUW5.5nrl9.OLOxrPJlNovdj_bblno
 hlGRV9JXk5Occ6Ld.nJMFlWgoqfRD4ZvKdqHl4WL2lGWeW5rw0FTGhVvIkDakMZXBFBz62GHFTaA
 1wAfYyGVVInNMig2kG4b35FAqs1kdF_KlALnslFN_nVcdp9Qg5mF2J25OGdDasrMQhW9tDO4b7XO
 024LVOTayv6UmUzYLrn2OKeEmOloG11KeuqraoTNjNMEdmFbD5QEO1muEN6TPQVkDaUVKiZDQVVE
 iHO4XiIVdOlMBfTTvjtx6WY.NPWtyyfI0iiKcpSJehjr3g0u.X3ENqSt1iCtLkfbajQlEs2s76ok
 kdsblRde0X5Kk9sLsc4GrGBvCW11ZTJxGfPWk97ydELKF0kDD2LJ4XWnwuU4TZNfQEVnl9umEFIJ
 _A5mjQOcqh1biDeYnEV_H_qmzacpUoQg1E9mR1uCkyakShuFjNLSqAd_m2Br1zfHtDOG6F4TnBTN
 XuaM9GjC_UQmSzLp74nTXoygE9jI4YGMU82gzET.onzarPBPEV4l1bmbZvgkTMl6ogsCii8Lq2Mq
 2xUUomO45JgivQ7PkzgHAmnNWCFFFeVKyIgIAl8xVrxRuyIyv51VaclqKEtxgC0FqbbgKqpQu.au
 csM_YDWl23pyMXEHYmDotuSzeZtPDYW3ZS.POplXcHxLIp4XHw7.XAMYc4jh2COBSJBNPd_6J.ye
 C36S21YV3zOiMthbsWOZjtNYh._HwAW1iQh3p0n.0nUPcEzs2k_6qH8XMwL9Kgbzt.0i3jJ2DHOw
 7dIWy0O65u6Fg6SWRJY_cjmZDFMYFmIDwjkWMCmdw89ibh8QdtFxUeZSCXVkxKaN5hJnhWaEIH8w
 tsXXf5f3kOF6rUbzUqP6QM9JvQT1ZZh8P0XasL02msoGSps3CZEnXnDT7yMmrZg4PXLa2XNAB7Tu
 SUuyD_j9fGBNTqigVZc4RtosfSQ4LqL9yEk9q7YiZ9ih.ncdMGAOKGmjYTkrON4a10lI7swalFi6
 LmsjxQ6AZjLVhPPD4JNFoaULXNIfktbMTD.gSo4eWYF8SUL3YRptumOgpsLDl3kTZlXWb7AsIE9l
 Py2SlPLt3oWUjG_S3fRpoyleTOlYIc1wS4GT8myKwAKjnXpWSoQJ3iVaOWrGFVwgt9mlDlPrNmpU
 4_IsUb79F.JyYVS8Z7Zl.bIwSUcArDffNllQ5N9.Ce8j0oM7nyRcIohs9Bd_WFHSacA2qQdsRNaF
 eDN.FzNBCVWDK28fmQLUpacUjjEXny19rBRLnE.HB_70f4CCriOOzDxBMbzANmhZiScWVLaG5Kog
 C.Xq3y5l85Zq1HT9VPZWp
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6e10243e-2d15-4bd4-8a56-3f2d1d095c01
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jan 2026 17:06:13 +0000
Received: by hermes--production-gq1-86969b76cd-nvz7p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 35ea2cfb8615b76b3184ded328eb03ca;
          Thu, 22 Jan 2026 16:56:02 +0000 (UTC)
Message-ID: <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
Date: Thu, 22 Jan 2026 08:56:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 lsf-pc@lists.linux-foundation.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	TAGGED_FROM(0.00)[bounces-75127-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,paul-moore.com:email,schaufler-ca.com:mid]
X-Rspamd-Queue-Id: E753D6BFF6
X-Rspamd-Action: no action

On 1/21/2026 7:00 PM, Song Liu wrote:
> Hi Paul,
>
> On Wed, Jan 21, 2026 at 4:14 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Jan 21, 2026 at 4:18 PM Song Liu <song@kernel.org> wrote:
>>> Current LSM hooks do not have good coverage for VFS mount operations.
>>> Specifically, there are the following issues (and maybe more..):
>> I don't recall LSM folks normally being invited to LSFMMBPF so it
>> seems like this would be a poor forum to discuss LSM hooks.
> Agreed this might not be the best forum to discuss LSM hooks.
> However, I am not aware of a better forum for in person discussions.
>
> AFAICT, in-tree LSMs have straightforward logics around mount
> monitoring. As long as we get these logic translated properly, I
> don't expect much controversy with in-tree LSMs.

The existing mount hooks can't handle multiple LSMs that provide
mount options. Fixing this has proven non-trivial. Changes to LSM
hooks have to be discussed on the LSM email list, regardless of how
little impact it seems they might have.

>
>>> PS: I am not sure whether other folks are already working on it. I will prepare
>>> some RFC patches before the conference if I don't see other proposals.
>> FWIW, I'm not aware of anyone currently working on revising the mount
>> hooks, but it's possible.  Posting a patchset, even an early RFC
>> draft, is always a good way to find out who might be working in the
>> same space :)
>>
>> Posting to the mailing list also has the advantage of reaching
>> everyone who might be interested, whereas discussing this at a
>> conference, especially one that is invite-only, is limiting.
> I expect there will be RFCs posted to the mailing list before the
> conference. We will incorporate feedbacks from the mailing list
> to make the discussion more productive at the conference. It is
> totally possible that some patches get accepted before the
> conference, so that we can simply celebrate at the conference. :)
>
> Thanks,
> Song
>

